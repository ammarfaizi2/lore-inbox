Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUIWSEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUIWSEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUIWSCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:02:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8127 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268207AbUIWR6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:58:21 -0400
Date: Thu, 23 Sep 2004 13:28:18 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "Mr. Berkley Shands" <berkley@dssimail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile64() on x86_64 breaks at 2gb (MAX_NON_LFS limit)
Message-ID: <20040923172818.GX31909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <41530349.2050003@dssimail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41530349.2050003@dssimail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 12:09:29PM -0500, Mr. Berkley Shands wrote:
> for the opteron, the value of MAX_NON_LFS (include/linux/fs.h) is fixed 
> at (1UL<<31 -1).
> Since ALL 64 bit boxes force O_LARGEFILE on, shouldn't this value be 
> (1UL<<63 -1) so that
> sendfile64() will proceed beyond the 2gb limit?
> under 2.6.6, sendfile64() has no __NR_sendfile64 entry in asm*/unistd.h 
> (same for 2.6.9-rc2)
> so the syscall sendfile64() maps to sendfile(), which has MAX_NON_LFS 
> hard coded in fs/read_write.c
> as its limit, rather than 0ULL as in sendfile64().
> 
> So the fix is to make the correct entry for sendfile64 in unistd.h (note 
> that this hoses /usr/include/.../syscalls.h :-)
> and update fs.h as folows:

No.  You want the MAX_NON_LFS limit for 32-bit programs that call sendfile()
(as opposed to sendfile64()) on 64-bit arches.

The correct fix which is in the kernel for a few months is:
http://linux.bkbits.net:8080/linux-2.5/diffs/include/asm-x86_64/unistd.h@1.25

	Jakub
