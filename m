Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWEMAKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWEMAKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWEMAKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:10:53 -0400
Received: from ns.suse.de ([195.135.220.2]:45507 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932221AbWEMAKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 20:10:51 -0400
Date: Fri, 12 May 2006 17:08:52 -0700
From: Greg KH <greg@kroah.com>
To: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060513000852.GA31511@kroah.com>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <20060512203416.GA17120@flint.arm.linux.org.uk> <20060512214354.GP27946@ftp.linux.org.uk> <20060512215520.GH17120@flint.arm.linux.org.uk> <20060512220807.GR27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org> <20060512222816.GS27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512222816.GS27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 11:28:16PM +0100, Al Viro wrote:
> On Fri, May 12, 2006 at 03:22:42PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Fri, 12 May 2006, Al Viro wrote:
> > > 
> > > Secondary question: who had resurrected that crap?  I distinctly remember
> > > killing it off...
> > 
> > If you did, I don't think it ever got into the kernel.
> > 
> > It was added by Kay Sievers on Nov 3, 2004, according to the old history 
> > (back then it was in drivers/block/genhd.c, and the function was called 
> > "block_hotplug()", but apart from renaming the function and moving the 
> > file, it's recognizably the same.
> > 
> > Of course, you may have killed off an even earlier incarnation..
> 
> Ah, right - there was another uevent mess in fs/super.c.  Sorry, got them
> confused... and that FPOS _is_ back.
> 
> gregkh, may I ask why had bdev_uevent() been resurrected?

One user, running an old version of HAL, on a distro that had an updated
version available (Gentoo), refused to upgrade it and was upset that
when they plugged a usb-storage device in, it did not show up as an icon
on the desktop.

Andrew pointed out that we broke the "don't break the userspace API"
kernel rule, so I put the patch back, and noted when it would finally be
removed.

I would gladly remove it again if everyone can agree that they will not
get upset at me again when someone running obsolete/broken userspace
programs complains...

thanks,

greg k-h
