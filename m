Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSH1JLM>; Wed, 28 Aug 2002 05:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSH1JLM>; Wed, 28 Aug 2002 05:11:12 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:41231 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317251AbSH1JLH>; Wed, 28 Aug 2002 05:11:07 -0400
Date: Wed, 28 Aug 2002 11:15:08 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: ide-2.4.20-pre4-ac2.patch
Message-ID: <20020828091508.GA1113@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Hedrick <andre@linux-ide.org>
Date: Tue, Aug 27, 2002 at 03:17:31PM -0700
> 
> This is out and has been forwarded to AC for review.
> 
burning an ide-scsi cdrom works better:

==========================
INTEL :cdrecord -v -eject -speed=16 -dev=1,0,0 test.iso02.iso
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 J”rg Schilling
TOC Type: 1 = CD-ROM
scsidev: '1,0,0'
scsibus: 1 target: 0 lun: 0
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.5'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'LITE-ON '
Identifikation : 'LTR-40125W      '
Revision       : 'WS05'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 1895168 = 1850 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data  393 MB
Total size:     451 MB (44:43.57) = 201268 sectors
Lout start:     451 MB (44:45/43) = 201268 sectors

scsi : aborting command due to timeout : pid 73, scsi1, channel 0, id 0, lun 0 Mode Sense (10) 00 3f 00 00 00 00 01 03 00
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -12513 (97:15/12)
  ATIP start of lead out: 359849 (79:59/74)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 22
Manufacturer: Ritek Co.
Blocks total: 359849 Blocks current: 359849 Blocks remaining: 158581
Starting to write CD/DVD at speed 16 in write mode for single session.
Last chance to quit, starting real write in 0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
Performing OPC...
==========================
However, I got worrying messages from my hdk drive shortly afterwards:


==========================
Aug 28 10:56:57 middle kernel: hdk: drive not ready for command
Aug 28 10:56:57 middle kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 28 10:56:57 middle kernel:
Aug 28 10:56:57 middle kernel: hdk: drive not ready for command
Aug 28 10:57:02 middle kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 28 10:57:02 middle kernel:
Aug 28 10:57:02 middle kernel: hdk: drive not ready for command
Aug 28 10:57:08 middle kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 28 10:57:08 middle kernel:
Aug 28 10:57:08 middle kernel: hdk: drive not ready for command
Aug 28 10:57:08 middle kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 28 10:57:08 middle kernel:
Aug 28 10:57:08 middle kernel: hdk: drive not ready for command
Aug 28 10:57:18 middle kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 28 10:57:18 middle kernel:
Aug 28 10:57:18 middle kernel: hdk: drive not ready for command
Aug 28 10:57:18 middle kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 28 10:57:18 middle kernel:
Aug 28 10:57:18 middle kernel: hdk: drive not ready for command
Aug 28 10:57:23 middle kernel: hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 28 10:57:23 middle kernel:
Aug 28 10:57:23 middle kernel: hdk: drive not ready for command
==========================

lspci:
==========================
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c860 (rev 13)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03)
==========================

dmesg (only relevant lines):
==========================
Linux version 2.4.20-pre4-ac2 (root@middle) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Aug 26 15:51:13 CEST 2002
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5770
Intel MultiProcessor Specification v1.4
Processors: 2
Kernel command line: root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=power-off mem=1048512K
ide_setup: hdc=scsi
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 48
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:DMA
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xe000-0xe007, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xe008-0xe00f, BIOS settings: hdk:DMA, hdl:pio
hda: Maxtor 33073H3, ATA DISK drive
hdc: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307045, ATA DISK drive
ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
         Switching to Ultra33 mode.
Warning: Primary channel requires an 80-pin cable for operation.
hde reduced to Ultra33 mode.
hdi: Maxtor 4G120J6, ATA DISK drive
hdk: Maxtor 4G120J6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xac00-0xac07,0xb002 on irq 16
ide4 at 0xd000-0xd007,0xd402 on irq 18
ide5 at 0xd800-0xd807,0xdc02 on irq 18
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hde: host protected area => 1
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(33)
hdi: host protected area => 1
hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
hdk: host protected area => 1
hdk: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
ide-cd: passing drive hdc to ide-scsi emulation.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
 hde: [PTBL] [5606/255/63] hde1 hde2 hde3
 hdi: hdi1 hdi2 hdi3
 hdk: hdk1 hdk2 hdk3
Floppy drive(s): fd0 is 1.44M
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000020]
 [events: 00000020]
 [events: 00000020]
md: autorun ...
md: considering hdk3 ...
md:  adding hdk3 ...
md:  adding hdi3 ...
md:  adding hde3 ...
md: created md0
md: bind<hde3,1>
md: bind<hdi3,2>
md: bind<hdk3,3>
md: running: <hdk3><hdi3><hde3>
md: hdk3's event counter: 00000020
md: hdi3's event counter: 00000020
md: hde3's event counter: 00000020
md0: max total readahead window set to 768k
md0: 3 data-disks, max readahead per data-disk: 256k
raid0: looking at hde3
raid0:   comparing hde3(6554432) with hde3(6554432)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdi3
raid0:   comparing hdi3(6554432) with hde3(6554432)
raid0:   EQUAL
raid0: looking at hdk3
raid0:   comparing hdk3(6554432) with hde3(6554432)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hde3 ... contained as device 0
  (6554432) is smallest!.
raid0: checking hdi3 ... contained as device 1
raid0: checking hdk3 ... contained as device 2
raid0: zone->nb_dev: 3, size: 19663296
raid0: current zone offset: 6554432
raid0: done.
raid0 : md_size is 19663296 blocks.
raid0 : conf->smallest->size is 19663296 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdk3 [events: 00000021]<6>(write) hdk3's sb offset: 6554432
md: hdi3 [events: 00000021]<6>(write) hdi3's sb offset: 6554432
md: hde3 [events: 00000021]<6>(write) hde3's sb offset: 6554432
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
==========================

and afterwards, my raid-0 array was corrupted:

==========================
Aug 28 11:09:38 middle kernel: vs-5150: search_by_key: invalid format found in block 796367. Fsck?
Aug 28 11:09:38 middle kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [10133 31020 0x0 SD]
Aug 28 11:09:38 middle kernel: is_tree_node: node level 65535 does not match to the expected one 1
Aug 28 11:09:38 middle kernel: vs-5150: search_by_key: invalid format found in block 796367. Fsck?
Aug 28 11:09:38 middle kernel: vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [10133 31021 0x0 SD]
Aug 28 11:09:38 middle kernel: is_tree_node: node level 65535 does not match to the expected one 1
==========================

This kind of corruption required reiserfsck --rebuild-tree, which gives
all sorts of nice messages afterwards:

==========================
Flushing..done
        Files found: 4526
        Directories found: 314
        Names pointing to nowhere (removed): 144
Pass 3a (looking for lost dir/files):
####### Pass 3a (lost+found pass) #########
Looking for lost directories:
Looking for lost files:1 /sec
Flushing..done done 0, 0 /sec
        Objects without names 151
        Empty lost dirs removed 151
        Files linked to /lost+found 151
Pass 4 - done           done 0, 0 /sec
Flushing..done
Syncing..done
###########
reiserfsck finished at Wed Aug 28 11:13:42 2002
###########
==========================

And I still get the erroneous '80-pin cable needed' message, and I am
using an 80-pin cable.

Hope this helps,
Jurriaan
-- 
Put it this way, when people slip in what dogs have left in the streets,
they do tend to say, 'Oops, I've trod in an Edmund'.
	Blackadder II
GNU/Linux 2.4.20-pre4-ac2 SMP/ReiserFS 2x1402 bogomips load av: 0.02 0.19 0.26
