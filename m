Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265284AbUETWRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbUETWRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUETWRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:17:33 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:23964 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S265284AbUETWRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:17:04 -0400
Subject: Re: Sluggish performances with FreeBSD
From: Laurent Goujon <laurent.goujon@online.fr>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20040520232957.A2172@electric-eye.fr.zoreil.com>
References: <1085080302.7764.20.camel@caribou.no-ip.org>
	 <20040520193406.GA16184@ss1000.ms.mff.cuni.cz>
	 <1085083195.4240.4.camel@caribou.no-ip.org>
	 <20040520232957.A2172@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1085091424.4238.13.camel@caribou.no-ip.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7-2mdk 
Date: Fri, 21 May 2004 00:17:05 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu, 20/05/2004 à 23:29 +0200, Francois Romieu a écrit :
> Laurent Goujon <laurent.goujon@online.fr> :
> > In ifconfig stats, I have no error, no overruns or dropped packets.
> > And remove the acpi modules have no effect...
> 
> - same thing if the acpi module is not inserted _at all_ during the boot ?
Same thing ! (add acpi=off option, disable acpi and acpid init scripts
which load the acpi modules)

> - how do you stress the network pipe ? 
Using ftp and nfs ! For more accurate results, I'm using netperf
(duration : 60s)

> - you probably want to provide detailled ethtool/lspci -vx output, 
>   (complete) dmesg from the boot sequence and vmstat 1 during your tests.
>   /proc/interrupts can't hurt either

ethtool -i output :
driver: sis900
version: v1.08.07 11/02/2003
firmware-version:
bus-info: 0000:00:03.0

lspci -vx :

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
	Flags: bus master, medium devsel, latency 32
	Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: <available only to root>
00: 39 10 50 06 07 00 10 22 01 00 00 06 00 20 80 00
10: 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: cfc00000-dfcfffff
00: 39 10 01 00 07 01 00 00 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 a0 a0 00 20
20: e0 df e0 df c0 cf c0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS961 [MuTIOL
Media IO]
	Flags: bus master, medium devsel, latency 0
00: 39 10 61 09 0f 00 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
	Flags: medium devsel, IRQ 11
	I/O ports at 0c00 [size=32]
00: 39 10 16 00 01 00 80 02 00 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00

00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at dfffa000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 07 10 03 0c 08 40 00 00
10: 00 a0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 01 70
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 50

00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 07 10 03 0c 08 40 00 00
10: 00 b0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 01 70
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 50

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller
(A,B step)
	Flags: bus master, fast devsel, latency 128
	I/O ports at ff00 [size=16]
00: 39 10 13 55 05 00 00 00 d0 80 01 01 00 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 39 10 13 55
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem]
(rev a0) (prog-if 00 [Generic])
	Subsystem: Uniwill Computer Corp: Unknown device 4003
	Flags: medium devsel, IRQ 10
	I/O ports at d400 [size=256]
	I/O ports at d000 [size=128]
	Capabilities: <available only to root>
00: 39 10 13 70 01 01 90 02 a0 00 03 07 00 40 00 00
10: 01 d4 00 00 01 d0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 84 15 03 40
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 03 34 0b

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
	Subsystem: Uniwill Computer Corp: Unknown device 5203
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at dc00 [size=256]
	I/O ports at d800 [size=128]
	Capabilities: <available only to root>
00: 39 10 12 70 05 01 90 02 a0 00 01 04 00 40 00 00
10: 01 dc 00 00 01 d8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 84 15 03 52
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 03 34 0b

00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 90)
	Subsystem: Uniwill Computer Corp: Unknown device 5002
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at cc00 [size=256]
	Memory at dfff9000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffc0000 [disabled] [size=128K]
	Capabilities: <available only to root>
00: 39 10 00 09 07 01 90 02 90 00 00 02 00 40 00 00
10: 01 cc 00 00 00 90 ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 84 15 02 50
30: 00 00 fc df 40 00 00 00 00 00 00 00 0b 01 34 0b

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Uniwill Computer Corp: Unknown device 5100
	Flags: 66Mhz, medium devsel, IRQ 11
	BIST result: 00
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at ac00 [size=128]
	Capabilities: <available only to root>
00: 39 10 25 63 03 00 b0 02 00 00 00 03 00 00 00 80
10: 08 00 00 d0 00 00 ee df 01 ac 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 84 15 00 51
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00

dmesg output:

Linux version 2.6.6-3mdk (nplanel@n3.mandrakesoft.com) (gcc version
3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #1 Thu May 20 00:12:26 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
 BIOS-e820: 000000000dff0000 - 000000000dff8000 (ACPI data)
 BIOS-e820: 000000000dff8000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff0ffff (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
223MB LOWMEM available.
On node 0 totalpages: 57328
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53232 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @
0x000fa920
ACPI: RSDT (v001 AMIINT SiS645XX 0x00000010 MSFT 0x0100000b) @
0x0dff0000
ACPI: FADT (v002 AMIINT SiS645XX 0x00000011 MSFT 0x0100000b) @
0x0dff0030
ACPI: DSDT (v001    SiS      650 0x00001000 MSFT 0x0100000d) @
0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Mandrake ro root=306 devfs=mount
resume=/dev/hda7 splash=silent
bootsplash: silent mode.
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1693.422 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 223208k/229312k available (1832k kernel code, 5428k reserved,
909k data, 276k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 3358.72 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 3febf9ff 00000000 00000000
00000000
CPU:     After vendor identify, caps: 3febf9ff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 1.70GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 223k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
Looking for DSDT in initrd ... not found!
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS961 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [LPTP] (off)
ACPI: Embedded Controller [EC0] (gpe 11)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Disabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
vesafb: framebuffer at 0xd0000000, mapped to 0xce809000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at cbb9:0000
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1085097373.425:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1024x768,
120029 bytes, v3).
Console: switching to colour frame buffer device 80x25
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: FUJITSU MHR2020AT, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITACD-RW CW-8121, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.1
 Sensor: 8
 new absolute packet format
input: SynPS/2 Synaptics TouchPad on isa0060/serio2
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
Resume Machine: resuming from /dev/hda7
Resuming from device hda7
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.14 2004-Apr-28, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 276k freed
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.2: Silicon Integrated Systems [SiS] USB 1.0
Controller
ohci_hcd 0000:00:02.2: irq 5, pci mem ceb10000
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.3: Silicon Integrated Systems [SiS] USB 1.0
Controller (#2)
ohci_hcd 0000:00:02.3: irq 5, pci mem ceb17000
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
EXT3 FS on hda6, internal journal
Adding 401552k swap on /dev/hda7.  Priority:-1 extents:1
SCSI subsystem initialized
imm: Version 2.05 (for Linux 2.4.0)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
ppa: Version 2.07 (for Linux 2.4.x)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 176M
agpgart: AGP aperture is 64M @ 0xe0000000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Supermount version 2.0.4 for kernel 2.6
NTFS driver 2.1.11 [Flags: R/O MODULE].
NTFS volume version 3.1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sis900.c: v1.08.07 11/02/2003
eth0: Unknown PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xcc00, IRQ 11, 00:a0:cc:cf:86:c7.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1791 buckets, 14328 max) - 296 bytes per
conntrack
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC0] (on-line)
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (75 C)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
inserting floppy driver for 2.6.6-3mdk
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
NET: Registered protocol family 17
intel8x0_measure_ac97_clock: measured 49564 usecs
intel8x0: clocking to 48000
nfs warning: mount version older than kernel
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0370920(lo)
IPv6 over IPv4 tunneling driver
lp0: using parport0 (polling).
lp0: console ready
mtrr: 0xd0000000,0x2000000 overlaps existing 0xd0000000,0x200000
eth0: no IPv6 routers present
Disabled Privacy Extensions on device c0370920(lo)
eth0: no IPv6 routers present

/proc/interrupts :
           CPU0       
  0:     962515          XT-PIC  timer
  1:       2241          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ohci_hcd, ohci_hcd
  8:          1          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 10:        560          XT-PIC  SiS SI7012
 11:      21223          XT-PIC  eth0
 12:     103559          XT-PIC  i8042
 14:      17723          XT-PIC  ide0
 15:       9127          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

vmstat 1 output during test :
procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 0  0  18388  17584   4008  75600    0    0     0     0 1016   152  6  1
93  0
 0  0  18388  17584   4008  75600    0    0     0     0 1041   179  4  0
96  0
 0  0  18360  17536   4016  75628   32    0    32    16 1025   168  6  0
81 13
 0  0  18360  17536   4016  75628    0    0     0     0 1038   151  3  1
96  0
 0  0  18360  17536   4016  75628    0    0     0     0 1017   155  4  1
95  0
 0  0  18360  17536   4016  75628    0    0     0     0 1038   150  3  0
97  0
 0  0  18360  17536   4016  75628    0    0     0     0 1017   135  4  0
96  0
 0  0  18360  17544   4024  75628    0    0     0    16 1037   178  7  0
81 12
 0  0  18360  17544   4024  75628    0    0     0     0 1015   136  3  0
97  0
 0  0  18360  17544   4024  75628    0    0     0     0 1038   159  4  0
96  0
 0  0  18360  17544   4024  75628    0    0     0     0 1019   150  3  1
96  0



> --
> Ueimor

Laurent G.

