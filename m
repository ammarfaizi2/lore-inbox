Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270015AbRHJUaz>; Fri, 10 Aug 2001 16:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270016AbRHJUaq>; Fri, 10 Aug 2001 16:30:46 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:2311 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270015AbRHJUad>; Fri, 10 Aug 2001 16:30:33 -0400
Date: Fri, 10 Aug 2001 15:30:41 -0500
Message-Id: <200108102030.f7AKUfa05113@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs, scsi_debug
In-Reply-To: <3B73D9F0.8BE1B0D1@torque.net>
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
	<3B735FCF.E197DD5B@torque.net>
	<200108100431.f7A4VkG01068@mobilix.ras.ucalgary.ca>
	<3B73D9F0.8BE1B0D1@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert writes:
> Richard Gooch wrote:
> > 
> > Douglas Gilbert writes:
> 
> > > $ ls -l /devfs/scsi/host46/bus0/target0/lun0/*
> > > brw-------    1 root     root     114,  16 Dec 31  1969
> > >                         /devfs/scsi/host46/bus0/target0/lun0/disc
> > > brw-------    1 root     root     114,  17 Dec 31  1969
> > >                         /devfs/scsi/host46/bus0/target0/lun0/part1
> > > brw-------    1 root     root     114,  18 Dec 31  1969
> > >                         /devfs/scsi/host46/bus0/target0/lun0/part2
> > > brw-------    1 root     root     114,  19 Dec 31  1969
> > >                         /devfs/scsi/host46/bus0/target0/lun0/part3
> > >
> > > Note the large major device number that devfs is pulling
> > > from the unused pool. Devfs makes some noise when
> > > 'rmmod scsi_debug' is executed but otherwise things looked
> > > ok.
> > 
> > What was the message?
> 
> After several seconds of silence, lots of these appeared:
>  devfs_dealloc_unique_number(): number 128 was already free
>  devfs_dealloc_unique_number(): number 128 was already free

I'm not able to debug this for the time being. Could you poke around
and figure out what's happening? The first thing to check for is to
see whether block major 128 was even allocated in the first
place. Check /proc/devices to see (make sure you don't pass devfs=only
at the boot line).

Next step is to hack in drivers/scsi/sd.c:sd_alloc_majors() and
sd_dealloc_majors() and add printk() calls. Is it possible
sd_dealloc_majors() is being called more than once?

Is 128 the only major number that it complains about? Any other
bitching and moaning?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
