Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbTF3VYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTF3VYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:24:02 -0400
Received: from line-I-122.adsl-dynamic.inode.at ([81.223.7.122]:39062 "EHLO
	mail.sk-tech.net") by vger.kernel.org with ESMTP id S265901AbTF3VWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:22:17 -0400
Date: Mon, 30 Jun 2003 23:39:20 +0200 (CEST)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: linux-kernel@vger.kernel.org
Subject: SCSI losses Device
Message-ID: <Pine.LNX.4.53.0306302309070.486@merlin.sk-tech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm stuck!

I've a DVD-RAM Jukebox attached via SCSI.

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: TOSHIBA  Model: SD-W1101 DVD-RAM Rev: 1137
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TOSHIBA  Model: SD-W1101 DVD-RAM Rev: 1137
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TOSHIBA  Model: SD-W1101 DVD-RAM Rev: 1137
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: TOSHIBA  Model: DVD-RAM SD-W1111 Rev: 1124
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: NSM      Model: NSM6000          Rev: 1120
  Type:   Medium Changer                   ANSI SCSI revision: 02

I "burn" a CD (actually I use mkisofs and dd to write to a DVD-RAM).

Writing works fine, even isoinfo works fine, but when I try to mount the
DVD this fails, and /var/log/messages is full of errors.

When I remove the SCSI drive and reinsert the driver the drive I used to
write the DVD-RAM is gone
...

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TOSHIBA  Model: SD-W1101 DVD-RAM Rev: 1137
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TOSHIBA  Model: SD-W1101 DVD-RAM Rev: 1137
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: TOSHIBA  Model: DVD-RAM SD-W1111 Rev: 1124
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: NSM      Model: NSM6000          Rev: 1120
  Type:   Medium Changer                   ANSI SCSI revision: 02

I've to power down the JukeBox to see the drive again...

scsi-remove-single-device and scs-add-single-device does not help.

...

Technical Info:

  Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

  Linux kuli03 2.4.21 #4 Mon Jun 23 11:45:52 CEST 2003 i686 unknown

....

Jun 30 22:40:09 kuli03 kernel: scsi0:0:1:0: Attempting to queue an ABORT
message
Jun 30 22:40:09 kuli03 kernel: CDB: 0x28 0x0 0x0 0x0 0x0 0x10 0x0 0x0 0x1
0x0
Jun 30 22:40:09 kuli03 kernel: scsi0: At time of recovery, card was not
paused
Jun 30 22:40:09 kuli03 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins
<<<<<<<<<<<<<<<<<
Jun 30 22:40:09 kuli03 kernel: scsi0: Dumping Card State in Message-in
phase, at SEQADDR 0x41
Jun 30 22:40:09 kuli03 kernel: Card was paused
Jun 30 22:40:09 kuli03 kernel: ACCUM = 0x4, SINDEX = 0x17, DINDEX = 0x22,
ARG_2 = 0x1
Jun 30 22:40:09 kuli03 kernel: HCNT = 0x0 SCBPTR = 0x0
Jun 30 22:40:09 kuli03 kernel: SCSIPHASE[0x0] SCSISIGI[0xe4] ERROR[0x0]
SCSIBUSL[0x0]
Jun 30 22:40:09 kuli03 kernel: LASTPHASE[0xe0] SCSISEQ[0x12] SBLKCTL[0x6]
SCSIRATE[0x18]
Jun 30 22:40:09 kuli03 kernel: SEQCTL[0x10] SEQ_FLAGS[0x0] SSTAT0[0x5]
SSTAT1[0x0]
Jun 30 22:40:09 kuli03 kernel: SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8]
SIMODE1[0xa4]
Jun 30 22:40:09 kuli03 kernel: SXFRCTL0[0x80] DFCNTRL[0x4] DFSTATUS[0x89]
Jun 30 22:40:09 kuli03 kernel: STACK: 0x0 0x163 0x178 0x111
Jun 30 22:40:09 kuli03 kernel: SCB count = 5
Jun 30 22:40:09 kuli03 kernel: Kernel NEXTQSCB = 3
Jun 30 22:40:09 kuli03 kernel: Card NEXTQSCB = 3
Jun 30 22:40:09 kuli03 kernel: QINFIFO entries:
Jun 30 22:40:09 kuli03 kernel: Waiting Queue entries:
Jun 30 22:40:09 kuli03 kernel: Disconnected Queue entries: 0:4
Jun 30 22:40:09 kuli03 kernel: QOUTFIFO entries:
Jun 30 22:40:09 kuli03 kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9
10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Jun 30 22:40:09 kuli03 kernel: Sequencer SCB Info:
Jun 30 22:40:09 kuli03 kernel:   0 SCB_CONTROL[0x44] SCB_SCSIID[0x17]
SCB_LUN[0x0] SCB_TAG[0x4]
Jun 30 22:40:09 kuli03 kernel:   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  16 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  17 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  18 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  19 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  20 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  21 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  22 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  23 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  24 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  25 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  26 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  27 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  28 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  29 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  30 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel:  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff]
Jun 30 22:40:09 kuli03 kernel: Pending list:
Jun 30 22:40:09 kuli03 kernel:   4 SCB_CONTROL[0x40] SCB_SCSIID[0x17]
SCB_LUN[0x0]
Jun 30 22:40:09 kuli03 kernel: Kernel Free SCB list: 2 1 0
Jun 30 22:40:09 kuli03 kernel: Untagged Q(1): 4
Jun 30 22:40:09 kuli03 kernel: DevQ(0:1:0): 0 waiting
Jun 30 22:40:09 kuli03 kernel: DevQ(0:2:0): 0 waiting
Jun 30 22:40:09 kuli03 kernel: DevQ(0:3:0): 0 waiting
Jun 30 22:40:09 kuli03 kernel: DevQ(0:4:0): 0 waiting
Jun 30 22:40:09 kuli03 kernel: DevQ(0:5:0): 0 waiting
Jun 30 22:40:09 kuli03 kernel:
Jun 30 22:40:09 kuli03 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends
>>>>>>>>>>>>>>>>>>
Jun 30 22:40:09 kuli03 kernel: scsi0:0:1:0: Device is active, asserting
ATN
Jun 30 22:40:09 kuli03 kernel: Recovery code sleeping
Jun 30 22:40:14 kuli03 kernel: Recovery code awake
Jun 30 22:40:14 kuli03 kernel: Timer Expired
Jun 30 22:40:14 kuli03 kernel: aic7xxx_abort returns 0x2003
Jun 30 22:40:14 kuli03 kernel: scsi0:0:1:0: Attempting to queue a TARGET
RESET message
Jun 30 22:40:14 kuli03 kernel: CDB: 0x28 0x0 0x0 0x0 0x0 0x10 0x0 0x0 0x1
0x0
Jun 30 22:40:14 kuli03 kernel: aic7xxx_dev_reset returns 0x2003
Jun 30 22:40:14 kuli03 kernel: Recovery SCB completes
Jun 30 22:40:19 kuli03 kernel: scsi: device set offline - not ready or
command retry failed after bus reset: host 0 channel 0 id 1 lun 0
Jun 30 22:40:19 kuli03 kernel: SCSI cdrom error : host 0 channel 0 id 1
lun 0 return code = 10000
Jun 30 22:40:19 kuli03 kernel:  I/O error: dev 0b:00, sector 64
Jun 30 22:40:19 kuli03 kernel: isofs_read_super: bread failed, dev=0b:00,
iso_blknum=16, block=16

