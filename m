Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRGXCLL>; Mon, 23 Jul 2001 22:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRGXCKv>; Mon, 23 Jul 2001 22:10:51 -0400
Received: from dsl-64135210.acton.ma.internetconnect.net ([64.13.5.210]:49074
	"EHLO alliance.centerclick.org") by vger.kernel.org with ESMTP
	id <S266583AbRGXCKp>; Mon, 23 Jul 2001 22:10:45 -0400
Mime-Version: 1.0
Message-Id: <v04210101b781c827accb@[10.0.2.30]>
X-Mailer: QUALCOMM MacOS Eudora Pro Version 4.2.1 (PPC)
Date: Mon, 23 Jul 2001 22:10:46 -0400
To: linux-kernel@vger.kernel.org
From: David Johnson <dave-kernel-list@centerclick.org>
Subject: DVD-RAM media detected with wrong number of blocks (2.4.7)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

When attempting to create an ext2 partition on a dvd-ram (2.6G/5.2G) 
media the number of blocks is detected wrong causing only half of the 
disk to be usable.  When creating the filesystem with mke2fs only 
609480 2K blocks are allowed instead of 1218960 2K blocks, and I end 
up with a 1.2GB partition instead of 2.4GB one.  The 1.2GB fs works 
fine, it's just a bit small :(

This is with 2.4.7 using a Creative DVD-RAM drive (1216S) on an Adaptec 2940UW.

The correct number of blocks is detected in 2.4.6


[...]
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
         <Adaptec 2940 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

   Vendor: CREATIVE  Model: DVD-RAM RAM1216S  Rev: 1311
   Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
sr0: scsi3-mmc drive: 0x/0x dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
[...]


$ mke2fs -b 2048 /dev/scd0
mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
/dev/scd0 is entire device, not just one partition!
Proceed anyway? (y,n) y
Filesystem label=
OS type: Linux
Block size=2048 (log=1)
Fragment size=2048 (log=1)
152608 inodes, 609480 blocks
30474 blocks (5.00%) reserved for the super user
First data block=0
38 block groups
16384 blocks per group, 16384 fragments per group
4016 inodes per group
Superblock backups stored on blocks:
         16384, 49152, 81920, 114688, 147456, 409600, 442368

Writing inode tables: done
Writing superblocks and filesystem accounting information: done
$


