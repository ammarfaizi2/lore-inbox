Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbTH0T5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 15:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTH0T5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 15:57:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31104 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262102AbTH0T5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 15:57:08 -0400
Date: Wed, 27 Aug 2003 15:58:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: root@mauve.demon.co.uk
cc: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <200308271933.UAA14620@mauve.demon.co.uk>
Message-ID: <Pine.LNX.4.53.0308271535060.5064@chaos>
References: <200308271933.UAA14620@mauve.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 root@mauve.demon.co.uk wrote:

> >
> > On Wed, 27 Aug 2003, H.Rosmanith (Kernel Mailing List) wrote:
> >
> > > > > "after the first write the flash device failed entirely". That doen't
> <snip>
> > Remember when AT Class machines had a BIOS that allowed you
> > to low-level format hard drives? When early IDE drives came
> > out, persons tried to format them and they got destroyed.
> > So, BIOS vendors took away the format capability.
> >
> > The IDE drive companies started a lie that was repeated so
> > often that it seemed true. It was that IDE drives didn't
> > have 'formatters' and, therefore, could only be formatted
> > at the factory. Of course, if this was true, how come
> > the format command did anything??  The truth was that
>
> This is actually true, and has been since around 80Mb or so.
> There is no absolute positioning information on the disk drive that can
> be used to lay down new positioning information for the tracks.
> Before this, there used to be a stepper motor that could position the
> head at track 743, or a seperate head that read track information from
> a dedicated surface.
>

No. Embedded servo-tracks have been used for this. Once a track is
written at the factory, even if the sectors are corrupt, it can
still be used for servo position because even corrupt data has
the spectral information necessary for the servo to find the
center of the track. The only possible problem is that you can't
find even one good sector to verify the track information. Both
the track number and the sector number is in the sector header.

You can low-level format many/most/all SCSI disks and ESDI disks
even though they also have embedded servo and voice-coil
positioners with no stepper motors and no feedback except from
the track information that you re-write.

Embedded servos work because the magnetic domains are always
too large for the data bits. This means that the system
ends up acting like a low-pass filter. The phase through
this filter changes, depending upon the position of the
head relative to when it was written. The servo nulls the
phase-shift to be what it was when the track was written.
This gets the head to the center of the track.

You do need some kind of independent positioner to write
the first tracks at the factory. Most use a 'formatter'
fixture that contains the feedback hardware necessary to do this.

Prototype drives get tracks written entirely using a software
approximation method where the first track is written slightly
off from the home position,  the next tracks are written
where the read-level from the previous write has fallen
6 dB (50%), as the positioner current is 'bumped' to overcome
friction and move to the next incremental track location.

This is not done for production drives because it is too
slow. However, this will allow the designer to experimentally
determine the maximim possible capacity of the drive, i.e.,
maximum number of cylinders.

> > these drives stored their parameters on the disk platters.
> > If you re-wrote the first real sectors on the drive, the
>
> This is more likely the problem, but
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


