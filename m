Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271230AbTGWTIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271234AbTGWTHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:07:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:59666
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S271230AbTGWTFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:05:33 -0400
Date: Wed, 23 Jul 2003 12:12:47 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Lawrence <dgl@integrinautics.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: compact flash IDE hot-swap summary please
In-Reply-To: <3F1ECFDD.D561D861@integrinautics.com>
Message-ID: <Pine.LNX.4.10.10307231211060.13376-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You never remove the "TrueIDE" from the cable so the bridge chip saves
you.  Go try it with standard media and you will see different.

Andre Hedrick
LAD Storage Consulting Group

On Wed, 23 Jul 2003, Dave Lawrence wrote:

> I have read through some old threads on this mailing
> list and am confused about what is and isn't supported
> by Linux in the area of removable IDE devices.  I
> apologize in advance for my ignorance, but I think there
> are others nearly as ignorant as I that could benefit
> from answers to these questions.
> 
> I have a Zaurus handheld that runs Linux that seems 
> to be able to hot-swap its IDE compact flash device
> with no problems.  But I've read in a recent
> thread "hdparm and removable IDE?" that hot-swap
> isn't "fully" supported and that is won't be
> until:
> 
> >2.7 at the earliest, and only if there is a general buy in about such a
> >change to the init handling. Similarly the big issues with hdparm -U and
> >-R are the same as with hotplug races, and will take a lot more than
> >quick hacks to fix.
> >
> >Alan Cox
> 
> How come my Zaurus hot-swaps fine (or does it have
> intermittent problems that I've just never seen?)?
> 
> 
> I have a single board computer with one IDE connector
> that has two compact flash (one master (hda), one slave (hdb))
> IDE devices connected to the one cable.  Is it possible in
> Linux now to (safely) remove the slave compact flash
> device after unmounting all partitions on that device?
> If not, will it ever be possible (or is there a hardware
> limitation that precludes doing this?)?
> 
> Is it possible in Linux now to (safely) remove the slave 
> compact flash without unmounting the partitions (assuming
> you're using a file system like ext3 that is robust to
> shutdowns)?
> 
> If not, will this ever be supported (and when?) or is there a 
> hardware limitation that precludes it?
> 
> How about if the compact flash device is in a SanDisk
> USB card reader or a Lexar Jumpshot USB card reader?
> Is hot-swapping of such media supported today without
> unmounting the partitions?  If not, will it ever be?
> 
> 
> Also, there were two related threads in January/February of
> 2002 that discussed the removability of compact flash:
> 
> false positives on disk change checks 
> PROBLEM: ext2/mount - multiple mounts corrupts inodes 
> 
> The original problem was that in 2.4 kernels, compact
> flash disks are corrupted if you remount already mounted
> partitions.  Somebody found a hack workaround for this
> problem, which was to remove the following lines of
> code from ide-probe.c:
> 
> > if (id->config & (1<<7)) 
> > drive->removable = 1; 
> > +#endif 
> 
> However, Andre Hedrick had the following response to
> this hack:
> 
> >REGARDLESS, it is removable media and this it reports so. 
> >The driver will not change to create false reports, because CFA has its 
> >own rules, and if you can figure them out great. 
> >
> >Removable media shall always report as Removable media. 
> >
> >If you purchase enough of the media, the OEM will allow you to alter the 
> >identify page and this it will not longer report "Removable". 
> >
> >Regards, 
> >
> >Andre Hedrick 
> >Linux Disk Certification Project Linux ATA Development 
> 
> It seems like Andre is implying the problem that is
> causing my compact flash disk corruption is that the
> disk is reporting being removable when it actually
> is not.  But what good is it for the disk to be
> flagged as removable if hot-swapping isn't supported?
> Shouldn't the "hack" solution be put into the kernel
> (at least as a configuration option) until the kernel
> fully supports removable compact flash (at which time,
> one would hope that you could remount compact flash
> without disk curruption)?  In 2.2 kernels,
> compact flash disks weren't corrupted by remounts - in
> 2.4 they are.
> 
> On a potentially related note (or maybe completely
> off-topic), I always get these kernel messages when
> using compact flash:
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> They don't seem to be related to any real problem.  How do
> I make those error messages go away?
> 
> 
> Thanks in advance for a "hotswap for dummies" summary.
> 
>                                Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

