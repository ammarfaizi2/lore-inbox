Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUDIRaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDIRaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:30:25 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:42884 "EHLO crianza")
	by vger.kernel.org with ESMTP id S261462AbUDIR37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:29:59 -0400
Date: Fri, 9 Apr 2004 13:29:59 -0400
To: linux-kernel@vger.kernel.org
Subject: Hang w/ HPET and ACPI 2.0 on AMD 8111, 2.6.5
Message-ID: <20040409172959.GB6133@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, please CC me as I'm not subscribed.

I have a machine with a Tyan S2875 single-cpu Opteron board.  When I
enable the HPET and ACPI 2.0 in the BIOS the kernel hangs during boot.
Here's the dmesg:

Linux version 2.6.5 (root@carignan) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Thu Apr 8 19:17:36 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x000f4600
ACPI: XSDT (v001 A M I  OEMXSDT  0x12000331 MSFT 0x00000097) @ 0x3fff0100
ACPI: FADT (v003 A M I  OEMFACP  0x12000331 MSFT 0x00000097) @ 0x3fff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x12000331 MSFT 0x00000097) @ 0x3fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x12000331 MSFT 0x00000097) @ 0x3ffff040
ACPI: HPET (v001 A M I  OEMHPET  0x12000331 MSFT 0x00000097) @ 0x3fff3390
ACPI: ASF! (v016 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x3fff33d0
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x102282a0 base: 0xfec01000
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=801 console=ttyS0,9600n8
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Console: colour VGA+ 80x25
Memory: 904244k/917504k available (2058k kernel code, 12516k reserved, 1014k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Using HPET for base-timer
Using HPET for gettimeofday
Detected 1594.442 MHz processor.
Using hpet for high-res timesource
Calibrating delay loop... 

...and it's dead.  If I disable ACPI 2.0 in the BIOS (but not the HPET)
it boots, but the HPET is not detected.  Like so:

Linux version 2.6.5 (root@carignan) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Thu Apr 8 19:17:36 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f4600
ACPI: RSDT (v001 A M I  OEMRSDT  0x12000331 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v002 A M I  OEMFACP  0x12000331 MSFT 0x00000097) @ 0x3fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x12000331 MSFT 0x00000097) @ 0x3fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x12000331 MSFT 0x00000097) @ 0x3ffff040
ACPI: ASF! (v016 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x3fff3390
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=801 console=ttyS0,9600n8
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1594.787 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 904244k/917504k available (2058k kernel code, 12516k reserved, 1014k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3137.53 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Opteron(tm) Processor 142 stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1593.0642 MHz.
..... host bus clock speed is 199.0205 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
testing the IO APIC.......................
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
udf: registering filesystem
PCI: Via IRQ fixup for 0000:01:0b.1, from 5 to 2
PCI: Via IRQ fixup for 0000:01:0b.0, from 9 to 1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 8151 AGP Bridge rev B2
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 128M @ 0xf0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k2
Copyright (c) 1999-2004 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: HL-DT-ST RW/DVD GCC-4520B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 52X DVD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ata1: SATA max UDMA/100 cmd 0xF8850C80 ctl 0xF8850C8A bmdma 0xF8850C00 irq 19
ata2: SATA max UDMA/100 cmd 0xF8850CC0 ctl 0xF8850CCA bmdma 0xF8850C08 irq 19
ata3: SATA max UDMA/100 cmd 0xF8850E80 ctl 0xF8850E8A bmdma 0xF8850E00 irq 19
ata4: SATA max UDMA/100 cmd 0xF8850EC0 ctl 0xF8850ECA bmdma 0xF8850E08 irq 19
ata1: dev 0 ATA, max UDMA/133, 72303840 sectors (lba48)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
ehci_hcd 0000:01:0b.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:01:0b.2: irq 19, pci mem f8856800
ehci_hcd 0000:01:0b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:01:0b.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:01:0b.0: VIA Technologies, Inc. USB
uhci_hcd 0000:01:0b.0: irq 17, io base 0000a000
uhci_hcd 0000:01:0b.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:01:0b.1: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:01:0b.1: irq 18, io base 0000a080
uhci_hcd 0000:01:0b.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed

I just flashed the BIOS with the newest version on Tyan's site.  Any
help with this would be appreciated.  .config is attached.

Thanks,
-ryan
