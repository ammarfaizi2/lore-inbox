Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTIODlS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 23:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTIODlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 23:41:18 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29963
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262429AbTIODlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 23:41:16 -0400
Date: Sun, 14 Sep 2003 20:23:23 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
In-Reply-To: <20030913021117.GA16296@tux.linuxdev.us.dell.com>
Message-ID: <Pine.LNX.4.10.10309141937280.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt:

This would require the generic mapping of disc labels away from the
current hdX/sdX to hdN where 0 =< N < 5.  This issue will be mapping EDDS
which you are working on, and I tip my hat for what value it has left.

I will chat offline more in details to see where you are going and if I
can offer help from the T13 side of life.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 13 Sep 2003, Matt Domsch wrote:

> >    Further, some sites may prefer block-level GUIDs to fs-level ones.
> >    Sites using raw partitions instead of filesystems, for one.
> 
> The EFI GUID Partition scheme (aka GPT aka CONFIG_EFI_PARTITION)
> stores a GUID in the disk label to define the whole disk, plus another
> per-partition GUID and per-partition label.  So even if the file
> system doesn't have one, if you're using GPT, one *could* use those.
> I haven't hacked up mount to search for those though.  If there's
> enough interest, I'll do so.  Recall GPT is currently only used on
> ia64, though the code works fine on other arches including x86, and
> it's been decided (on l-k at least) that GPT will be the default disk
> label format for systems running 2.6.x kernels with disks >2TB, as the
> msdos label can't hold it.
> 
> > The boot disk, OTOH, is tough. Right now, we just assume the
> > sysadmin knows what's he's doing, when he installs lilo or grub on a
> > disk.  You care about the boot disk when installing lilo... maybe
> > there are similar situations too which I do not recall.  As Alan
> > said, besides EDD (only on newer boxes) there's really nothing.
> 
> EDD BIOSs are coming, slowly...  2 work today correctly, several more
> are "close but no cigar", it's all the rest that worry me.
> 
> There's one more trick that's being used successfully, which I would
> like to add to the EDD code.  That's "let BIOS help you out before
> installing".  i.e. you boot into a FreeDOS environment, write a
> system-unique disk signature to the boot disk (int13 device 80h)
> "BOOT" or something - we've got 4 bytes available in the msdos label
> for it, then reboot and let Linux go grab the signature,
> store it, and like edd.o does, export it to userspace.  Now from
> userspace one can see what Linux-named-disk has the signature you're
> looking for, and voila, you now solved it w/o needing EDD BIOSs.  But
> it requires a non-Linux boot step somewhere in the install process.
> 
> Thanks,
> Matt
> 
> -- 
> Matt Domsch
> Sr. Software Engineer, Lead Engineer
> Dell Linux Solutions www.dell.com/linux
> Linux on Dell mailing lists @ http://lists.us.dell.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

