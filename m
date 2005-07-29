Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVG2CCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVG2CCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 22:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVG2CCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 22:02:41 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:62595
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262010AbVG2CCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 22:02:34 -0400
Date: Thu, 28 Jul 2005 22:03:32 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Time Flies (Twice as Fast)
Message-ID: <20050729020332.GA12920@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12.3
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hola,

I have an eMachines T6212 Opteron system on which the system clock
seems to run at ~twice the speed of the wall clock. The main board
is an ASUS K8 of some description with at ATI SB400 southbridge and
an ATI RS480 northbridge. Kernel version is 2.6.12.3.

If I disable ACPI, the clock slows down to what seems to be the proper
speed, but then my NIC doesn't work, presumably because it shares
an interrupt with something else.

I've tried booting with clock=tsc and clock=pit to no effect. Based
on my review of the list archives, there appears to be issues with
the chipset, but I haven't been able to sort out what the real problem
is and the appropriate solution.

There's an ACPI error that seems potentially troublesome:

ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPC0.LNK0] in namespace, AE_NOT_FOUND
search_node ffff81001fec9440 start_node ffff81001fec9440 return_node 0000000000000000

I also see this message from the PCI subsystem:

PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1

As a starting point, I've attached lspci output and the boot log. I'm
willing to provide more information and try patches and such.

Thanks.

Kurt

-- 
Westheimer's Discovery:
	A couple of months in the laboratory can frequently save a
couple of hours in the library.

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.log"

00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 64
	I/O ports at 4100 [disabled] [size=32]
	Memory at <ignored> (64-bit, non-prefetchable) [size=512M]

00:11.0 IDE interface: ATI Technologies Inc: Unknown device 437a (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
	I/O ports at fe00 [size=8]
	I/O ports at fd00 [size=4]
	I/O ports at fc00 [size=8]
	I/O ports at fb00 [size=4]
	I/O ports at fa00 [size=16]
	Memory at fe02f000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

00:12.0 IDE interface: ATI Technologies Inc: Unknown device 4379 (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	I/O ports at f900 [size=8]
	I/O ports at f800 [size=4]
	I/O ports at f700 [size=8]
	I/O ports at f600 [size=4]
	I/O ports at f500 [size=16]
	Memory at fe02e000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4374 (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 185
	Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4375 (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 185
	Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4373 (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 185
	Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

00:14.0 SMBus: ATI Technologies Inc: Unknown device 4372 (rev 04)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: 66Mhz, medium devsel
	I/O ports at 0400 [size=16]
	Memory at fe02a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [b0] #08 [a802]

00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4376 (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 177
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f300 [size=16]
	Capabilities: [70] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 4377
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7141
	Flags: bus master, 66Mhz, medium devsel, latency 0

00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4371 (prog-if 01 [Subtractive decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fb000000-fcffffff
	Prefetchable memory behind bridge: c8000000-d7ffffff

00:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown device 4370
	Subsystem: Micro-Star International Co., Ltd.: Unknown device b000
	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 193
	Memory at fe029000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

01:00.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Flags: bus master, medium devsel, latency 64, IRQ 201
	Memory at d7fff000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

01:00.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Flags: bus master, medium devsel, latency 64, IRQ 201
	Memory at d7ffe000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

01:01.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Flags: bus master, medium devsel, latency 64, IRQ 169
	I/O ports at ef00 [size=256]
	Memory at fcfff000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:02.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 AGP 8x] (rev c1) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
	Memory at c8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

01:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 093c
	Flags: medium devsel, IRQ 5
	I/O ports at ee00 [size=256]
	Memory at fcffe000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2

01:04.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 093d
	Flags: bus master, medium devsel, latency 64, IRQ 169
	Memory at fcffd000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at ed00 [size=128]
	Capabilities: [50] Power Management version 2


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.log"

Bootdata ok (command line is auto BOOT_IMAGE=krw ro root=302 clock=tsc hpet=disable)
Linux version 2.6.12.3 (kurt@easter) (gcc version 3.4.3) #1 Fri Jul 29 06:04:06 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000000f00000 (usable)
 BIOS-e820: 0000000000f00000 - 0000000001000000 (reserved)
 BIOS-e820: 0000000001000000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 RS480                                 ) @ 0x00000000000f7c50
ACPI: RSDT (v001 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000001fef3040
ACPI: FADT (v002 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000001fef30c0
ACPI: MCFG (v001 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000001fef6b00
ACPI: MADT (v001 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000001fef6a40
ACPI: DSDT (v001 RS480  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 130800
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126704 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 1ff00000 (gap: 1ff00000:c0100000)
Checking aperture...
CPU 0: aperture @ 744000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=krw ro root=302 clock=tsc hpet=disable
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1989.864 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 508884k/523200k available (2624k kernel code, 12508k reserved, 1122k data, 184k init)
Calibrating delay loop... 3915.77 BogoMIPS (lpj=1957888)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 00
Using local APIC timer interrupts.
Detected 12.436 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPC0.LNK0] in namespace, AE_NOT_FOUND
search_node ffff81001fec9440 start_node ffff81001fec9440 return_node 0000000000000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:02.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11), disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 3 of device 0000:00:00.0
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
Losing some ticks... checking if CPU frequency changed.
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 177
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf300-0xf307, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf308-0xf30f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HDS722516VLAT20, ATA DISK drive
hdb: Maxtor 84320D4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TSSTcorpCD/DVDW TS-H552B, ATAPI CD/DVD-ROM drive
hdd: LITE-ON CD-ROM LTN-489S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 321672960 sectors (164696 MB) w/1794KiB Cache, CHS=20023/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 128KiB
hdb: 8439184 sectors (4320 MB) w/256KiB Cache, CHS=8930/15/63, UDMA(33)
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
usbmon: debugs is not available
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 185
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 185, io mem 0xfe02d000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 185
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 185, io mem 0xfe02c000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.2
sl811: driver sl811-hcd, 19 May 2005
usb 1-4: new full speed USB device using ohci_hcd and address 2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (2043 buckets, 16344 max) - 296 bytes per conntrack
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PCI0 USB0 USB1 USB2 AUDO  P2P  MAC 
ACPI: (supports S0 S1 S3 S4bios S5)
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 185
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: irq 185, io mem 0xfe02b000
ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
usb 1-4: USB disconnect, address 2
usb 1-4: new full speed USB device using ohci_hcd and address 3
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
  Vendor: Generic   Model: USB SD Reader     Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Vendor: Generic   Model: USB CF Reader     Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi0, channel 0, id 0, lun 1
Attached scsi generic sg1 at scsi0, channel 0, id 0, lun 1,  type 0
  Vendor: Generic   Model: USB SM Reader     Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdc at scsi0, channel 0, id 0, lun 2
Attached scsi generic sg2 at scsi0, channel 0, id 0, lun 2,  type 0
  Vendor: Generic   Model: USB MS Reader     Rev: 1.03
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdd at scsi0, channel 0, id 0, lun 3
Attached scsi generic sg3 at scsi0, channel 0, id 0, lun 3,  type 0
usb-storage: device scan complete
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 193
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 20 (level, low) -> IRQ 201
bttv0: Bt878 (rev 17) at 0000:01:00.0, irq: 201, latency: 64, mmio: 0xd7fff000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fffffb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tveeprom: Hauppauge: model = 38101, rev = B410, serial# = 1900677
tveeprom: tuner = Philips FI1236 MK2 (idx = 10, type = 2)
tveeprom: tuner fmt = NTSC(M) (eeprom = 0x08, v4l2 = 0x00001000)
tveeprom: audio_processor = None (type = 0)
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 0-0061: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI Interrupt 0000:01:00.1[A] -> GSI 20 (level, low) -> IRQ 201
bt878(0): Bt878 (rev 17) at 01:00.1, irq: 201, latency: 64, memory: 0xd7ffe000
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 21 (level, low) -> IRQ 169
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 000000000001ef00, 00:A0:CC:D9:7A:75, IRQ 169.
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 21 (level, low) -> IRQ 169
PCI: Via IRQ fixup for 0000:01:04.0, from 3 to 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[169]  MMIO=[fcffd000-fcffd7ff]  Max Packet=[2048]
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00009939f8]
eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80427420(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

--6TrnltStXW4iwmi0--
