Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTIZMrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIZMrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:47:08 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:4873 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S261929AbTIZMqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:46:39 -0400
To: linux-kernel@vger.kernel.org
Subject: [BUG?] SIS IDE DMA errors
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 26 Sep 2003 14:30:24 +0200
Message-ID: <yw1x7k3vlokf.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I reported this a long time ago, but nobody seemed to care, so here it
is again.

With all 2.6.0 versions so far, I get these errors when writing lots
of data to the disk:

hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command

It only happens when I write more than about 100 MB at more than 5
MB/s or so, never when writing smaller amounts of data.

System details follow.

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 10)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 1688
	Flags: bus master, fast devsel, latency 128
	I/O ports at b800 [size=16]

Linux version 2.6.0-test5-nick15 (mru@ford) (gcc version 3.3.1) #14 Fri Sep 19 11:26:47 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dffa000 (usable)
 BIOS-e820: 000000000dffa000 - 000000000dfff000 (ACPI data)
 BIOS-e820: 000000000dfff000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
223MB LOWMEM available.
On node 0 totalpages: 57338
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53242 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6460
ACPI: RSDT (v001 ASUS   M2000E   0x42302e31 MSFT 0x31313031) @ 0x0dffa000
ACPI: FADT (v001 ASUS   M2000E   0x42302e31 MSFT 0x31313031) @ 0x0dffa080
ACPI: BOOT (v001 ASUS   M2000E   0x42302e31 MSFT 0x31313031) @ 0x0dffa040
ACPI: DSDT (v001   ASUS M2000E   0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 init=/sbin/lvm2/lvmroot video=sisfb:mode:1024x768x8
sisfb: Options mode:1024x768x8
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2070.560 MHz processor.
Console: colour VGA+ 80x25
Memory: 223688k/229352k available (1655k kernel code, 4972k reserved, 744k data, 136k init, 0k highmem)
Calibrating delay loop... 4087.80 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf17c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................................................................
Table [DSDT](id F004) - 585 Objects with 52 Devices 200 Methods 21 Regions
ACPI Namespace successfully loaded at root c038b39c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package initialization:..............................................  psargs-0352: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUND
search_node cdf6f8a8 start_node cdf6f8a8 return_node 00000000
 psparse-1121: *** Error: , AE_NOT_FOUND

  nsinit-0293 [06] ns_init_one_object    : Could not execute arguments for [_PSL] (Package), AE_NOT_FOUND
....................
Initialized 21/21 Regions 5/5 Fields 19/19 Buffers 21/21 Packages (593 nodes)
Executing all Device _STA and_INI methods:.....................................................
53 Devices found containing: 53 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (on)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
sisfb: Video ROM found and mapped to c00c0000
sisfb: Framebuffer at 0xf0000000, mapped to 0xce80f000, size 32768k
sisfb: MMIO at 0xe7800000, mapped to 0xd0810000, size 128k
sisfb: Memory heap starting at 12288K
sisfb: Using MMIO queue mode
sisfb: LVDS transmitter detected
sisfb: Default mode is 1024x768x8 (60Hz)
sisfb: Added MTRRs
sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
sisfb: 2D acceleration is enabled, scrolling mode ypan
fb0: SIS 650/M650/651/740 VGA frame buffer device, Version 1.6.01
sisfb: Change mode to 1024x768x8-60Hz
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Total HugeTLB memory allocated, 0
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU] (supports C1 C2, 4 throttling states)
ACPI: Thermal Zone [THRM] (45 C)
Asus Laptop ACPI Extras version 0.24a
  M2E model detected, supported
  Notify Handler installed successfully
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS SCB-2408, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 522104k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on dm-3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:0a.0 [1043:1687]
Yenta: ISA IRQ list 0098, PCI irq10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0a.1 [1043:1687]
Yenta: ISA IRQ list 0098, PCI irq10
Socket status: 30000006
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xa000, IRQ 5, 00:0c:6e:40:b0:22.
eth0: Media Link On 100mbps full-duplex 
intel8x0: clocking to 48000
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 0000:00:02.2: OHCI Host Controller
ohci-hcd 0000:00:02.2: irq 9, pci mem d08b6000
ohci-hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 3 ports detected
ohci-hcd 0000:00:02.3: OHCI Host Controller
ohci-hcd 0000:00:02.3: irq 9, pci mem d091e000
ohci-hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 3 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 176M
agpgart: AGP aperture is 64M @ 0xe8000000
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:02.2-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
SCSI subsystem initialized
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
EXT3 FS on dm-1, internal journal
vmmon: no version magic, tainting kernel.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmmon: Module vmmon: unloaded
vmnet: no version magic, tainting kernel.
vmnet: module license 'unspecified' taints kernel.
vmmon: no version magic, tainting kernel.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
vmnet: no version magic, tainting kernel.
vmnet: module license 'unspecified' taints kernel.
/dev/vmnet: open called by PID 1997 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: up
bridge-eth0: attached
/dev/vmnet: open called by PID 2015 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2270 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2288 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2342 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
spurious 8259A interrupt: IRQ7.
/dev/vmnet: open called by PID 2407 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2414 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2471 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
/dev/vmnet: open called by PID 2509 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2516 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2523 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
acpi_bus-0199 [17] acpi_bus_set_power    : Device is not power manageable
acpi_thermal-0611 [16] acpi_thermal_active   : Unable to turn cooling device [cdf6fd28] 'on'
acpi_bus-0199 [17] acpi_bus_set_power    : Device is not power manageable
acpi_thermal-0611 [16] acpi_thermal_active   : Unable to turn cooling device [cdf6fd28] 'on'
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success


-- 
Måns Rullgård
mru@users.sf.net
