Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTADTDG>; Sat, 4 Jan 2003 14:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTADTDG>; Sat, 4 Jan 2003 14:03:06 -0500
Received: from f27.law8.hotmail.com ([216.33.241.27]:45839 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261312AbTADTDE>;
	Sat, 4 Jan 2003 14:03:04 -0500
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.54 ide-scsi and cdrecord
Date: Sat, 04 Jan 2003 14:11:32 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F27Iu6VXNjimExOpK7u00012a9a@hotmail.com>
X-OriginalArrivalTime: 04 Jan 2003 19:11:32.0748 (UTC) FILETIME=[17E52CC0:01C2B425]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide-scsi refuses to boot with A NULL pointer oops (is  there a patch yet?). 
But I figured it didn't matter because I could use cdrecord without the scsi 
layer. So I rebuilt 2.5.54 w/o scsi. Here's the dmesg:

.............
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y120P0, ATA DISK drive
hdb: MAXTOR 6L060J3, ATA DISK drive
hda: DMA disabled
hdb: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY CD-RW CRX195E1, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
spurious 8259A interrupt: IRQ7.
hda: host protected area => 1
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63, 
UDMA(133)
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: host protected area => 1
hdb: 117266688 sectors (60041 MB) w/1820KiB Cache, CHS=116336/16/63, 
UDMA(133)
hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 >
...........

I got cdrecord 2.0:

[root@amd1900 root]# cdrecord -scanbus -dev=ATAPI
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
scsidev: 'ATAPI'
devname: 'ATAPI'
scsibus: -2 target: -2 lun: -2
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
cdrecord: No such device or address. Cannot open SCSI driver.
cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you are 
root.
cdrecord: For possible transport specifiers try 'cdrecord dev=help'.

FWIW, I also tried just cdrecord -scanbus

What am I missing? I thought we didn't need the scsi layer anymore.

Here are snips from .config:

CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y

CONFIG_BLK_DEV_IDECD=y

# IDE chipset support/bugfixes
#

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y

CONFIG_IDEDMA_PCI_AUTO=y

CONFIG_BLK_DEV_IDEDMA=y

CONFIG_BLK_DEV_ADMA=y

CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y

CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set











_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

