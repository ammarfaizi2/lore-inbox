Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319114AbSIDJnV>; Wed, 4 Sep 2002 05:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319116AbSIDJnV>; Wed, 4 Sep 2002 05:43:21 -0400
Received: from c144049.adsl.hansenet.de ([213.39.144.49]:2308 "EHLO
	smaug.lan.local") by vger.kernel.org with ESMTP id <S319114AbSIDJnS>;
	Wed, 4 Sep 2002 05:43:18 -0400
Message-ID: <XFMail.20020904114748.f.hinzmann@hamburg.de>
X-Mailer: XFMail 1.5.2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Wed, 04 Sep 2002 11:47:48 +0200 (CEST)
From: Florian Hinzmann <f.hinzmann@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have problems with DMA mode at one of my boxes ( more technical 
details at the end of this mail ).

It has one small disk (hda) and three disks bigger than 32GB. The machine
does not boot with that big harddisks connected even if they are not
listed in the BIOS. To circumvent this the three Maxtor disks (hdb,hdc,hdd) 
have jumpers set which reduces them to 4092 cylinder. I the setmax utility 
before to "unclip" them, but now the STROKE kernel option does this job and 
that works fine.

But I do issue a "hdparm -d0" for each of them at bootup currently and they 
are running fine then. Enabling DMA with "hdparm -d1" (or not using hdparm at all)
leads to errors like the following quite fast and reproducable:

kernel: hdb: dma_timer_expiry: dma status == 0x60
kernel: hdb: timeout waiting for DMA
kernel: hdb: timeout waiting for DMA
kernel: hdb: (__ide_dma_test_irq) called while not waiting
kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: 
kernel: hdb: drive not ready for command 

Turning DMA off again stops these.


I'd love to hear any experience other people have with this mainboard
or even some statement if DMA is supposed to work with my setup.


Technical details below. If anything is missing please say so and I
will get it.


Regards
 
   Florian

-------------------------------------------------------------------------------
Mainboard: Asus P/I-XP55T2P4

--- part of dmesg -------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: Maxtor 82560A4, ATA DISK drive
hdb: Maxtor 4D080H4, ATA DISK drive
hdc: Maxtor 4W080H6, ATA DISK drive
hdd: Maxtor 4D060H3, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 5001728 sectors (2561 MB) w/256KiB Cache, CHS=620/128/63, DMA
hdb: host protected area => 1
hdb: 160086527 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, (U)DMA
hdc: host protected area => 1
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, (U)DMA
hdd: host protected area => 1
hdd: 120069935 sectors (61476 MB) w/2048KiB Cache, CHS=7474/255/63, (U)DMA
Partition check:
 hda: hda1 hda2
 hdb: hdb1
 hdc: hdc1
 hdd: hdd1

--- part of lspci -vv ---------------------------------------------------------
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at e800 [size=16]

--- atapci (v0.50) ------------------------------------------------------------
pcibus = 33333
00:07.1 vendor=8086 device=7010 class=0101 irq=0 base4=e801
----------PIIX BusMastering IDE Configuration---------------
Driver Version:                     1.3
South Bridge:                       28688
Revision:                           IDE 0
Highest DMA rate:                   MWDMA16
BM-DMA base:                        0xe800
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Prefetch+Post:        yes       yes       yes       yes
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       90ns      90ns      90ns      90ns
Cmd Active:         360ns     360ns     360ns     360ns
Cmd Recovery:       540ns     540ns     540ns     540ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:         120ns     120ns     120ns     120ns
Transfer Rate:   16.6MB/s  16.6MB/s  16.6MB/s  16.6MB/s

--- IDE part of .config --------------------------------------------------------
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_BAILOUT=y
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set


--
  Florian Hinzmann                         private: f.hinzmann@hamburg.de
                                            Debian: fh@debian.org
PGP Key / ID: 1024D/B4071A65
Fingerprint : F9AB 00C1 3E3A 8125 DD3F  DF1C DF79 A374 B407 1A65
