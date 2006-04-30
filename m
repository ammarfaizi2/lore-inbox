Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWD3NXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWD3NXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 09:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWD3NXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 09:23:20 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:25249 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S1751109AbWD3NXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 09:23:19 -0400
Date: Sun, 30 Apr 2006 16:23:17 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: linux-kernel@vger.kernel.org
Subject: promise 20268 dma lockups with 2.4 & 2.6
Message-ID: <Pine.LNX.4.64.0604301535500.1829@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 	Hi,

 	I have a system with 4 pata disks on stripping software raid with 
Promise Faststrak TX2 controller. After about a year of normal operation(the 
system is a fileserver heavily loaded 24/7), the last two weeks the system lockups up
completely randomly after 2-4 days of uptime and has to be resetted. Just 
before the lockups,those errors appear:

Apr 30 02:40:22 system kernel: hde: dma_timer_expiry: dma status == 0x60
Apr 30 02:40:22 system kernel: hde: DMA timeout retry
Apr 30 02:40:22 system kernel: PDC202XX: Primary channel reset.
Apr 30 02:40:22 system kernel: hde: timeout waiting for DMA
Apr 30 02:40:22 system kernel: hdf: dma_intr: status=0x00 { }
Apr 30 02:40:22 system kernel: ide: failed opcode was: unknown
Apr 30 02:40:22 system kernel: hdf: dma_intr: status=0x00 { }
Apr 30 02:40:22 system kernel: ide: failed opcode was: unknown
Apr 30 02:40:22 system kernel: hdf: dma_intr: status=0x00 { }
Apr 30 02:40:22 system kernel: ide: failed opcode was: unknown
Apr 30 02:40:22 system kernel: hdf: dma_intr: status=0x00 { }
Apr 30 02:40:22 system kernel: ide: failed opcode was: unknown
Apr 30 02:40:22 system kernel: hdf: DMA disabled
Apr 30 02:40:22 system kernel: PDC202XX: Primary channel reset.
Apr 30 02:40:22 system kernel: ide2: reset: success
Apr 30 02:40:42 system kernel: hde: dma_timer_expiry: dma status == 0x21

and from the previous crash

Apr 24 18:22:21 system kernel: hde: dma_timer_expiry: dma status == 0x61
Apr 24 18:22:31 system kernel: hde: DMA timeout error
Apr 24 18:22:31 system kernel: hde: dma timeout error: status=0x80 { Busy 
}
Apr 24 18:22:31 system kernel: ide: failed opcode was: unknown
Apr 24 18:22:31 system kernel: hde: DMA disabled
Apr 24 18:22:31 system kernel: hdf: DMA disabled
Apr 24 18:22:31 system kernel: PDC202XX: Primary channel reset.
Apr 24 18:22:31 system kernel: ide2: reset: success
Apr 24 18:22:52 system kernel: hde: dma_timer_expiry: dma status == 0x21

and before that

Apr 22 04:57:27 system kernel: hde: status timeout: status=0x80 { Busy }
Apr 22 04:57:27 system kernel:
Apr 22 04:57:27 system kernel: hde: DMA disabled
Apr 22 04:57:27 system kernel: hdf: DMA disabled
Apr 22 04:57:27 system kernel: PDC202XX: Primary channel reset.
Apr 22 04:57:27 system kernel: hde: drive not ready for command
Apr 22 04:57:33 system kernel: ide2: reset: master: ECC circuitry error

and again the previous crash

Apr 19 16:05:54 system kernel: hde: dma_timer_expiry: dma status == 0x61
Apr 19 16:06:04 system kernel: hde: error waiting for DMA
Apr 19 16:06:04 system kernel: hde: dma timeout retry: status=0x80 { Busy 
}
Apr 19 16:06:04 system kernel:
Apr 19 16:06:04 system kernel: hde: DMA disabled
Apr 19 16:06:04 system kernel: hdf: DMA disabled
Apr 19 16:06:04 system kernel: PDC202XX: Primary channel reset.
Apr 19 16:06:04 system kernel: ide2: reset: success
Apr 19 16:06:04 system kernel: blk: queue c03e9e28, I/O limit 4095Mb (mask 
0xffffffff)
Apr 19 16:06:24 system kernel: hde: dma_timer_expiry: dma status == 0x21

 	More or less the same stuff repeats for a couple of more crashes. 
This is the first lockup:

Apr 13 22:02:16 system kernel: hdg: error waiting for DMA
Apr 13 22:02:16 system kernel: hdg: dma timeout retry: status=0x80 { Busy 
}
Apr 13 22:02:16 system kernel:
Apr 13 22:02:16 system kernel: hdg: DMA disabled
Apr 13 22:02:16 system kernel: hdh: DMA disabled
Apr 13 22:02:16 system kernel: PDC202XX: Secondary channel reset.
Apr 13 22:02:22 system kernel: ide3: reset: success
Apr 13 22:02:23 system kernel: hdh: status error: status=0x58 { DriveReady 
SeekComplete DataRequest }
Apr 13 22:02:23 system kernel:
Apr 13 22:02:23 system kernel: hdh: drive not ready for command
Apr 13 22:02:23 system kernel: hdh: status timeout: status=0xd0 { Busy }
Apr 13 22:02:23 system kernel:
Apr 13 22:02:23 system kernel: PDC202XX: Secondary channel reset.
Apr 13 22:02:23 system kernel: hdh: drive not ready for command
Apr 13 22:02:23 system kernel: ide3: reset: success
Apr 13 22:02:23 system kernel: hdh: status error: status=0x58 { DriveReady 
SeekComplete DataRequest }
Apr 13 22:02:23 system kernel:
Apr 13 22:02:23 system kernel: hdh: drive not ready for command
Apr 13 22:02:23 system kernel: hdh: status timeout: status=0xd0 { Busy }
Apr 13 22:02:23 system kernel:
Apr 13 22:02:23 system kernel: PDC202XX: Secondary channel reset.
Apr 13 22:02:23 system kernel: hdh: drive not ready for command
Apr 13 22:02:23 system kernel: ide3: reset: success
Apr 13 22:02:24 system kernel: blk: queue c046fd84, I/O limit 4095Mb (mask 
0xffffffff)
Apr 13 22:02:44 system kernel: hdg: dma_timer_expiry: dma status == 0x21

 	So far I tried (and failed)
1) Swap hde for a new one
2) Swap ide2 cable for new one (both not round)
3) Swapped motherboard, cpu, PSU and memory
4) Swapped fasttrak for an ultra tx2 again with 20268
5) Execute hdparm immediately after boot and manually setup udma5 mode
6) Disable SMART (smartools)
7) Upgrade from 2.4.32 to 2.6.16.9

 	Absolutely nothing worked so far.
This is the dmesg of the system when it boots

Linux version 2.6.16.9 (root@system) (gcc version 3.3.4) #2 Sat Apr 22 21:32:10 EEST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 61424 pages, LIFO batch
   HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f76e0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff7300
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 20000000 (gap: 10000000:eec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 max_loop=32
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 2004.867 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255528k/262080k available (2357k kernel code, 6000k reserved, 827k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4016.36 BogoMIPS (lpj=8032738)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.00GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 1820)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb9e0, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: f2000000-f3ffffff
   PREFETCH window: f0000000-f1ffffff
PCI: Bridge: 0000:00:1e.0
   IO window: a000-bfff
   MEM window: f4000000-f5ffffff
   PREFETCH window: 20000000-200fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Real Time Clock Driver v1.12ac
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [LNKF] -> GSI 12 (level, low) -> IRQ 12
e1000: 0000:02:0a.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:33:a6:f2
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
ICH5: chipset revision 2
ICH5: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MAXTOR 6L020J1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
PDC20268: IDE controller at PCI slot 0000:02:09.0
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LNK1] -> GSI 5 (level, low) -> IRQ 5
PDC20268: chipset revision 1
PDC20268: ROM enabled at 0x20040000
PDC20268: 100%% native mode on irq 5
     ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: WDC WD3000JB-00KFA0, ATA DISK drive
hdf: IC35L060AVVA07-0, ATA DISK drive
ide2 at 0xa400-0xa407,0xa802 on irq 5
Probing IDE interface ide3...
hdg: WDC WD2500JB-00GVA0, ATA DISK drive
hdh: WDC WD2500JB-00GVA0, ATA DISK drive
ide3 at 0xac00-0xac07,0xb002 on irq 5
Probing IDE interface ide1...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 40132503 sectors (20547 MB) w/1819KiB Cache, CHS=39813/16/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 hda3
hde: max request size: 512KiB
hde: 586072368 sectors (300069 MB) w/8192KiB Cache, CHS=36481/255/63, UDMA(100)
hde: cache flushes supported
  hde: hde1
hdf: max request size: 128KiB
hdf: 117347328 sectors (60081 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hdf: cache flushes supported
  hdf: hdf1
hdg: max request size: 512KiB
hdg: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hdg: cache flushes supported
  hdg: hdg1
hdh: max request size: 512KiB
hdh: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hdh: cache flushes supported
  hdh: hdh1
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
    pIII_sse  :  2607.000 MB/sec
raid5: using function: pIII_sse (2607.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
ip_conntrack version 2.4 (2047 buckets, 16376 max) - 232 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
input: AT Translated Set 2 keyboard as /class/input/input0
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
PCI0 HUB0 UAR1 UAR2 USB0 USB1 USB2 USB3 USBE MODM
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdh1 ...
md:  adding hdh1 ...
md:  adding hdg1 ...
md:  adding hdf1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdf1>
md: bind<hdg1>
md: bind<hdh1>
md: running: <hdh1><hdg1><hdf1><hde1>
md0: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid0: looking at hdh1
raid0:   comparing hdh1(244195904) with hdh1(244195904)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdg1
raid0:   comparing hdg1(244195904) with hdh1(244195904)
raid0:   EQUAL
raid0: looking at hdf1
raid0:   comparing hdf1(58673536) with hdh1(244195904)
raid0:   NOT EQUAL
raid0:   comparing hdf1(58673536) with hdg1(244195904)
raid0:   NOT EQUAL
raid0:   comparing hdf1(58673536) with hdf1(58673536)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: looking at hde1
raid0:   comparing hde1(244195904) with hdh1(244195904)
raid0:   EQUAL
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking hde1 ... contained as device 0
raid0: checking hdg1 ... contained as device 1
raid0: checking hdh1 ... contained as device 2
raid0: checking hdf1 ... nope.
raid0: zone->nb_dev: 3, size: 556567104
raid0: current zone offset: 244195904
raid0: done.
raid0 : md_size is 791261248 blocks.
raid0 : conf->hash_spacing is 234694144 blocks.
raid0 : nb_zone is 4.
raid0 : Allocating 16 bytes for hash.
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
Adding 538168k swap on /dev/hda3.  Priority:-1 extents:1 across:538168k
EXT3 FS on hda1, internal journal
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batc
h 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present


 	Any help is appreciated.

 	Best regards,

--
============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
============================================================================
