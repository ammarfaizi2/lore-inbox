Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRJIEMI>; Tue, 9 Oct 2001 00:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277715AbRJIEL7>; Tue, 9 Oct 2001 00:11:59 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.11.31.247]:11136 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S277713AbRJIELx>; Tue, 9 Oct 2001 00:11:53 -0400
Message-ID: <3BC27919.6F65D808@home.com>
Date: Mon, 08 Oct 2001 23:12:09 -0500
From: Jordan Breeding <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-ac10-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: weird problem with hdb=scsi
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing a weird problem where if I set an ATAPI Zip 250 to be
ide-scsi using hdb=scsi at boot time everything works once booted into
multiuser but the initial partition check still tries to check the drive
as though it were being controlled by ide drivers.  Here is the
pertinent dmesg section:

== BEGIN OUTPUT ==
hda: IBM-DTLA-307075, ATA DISK drive
hdb: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdc: KENWOOD CD-ROM UCR-421 V226G, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=73308/64/32,
UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11
>
 hdb:<3>ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0
 unable to read partition table
... SNIPPED ...
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: KENWOOD   Model: CD-ROM UCR-421    Rev: 226G
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 68x/68x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
== END OUTPUT ==

Why does the ide subsystem not ignore drives which are being controlled
by <drive>=scsi during partition check since the SCSI subsystem is now
going to handle partition checks for that drive?  Thanks for any
information.

Jordan Breeding
