Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBIIuc>; Fri, 9 Feb 2001 03:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbRBIIuX>; Fri, 9 Feb 2001 03:50:23 -0500
Received: from smtp.radiolinja.fi ([192.77.123.20]:28208 "EHLO
	smtp.radiolinja.fi") by vger.kernel.org with ESMTP
	id <S130102AbRBIIuR>; Fri, 9 Feb 2001 03:50:17 -0500
Date: Fri, 9 Feb 2001 09:16:09 +0200 (EET)
From: Tomi Sarvela <ts@piglet.radiolinja.fi>
To: linux-kernel@vger.kernel.org
Subject: Problem with linux-2.4.1, QLogic ISP 1020 and raid5
Message-ID: <Pine.LNX.4.21.0102090827020.19728-100000@piglet.radiolinja.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The problem is that I can't build raid5 array with 2.4.1.
Stresstest shows that disks and SCSI card seem to work ok
(fdisk, dd if=/dev/sda of=/dev/sdb bs=64k, mkfs.ext2
all are fine). Also, I can for example mirror two first
disks of the array with raid1, mkfs it and everything is fine.

When trying to arrange the disks to raid5 configuration,
something barfs. After mkraid /dev/md0 and the disk lists,
one or two disks show

isp1020: unexpected request queue overflow

... then, after a while, screen starts filling with

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 10,
lun 0 Read (10) 00 00 00 03 f7 00 04 00 00
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 10,
lun 0 Read (10) 00 00 00 03 f7 00 04 00 00

with the rate of 2 per second or so. The id that timeouts
changes if I try to make raid to raw disks instead of
partitions (/dev/sda instead of /dev/sda1). If two disks
show the request queue overflow, both ID's give same errors.

If there's ideas/patches what I could try, please CC,
I can only read lkml when I have time, the traffic is
too heavy for my mailbox.

TIA,

	Tomi Sarvela

_________________________________________o/__ _
                                         O\
Hardware configuration:
Compaq deskpro, PII-350
QLogic ISP 1020 (BIOS ver 4.15)
SCSI-box with 6 2GB DF disks (Seagate ST32550W),
all disks have same firmware


Software versions:
RedHat 6.2 underneath
gcc 2.91.66 (egcs-1.1.2)
raid-tools 0.90.0
linux-2.4.1 (with updated modutils and util-linux)
SCSI and QLogic driver build as modules
MD built to kernel (I couldn't get it right as module),
raid1 and raid5 compiled as modules.


#/etc/raidtab (with working raid1 config)
raiddev /dev/md0
raid-level     1
nr-raid-disks  2
nr-spare-disks 0
chunk-size     4

device /dev/sda1
raid-device 0
device /dev/sdb1
raid-device 1


#/etc/raidtab (with failing raid5 config)
raiddev /dev/md0
raid-level     5
nr-raid-disks  6
nr-spare-disks 0
chunk-size     64

device /dev/sda1
raid-device 0
...
device /dev/sdf1
raid-device 5



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
