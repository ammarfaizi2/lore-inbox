Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbUBEU1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUBEU1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:27:38 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:22357 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266524AbUBEU0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:26:24 -0500
Message-ID: <4022A6E4.1030103@uchicago.edu>
Date: Thu, 05 Feb 2004 14:26:12 -0600
From: Ryan Reich <ryanr@uchicago.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-ck1
References: <1lOM6-i6-3@gated-at.bofh.it>
In-Reply-To: <1lOM6-i6-3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get "bad: scheduling while atomic" on boot, before init starts.  Full 
dmesg follows.  It appears to follow the discovery of my "initrd," which is 
really just a bootsplash image (I don't use initrd for anything else).

Linux version 2.6.2-ck1 (ryanr@ryanr) (gcc version 2.95.3 20010315 
(release)) #2 Thu Feb 5 14:10:52 CST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
  user: 0000000000000000 - 000000000009fc00 (usable)
  user: 000000000009fc00 - 00000000000a0000 (reserved)
  user: 00000000000f0000 - 0000000000100000 (reserved)
  user: 0000000000100000 - 000000000fff0000 (usable)
255MB LOWMEM available.
On node 0 totalpages: 65520
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 61424 pages, LIFO batch:14
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6f50
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff7880
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hdb1 rw quiet vga=791 mem=262080K
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2079.998 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 256120k/262080k available (1517k kernel code, 5216k reserved, 750k 
data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4112.38 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
bad: scheduling while atomic!
Call Trace:
  [<c0116eac>] schedule+0x3c/0x530
  [<c014b76f>] __set_page_dirty_buffers+0xff/0x110
  [<c016608c>] simple_commit_write+0x6c/0x80
  [<c01182e7>] __cond_resched+0x17/0x20
  [<c0132d99>] generic_file_aio_write_nolock+0x959/0xa40
  [<c0161567>] inode_setattr+0x127/0x140
  [<c013459d>] buffered_rmqueue+0xfd/0x110
  [<c013464b>] __alloc_pages+0x9b/0x2f0
  [<c0132eef>] generic_file_write_nolock+0x6f/0x90
  [<c0137393>] cache_grow+0x1c3/0x280
  [<c01375f1>] cache_alloc_refill+0x1a1/0x200
  [<c013785f>] kmem_cache_alloc+0x2f/0x40
  [<c014aa0d>] file_move+0x3d/0x50
  [<c0148f6b>] dentry_open+0xeb/0x1e0
  [<c0132fd2>] generic_file_write+0x42/0x60
  [<c0149c1c>] vfs_write+0x9c/0xd0
  [<c0105000>] _stext+0x0/0x60
  [<c0149cd1>] sys_write+0x31/0x50
  [<c033ce6a>] populate_rootfs+0xba/0xe0
  [<c033a64b>] start_kernel+0x14b/0x180

Freeing initrd memory: 38k freed
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2600+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb590, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17)
ACPI: PCI Interrupt Link [APC3] (IRQs 18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbfe0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc010, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
vesafb: framebuffer at 0xe0000000, mapped to 0xd0808000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:545e
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (36 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
bootsplash 3.1.3-2003/11/14: looking for picture.... silentjpeg size 19730 
bytes, found (1024x768, 19600 bytes, v3).
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Using cfq io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVVN07-0, ATA DISK drive
hdb: Maxtor 6E040L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-RW 52X24, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1
hdb: max request size: 128KiB
hdb: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
  /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 p6 p7 p8 >
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: GenPS/2 Genius Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
RAMDISK: Couldn't find valid RAM disk image starting at 0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb1, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb1) for (hdb1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem).
Freeing unused kernel memory: 120k freed
NET: Registered protocol family 1
Adding 530104k swap on /dev/hdb8.  Priority:1 extents:1
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb5, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb5) for (hdb5)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb6, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb6) for (hdb6)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb7, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb7) for (hdb7)
Using r5 hash to sort names
Supermount version 2.0.4 for kernel 2.6
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:02.2: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 11, pci mem d1984000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem d1993000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem d1cd6000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
Real Time Clock Driver v1.12
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.19.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01297:0531 bound to 0000:00:04.0
NET: Registered protocol family 17
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 304 bytes per conntrack
process `named' is using obsolete setsockopt SO_BSDCOMPAT
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, hp deskjet 5550
lp0: using parport0 (polling).
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0: clocking to 47441
request_module: failed /sbin/modprobe -- snd-card-2. error = 256
bootsplash 3.1.3-2003/11/14: looking for picture.... found, freeing memory.
bootsplash: status on console 0 changed to off
mtrr: 0xe0000000,0x4000000 overlaps existing 0xe0000000,0x1000000
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
mtrr: 0xe0000000,0x4000000 overlaps existing 0xe0000000,0x1000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 4x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

-- 
Ryan Reich
ryanr@uchicago.edu
