Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVCJWLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVCJWLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVCJWDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:03:22 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:49258 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S263252AbVCJVuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:50:39 -0500
Date: Thu, 10 Mar 2005 22:50:47 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: RAID1 not save my system in case disk failure
Message-ID: <Pine.BSO.4.61.0503102013030.17963@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-20184778-1110491447=:17963"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-20184778-1110491447=:17963
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT


Short description:

I just observe some not good consequences of disk failure in system with 
mirrored devices. After dropping I/O operations on disk chained to 
RAID1 device not all meta device are degraded. After this I observe system 
freezes for long time. Few times system completly hangs.

Long description:

- kernel version: 2.6.10 (latest from Fedora: 2.6.10-1.770_FC3smp),

- hardware configuration:
   two athlons 2000MP, 2GB RAM
   DAS: 4x36GB SCSI disks connected to Adaptec 3960D Ultra160 SCSI adapter

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: SEAGATE  Model: ST336607LW       Rev: 0007
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: PIONEER  Model: DVD-ROM DVD-305  Rev: 1.03
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
   Vendor: IBM      Model: IC35L036UWD210-0 Rev: S5BS
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
   Vendor: IBM      Model: IC35L036UWD210-0 Rev: S5BS
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 12 Lun: 00
   Vendor: IBM      Model: IC35L036UWD210-0 Rev: S5CQ
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: USB      Model: BAR              Rev: 2.00
   Type:   Direct-Access                    ANSI SCSI revision: 02

- meta devices configuration (from /proc/mdstat):

md2 : active raid1 sdb2[1] sda2[0]
       987904 blocks [2/2] [UU]

md3 : active raid1 sdd2[1] sdc2[0]
       987904 blocks [2/2] [UU]

md1 : active raid1 sdd3[1] sdc3[0]
       34772608 blocks [2/2] [UU]

md0 : active raid1 sdb3[1] sda3[0]
       34772608 blocks [2/2] [UU]

On top of md0 and md1 is configured one LVM2 volume.
md2 and md3 are used as swap devices.
Above was on system without errors.
After some system activity /dev/sda starts report dropping I/O operations.
Example report from dmesg command output:

----
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x16b
Card was paused
ACCUM = 0x40, SINDEX = 0x91, DINDEX = 0x52, ARG_2 = 0xff
HCNT = 0x0 SCBPTR = 0x5
SCSIPHASE[0x0] SCSISIGI[0x46] ERROR[0x0] SCSIBUSL[0x33]
LASTPHASE[0x40] SCSISEQ[0x12] SBLKCTL[0x6] SCSIRATE[0x95]
SEQCTL[0x10] SEQ_FLAGS[0x20] SSTAT0[0x2] SSTAT1[0x0]
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xac]
SXFRCTL0[0x88] DFCNTRL[0x0] DFSTATUS[0x89]
STACK: 0x34 0x34 0x163 0x178
SCB count = 16
Kernel NEXTQSCB = 15
Card NEXTQSCB = 15
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 9 8 7 3 2 6 11 0 4 10 1 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info:
   0 SCB_CONTROL[0xe0] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   1 SCB_CONTROL[0xe0] SCB_SCSIID[0x37] SCB_LUN[0x0] SCB_TAG[0xff]
   2 SCB_CONTROL[0xe0] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   3 SCB_CONTROL[0xe0] SCB_SCSIID[0xc7] SCB_LUN[0x0] SCB_TAG[0xff]
   4 SCB_CONTROL[0xe0] SCB_SCSIID[0x37] SCB_LUN[0x0] SCB_TAG[0xff]
   5 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x2]
   6 SCB_CONTROL[0xe0] SCB_SCSIID[0x37] SCB_LUN[0x0] SCB_TAG[0xff]
   7 SCB_CONTROL[0xe0] SCB_SCSIID[0x37] SCB_LUN[0x0] SCB_TAG[0xff]
   8 SCB_CONTROL[0xe0] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff]
   9 SCB_CONTROL[0xe0] SCB_SCSIID[0xc7] SCB_LUN[0x0] SCB_TAG[0xff]
  10 SCB_CONTROL[0xe0] SCB_SCSIID[0xc7] SCB_LUN[0x0] SCB_TAG[0xff]
  11 SCB_CONTROL[0xe0] SCB_SCSIID[0xc7] SCB_LUN[0x0] SCB_TAG[0xff]
  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  16 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  30 SCB_CONTROL[0x0] SCB_SCSIIDTAG[0xff]
  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
Pending list:
   2 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0]
Kernel Free SCB list: 7 3 10 11 0 6 1 5 4 8 9 14 13 12
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
DevQ(0:12:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi0:0:0:0: Attempting to queue a TARGET RESET message
CDB: 0x12 0x0 0x0 0x0 0x24 0x0
aic7xxx_dev_reset returns 0x2003
scsi0:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x25 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
aic7xxx_dev_reset returns 0x2003
scsi0:0:2:0: Attempting to queue a TARGET RESET message
CDB: 0x2a 0x0 0x4 0x45 0xc7 0x45 0x0 0x0 0x8 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
SCSI error : <0 0 0 0> return code = 0x10000
SCSI error : <0 0 0 0> return code = 0x10000
SCSI error : <0 0 0 0> return code = 0x10000
SCSI error : <0 0 0 0> return code = 0x10000
scsi0:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
SCSI error : <0 0 0 0> return code = 0x10000
SCSI error : <0 0 0 0> return code = 0x10000
SCSI error : <0 0 0 0> return code = 0x10000
scsi0:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
SCSI error : <0 0 0 0> return code = 0x10000
SCSI error : <0 0 0 0> return code = 0x10000
SCSI error : <0 0 0 0> return code = 0x10000
scsi0:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
SCSI error : <0 0 0 0> return code = 0x10000
md: cannot remove active disk sda2 from md2 ...
md: cannot remove active disk sda2 from md2 ...
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
-----

And after this /proc/mdstat shows:

Personalities : [raid1]
md2 : active raid1 sdb2[1] sda2[0]
       987904 blocks [2/2] [UU]

md3 : active raid1 sdd2[1] sdc2[0]
       987904 blocks [2/2] [UU]

md1 : active raid1 sdd3[1] sdc3[0]
       34772608 blocks [2/2] [UU]

md0 : active raid1 sdb3[1]              <<=====
       34772608 blocks [2/1] [_U]        <<=====

unused devices: <none>

So md0 was degraded .. good.
But md2 not .. bad.
After this system still tries touch /dev/sda and sill in logs I see
reports about I/O dropping. During operate on /dev/sda system 
freezes for relative logn time (20-30 s) .. all what I can do 
during this freezes is moving mouse cursor.
Also two times I observe system completly hangs and only cold restart 
helps.
Workaroud for above is of course:

# swapoff /dev/md2

But .. question is: why md2 was not degraded ? :>
md2 still is used on swap activity and this is probably root of freezez.

In above dmesg log I see repeated line:

scsi0:A:0:0: DV failed to configure device.  Please file a bug report against this driver.

Maybe this is root of problems (?).
What more can I do for better describe this case if above will not help ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-20184778-1110491447=:17963--
