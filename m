Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312395AbSCaUht>; Sun, 31 Mar 2002 15:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312405AbSCaUhl>; Sun, 31 Mar 2002 15:37:41 -0500
Received: from mathsun1.math.utk.edu ([160.36.50.30]:40973 "HELO
	mathsun1.math.utk.edu") by vger.kernel.org with SMTP
	id <S312395AbSCaUha>; Sun, 31 Mar 2002 15:37:30 -0500
Date: Sun, 31 Mar 2002 15:37:26 -0500
From: Geoffrey Hoff <ghoff@math.utk.edu>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: 2.4.19-pre3 udma ide hang with heavy disk activity
Message-ID: <20020331203726.GB16709@MATHSUN1.MATH.UTK.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On kernels 2.4.19-pre3 and later I get a disk hang any time I generate
heavy disk activity.  My test is a quick script that untars 2.4.0 and
then applys patch up to 2.4.19 and repeats.  With kernels 19-pre3
through 19-pre5, I can usually get through about the third patch and then
my hard drive activity led goes solid and I can no longer access any
disk.  This is happening specifically with a VIA controller (vt82c596b
rev 22) with a Maxtor 91536U6.  Attached are part of my dmesg,
proc/ide/via, hdinfo of /dev/hda and part of my .config.  If I use
hdparm to set the drive to mdma2 in 19-pre3 I never see any problems.  It
only happens in any udma mode.  I compiled 19-pre3 with the via
driver disabled, but the problem continues.  I also tried 19-pre5 as I
looked and saw that it contains more ide updates, but I get the same
results.

In 19-pre2 and previous kernels, If the drive is running in UDMA66, I
ocassionally get checksum errors and retries so I usually on boot put
the drive in UDMA33 mode.  I have never seen any error of any kind in
this mode.  I have tried modes udma0, 2, and 4 on 2.4.19-pre3 and they
all eventually hang.  When this hang occurs, I get no kernel messages at
all.  I set dmesg to level 8 so I should see any message on the console.
If it weren't for ext3 and reiserfs, I would be very tired of fscks by
now.  If there is anything that I can try to help narrow this problem
down, please let me know.

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 91536U6, ATA DISK drive
hdc: Memorex CRW-2642, ATAPI CD/DVD-ROM drive
hdd: QUANTUM BIGFOOT2550A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 30000096 sectors (15360 MB) w/2048KiB Cache, CHS=1867/255/63, UDMA(66)
hdd: 5033952 sectors (2577 MB) w/87KiB Cache, CHS=4994/16/63, DMA
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 > hda4
 hdd: [PTBL] [624/128/63] hdd1

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=via

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c596b
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xe000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       DMA
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      90ns      30ns
Cycle Time:          30ns     600ns     180ns     120ns
Transfer Rate:   66.0MB/s   3.3MB/s  11.0MB/s  16.5MB/s

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hdinfo


/dev/hda:

non-removable ATA device, with non-removable media
	Model Number:		Maxtor 91536U6                          
	Serial Number:		W606XRXA            
	Firmware Revision:	VA510PF0
Standards:
	Used: ATA/ATAPI-4 T13 1153D revision 17 
	Supported: 1 2 3 4 5 & some of 5
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	bytes/track:	0		(obsolete)
	bytes/sector:	0		(obsolete)
	current sector capacity: 16514064
	LBA user addressable sectors = 30000096
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 2048.0kB	ECC bytes: 57	Queue depth: 1
	Standby timer values: spec'd by standard, no device specific minimum
	r/w multiple sector transfer: Max = 16	Current = 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	look-ahead
	   *	write cache
	   *	Power Management feature set
		SMART feature set
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
HW reset results:
	CBLID- below Vih
	Device num = 0 determined by the jumper
Checksum: correct

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1867/255/63, sectors = 30000096, start = 0
 busstate     =  1 (on)

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dot-config

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
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC_ADMA is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_ELEVATOR_NOOP is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

--EVF5PPMfhYS0aIcm--
