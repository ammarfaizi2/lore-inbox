Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292533AbSCSUII>; Tue, 19 Mar 2002 15:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292539AbSCSUH7>; Tue, 19 Mar 2002 15:07:59 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:26261 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292533AbSCSUHn>; Tue, 19 Mar 2002 15:07:43 -0500
Message-ID: <3C979955.22A4C79D@zeroscale.com>
Date: Tue, 19 Mar 2002 21:02:29 +0100
From: Martin Rode <Martin.Rode@zeroscale.com>
Organization: Zeroscale GmbH & Co. KG / Programmfabrik GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New IBM IDE drive recognized as 40 GB but is 80 GB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers,

This problem is on a:

Linux version 2.4.18-pre3-ac1 (root@apu.pf-berlin.de) (gcc version 2.96

We have bought a new IDE hard drive:

hdb: IC35L040AVVA07-0, ATA DISK drive

This is wrongly recognized as 40GB (should be 80GB) drive:

>From dmesg:
====================
ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:pio, hdd:pio
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3649/255/63,
(U)DMA
hdb: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=5005/255/63,
UDMA(33)
                       <----> this is wrong
But doing:

[root@apu /root]# cat /proc/ide/hdb/capacity
80418240           <--------------------------------- this is correct
[root@apu /root]#

shows the right capacity.

The CHS counts in dmesg are not the ones physically printed on the
drive. However, a kernel command line "hdb=16383/16/63" did not fix the
problem and resulted in the same GB count.

mke2fs on a fully allocated /dev/hdb1 shows 40GB to me.
Using LVM on the whole drive /dev/hdb same thing, only 40 GB.

What am I doing wrong?

Thanks for your help and a private cc, since I'm no subscriber.

Take Care,

;Martin



Below my kernel config (IDE relevant stuff):

Config:
=====================
[root@apu /root]# grep IDE /root/apukernel/linux/.config
# CONFIG_PARIDE is not set
# ATA/IDE/MFM/RLL support
CONFIG_IDE=y
# IDE, ATA and ATAPI Block devices
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y
# Old CD-ROM drivers (not SCSI, not IDE)
# CONFIG_CD_NO_IDESCSI is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_VIDEO_DEV is not set
# CONFIG_VIDEO_SELECT is not set
[root@apu /root]#
