Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSHUCIH>; Tue, 20 Aug 2002 22:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317661AbSHUCIG>; Tue, 20 Aug 2002 22:08:06 -0400
Received: from h24-71-173-70.ss.shawcable.net ([24.71.173.70]:9858 "EHLO
	valhalla.homelinux.org") by vger.kernel.org with ESMTP
	id <S317648AbSHUCIE>; Tue, 20 Aug 2002 22:08:04 -0400
Date: Tue, 20 Aug 2002 20:11:53 -0600 (CST)
From: "Jason C. Pion" <jpion@valhalla.homelinux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre2-ac5 Promise PDC20269
Message-ID: <Pine.LNX.4.44.0208201845060.10173-100000@valhalla.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've run across a bit of a strange occurrence since the "new" IDE code was 
put into the ac patches in 2.4.20-pre2-acX.  I have 2 udma133 drives 
attached to my Ultra133TX2 (PDC20269) controller.  Both drives are 
connected using 80-wire cables.  I've never had any issues with this setup 
until now.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hdc: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST GCE-8160B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller on PCI bus 00 dev 68
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x1090-0x1097, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1098-0x109f, BIOS settings: hdg:pio, hdh:pio
hde: MAXTOR 6L060J3, ATA DISK drive
ide2 at 0x10c0-0x10c7,0x10ba on irq 17
hdg: MAXTOR 6L060L3, ATA DISK drive
ide3 at 0x10b0-0x10b7,0x10a6 on irq 17
ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
         Switching to Ultra33 mode.
Warning: Primary channel requires an 80-pin cable for operation.
hde reduced to Ultra33 mode.
hde: host protected area => 1
hde: 117266688 sectors (60041 MB) w/1820KiB Cache, CHS=116336/16/63, UDMA(133)
ULTRA 66/100/133: Secondary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
         Switching to Ultra33 mode.
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
hdg: host protected area => 1
hdg: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(133)
Partition check:
 hde: [PTBL] [7299/255/63] hde1 hde2 hde3 hde4
 hdg: hdg1 hdg2 hdg3 hdg4


The dmesg output seems to indicate that hde and hdg have been "reduced to 
Ultra33 mode."  However, 2 lines later the drives are listed as 
"UDMA(133)".  hdparm indicates that the drives are operating at udma6.

Here's the relevant portion of my config:

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_DM is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE_KNOWS=y
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
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
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDECD_BAILOUT is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
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
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

The system is a dual MP 1600+ Tyan S2460 with on-board AMD7411 IDE being 
used for CD and CD-RW.

The HDs do seem to work properly, but this message at boot about 
reducing to ultra33 mode is somewhat confusing.  This has only ever 
occurred with the new ide code.  Any ideas?

Thanks.

	Jason


