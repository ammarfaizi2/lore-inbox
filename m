Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbULDR6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbULDR6o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 12:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbULDR6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 12:58:43 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:13961
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262568AbULDR42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 12:56:28 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.6.10-rc3 on VAIO laptop (USB, etc.)
Message-Id: <E1Cae8z-0001v4-00@penngrove.fdns.net>
Date: Sat, 04 Dec 2004 09:56:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of earlier issues have been fixed but a new problem has appeared.  USB
service (uhci-hcd) does not come back properly after hibernation.  So far,
'uhci-hcd' is unloaded prior to hibernation and reloaded afterwards.  If i
recall correctly, that was to make sure things come up cleanly.  It is no 
longer doing that (see below).  If it is not unloaded, then it now hangs
during suspend (also see below.  In addition, occasionally, it doesn't come
up properly to begin with, but that is not very repeatable.

Firewire still doesn't work after software suspend (even if a relevant
modules are unloaded prior to hibernation).  That effectively means i
still can't use the CD-R/W drive if i'm running off of batteries.

There is a minor module unloading issues as well.  'rmmod sd_mod' hangs if 
it is done before unloading 'usb_storage'.

That's the initial report for i386 (and i'll need to ckear up some more disk 
space to try it for the PowerMac 8500/G3).

				-- JM

Attachments: Console log for USB not coming back cleanly after hibernation
	     Console log for software suspend hanging if uhci-hcd not unloaded
-------------------------------------------------------------------------------
Linux version 2.6.10-rc3 (tvr@tvr-vaio) (gcc version 3.3.5 (Debian 1:3.3.5-2)) #1 Sat Dec 4 01:08:05 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fcf0000 (usable)
 BIOS-e820: 000000000fcf0000 - 000000000fcfc000 (ACPI data)
 BIOS-e820: 000000000fcfc000 - 000000000fd00000 (ACPI NVS)
 BIOS-e820: 000000000fd00000 - 000000000fe80000 (usable)
 BIOS-e820: 000000000fe80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
0MB HIGHMEM available.
254MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.10-rc3 ro root=307 console=ttyS0,9600 console=tty1
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1127.225 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255036k/260608k available (1662k kernel code, 4988k reserved, 720k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
vesafb: framebuffer at 0xe8000000, mapped to 0xd0880000, using 832k, total 832k
vesafb: mode is 1024x768x8, linelength=1024, pages=0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:1f.6 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PWRB USB1 USB2 USB3  LAN CRD0  EC0 COMA MODE 
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
Real Time Clock Driver v1.12
Sony Vaio Jogdial input method installed.
Sony Vaio Keys input method installed.
sonypi: Sony Programmable I/O Controller Driverv1.25.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0xe0204000, irq 9, MAC addr 08:00:46:4E:8C:7E
NTFS driver 2.1.22 [Flags: R/W MODULE].
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
intel8x0_measure_ac97_clock: measured 49430 usecs
intel8x0: clocking to 48000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
uhci_hcd 0000:00:1d.0: irq 9, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: Product: Intel Corp. 82801CA/CAM USB (Hub #1)
usb usb1: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
uhci_hcd 0000:00:1d.1: irq 9, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: Product: Intel Corp. 82801CA/CAM USB (Hub #2)
usb usb2: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
uhci_hcd 0000:00:1d.2: irq 9, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: Product: Intel Corp. 82801CA/CAM USB (Hub #3)
usb usb3: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: Product: USB Memory Stick Slot
usb 3-1: Manufacturer: Sony
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: Sony      Model: MSC-U03           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:05.0 [104d:8100]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[e0205000-e02057ff]  Max Packet=[2048]
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport0: Printer, EPSON Stylus Photo 700
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
hw_random hardware driver 1.0.0 loaded
ieee1394: sbp2: Logged into SBP-2 device
  Vendor: MATSHITA  Model: UJDA730 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [ATF0] (46 C)
lp0: using parport0 (interrupt-driven).
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
[drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82830 CGC [Chipset Graphics Controller]
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
[drm] Initialized i830 1.3.2 20021108 on minor 1: Intel Corp. 82830 CGC [Chipset Graphics Controller] (#2)
mtrr: base(0xe8000000) is not aligned on a size(0x180000) boundary
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb3: USB disconnect, address 1
usb 3-1: USB disconnect, address 2
uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
Stopping tasks: ===================================================================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-done (22433 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section: 
swsusp: Saving Highmem
.<7>[nosave pfn 0x34f]<7>[nosave pfn 0x350]........................swsusp: Need to copy 13151 pages
suspend: (pages needed: 13151 + 512 free: 51999)
.<7>[nosave pfn 0x34f]<7>[nosave pfn 0x350]........................swsusp: critical section/: done (13215 pages copied)
swsusp: Restoring Highmem
PM: writing image.
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
 swsusp: Version: 132618
 swsusp: Num Pages: 65152
 swsusp: UTS Sys: Linux
 swsusp: UTS Node: tvr-vaio
 swsusp: UTS Release: 2.6.10-rc3
 swsusp: UTS Version: #1 Sat Dec 4 01:08:05 PST 2004
 swsusp: UTS Machine: i686
 swsusp: UTS Domain: (none)
 swsusp: CPUs: 1
 swsusp: Image: 13215 Pages
 swsusp: Pagedir: 0 Pages
Writing data to swap (13215 pages)...       0%  1%  2%  3%  4%  5%  6%  7%  8%  9% 10% 11% 12% 13% 14% 15% 16% 17% 18% 19% 20% 21% 22% 23% 24% 25% 26% 27% 28% 29% 30% 31% 32% 33% 34% 35% 36% 37% 38% 39% 40% 41% 42% 43% 44% 45% 46% 47% 48% 49% 50% 51% 52% 53% 54% 55% 56% 57% 58% 59% 60% 61% 62% 63% 64% 65% 66% 67% 68% 69% 70% 71% 72% 73% 74% 75% 76% 77% 78% 79% 80% 81% 82% 83% 84% 85% 86% 87% 88% 89% 90% 91% 92% 93% 94% 95% 96% 97% 98% 99%100%done
Writing pagedir (52 pages)
S|
Powering off system
Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
in_atomic():0, irqs_disabled():1
 [<c010353e>] dump_stack+0x1e/0x30
 [<c0113ac8>] __might_sleep+0x98/0xa0
 [<c02156d2>] device_shutdown+0x22/0x98
 [<c012f878>] power_down+0x78/0x80
 [<c012fa81>] pm_suspend_disk+0x91/0xc0
 [<c012dbf5>] enter_state+0x95/0xa0
 [<c012dc12>] software_suspend+0x12/0x20
 [<c01e271a>] acpi_system_write_sleep+0x6b/0x86
 [<c014df6a>] vfs_write+0xaa/0x130
 [<c014e0bb>] sys_write+0x4b/0x80
 [<c0102fef>] syscall_call+0x7/0xb
Shutdown: hda
acpi_power_off called
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fcf0000 (usable)
 BIOS-e820: 000000000fcf0000 - 000000000fcfc000 (ACPI data)
 BIOS-e820: 000000000fcfc000 - 000000000fd00000 (ACPI NVS)
 BIOS-e820: 000000000fd00000 - 000000000fe80000 (usable)
 BIOS-e820: 000000000fe80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
0MB HIGHMEM available.
254MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.10-rc3 ro root=307 ro root=307 console=ttyS0,9600 console=tty1 resume=/dev/hda6
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1127.246 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255036k/260608k available (1662k kernel code, 4988k reserved, 720k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
vesafb: framebuffer at 0xe8000000, mapped to 0xd0880000, using 832k, total 832k
vesafb: mode is 1024x768x8, linelength=1024, pages=0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:1f.6 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
Relocating pagedir not necessary
Reading image data (13215 pages):       0%  1%  2%  3%  4%  5%  6%  7%  8%  9% 10% 11% 12% 13% 14% 15% 16% 17% 18% 19% 20% 21% 22% 23% 24% 25% 26% 27% 28% 29% 30% 31% 32% 33% 34% 35% 36% 37% 38% 39% 40% 41% 42% 43% 44% 45% 46% 47% 48% 49% 50% 51% 52% 53% 54% 55% 56% 57% 58% 59% 60% 61% 62% 63% 64% 65% 66% 67% 68% 69% 70% 71% 72% 73% 74% 75% 76% 77% 78% 79% 80% 81% 82% 83% 84% 85% 86% 87% 88% 89% 90% 91% 92% 93% 94% 95% 96% 97% 98% 99%100% 13215 done.
Stopping tasks: ==|
Freeing memory...  done (0 pages freed)
PM: Restoring saved image.
swsusp: Restoring Highmem
PM: Image restored successfully.
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Restarting tasks... done
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
uhci_hcd 0000:00:1d.0: irq 9, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: Product: Intel Corp. 82801CA/CAM USB (Hub #1)
usb usb1: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
uhci_hcd 0000:00:1d.1: irq 9, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: Product: Intel Corp. 82801CA/CAM USB (Hub #2)
usb usb2: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
uhci_hcd 0000:00:1d.2: irq 9, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: Product: Intel Corp. 82801CA/CAM USB (Hub #3)
usb usb3: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
intel8x0_measure_ac97_clock: measured 49448 usecs
intel8x0: clocking to 48000
uhci_hcd 0000:00:1d.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
usb 3-1: khubd timed out on ep0in
usb 3-1: khubd timed out on ep0out
usb 3-1: khubd timed out on ep0out
usb 3-1: device not accepting address 2, error -110
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: khubd timed out on ep0in
usb 3-1: khubd timed out on ep0out
usb 3-1: khubd timed out on ep0out
usb 3-1: device not accepting address 3, error -110
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb3: USB disconnect, address 1
uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
uhci_hcd 0000:00:1d.0: irq 9, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: Product: Intel Corp. 82801CA/CAM USB (Hub #1)
usb usb1: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
uhci_hcd 0000:00:1d.1: irq 9, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: Product: Intel Corp. 82801CA/CAM USB (Hub #2)
usb usb2: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
uhci_hcd 0000:00:1d.2: irq 9, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: Product: Intel Corp. 82801CA/CAM USB (Hub #3)
usb usb3: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:1d.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
usb 3-1: khubd timed out on ep0in
usb 3-1: khubd timed out on ep0out
usb 3-1: khubd timed out on ep0out
usb 3-1: device not accepting address 2, error -110
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: khubd timed out on ep0in
usb 3-1: khubd timed out on ep0out
usb 3-1: khubd timed out on ep0out
usb 3-1: device not accepting address 3, error -110
-------------------------------------------------------------------------------
Linux version 2.6.10-rc3 (tvr@tvr-vaio) (gcc version 3.3.5 (Debian 1:3.3.5-2)) #1 Sat Dec 4 01:08:05 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fcf0000 (usable)
 BIOS-e820: 000000000fcf0000 - 000000000fcfc000 (ACPI data)
 BIOS-e820: 000000000fcfc000 - 000000000fd00000 (ACPI NVS)
 BIOS-e820: 000000000fd00000 - 000000000fe80000 (usable)
 BIOS-e820: 000000000fe80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
0MB HIGHMEM available.
254MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.10-rc3 ro root=307 console=ttyS0,9600 console=tty1
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1127.268 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255036k/260608k available (1662k kernel code, 4988k reserved, 720k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
vesafb: framebuffer at 0xe8000000, mapped to 0xd0880000, using 832k, total 832k
vesafb: mode is 1024x768x8, linelength=1024, pages=0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:1f.6 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PWRB USB1 USB2 USB3  LAN CRD0  EC0 COMA MODE 
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
Real Time Clock Driver v1.12
Sony Vaio Jogdial input method installed.
Sony Vaio Keys input method installed.
sonypi: Sony Programmable I/O Controller Driverv1.25.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0xe0204000, irq 9, MAC addr 08:00:46:4E:8C:7E
NTFS driver 2.1.22 [Flags: R/W MODULE].
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
intel8x0_measure_ac97_clock: measured 49423 usecs
intel8x0: clocking to 48000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
uhci_hcd 0000:00:1d.0: irq 9, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: Product: Intel Corp. 82801CA/CAM USB (Hub #1)
usb usb1: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
uhci_hcd 0000:00:1d.1: irq 9, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: Product: Intel Corp. 82801CA/CAM USB (Hub #2)
usb usb2: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
uhci_hcd 0000:00:1d.2: irq 9, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: Product: Intel Corp. 82801CA/CAM USB (Hub #3)
usb usb3: Manufacturer: Linux 2.6.10-rc3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: AC Adapter [ACAD] (on-line)
usb 3-1: new full speed USB device using uhci_hcd and address 2
ACPI: Battery Slot [BAT1] (battery present)
usb 3-1: Product: USB Memory Stick Slot
usb 3-1: Manufacturer: Sony
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: Sony      Model: MSC-U03           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:05.0 [104d:8100]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[e0205000-e02057ff]  Max Packet=[2048]
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport0: Printer, EPSON Stylus Photo 700
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
hw_random hardware driver 1.0.0 loaded
ieee1394: sbp2: Logged into SBP-2 device
  Vendor: MATSHITA  Model: UJDA730 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [ATF0] (47 C)
lp0: using parport0 (interrupt-driven).
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
[drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82830 CGC [Chipset Graphics Controller]
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
[drm] Initialized i830 1.3.2 20021108 on minor 1: Intel Corp. 82830 CGC [Chipset Graphics Controller] (#2)
mtrr: base(0xe8000000) is not aligned on a size(0x180000) boundary
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
Stopping tasks: =======================================================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done (16535 pages freed)
uhci_hcd 0000:00:1d.2: suspend_hc
uhci_hcd 0000:00:1d.2: --> PCI D0/legacy
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.1: --> PCI D0/legacy
uhci_hcd 0000:00:1d.0: suspend_hc
uhci_hcd 0000:00:1d.0: --> PCI D0/legacy
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section: 
swsusp: Saving Highmem
.<7>[nosave pfn 0x34f]<7>[nosave pfn 0x350].......................swsusp: Need to copy 13700 pages
suspend: (pages needed: 13700 + 512 free: 51450)
.<7>[nosave pfn 0x34f]<7>[nosave pfn 0x350]..........................swsusp: critical section/: done (13764 pages copied)
swsusp: Restoring Highmem
PM: writing image.
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: resume from PCI D0 (legacy)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.1: resume from PCI D0 (legacy)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.0: wakeup_hc
uhci_hcd 0000:00:1d.2: resume from PCI D0 (legacy)
uhci_hcd 0000:00:1d.1: wakeup_hc
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
uhci_hcd 0000:00:1d.2: wakeup_hc
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
===============================================================================
