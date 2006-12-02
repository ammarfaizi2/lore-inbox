Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162969AbWLBL6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162969AbWLBL6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162970AbWLBL6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:58:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36367 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1162969AbWLBL6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:58:16 -0500
Date: Sat, 2 Dec 2006 11:57:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       Christoph Schmid <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Message-ID: <20061202115709.GC4030@ucw.cz>
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it> <7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local> <20061130171910.GD1860@elf.ucw.cz> <87k61bpuk4.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k61bpuk4.fsf@denkblock.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> 1. Adds functions to ide-disk.c and scsi_lib.c that issue an idle
> >>    immediate with head unload or a standby immediate command as
> >>    appropriate and stop the queue on command completion.
> >
> > Can we get short Documentation/ patch?
> 
> Sure. Would Documentation/block/disk-protection.txt be an appropriate
> location?

Yes.

> >> +module_param_named(protect_method, libata_protect_method, int, 0444);
> >> +MODULE_PARM_DESC(protect_method, "hdaps disk protection method  (0=autodetect, 1=unload, 2=standby)");
> >
> > Should this be configurable by module parameter? Why not tell each
> > unload what to do?
> 
> As I understand, ATA specs expect drives to indicate whether they
> support the head unload feature of the idle immediate command or not.
> Unfortunately, a whole lot of them doesn't, well, mine doesn't anyway.
> Since I know that my drive does actually support head unloading, I'd
> like to tell the module so in order to prevent it from falling back to
> standby immediate. Applications that issue disk parking requests
> should not be bothered with this issue, in my opinion.

What if you have two disks and one supports head unload and second
does not?

> > Is /sys interface right thing to do?
> 
> Probably, you're right here. Since this feature is actually drive
> specific, it should not really be set globally as a libata or ide-disk
> parameter but specifically for each drive connected. Perhaps we should
> add another attribute to /sys/block/*/queue or enhance the scope of
> /sys/block/*/queue/protect?

Certainly better than current solution. Or maybe ioctl similar to wat
hdparm uses?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
