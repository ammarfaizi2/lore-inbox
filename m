Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSFZQES>; Wed, 26 Jun 2002 12:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSFZQER>; Wed, 26 Jun 2002 12:04:17 -0400
Received: from ns.suse.de ([213.95.15.193]:8458 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316663AbSFZQEM>;
	Wed, 26 Jun 2002 12:04:12 -0400
Date: Wed, 26 Jun 2002 18:03:50 +0200
From: Ihno Krumreich <ihno@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Martin Schwenke <martin@meltin.net>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020626180350.A29197@wotan.suse.de>
References: <20020620165553.GA16897@win.tue.nl> <Pine.LNX.4.44.0206201046340.8225-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206201046340.8225-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 11:11:45AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 20 Jun 2002, Andries Brouwer wrote:
> >
> > At present this does not look very useful, but it may have future.
> 
> Nobody is actually using it yet, so there hasn't been much feedback (and,
> for the same reason, not much reason for driver writers to care -
> everything that shows up there now ends up being pretty much built by the
> bus that contains the devices rather than any device-specific information
> itself).
> 
> > But there is a pressing present problem. What name do my devices have?
> > I plug in a SmartMedia card reader. It will become some SCSI device.
> 
> That's a user-space issue, the kernel is not going to make any policy.
> We've seen where policy takes us with devfs.
> 


Hello,

by following the discussion I still miss a naming sceme for
devices like disks, tapes, cdrom for the user (no kernelhackers, but the
daily user running the system for some productive work). Does there exist
a naming sceme for persistant names for those devices? I think of something
like scsidev (http://www.garloff.de/kurt/linux/scsidev/#scsidev). 

I think the scsidev idea could be extended to a general sceme that
satisfies all technologies (not only ide and scsi).

I think of something like 

/dev/<device-type>/<technologie>_<Uniq-Number>_<Bus-number>_<Target>_<Lun>_<Device_type_specific>

<device-type> would be disks, tapes, cd-rom and other devices (scanner?)

<technologie> is something really readable for the user (ide, scsi, dasd (dasd are
              disks on the IBM zSeries)

<Uniq-number>	something to make a device uniq. examples for this could be:
                - PC the I/O-port used by the controller
		- DASD the device-port where the dasd is assigned
<bus-Number>
<Target>
<Lun>		As intented by SCSI. On technologies where they make no sense
		just leave them 0 (for example dasd don`t have that).

<device_type_specific>	depends on the device type. 
			for disks this is the partition-number
			for tapes rewind, norewind, compression, density

examples:

disks:

/dev/disks/ide_01f0_0_0_0_0	for the whole IDE disk
/dev/disks/ide_01f0_0_0_0_1	for partition 1
.
.
/dev/disks/ide_01f0_0_0_0_31	for partition 31

/dev/disks/scsi_0330_0_1_0_0	for the controller at port 0x330, disk bus 0 target 1, lun 0
/dev/disks/scsi_0330_0_1_0_1	for partition 1
.
.
/dev/disks/scsi_0330_0_1_0_15	for partition 15

/dev/disks/dasd_0150_0_0_0_0	for dasd at device-port 0x150, whole disk
/dev/disks/dasd_0150_0_0_0_1	for partition 1
.
.
/dev/disks/dasd_0150_0_0_0_3	for partition 3

tapes:

/dev/tapes/scsi_0330_0_2_0_r	auto-rewind SCSI-Tape at controller at Port 0x330
/dev/tapes/scsi_0330_0_2_0_n	no-rewind SCSI-Tape at controller at Port 0x330


Beside some standard devices, the devices could be created

- at system start for coldplugged devices
- by /sbin/hotplug for hotpluged devices

This naming sceme could be used for kernel 2.4 by creating nodes and for
kernel 2.5 by making symbolic links to /devices.

something forgotten?


Ihno

