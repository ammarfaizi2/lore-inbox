Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWCKGRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWCKGRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 01:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWCKGRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 01:17:39 -0500
Received: from gw.goop.org ([64.81.55.164]:45256 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751107AbWCKGRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 01:17:38 -0500
Message-ID: <4412321B.6030006@goop.org>
Date: Fri, 10 Mar 2006 18:12:43 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: davej@redhat.com
Subject: 2.6.15-1.2032_FC5 (2.6.16rc5-git9?): Losing ticks with x86_64 w/
 Nvidia chipset
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems my system is losing interrupts.  It regularly emits the message:

    Losing some ticks... checking if CPU frequency changed.

and it seems to lose mouse movements and button presses.

I also wonder if this is also the cause of my problems with ripping CDs; 
I'll post separately about that problem, but it seems to be that the ide 
driver is losing interrupts and failing to recover.

This is a Shuttle SN95V10 board, with Nvidia nforce 3 chipset. I'm 
running FC5 test 3, with kernel 2.6.15-1.2032_FC5, which appears to be 
built from 2.6.16rc5-git9.  I'm using the nvidia driver for my nvidia 
graphics card, but I get the same problems without it, just using the 
plain "nv" driver.

Any clues on how I can track down the problem here?  Should I try 
booting with acpi=off or something?

Thanks,
    J

Details:

/proc/interrupts:

           CPU0
  0:    7972830    IO-APIC-edge  timer
  7:          2    IO-APIC-edge  parport0
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 15:     285841    IO-APIC-edge  ide1
 16:     350874   IO-APIC-level  libata, NVidia CK8S
 17:     377726   IO-APIC-level  skge, nvidia
 18:    1775120   IO-APIC-level  ehci_hcd:usb1
 19:       2432   IO-APIC-level  ohci_hcd:usb2
 20:          0   IO-APIC-level  ohci_hcd:usb3
 21:      30350   IO-APIC-level  ohci1394
NMI:       1281
LOC:    7973266
ERR:          0
MIS:          0


lspci:

00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2)
00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configu ration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600/GeForce 6600 GT] (rev a2)
02:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
02:08.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)

lspci -v

00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [c0] AGP version 3.0

00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: 66MHz, fast devsel, IRQ 10
        I/O ports at ff00 [size=32]
        I/O ports at 4c00 [size=64]
        I/O ports at 4c40 [size=64]
        Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 19
        Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
        Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2) (prog-if 20 [EHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 18
        Memory at fdffd000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 16
        I/O ports at f200 [size=256]
        I/O ports at fc00 [size=128]
        Memory at fdffc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2) (prog-if 8a [Maste r SecP PriP])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at fa00 [size=16]
        Capabilities: [44] Power Management version 2

00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 16
        I/O ports at 09f0 [size=8]
        I/O ports at 0bf0 [size=4]
        I/O ports at 0970 [size=8]
        I/O ports at 0b70 [size=4]
        I/O ports at f500 [size=16]
        I/O ports at f400 [size=128]
        Capabilities: [44] Power Management version 2

00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 16
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fa000000-fcffffff
        Prefetchable memory behind bridge: d0000000-dfffffff

00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2) (prog-if 00 [Normal decod e])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fde00000-fdefffff
        Prefetchable memory behind bridge: fdd00000-fddfffff

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configu ration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600/GeForce 6600 GT] (rev a2) (prog- if 00 [VGA])
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 17
        Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
        [virtual] Expansion ROM at fc000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

02:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI ])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 21
        Memory at fdeff000 (32-bit, non-prefetchable) [size=2K]
        I/O ports at df00 [size=128]
        Capabilities: [50] Power Management version 2

02:08.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device c231
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
        Memory at fdef8000 (32-bit, non-prefetchable) [size=16K]
        I/O ports at dc00 [size=256]
        [virtual] Expansion ROM at fdd00000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data

: minilith:pts/0; ugg lspci -v
00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [c0] AGP version 3.0

00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: 66MHz, fast devsel, IRQ 10
        I/O ports at ff00 [size=32]
        I/O ports at 4c00 [size=64]
        I/O ports at 4c40 [size=64]
        Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 19
        Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
        Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2) (prog-if 20 [EHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 18
        Memory at fdffd000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 16
        I/O ports at f200 [size=256]
        I/O ports at fc00 [size=128]
        Memory at fdffc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2) (prog-if 8a [Master SecP PriP])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at fa00 [size=16]
        Capabilities: [44] Power Management version 2

00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a551
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 16
        I/O ports at 09f0 [size=8]
        I/O ports at 0bf0 [size=4]
        I/O ports at 0970 [size=8]
        I/O ports at 0b70 [size=4]
        I/O ports at f500 [size=16]
        I/O ports at f400 [size=128]
        Capabilities: [44] Power Management version 2

00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 16
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fa000000-fcffffff
        Prefetchable memory behind bridge: d0000000-dfffffff

00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fde00000-fdefffff
        Prefetchable memory behind bridge: fdd00000-fddfffff

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600/GeForce 6600 GT] (rev a2) (prog-if 00 [VGA])
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 17
        Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
        [virtual] Expansion ROM at fc000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

02:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 21
        Memory at fdeff000 (32-bit, non-prefetchable) [size=2K]
        I/O ports at df00 [size=128]
        Capabilities: [50] Power Management version 2

02:08.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device c231
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
        Memory at fdef8000 (32-bit, non-prefetchable) [size=16K]
        I/O ports at dc00 [size=256]
        [virtual] Expansion ROM at fdd00000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data


dmesg output:

Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 quiet )
Linux version 2.6.15-1.2032_FC5 (bhcompile@hs20-bc1-5.build.redhat.com) (gcc version 4.1.0 20060304 (Red Hat 4.1.0-2)) #1 SMP Tue Mar 7 22:18:30 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 XPC                                   ) @ 0x00000000000f8fd0
ACPI: RSDT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3040
ACPI: FADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000003fff7880
ACPI: MADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff77c0
ACPI: DSDT (v001 XPC     SN95V20 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000003fff0000
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000003fff0000
On node 0 totalpages: 256780
  DMA zone: 2779 pages, LIFO batch:0
  DMA32 zone: 254001 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
SMP: Allowing 2 CPUs, 1 hotplug CPUs
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2210.789 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1023472k/1048512k available (2320k kernel code, 24640k reserved, 1211k data, 196k init)
Calibrating delay using timer specific routine.. 4426.38 BogoMIPS (lpj=8852779)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
Using local APIC timer interrupts.
result 12561301
Detected 12.561 MHz APIC timer.
Brought up 1 CPUs
testing NMI watchdog ... OK.
0
checking if image is initramfs... it is
Freeing initrd memory: 1837k freed
DMI 2.2 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 256M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
PCI: Bridge: 0000:00:0b.0
  IO window: e000-efff
  MEM window: fa000000-fcffffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:0e.0
  IO window: d000-dfff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1141981243.568:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key ABAB1965D89C5E80
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (51 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xfa00-0xfa07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfa08-0xfa0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xe, vid 0x2
ACPI wakeup devices:
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 196k freed
Write protecting the kernel read-only data: 435k
SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:0a.0: version 0.8
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 23
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 23 (level, high) -> IRQ 16
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xF500 irq 16
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xF508 irq 16
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link down (SStatus 0)
scsi1 : sata_nv
  Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 17
skge 1.3 addr 0xfdef8000 irq 17 chip Yukon-Lite rev 7
skge eth0: addr 00:30:1b:b5:dd:8f
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
sd 0:0:0:0: Attached scsi generic sg0 type 0
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 22 (level, high) -> IRQ 18
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 18, io mem 0xfdffd000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 (level, high) -> IRQ 19
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 19, io mem 0xfdfff000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 20 (level, high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 20, io mem 0xfdffe000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC5] -> GSI 16 (level, low) -> IRQ 17
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-8178  Wed Dec 14 16:58:07 PST 2005
ieee1394: Initialized config rom entry `ip1394'
usb 1-3: new high speed USB device using ehci_hcd and address 4
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 21 sharing vector 0xD9 and IRQ 21
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:02:07.0, from 10 to 5
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[fdeff000-fdeff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
usb 1-3: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
usb 2-1: new low speed USB device using ohci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
input: Logitech Logitech USB Keyboard as /class/input/input0
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:02.0-1
input: Logitech Logitech USB Keyboard as /class/input/input1
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:02.0-1
usb 2-2: new low speed USB device using ohci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
input: Logitech USB RECEIVER as /class/input/input2
input: USB HID v1.11 Mouse [Logitech USB RECEIVER] on usb-0000:00:02.0-2
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 23 (level, high) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00301bb50000ddf3]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[000a270002592e4e]
ieee1394: Node added: ID:BUS[0-03:1023]  GUID[000a27000401f4a2]
intel8x0_measure_ac97_clock: measured 58700 usecs
intel8x0: clocking to 46960
video1394: Installed video1394 module
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
scsi3 : SBP-2 IEEE-1394
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
  Vendor: Apple     Model: iPod              Rev: 1.53
  Type:   Direct-Access-RBC                  ANSI SCSI revision: 02
sdb: Spinning up disk....<5>  Vendor: ATECH     Model: FLASH-CFC         Rev: 019D
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 2:0:0:0: Attached scsi removable disk sdc
sd 2:0:0:0: Attached scsi generic sg1 type 0
  Vendor: ATECH     Model: FLASH-SDC         Rev: 019D
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 2:0:0:1: Attached scsi removable disk sdd
sd 2:0:0:1: Attached scsi generic sg2 type 0
  Vendor: ATECH     Model: FLASH-SMC         Rev: 019D
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 2:0:0:2: Attached scsi removable disk sde
sd 2:0:0:2: Attached scsi generic sg3 type 0
  Vendor: ATECH     Model: FLASH-MSC         Rev: 019D
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 2:0:0:3: Attached scsi removable disk sdf
sd 2:0:0:3: Attached scsi generic sg4 type 0
usb-storage: device scan complete
ready
SCSI device sdb: 78126048 512-byte hdwr sectors (40001 MB)
sdb: test WP failed, assume Write Enabled
sdb: asking for cache data failed
sdb: assuming drive cache: write through
SCSI device sdb: 78126048 512-byte hdwr sectors (40001 MB)
sdb: test WP failed, assume Write Enabled
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: [mac] sdb1 sdb2 sdb3
sd 3:0:0:0: Attached scsi removable disk sdb
sd 3:0:0:0: Attached scsi generic sg5 type 14
Non-volatile memory driver v1.2
floppy0: no floppy controllers found
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.base_reachable_time; Use net.ipv6.neigh.lo.base_reachable_time_ms instead.
skge eth0: enabling interface
ADDRCONF(NETDEV_UP): eth0: link is not ready
skge eth0: Link is up at 1000 Mbps, full duplex, flow control tx and rx
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
it87: Found IT8712F chip at 0x290, revision 6
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
ieee1394: Node changed: 0-03:1023 -> 0-02:1023
ieee1394: Node suspended: ID:BUS[0-01:1023]  GUID[000a270002592e4e]
Losing some ticks... checking if CPU frequency changed.
loop: loaded (max 8 devices)



