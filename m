Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbUKGVyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUKGVyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUKGVyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:54:39 -0500
Received: from lists.us.dell.com ([143.166.224.162]:35663 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261700AbUKGVwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:52:12 -0500
Date: Sun, 7 Nov 2004 15:52:04 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Linus Torvalds <torvalds@osdl.org>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: EFI partition code broken..
Message-ID: <20041107215204.GB3169@lists.us.dell.com>
References: <Pine.LNX.4.58.0411070959560.2223@ppc970.osdl.org> <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 11:30:18AM -0800, Linus Torvalds wrote:
> There's a few reports of various USB storage devices locking up. The last 
> one was an iPod, but there's apparently others too.
> 
> The reason? They are unhappy if you access them past the end, and they 
> seem to have problems reporting their true size.
> 
> And the EFI partitioning code will happily just blindly try to access the 
> last sector, because that's where the EFI partition is. Boom. Immediately 
> dead iPod/whatever.

Another train of thought, and copying gregkh for inspiration.  Is there
any way to know which devices lie about their size, and fix that with
quirk code in the device discovery routines?  While I can fix
fs/partitions/efi.c to not to always do I/O to the end of the
purported size of the device, userspace and 'dd' can't.  If we could
quirk down the reported size for devices known to lie, then everything
which uses that value wouldn't have to have its own rules for such.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
