Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbTCRFWs>; Tue, 18 Mar 2003 00:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbTCRFWs>; Tue, 18 Mar 2003 00:22:48 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:384 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S262019AbTCRFWm>;
	Tue, 18 Mar 2003 00:22:42 -0500
Date: Mon, 17 Mar 2003 21:33:35 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.5.65] MD RAID1 weirdness
Message-ID: <20030318053335.GA673@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just booted from 2.5.65-BK6 to 2.5.65 after an unexpected lockup in X,
and found weird MD messages at boot followed by an amazingly fast
(broken :)) resync.  /proc/mdstat now reports:

Personalities : [linear] [raid0] [raid1] 
md2 : active raid1 hde1[0] hdg1[1]
      45030080 blocks [2/2] [UU]
      
unused devices: <none>

...which can't be correct considering it normally takes 20 minutes to
resync.  Here is the dmesg (note the "sync aborting" messages):

Linux version 2.5.65 (root@oof) (gcc version 3.2.3 20030309 (Debian prerelease)) #7 Mon Mar 17 21:18:44 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7610
ACPI: RSDT (v001 VIA694 MSI ACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 VIA694 MSI ACPI 16944.11825) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=302 console=ttyS0,115200n8 console=tty0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1199.317 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2359.29 BogoMIPS
Memory: 255048k/262080k available (2486k kernel code, 6308k reserved, 809k data, 140k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1199.0339 MHz.
..... host bus clock speed is 199.0889 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb160, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
spurious 8259A interrupt: IRQ7.
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.......................................................................
Table [DSDT] - 336 Objects with 31 Devices 71 Methods 21 Regions
ACPI Namespace successfully loaded at root c047ba9c
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 0000000000004020
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:...............................
31 Devices found containing: 31 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:........................................
Initialized 17/21 Regions 0/1 Fields 14/15 Buffers 9/9 Packages (336 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.95 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
powernow: AMD K7 CPU detected.
powernow: No powernow capabilities detected
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT133/KM133/TwisterK chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST360021A, ATA DISK drive
hdb: WDC AC33100H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 010, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 00:0f.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
hde: IBM-DTLA-307045, ATA DISK drive
ide2 at 0xb400-0xb407,0xb802 on irq 11
hdg: IBM-DTLA-307045, ATA DISK drive
ide3 at 0xbc00-0xbc07,0xc002 on irq 11
hda: host protected area => 1
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: 6185088 sectors (3167 MB) w/128KiB Cache, CHS=6136/16/63, DMA
 hdb: hdb1
hde: host protected area => 1
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
 hde: hde1
hdg: host protected area => 1
hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
 hdg: hdg1
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
end_request: I/O error, dev hdd, sector 0
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:07.2: PCI device 1106:3038
uhci-hcd 00:07.2: irq 12, io base 0000a400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 00:07.3: PCI device 1106:3038
uhci-hcd 00:07.3: irq 12, io base 0000a800
uhci-hcd 00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 2003 UTC).
ALSA device list:
  #0: Trident TRID4DWAVENX PCI Audio at 0xb000, irq 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
BIOS EDD facility v0.09 2003-Jan-22, 3 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-00:07.2-1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,2): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 468187
EXT3-fs: ide0(3,2): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
blk: queue c048595c, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0485c34, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0486a24, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0487288, I/O limit 4095Mb (mask 0xffffffff)
Adding 265064k swap on /dev/hda3.  Priority:0 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
md: autorun ...
md: considering hde1 ...
md:  adding hde1 ...
md:  adding hdg1 ...
md: created md2
md: bind<hdg1>
md: bind<hde1>
md: running: <hde1><hdg1>
md: md2: raid array is not clean -- starting background reconstruction
md2: max total readahead window set to 128k
md2: 1 data-disks, max readahead per data-disk: 128k
md2: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid1: raid set md2 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: syncing RAID array md2
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 45030080 blocks.
raid1: sync aborting as there is nowhere to write sector 0
raid1: sync aborting as there is nowhere to write sector 128
raid1: sync aborting as there is nowhere to write sector 256
raid1: sync aborting as there is nowhere to write sector 384
raid1: sync aborting as there is nowhere to write sector 512
raid1: sync aborting as there is nowhere to write sector 640
raid1: sync aborting as there is nowhere to write sector 768
raid1: sync aborting as there is nowhere to write sector 896
raid1: sync aborting as there is nowhere to write sector 1024
raid1: sync aborting as there is nowhere to write sector 1152
raid1: sync aborting as there is nowhere to write sector 1280
raid1: sync aborting as there is nowhere to write sector 1408
raid1: sync aborting as there is nowhere to write sector 1536
raid1: sync aborting as there is nowhere to write sector 1664
raid1: sync aborting as there is nowhere to write sector 1792
raid1: sync aborting as there is nowhere to write sector 1920
raid1: sync aborting as there is nowhere to write sector 2048
raid1: sync aborting as there is nowhere to write sector 2176
raid1: sync aborting as there is nowhere to write sector 2304
raid1: sync aborting as there is nowhere to write sector 2432
raid1: sync aborting as there is nowhere to write sector 2560
raid1: sync aborting as there is nowhere to write sector 2688
raid1: sync aborting as there is nowhere to write sector 2816
raid1: sync aborting as there is nowhere to write sector 2944
raid1: sync aborting as there is nowhere to write sector 3072
raid1: sync aborting as there is nowhere to write sector 3200
raid1: sync aborting as there is nowhere to write sector 3328
raid1: sync aborting as there is nowhere to write sector 3456
raid1: sync aborting as there is nowhere to write sector 3584
raid1: sync aborting as there is nowhere to write sector 3712
raid1: sync aborting as there is nowhere to write sector 3840
md: md2: sync done.
raid1: sync aborting as there is nowhere to write sector 3968
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on md(9,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
Freeing alive device cf0ed000, eth%d
e100: eth0: Intel(R) PRO/100+ PCI Adapter

e100: eth0 NIC Link is Up 100 Mbps Full duplex

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
