Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTKQVF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTKQVF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:05:57 -0500
Received: from hell.org.pl ([212.244.218.42]:60677 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261827AbTKQVFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:05:24 -0500
Date: Mon, 17 Nov 2003 22:05:28 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Subject: [USB] uhci-hcd.c: b400: host controller halted after ACPI S3
Message-ID: <20031117210528.GC20681@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Hi,
In brief: After resuming from S3 (Suspend-To-RAM), my USB hosts go very
bad.

Less short:
drivers/usb/host/uhci-hcd.c: b400: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad

Those messages appear in the logs after a successful S3 resume. The USB
mouse goes off and the HCDs work no more. Below is the lspci -v, attached
it the dmesg output. I'll be happy to provide more info.

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl

cat /proc/interrupts:
           CPU0
  0:     208978          XT-PIC  timer
  1:       7477          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     142003          XT-PIC  Ricoh Co Ltd RL5c476 II, usb-uhci, radeon@PCI:1:0:0
  8:          2          XT-PIC  rtc
  9:        129          XT-PIC  acpi, eth0, usb-uhci, ohci1394
 11:     140676          XT-PIC  Ricoh Co Ltd RL5c476 II (#2), PCTel, Intel 82801CA-ICH3
 12:       2605          XT-PIC  PS/2 Mouse
 14:       9394          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0
ERR:          0

lspci -v:
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Subsystem: Asustek Computer, Inc.: Unknown device 1626
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d7000000-d7efffff
        Prefetchable memory behind bridge: d7f00000-dfffffff

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1628
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at b800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1628
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at b400 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: d6000000-d6ffffff

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 1628
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 8400 [size=16]
        Memory at d5800000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 1583
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [Generic])
        Subsystem: Asustek Computer, Inc.: Unknown device 1496
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e200 [size=256]
        I/O ports at e300 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 1622
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Asustek Computer, Inc.: Unknown device 1045
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at a800 [size=256]
        Memory at d6800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Asustek Computer, Inc.: Unknown device 1624
        Flags: bus master, medium devsel, latency 168, IRQ 5
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=02, subordinate=03, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Asustek Computer, Inc.: Unknown device 1624
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=04, subordinate=07, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1627
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at d6000000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="dmesg.serio"

Linux version 2.6.0-test9-mm3 (sziwan@nadir) (gcc version 3.2.3) #14 Mon Nov 17 21:15:54 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff9000 (usable)
 BIOS-e820: 000000000fff9000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65529
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61433 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ASUS L3C with broken BIOS detected. Refusing to enable the local APIC.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6890
ACPI: RSDT (v001 ASUS   P4_L3CS  0x42302e31 MSFT 0x31313031) @ 0x0fff9000
ACPI: FADT (v001 ASUS   P4_L3CS  0x42302e31 MSFT 0x31313031) @ 0x0fff9080
ACPI: BOOT (v001 ASUS   P4_L3CS  0x42302e31 MSFT 0x31313031) @ 0x0fff9040
ACPI: DSDT (v001   ASUS P4_L3CS  0x00001000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6 ro root=305 resume=/dev/hda1 acpi_sleep=s3_bios noresume
current: c0325a60
current->thread_info: c038e000
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1700.566 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 255888k/262116k available (1912k kernel code, 5528k reserved, 701k data, 132k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 3350.52 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 3febf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0e40, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..............................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 761 Objects with 59 Devices 254 Methods 26 Regions
ACPI Namespace successfully loaded at root c03c617c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E428 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E42C on int 9
Completing Region/Field/Buffer/Package initialization:..................................................................................
Initialized 26/26 Regions 0/0 Fields 23/23 Buffers 33/33 Packages (769 nodes)
Executing all Device _STA and_INI methods:............................................................
60 Devices found containing: 60 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *5)
ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: Embedded Controller [ECD0] (gpe 28)
ACPI: Power Resource [PRCF] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc3c0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc3f0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS for Linux with no debug enabled
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LIDD]
ACPI: Fan [CFAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (52 C)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8400-0x8407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8408-0x840f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 > p4
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
Resume Machine: Resuming from device hda1
Resume Machine: This is normal swap space
disabled
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
XFS mounting filesystem hda5
Starting XFS recovery on filesystem: hda5 (dev: hda5)
Ending XFS recovery on filesystem: hda5 (dev: hda5)
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
Adding 393552k swap on /dev/hda1.  Priority:-1 extents:1
XFS mounting filesystem hda6
Starting XFS recovery on filesystem: hda6 (dev: hda6)
Ending XFS recovery on filesystem: hda6 (dev: hda6)
Asus Laptop ACPI Extras version 0.26
  L3C model detected, supported
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:07.0 [1043:1624]
Yenta: ISA IRQ list 0498, PCI irq5
Socket status: 30000006
PCI: Enabling device 0000:02:07.1 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:02:07.1 [1043:1624]
Yenta: ISA IRQ list 0498, PCI irq11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x2f8-0x2ff 0x378-0x37f 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xa800, 00:e0:18:dc:6d:bc, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8100'
eth0: link down
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 5, io base 0000b800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 9, io base 0000b400
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 1-0:1.0: new USB device on port 2, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on usb-0000:00:1d.0-2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[d6000000-d60007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0180003075522]
PM: Preparing system for suspend
Stopping tasks: =========================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
 hwsleep-0257 [30] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
zapping low mappings.
input: AT Translated Set 2 keyboard on isa0060/serio0
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
eth0: link down
hda: Wakeup request inited, waiting for !BSY...
drivers/usb/host/uhci-hcd.c: b800: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: b800: host controller halted. very bad
hda: start_power_step(step: 1000)
blk: queue c1352800, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
drivers/usb/host/uhci-hcd.c: b400: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: b400: host controller halted. very bad
Restarting tasks... done

--PNTmBPCT7hxwcZjr--
