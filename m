Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUGTVOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUGTVOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 17:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUGTVOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 17:14:39 -0400
Received: from outmail.tqs.com ([12.168.224.5]:60899 "EHLO mail.tqs.com")
	by vger.kernel.org with ESMTP id S266237AbUGTVOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 17:14:21 -0400
Subject: Promise Ultra Track RM15000 + aic7xxx
From: "Adams, Bill TQO" <badams@tqs.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-wai8C4h8/+Kfv4U/i72k"
Message-Id: <1090358056.19336.365.camel@badams.tqs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jul 2004 14:14:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wai8C4h8/+Kfv4U/i72k
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

linux 2.4.26 stock kernel

I have a Promise Ultra Track RM15000 which is basically a IDE<->SCSI
RAID enclosure. It is running the latest firmware 1.10.0.19. You can
read all about it here:
http://www.promise.com/product/product_detail_eng.asp?productId=109&familyId=6

This is connected to an Adaptec 29160 with the latest firmware 3.10.0.

Whether I am formatting a partition as a MySQL InnoDB raw or as ext3, it
gives many errors. On the ext3 format, the badblocks command is what
elucidates the problems.
  mkfs -j /dev/sdb1 -T largefile4 -v -c -c
which runs
  badblocks -b 4096 -s -w /dev/sdb1 170897454

The errors seem to happen in random places of the badblocks check each
time I try the sequence:
  modprobe aic7xxx aic7xxx='random options"
  mkfs -j /dev/sdb1 -T largefile4 -v -c -c
  rmmod aic7xxx

I have tried both periodic_otag and periodic_otag.extended along with
"verbose.tag_info:{{16.16.16}}" and nothing seems to make a difference.

I have another system with three Adaptec 3960D controllers connected to
winchester systems raid enclosures. This system has the same version
aic7xxx driver (6.2.36) and has no problems so I seriously doubt it is
the driver.

I have pasted in some of the logs below so that search engines can find
them ('cause I don't get enough spam as it is) and have also attached a
.tgz of the log files since my email client will probably mangle the
formatting of the pasted in logs.

Any insight, suggestions, or help would be greatly appreciated. Please
cc me as I am not on the list.

And of course I am happy to provide further information.

--Bill Adams


Three bits of info follow, the output from /proc/scsi/aic7xxx/1; the
syslog for the module load; and a section of the syslog showing some of
the scsi errors.

=-=-=-=-=-=-=-=
Log for cat /proc/scsi/aic7xxx/1 

Adaptec AIC7xxx driver version: 6.2.36
Adaptec 29160 Ultra160 SCSI adapter
aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Allocated SCBs: 18, SG List Length: 85

Serial EEPROM:
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
0x08f4 0x7c5d 0x2807 0x0010 0x0300 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0xe64f 

Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 7055
                Commands Active 13
                Command Openings 3
                Max Tagged Openings 16
                Device Queue Frozen Count 0
Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 16
                Max Tagged Openings 16
                Device Queue Frozen Count 0
Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 62, 16bit)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 3
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 7 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 8 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 9 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 11 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 12 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 13 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 14 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Target 15 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)


=-=-=-=-=-=-=-=-=-=
Log for  modprobe aic7xxx
aic7xxx='verbose.periodic_otag.extended.tag_info:{{16.16.16}}'

Jul 20 16:11:06 host kernel: tag_info[0:0] = 16
Jul 20 16:11:06 host kernel: tag_info[0:1] = 16
Jul 20 16:11:06 host kernel: tag_info[0:2] = 16
Jul 20 16:11:06 host kernel: PCI: Enabling device 01:06.0 (0116 -> 0117)
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Enabling 39Bit Addressing
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Reading SEEPROM...done.
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: BIOS eeprom is present
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Secondary High byte
termination Enabled
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Secondary Low byte
termination Enabled
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Primary Low Byte termination
Enabled
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Primary High Byte
termination Enabled
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Downloading Sequencer
Program... 432 instructions downloaded
Jul 20 16:11:06 host kernel: ahc_pci:1:6:0: Features 0x1def6, Bugs 0x40,
Flags 0x21485540
Jul 20 16:11:06 host kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
Jul 20 16:11:06 host kernel:         <Adaptec 29160 Ultra160 SCSI
adapter>
Jul 20 16:11:06 host kernel:         aic7892: Ultra160 Wide Channel A,
SCSI Id=7, 32/253 SCBs
Jul 20 16:11:06 host kernel: 
Jul 20 16:11:06 host kernel: blk: queue c8c16018, I/O limit 524287Mb
(mask 0x7fffffffff)
Jul 20 16:11:21 host kernel: (scsi1:A:0:0): Sending PPR bus_width 1,
period 9, offset 7f, ppr_options 2
Jul 20 16:11:21 host kernel: (scsi1:A:0:0): Received PPR width 1, period
9, offset 3e,options 2
Jul 20 16:11:21 host kernel: ^IFiltered to width 1, period 9, offset 3e,
options 2
Jul 20 16:11:21 host kernel: (scsi1:A:0): 6.600MB/s transfers (16bit)
Jul 20 16:11:21 host kernel: scsi1: target 0 using 16bit transfers
Jul 20 16:11:21 host kernel: (scsi1:A:0): 160.000MB/s transfers
(80.000MHz DT, offset 62, 16bit)
Jul 20 16:11:21 host kernel: scsi1: target 0 synchronous at 80.0MHz DT,
offset = 0x3e
Jul 20 16:11:21 host kernel: (scsi1:A:1:0): Sending PPR bus_width 1,
period 9, offset 7f, ppr_options 2
Jul 20 16:11:21 host kernel: (scsi1:A:1:0): Received PPR width 1, period
9, offset 3e,options 2
Jul 20 16:11:21 host kernel: ^IFiltered to width 1, period 9, offset 3e,
options 2
Jul 20 16:11:21 host kernel: (scsi1:A:1): 6.600MB/s transfers (16bit)
Jul 20 16:11:21 host kernel: scsi1: target 1 using 16bit transfers
Jul 20 16:11:21 host kernel: (scsi1:A:1): 160.000MB/s transfers
(80.000MHz DT, offset 62, 16bit)
Jul 20 16:11:21 host kernel: scsi1: target 1 synchronous at 80.0MHz DT,
offset = 0x3e
Jul 20 16:11:21 host kernel: (scsi1:A:2:0): Sending PPR bus_width 1,
period 9, offset 7f, ppr_options 2
Jul 20 16:11:21 host kernel: (scsi1:A:2:0): Received PPR width 1, period
9, offset 3e,options 2
Jul 20 16:11:21 host kernel: ^IFiltered to width 1, period 9, offset 3e,
options 2
Jul 20 16:11:21 host kernel: (scsi1:A:2): 6.600MB/s transfers (16bit)
Jul 20 16:11:21 host kernel: scsi1: target 2 using 16bit transfers
Jul 20 16:11:21 host kernel: (scsi1:A:2): 160.000MB/s transfers
(80.000MHz DT, offset 62, 16bit)
Jul 20 16:11:21 host kernel: scsi1: target 2 synchronous at 80.0MHz DT,
offset = 0x3e
Jul 20 16:11:24 host kernel:   Vendor: Promise   Model:  8 Disk
RAID5     Rev: 1.10
Jul 20 16:11:24 host kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 03
Jul 20 16:11:24 host kernel: blk: queue e1671e18, I/O limit 524287Mb
(mask 0x7fffffffff)
Jul 20 16:11:24 host kernel:   Vendor: Promise   Model:  7 Disk
RAID5     Rev: 1.10
Jul 20 16:11:24 host kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 03
Jul 20 16:11:24 host kernel: blk: queue cb8e0818, I/O limit 524287Mb
(mask 0x7fffffffff)
Jul 20 16:11:24 host kernel:   Vendor: Promise   Model: RAID
Console      Rev: 1.00
Jul 20 16:11:24 host kernel:   Type:  
Processor                          ANSI SCSI revision: 03
Jul 20 16:11:24 host kernel: blk: queue d2172e18, I/O limit 524287Mb
(mask 0x7fffffffff)
Jul 20 16:11:27 host kernel: (scsi1:A:0): 160.000MB/s transfers
(80.000MHz DT, offset 62, 16bit)
Jul 20 16:11:27 host kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth
16
Jul 20 16:11:27 host kernel: (scsi1:A:1): 160.000MB/s transfers
(80.000MHz DT, offset 62, 16bit)
Jul 20 16:11:27 host kernel: scsi1:A:1:0: Tagged Queuing enabled.  Depth
16
Jul 20 16:11:27 host kernel: (scsi1:A:2): 160.000MB/s transfers
(80.000MHz DT, offset 62, 16bit)
Jul 20 16:11:27 host kernel: Attached scsi disk sdb at scsi1, channel 0,
id 0, lun 0
Jul 20 16:11:27 host kernel: Attached scsi disk sdc at scsi1, channel 0,
id 1, lun 0
Jul 20 16:11:27 host kernel: SCSI device sdb: 4101561856 512-byte hdwr
sectors (2100000 MB)
Jul 20 16:11:27 host kernel:  sdb: sdb1 sdb2 sdb3
Jul 20 16:11:27 host kernel: SCSI device sdc: 3515624448 512-byte hdwr
sectors (1800000 MB)
Jul 20 16:11:27 host kernel:  sdc: sdc1 sdc2


=-=-=-=-=-=-=-=-=-=-=-=
Syslog Entry With Errors

Jul 20 16:00:41 host kernel: scsi1:0:0:0: Attempting to queue an ABORT
message
Jul 20 16:00:41 host kernel: CDB: 0x2a 0x0 0x1 0x5d 0xbf 0x7f 0x0 0x2
0x78 0x0
Jul 20 16:00:41 host kernel: scsi1: At time of recovery, card was not
paused
Jul 20 16:00:41 host kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins
<<<<<<<<<<<<<<<<<
Jul 20 16:00:41 host kernel: scsi1: Dumping Card State while idle, at
SEQADDR 0x8
Jul 20 16:00:41 host kernel: Card was paused
Jul 20 16:00:41 host kernel: ACCUM = 0x4, SINDEX = 0x64, DINDEX = 0x65,
ARG_2 = 0x3
Jul 20 16:00:41 host kernel: HCNT = 0x0 SCBPTR = 0x1
Jul 20 16:00:41 host kernel: SCSIPHASE[0x0] SCSISIGI[0x0] ERROR[0x0]
SCSIBUSL[0x0] 
Jul 20 16:00:41 host kernel: LASTPHASE[0x1] SCSISEQ[0x12] SBLKCTL[0xa]
SCSIRATE[0x0] 
Jul 20 16:00:41 host kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0]
SSTAT1[0x8] 
Jul 20 16:00:41 host kernel: SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8]
SIMODE1[0xa4] 
Jul 20 16:00:41 host kernel: SXFRCTL0[0x80] DFCNTRL[0x0] DFSTATUS[0x89] 
Jul 20 16:00:41 host kernel: STACK: 0xe8 0x16a 0x17f 0x3
Jul 20 16:00:41 host kernel: SCB count = 18
Jul 20 16:00:42 host kernel: Kernel NEXTQSCB = 5
Jul 20 16:00:42 host kernel: Card NEXTQSCB = 5
Jul 20 16:00:42 host kernel: QINFIFO entries: 
Jul 20 16:00:42 host kernel: Waiting Queue entries: 
Jul 20 16:00:43 host kernel: Disconnected Queue entries: 1:14 6:2 11:9
10:16 14:13 9:11 8:3 2:15 4:10 0:8 7:7 3:6 15:1 5:4 12:0 13:17 
Jul 20 16:00:43 host kernel: QOUTFIFO entries: 
Jul 20 16:00:43 host kernel: Sequencer Free SCB List: 16 17 18 19 20 21
22 23 24 25 26 27 28 29 30 31 
Jul 20 16:00:44 host kernel: Sequencer SCB Info: 
Jul 20 16:00:44 host kernel:   0 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x8] 
Jul 20 16:00:44 host kernel:   1 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xe] 
Jul 20 16:00:44 host kernel:   2 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xf] 
Jul 20 16:00:44 host kernel:   3 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x6] 
Jul 20 16:00:44 host kernel:   4 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xa] 
Jul 20 16:00:44 host kernel:   5 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x4] 
Jul 20 16:00:44 host kernel:   6 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x2] 
Jul 20 16:00:44 host kernel:   7 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x7] 
Jul 20 16:00:44 host kernel:   8 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x3] 
Jul 20 16:00:44 host kernel:   9 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xb] 
Jul 20 16:00:44 host kernel:  10 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x10] 
Jul 20 16:00:45 host kernel:  11 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x9] 
Jul 20 16:00:45 host kernel:  12 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x0] 
Jul 20 16:00:45 host kernel:  13 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x11] 
Jul 20 16:00:46 host kernel:  14 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xd] 
Jul 20 16:00:46 host kernel:  15 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x1] 
Jul 20 16:00:47 host kernel:  16 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:47 host kernel:  17 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:48 host kernel:  18 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:48 host kernel:  19 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:48 host kernel:  20 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:49 host kernel:  21 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:49 host kernel:  22 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:49 host kernel:  23 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:50 host kernel:  24 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:50 host kernel:  25 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:50 host kernel:  26 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:50 host kernel:  27 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:50 host kernel:  28 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:51 host kernel:  29 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:51 host kernel:  30 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:51 host kernel:  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff]
SCB_LUN[0xff] SCB_TAG[0xff] 
Jul 20 16:00:51 host kernel: Pending list: 
Jul 20 16:00:51 host kernel:  14 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   2 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   9 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:  16 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:  13 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:  11 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   3 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:  15 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:  10 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   8 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   7 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   6 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   1 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   4 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:   0 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel:  17 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0] 
Jul 20 16:00:52 host kernel: Kernel Free SCB list: 12 
Jul 20 16:00:52 host kernel: DevQ(0:0:0): 0 waiting
Jul 20 16:00:52 host kernel: DevQ(0:1:0): 0 waiting
Jul 20 16:00:52 host kernel: DevQ(0:2:0): 0 waiting
Jul 20 16:00:52 host kernel: 
Jul 20 16:00:52 host kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends
>>>>>>>>>>>>>>>>>>
Jul 20 16:00:52 host kernel: (scsi1:A:0:0): Device is disconnected,
re-queuing SCB
Jul 20 16:00:52 host kernel: Recovery code sleeping
Jul 20 16:00:52 host kernel: (scsi1:A:0:0): Abort Tag Message Sent
Jul 20 16:00:52 host kernel: (scsi1:A:0:0): SCB 1 - Abort Tag Completed.
Jul 20 16:00:52 host kernel: Recovery SCB completes
Jul 20 16:00:52 host kernel: Recovery code awake
Jul 20 16:00:52 host kernel: aic7xxx_abort returns 0x2002
Jul 20 16:00:52 host kernel: scsi1:0:0:0: Attempting to queue an ABORT
message
Jul 20 16:00:52 host kernel: CDB: 0x2a 0x0 0x1 0x5d 0xc1 0xf7 0x0 0x1
0x6a 0x0
Jul 20 16:00:52 host kernel: scsi1:0:0:0: Command not found
Jul 20 16:00:52 host kernel: aic7xxx_abort returns 0x2002
Jul 20 16:00:52 host kernel: scsi1:0:0:0: Attempting to queue an ABORT
message
Jul 20 16:00:52 host kernel: CDB: 0x2a 0x0 0x1 0x5d 0xc3 0x79 0x0 0x0
0x20 0x0
Jul 20 16:00:52 host kernel: scsi1:0:0:0: Command not found
Jul 20 16:00:52 host kernel: aic7xxx_abort returns 0x2002
Jul 20 16:01:18 host kernel: scsi1:0:0:0: Attempting to queue an ABORT
message
Jul 20 16:01:18 host kernel: CDB: 0x2a 0x0 0x1 0x5d 0x9c 0xb9 0x0 0x0
0x40 0x0
Jul 20 16:01:18 host kernel: scsi1:0:0:0: Command not found
Jul 20 16:01:18 host kernel: aic7xxx_abort returns 0x2002
Jul 20 16:01:18 host kernel: scsi1:0:0:0: Attempting to queue an ABORT
message
Jul 20 16:01:18 host kernel: CDB: 0x2a 0x0 0x1 0x5d 0xc3 0x99 0x0 0x2
0x9e 0x0
Jul 20 16:01:18 host kernel: scsi1:0:0:0: Command not found
[and more]


--=-wai8C4h8/+Kfv4U/i72k
Content-Disposition: attachment; filename=badams_logs.tgz
Content-Type: application/x-compressed-tar; name=badams_logs.tgz
Content-Transfer-Encoding: base64

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
2+h/DGjELgB4AAA=

--=-wai8C4h8/+Kfv4U/i72k--

