Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422866AbWJOIDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422866AbWJOIDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 04:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWJOIDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 04:03:54 -0400
Received: from mail.suse.de ([195.135.220.2]:63183 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422866AbWJOIDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 04:03:52 -0400
Date: Sun, 15 Oct 2006 10:03:51 +0200
From: Nick Piggin <npiggin@suse.de>
To: Robin Holt <holt@sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_user_pages(..., write==1, ...) may return with readable pte.
Message-ID: <20061015080351.GA4763@wotan.suse.de>
References: <20061013203342.GA21610@lnx-holt.americas.sgi.com> <20061014045305.GA23740@wotan.suse.de> <20061014101507.GA6316@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014101507.GA6316@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 05:15:07AM -0500, Robin Holt wrote:
> > dup_mmap holds mmap_sem for write. get_user_pages caller must hold it
> > for read.
> 
> I could have sworn I checked for that and found a down_read(), but
> now that I look when I have some time, it is clearly a down_write().
> Sorry for the distraction.

I'm one to do the same thing, don't worry ;)

> It is a user job that is passing data between hosts.  The host is
> under heavy memory pressure and one rank of the MPI job gets silent
> data corruption.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=016eb4a0ed06a3677d67a584da901f0e9a63c666

It could be this? inode reclaim calls invalidate_inode_pages, so this
one is a memory corrupter under heavy reclaim pressure.


> 
> Thanks and sorry for wasting your time,

Not at all, my pleasure.
