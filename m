Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTLWMFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 07:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbTLWMFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 07:05:35 -0500
Received: from camus.xss.co.at ([194.152.162.19]:27411 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265113AbTLWMEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 07:04:52 -0500
Message-ID: <3FE82F4C.7070207@xss.co.at>
Date: Tue, 23 Dec 2003 13:04:28 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: ACPI: problem on ASUS PR-DLS533
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

There are some ACPI-related problems w/ an ASUS PR-DLS5333
Dual Xeon motherboard. I already reported this back in June
for Linux-2.4.21-ac and since then I've tested several kernel
versions, all with the same result: when booting with an ACPI
enabled kernel, the Fusion MPT driver does not find the LSI
Logic 53c1030 PCI-X Fusion-MPT U320 SCSI controller.

I have to boot with "acpi=off" or "pci=noacpi" to get the SCSI
controller hardware recognized.

I verified this problem with:
2.4.21-ac
2.4.23
2.4.24-pre2

Some more info:

System: ASUS AP1700-S5 server with Asus PR-DLS533 motherboard,
ServerWorks Chipset (GCLE, CSB5 and CIOB-X2), Dual Xeon 2.8GHz
(HyperThreading enabled), 2GB RAM

root@tolstoi:~ {516} $ lspci -v
00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 31)
        Flags: fast devsel

00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
        Flags: fast devsel

00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
        Flags: fast devsel

00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp. 82540EM Gigabit Ethernet Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
        Memory at fd800000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 46
        Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at d400 [size=256]
        Memory at fb800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at febe0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Flags: bus master, medium devsel, latency 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 88 [Master SecP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Flags: bus master, medium devsel, latency 32
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at a800 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at fb000000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Flags: bus master, medium devsel, latency 0

00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: [60]
02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 22
        I/O ports at a000 [size=256]
        Memory at fa000000 (64-bit, non-prefetchable) [size=64K]
        Memory at f9800000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe900000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [68]
02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 23
        I/O ports at 9800 [size=256]
        Memory at f9000000 (64-bit, non-prefetchable) [size=64K]
        Memory at f8800000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe800000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [68]
03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)
        Subsystem: Intel Corp.: Unknown device 110d
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        Memory at f8000000 (64-bit, non-prefetchable) [size=128K]
        Memory at f7800000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at 9400 [size=32]
        Expansion ROM at fe7e0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

Kernel boot messages (2.4.24-pre2, booting with "pci=noacpi"):
[...]
Dec 23 12:34:04 tolstoi kernel: klogd 1.3-3, log source = /proc/kmsg started.
Dec 23 12:34:04 tolstoi kernel: Inspecting /boot/System.map-2.4.24-pre2
Dec 23 12:34:04 tolstoi kernel: Loaded 16929 symbols from /boot/System.map-2.4.24-pre2.
Dec 23 12:34:04 tolstoi kernel: Symbols match kernel version 2.4.24.
Dec 23 12:34:04 tolstoi kernel: Loaded 160 symbols from 9 modules.
Dec 23 12:34:04 tolstoi kernel: Linux version 2.4.24-pre2 (root@demo) (gcc version 2.95.3 20010315 (release)) #3 SMP Tue Dec 23 11:40:31 CET 2003
Dec 23 12:34:04 tolstoi kernel: BIOS-provided physical RAM map:
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 0000000000100000 - 000000007fffa000 (usable)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 000000007fffa000 - 000000007ffff000 (ACPI data)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Dec 23 12:34:04 tolstoi kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Dec 23 12:34:04 tolstoi kernel: 1151MB HIGHMEM available.
Dec 23 12:34:04 tolstoi kernel: 896MB LOWMEM available.
Dec 23 12:34:04 tolstoi kernel: ACPI: have wakeup address 0xc0002000
Dec 23 12:34:04 tolstoi kernel: found SMP MP-table at 000f0490
Dec 23 12:34:04 tolstoi kernel: hm, page 000f0000 reserved twice.
Dec 23 12:34:04 tolstoi kernel: hm, page 000f1000 reserved twice.
Dec 23 12:34:04 tolstoi kernel: hm, page 000f0000 reserved twice.
Dec 23 12:34:04 tolstoi kernel: hm, page 000f1000 reserved twice.
Dec 23 12:34:04 tolstoi kernel: On node 0 totalpages: 524282
Dec 23 12:34:04 tolstoi kernel: zone(0): 4096 pages.
Dec 23 12:34:04 tolstoi kernel: zone(1): 225280 pages.
Dec 23 12:34:04 tolstoi kernel: zone(2): 294906 pages.
Dec 23 12:34:04 tolstoi kernel: ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5150
Dec 23 12:34:04 tolstoi kernel: ACPI: RSDT (v001 ASUS   PRDLS533 0x42302e31 MSFT 0x31313031) @ 0x7fffa000
Dec 23 12:34:04 tolstoi kernel: ACPI: FADT (v001 ASUS   PRDLS533 0x42302e31 MSFT 0x31313031) @ 0x7fffa145
Dec 23 12:34:04 tolstoi kernel: ACPI: BOOT (v001 ASUS   PRDLS533 0x42302e31 MSFT 0x31313031) @ 0x7fffa034
Dec 23 12:34:04 tolstoi kernel: ACPI: SPCR (v001 ASUS   PRDLS533 0x42302e31 MSFT 0x31313031) @ 0x7fffa05c
Dec 23 12:34:04 tolstoi kernel: ACPI: MADT (v001 ASUS   PRDLS533 0x42302e31 MSFT 0x31313031) @ 0x7fffa0a9
Dec 23 12:34:04 tolstoi kernel: ACPI: DSDT (v001   ASUS PRDLS533 0x00001000 MSFT 0x0100000b) @ 0x00000000
Dec 23 12:34:04 tolstoi kernel: ACPI: Local APIC address 0xfee00000
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Dec 23 12:34:04 tolstoi kernel: Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Dec 23 12:34:04 tolstoi kernel: Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Dec 23 12:34:04 tolstoi kernel: Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Dec 23 12:34:04 tolstoi kernel: Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Dec 23 12:34:04 tolstoi kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Dec 23 12:34:04 tolstoi kernel: Using ACPI for processor (LAPIC) configuration information
Dec 23 12:34:04 tolstoi kernel: Intel MultiProcessor Specification v1.4
Dec 23 12:34:04 tolstoi kernel:     Virtual Wire compatibility mode.
Dec 23 12:34:04 tolstoi kernel: OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
Dec 23 12:34:04 tolstoi kernel: I/O APIC #8 Version 17 at 0xFEC00000.
Dec 23 12:34:04 tolstoi kernel: I/O APIC #9 Version 17 at 0xFEC01000.
Dec 23 12:34:04 tolstoi kernel: I/O APIC #10 Version 17 at 0xFEC02000.
Dec 23 12:34:04 tolstoi kernel: Enabling APIC mode: Flat.^IUsing 3 I/O APICs
Dec 23 12:34:04 tolstoi kernel: Processors: 4
Dec 23 12:34:04 tolstoi kernel: Kernel command line: BOOT_IMAGE=linux2424pre2 ro root=100 pci=noacpi
Dec 23 12:34:04 tolstoi kernel: Initializing CPU#0
Dec 23 12:34:04 tolstoi kernel: Detected 2790.820 MHz processor.
Dec 23 12:34:04 tolstoi kernel: Console: colour VGA+ 80x50
Dec 23 12:34:04 tolstoi kernel: Calibrating delay loop... 5570.56 BogoMIPS
Dec 23 12:34:04 tolstoi kernel: Memory: 2069552k/2097128k available (1031k kernel code, 27188k reserved, 470k data, 108k init, 1179624k highmem)
Dec 23 12:34:04 tolstoi kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Dec 23 12:34:04 tolstoi kernel: Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Dec 23 12:34:04 tolstoi kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Dec 23 12:34:04 tolstoi kernel: Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 23 12:34:04 tolstoi kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Dec 23 12:34:04 tolstoi kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Dec 23 12:34:04 tolstoi kernel: CPU: L2 cache: 512K
Dec 23 12:34:04 tolstoi kernel: CPU: Physical Processor ID: 0
Dec 23 12:34:04 tolstoi kernel: Intel machine check architecture supported.
Dec 23 12:34:04 tolstoi kernel: Intel machine check reporting enabled on CPU#0.
Dec 23 12:34:04 tolstoi kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: Enabling fast FPU save and restore... done.
Dec 23 12:34:04 tolstoi kernel: Enabling unmasked SIMD FPU exception support... done.
Dec 23 12:34:04 tolstoi kernel: Checking 'hlt' instruction... OK.
Dec 23 12:34:04 tolstoi kernel: POSIX conformance testing by UNIFIX
Dec 23 12:34:04 tolstoi kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Dec 23 12:34:04 tolstoi kernel: mtrr: detected mtrr type: Intel
Dec 23 12:34:04 tolstoi kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Dec 23 12:34:04 tolstoi kernel: CPU: L2 cache: 512K
Dec 23 12:34:04 tolstoi kernel: CPU: Physical Processor ID: 0
Dec 23 12:34:04 tolstoi kernel: Intel machine check reporting enabled on CPU#0.
Dec 23 12:34:04 tolstoi kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Dec 23 12:34:04 tolstoi kernel: per-CPU timeslice cutoff: 1463.06 usecs.
Dec 23 12:34:04 tolstoi kernel: enabled ExtINT on CPU#0
Dec 23 12:34:04 tolstoi kernel: ESR value before enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: ESR value after enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: Booting processor 1/1 eip 3000
Dec 23 12:34:04 tolstoi kernel: Initializing CPU#1
Dec 23 12:34:04 tolstoi kernel: masked ExtINT on CPU#1
Dec 23 12:34:04 tolstoi kernel: ESR value before enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: ESR value after enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: Calibrating delay loop... 5570.56 BogoMIPS
Dec 23 12:34:04 tolstoi kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Dec 23 12:34:04 tolstoi kernel: CPU: L2 cache: 512K
Dec 23 12:34:04 tolstoi kernel: CPU: Physical Processor ID: 0
Dec 23 12:34:04 tolstoi kernel: Intel machine check reporting enabled on CPU#1.
Dec 23 12:34:04 tolstoi kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Dec 23 12:34:04 tolstoi kernel: Booting processor 2/6 eip 3000
Dec 23 12:34:04 tolstoi kernel: Initializing CPU#2
Dec 23 12:34:04 tolstoi kernel: masked ExtINT on CPU#2
Dec 23 12:34:04 tolstoi kernel: ESR value before enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: ESR value after enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: Calibrating delay loop... 5570.56 BogoMIPS
Dec 23 12:34:04 tolstoi kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Dec 23 12:34:04 tolstoi kernel: CPU: L2 cache: 512K
Dec 23 12:34:04 tolstoi kernel: CPU: Physical Processor ID: 3
Dec 23 12:34:04 tolstoi kernel: Intel machine check reporting enabled on CPU#2.
Dec 23 12:34:04 tolstoi kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Dec 23 12:34:04 tolstoi kernel: Booting processor 3/7 eip 3000
Dec 23 12:34:04 tolstoi kernel: Initializing CPU#3
Dec 23 12:34:04 tolstoi kernel: masked ExtINT on CPU#3
Dec 23 12:34:04 tolstoi kernel: ESR value before enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: ESR value after enabling vector: 00000000
Dec 23 12:34:04 tolstoi kernel: Calibrating delay loop... 5570.56 BogoMIPS
Dec 23 12:34:04 tolstoi kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Dec 23 12:34:04 tolstoi kernel: CPU: L2 cache: 512K
Dec 23 12:34:04 tolstoi kernel: CPU: Physical Processor ID: 3
Dec 23 12:34:04 tolstoi kernel: Intel machine check reporting enabled on CPU#3.
Dec 23 12:34:04 tolstoi kernel: CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Dec 23 12:34:04 tolstoi kernel: CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Dec 23 12:34:04 tolstoi kernel: Total of 4 processors activated (22282.24 BogoMIPS).
Dec 23 12:34:04 tolstoi kernel: cpu_sibling_map[0] = 1
Dec 23 12:34:04 tolstoi kernel: cpu_sibling_map[1] = 0
Dec 23 12:34:04 tolstoi kernel: cpu_sibling_map[2] = 3
Dec 23 12:34:04 tolstoi kernel: cpu_sibling_map[3] = 2
Dec 23 12:34:04 tolstoi kernel: ENABLING IO-APIC IRQs
Dec 23 12:34:04 tolstoi kernel: Setting 8 in the phys_id_present_map
Dec 23 12:34:04 tolstoi kernel: ...changing IO-APIC physical APIC ID to 8 ... ok.
Dec 23 12:34:04 tolstoi kernel: Setting 9 in the phys_id_present_map
Dec 23 12:34:04 tolstoi kernel: ...changing IO-APIC physical APIC ID to 9 ... ok.
Dec 23 12:34:04 tolstoi kernel: Setting 10 in the phys_id_present_map
Dec 23 12:34:04 tolstoi kernel: ...changing IO-APIC physical APIC ID to 10 ... ok.
Dec 23 12:34:04 tolstoi kernel: init IO_APIC IRQs
Dec 23 12:34:04 tolstoi kernel:  IO-APIC (apicid-pin) 8-0, 8-5, 8-9, 8-10, 8-12, 8-14, 9-0, 9-1, 9-4, 9-5, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 10-0, 10-1, 10-2, 10-3, 10-4, 10-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-15 not connected.
Dec 23 12:34:04 tolstoi kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Dec 23 12:34:04 tolstoi kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Dec 23 12:34:04 tolstoi kernel: ...trying to set up timer (IRQ0) through the 8259A ...
Dec 23 12:34:04 tolstoi kernel: ..... (found pin 0) ...works.
Dec 23 12:34:04 tolstoi kernel: number of MP IRQ sources: 16.
Dec 23 12:34:04 tolstoi kernel: number of IO-APIC #8 registers: 16.
Dec 23 12:34:04 tolstoi kernel: number of IO-APIC #9 registers: 16.
Dec 23 12:34:04 tolstoi kernel: number of IO-APIC #10 registers: 16.
Dec 23 12:34:04 tolstoi kernel: testing the IO APIC.......................
Dec 23 12:34:04 tolstoi kernel:
Dec 23 12:34:04 tolstoi kernel: IO APIC #8......
Dec 23 12:34:04 tolstoi kernel: .... register #00: 08000000
Dec 23 12:34:04 tolstoi kernel: .......    : physical APIC id: 08
Dec 23 12:34:04 tolstoi kernel: .......    : Delivery Type: 0
Dec 23 12:34:04 tolstoi kernel: .......    : LTS          : 0
Dec 23 12:34:04 tolstoi kernel: .... register #01: 000F0011
Dec 23 12:34:04 tolstoi kernel: .......     : max redirection entries: 000F
Dec 23 12:34:04 tolstoi kernel: .......     : PRQ implemented: 0
Dec 23 12:34:04 tolstoi kernel: .......     : IO APIC version: 0011
Dec 23 12:34:04 tolstoi kernel: .... register #02: 08000000
Dec 23 12:34:04 tolstoi kernel: .......     : arbitration: 08
Dec 23 12:34:04 tolstoi kernel: .... IRQ redirection table:
Dec 23 12:34:04 tolstoi kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Dec 23 12:34:04 tolstoi kernel:  00 00F 0F  0    0    0   0   0    1    1    31
Dec 23 12:34:04 tolstoi kernel:  01 00F 0F  0    0    0   0   0    1    1    39
Dec 23 12:34:04 tolstoi kernel:  02 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  03 00F 0F  0    0    0   0   0    1    1    41
Dec 23 12:34:04 tolstoi kernel:  04 00F 0F  0    0    0   0   0    1    1    49
Dec 23 12:34:04 tolstoi kernel:  05 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  06 00F 0F  0    0    0   0   0    1    1    51
Dec 23 12:34:04 tolstoi kernel:  07 00F 0F  0    0    0   0   0    1    1    59
Dec 23 12:34:04 tolstoi kernel:  08 00F 0F  0    0    0   0   0    1    1    61
Dec 23 12:34:04 tolstoi kernel:  09 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0a 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0b 00F 0F  1    1    0   1   0    1    1    69
Dec 23 12:34:04 tolstoi kernel:  0c 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0d 00F 0F  0    0    0   0   0    1    1    71
Dec 23 12:34:04 tolstoi kernel:  0e 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0f 00F 0F  0    0    0   0   0    1    1    79
Dec 23 12:34:04 tolstoi kernel:
Dec 23 12:34:04 tolstoi kernel: IO APIC #9......
Dec 23 12:34:04 tolstoi kernel: .... register #00: 09000000
Dec 23 12:34:04 tolstoi kernel: .......    : physical APIC id: 09
Dec 23 12:34:04 tolstoi kernel: .......    : Delivery Type: 0
Dec 23 12:34:04 tolstoi kernel: .......    : LTS          : 0
Dec 23 12:34:04 tolstoi kernel: .... register #01: 000F0011
Dec 23 12:34:04 tolstoi kernel: .......     : max redirection entries: 000F
Dec 23 12:34:04 tolstoi kernel: .......     : PRQ implemented: 0
Dec 23 12:34:04 tolstoi kernel: .......     : IO APIC version: 0011
Dec 23 12:34:04 tolstoi kernel: .... register #02: 09000000
Dec 23 12:34:04 tolstoi kernel: .......     : arbitration: 09
Dec 23 12:34:04 tolstoi kernel: .... IRQ redirection table:
Dec 23 12:34:04 tolstoi kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Dec 23 12:34:04 tolstoi kernel:  00 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  01 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  02 00F 0F  1    1    0   1   0    1    1    81
Dec 23 12:34:04 tolstoi kernel:  03 00F 0F  1    1    0   1   0    1    1    89
Dec 23 12:34:04 tolstoi kernel:  04 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  05 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  06 00F 0F  1    1    0   1   0    1    1    91
Dec 23 12:34:04 tolstoi kernel:  07 00F 0F  1    1    0   1   0    1    1    99
Dec 23 12:34:04 tolstoi kernel:  08 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  09 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0a 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0b 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0c 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0d 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0e 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0f 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:
Dec 23 12:34:04 tolstoi kernel: IO APIC #10......
Dec 23 12:34:04 tolstoi kernel: .... register #00: 0A000000
Dec 23 12:34:04 tolstoi kernel: .......    : physical APIC id: 0A
Dec 23 12:34:04 tolstoi kernel: .......    : Delivery Type: 0
Dec 23 12:34:04 tolstoi kernel: .......    : LTS          : 0
Dec 23 12:34:04 tolstoi kernel: .... register #01: 000F0011
Dec 23 12:34:04 tolstoi kernel: .......     : max redirection entries: 000F
Dec 23 12:34:04 tolstoi kernel: .......     : PRQ implemented: 0
Dec 23 12:34:04 tolstoi kernel: .......     : IO APIC version: 0011
Dec 23 12:34:04 tolstoi kernel: .... register #02: 0A000000
Dec 23 12:34:04 tolstoi kernel: .......     : arbitration: 0A
Dec 23 12:34:04 tolstoi kernel: .... IRQ redirection table:
Dec 23 12:34:04 tolstoi kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Dec 23 12:34:04 tolstoi kernel:  00 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  01 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  02 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  03 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  04 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  05 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  06 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  07 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  08 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  09 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0a 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0b 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0c 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0d 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel:  0e 00F 0F  1    1    0   1   0    1    1    A1
Dec 23 12:34:04 tolstoi kernel:  0f 000 00  1    0    0   0   0    0    0    00
Dec 23 12:34:04 tolstoi kernel: IRQ to pin mappings:
Dec 23 12:34:04 tolstoi kernel: IRQ0 -> 0:0
Dec 23 12:34:04 tolstoi kernel: IRQ1 -> 0:1
Dec 23 12:34:04 tolstoi kernel: IRQ3 -> 0:3
Dec 23 12:34:04 tolstoi kernel: IRQ4 -> 0:4
Dec 23 12:34:04 tolstoi kernel: IRQ6 -> 0:6
Dec 23 12:34:04 tolstoi kernel: IRQ7 -> 0:7
Dec 23 12:34:04 tolstoi kernel: IRQ8 -> 0:8
Dec 23 12:34:04 tolstoi kernel: IRQ11 -> 0:11
Dec 23 12:34:04 tolstoi kernel: IRQ13 -> 0:13
Dec 23 12:34:04 tolstoi kernel: IRQ15 -> 0:15
Dec 23 12:34:04 tolstoi kernel: IRQ18 -> 1:2
Dec 23 12:34:04 tolstoi kernel: IRQ19 -> 1:3
Dec 23 12:34:04 tolstoi kernel: IRQ22 -> 1:6
Dec 23 12:34:04 tolstoi kernel: IRQ23 -> 1:7
Dec 23 12:34:04 tolstoi kernel: IRQ46 -> 2:14
Dec 23 12:34:04 tolstoi kernel: .................................... done.
Dec 23 12:34:04 tolstoi kernel: Using local APIC timer interrupts.
Dec 23 12:34:04 tolstoi kernel: calibrating APIC timer ...
Dec 23 12:34:04 tolstoi kernel: ..... CPU clock speed is 2790.8938 MHz.
Dec 23 12:34:04 tolstoi kernel: ..... host bus clock speed is 132.8995 MHz.
Dec 23 12:34:08 tolstoi kernel: cpu: 0, clocks: 1328995, slice: 265799
Dec 23 12:34:08 tolstoi kernel: CPU0<T0:1328992,T1:1063184,D:9,S:265799,C:1328995>
Dec 23 12:34:08 tolstoi kernel: cpu: 1, clocks: 1328995, slice: 265799
Dec 23 12:34:08 tolstoi kernel: cpu: 2, clocks: 1328995, slice: 265799
Dec 23 12:34:08 tolstoi kernel: cpu: 3, clocks: 1328995, slice: 265799
Dec 23 12:34:08 tolstoi kernel: CPU1<T0:1328992,T1:797392,D:2,S:265799,C:1328995>
Dec 23 12:34:08 tolstoi kernel: CPU2<T0:1328992,T1:531584,D:11,S:265799,C:1328995>
Dec 23 12:34:08 tolstoi kernel: CPU3<T0:1328992,T1:265792,D:4,S:265799,C:1328995>
Dec 23 12:34:08 tolstoi kernel: checking TSC synchronization across CPUs: passed.
Dec 23 12:34:08 tolstoi kernel: Waiting on wait_init_idle (map = 0xe)
Dec 23 12:34:08 tolstoi kernel: All processors have done init_idle
Dec 23 12:34:08 tolstoi kernel: ACPI: Subsystem revision 20031203
Dec 23 12:34:08 tolstoi kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1520, last bus=4
Dec 23 12:34:08 tolstoi kernel: PCI: Using configuration type 1
Dec 23 12:34:08 tolstoi kernel: ACPI: IRQ9 SCI: Level Trigger.
Dec 23 12:34:08 tolstoi kernel: ACPI: Interpreter enabled
Dec 23 12:34:08 tolstoi kernel: ACPI: Using PIC for interrupt routing
Dec 23 12:34:08 tolstoi kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKQ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKV] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKW] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKX] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKY] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNKZ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 5 10 11 12 14 15)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Dec 23 12:34:08 tolstoi kernel: PCI: Probing PCI hardware (bus 00)
Dec 23 12:34:08 tolstoi kernel: PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Root Bridge [PCI1] (00:00)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Root Bridge [PCI2] (00:00)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Root Bridge [PCI3] (00:00)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI3._PRT]
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Root Bridge [PCI4] (00:00)
Dec 23 12:34:08 tolstoi kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI4._PRT]
Dec 23 12:34:08 tolstoi kernel: PCI: Probing PCI hardware
Dec 23 12:34:08 tolstoi kernel: PCI: Discovered primary peer bus 01 [IRQ]
Dec 23 12:34:08 tolstoi kernel: PCI: Discovered primary peer bus 02 [IRQ]
Dec 23 12:34:08 tolstoi kernel: PCI: Discovered primary peer bus 03 [IRQ]
Dec 23 12:34:08 tolstoi kernel: PCI: Discovered primary peer bus 04 [IRQ]
Dec 23 12:34:08 tolstoi kernel: PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
Dec 23 12:34:08 tolstoi kernel: PCI->APIC IRQ transform: (B0,I2,P0) -> 18
Dec 23 12:34:08 tolstoi kernel: PCI->APIC IRQ transform: (B0,I3,P0) -> 46
Dec 23 12:34:08 tolstoi kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 11
Dec 23 12:34:08 tolstoi kernel: PCI->APIC IRQ transform: (B2,I4,P0) -> 22
Dec 23 12:34:08 tolstoi kernel: PCI->APIC IRQ transform: (B2,I4,P1) -> 23
Dec 23 12:34:08 tolstoi kernel: PCI->APIC IRQ transform: (B3,I2,P0) -> 19
Dec 23 12:34:08 tolstoi kernel: Linux NET4.0 for Linux 2.4
Dec 23 12:34:08 tolstoi kernel: Based upon Swansea University Computer Society NET3.039
Dec 23 12:34:08 tolstoi kernel: Initializing RT netlink socket
Dec 23 12:34:08 tolstoi kernel: Starting kswapd
Dec 23 12:34:08 tolstoi kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Dec 23 12:34:08 tolstoi kernel: VFS: Disk quotas vdquot_6.5.1
Dec 23 12:34:08 tolstoi kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
Dec 23 12:34:08 tolstoi kernel: devfs: boot_options: 0x1
Dec 23 12:34:08 tolstoi kernel: Detected PS/2 Mouse Port.
Dec 23 12:34:08 tolstoi kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
Dec 23 12:34:08 tolstoi kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec 23 12:34:08 tolstoi kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec 23 12:34:08 tolstoi kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Dec 23 12:34:08 tolstoi kernel: Initializing Cryptographic API
Dec 23 12:34:08 tolstoi kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 23 12:34:08 tolstoi kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec 23 12:34:08 tolstoi kernel: IP: routing cache hash table of 16384 buckets, 128Kbytes
Dec 23 12:34:08 tolstoi kernel: TCP: Hash tables configured (established 262144 bind 65536)
Dec 23 12:34:08 tolstoi kernel: RAMDISK: Compressed image found at block 0
Dec 23 12:34:08 tolstoi kernel: Freeing initrd memory: 442k freed
Dec 23 12:34:08 tolstoi kernel: VFS: Mounted root (romfs filesystem) readonly.
Dec 23 12:34:08 tolstoi kernel: Mounted devfs on /dev
Dec 23 12:34:08 tolstoi kernel: Freeing unused kernel memory: 108k freed
Dec 23 12:34:08 tolstoi kernel: SCSI subsystem driver Revision: 1.00
Dec 23 12:34:08 tolstoi kernel: Fusion MPT base driver 2.05.05+
Dec 23 12:34:08 tolstoi kernel: Copyright (c) 1999-2002 LSI Logic Corporation
Dec 23 12:34:08 tolstoi kernel: mptbase: Initiating ioc0 bringup
Dec 23 12:34:08 tolstoi kernel: ioc0: 53C1030: Capabilities={Initiator}
Dec 23 12:34:08 tolstoi kernel: mptbase: Initiating ioc1 bringup
Dec 23 12:34:08 tolstoi kernel: ioc1: 53C1030: Capabilities={Initiator}
Dec 23 12:34:08 tolstoi kernel: mptbase: 2 MPT adapters found, 2 installed.
Dec 23 12:34:08 tolstoi kernel: Fusion MPT SCSI Host driver 2.05.05+
Dec 23 12:34:08 tolstoi kernel: scsi0 : ioc0: LSI53C1030, FwRev=01012e00h, Ports=1, MaxQ=255, IRQ=22
Dec 23 12:34:08 tolstoi kernel: scsi1 : ioc1: LSI53C1030, FwRev=01012e00h, Ports=1, MaxQ=255, IRQ=23
Dec 23 12:34:08 tolstoi kernel: blk: queue f7b59e18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Dec 23 12:34:08 tolstoi kernel:   Vendor: IBM       Model: DDYS-T18350M      Rev: S9YB
Dec 23 12:34:08 tolstoi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Dec 23 12:34:08 tolstoi kernel: blk: queue f7b59a18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Dec 23 12:34:08 tolstoi kernel:   Vendor: QUANTUM   Model: ATLAS10K3_18_SCA  Rev: 020K
Dec 23 12:34:08 tolstoi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Dec 23 12:34:08 tolstoi kernel: blk: queue f7b59618, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Dec 23 12:34:08 tolstoi kernel:   Vendor: SDR       Model: GEM318            Rev: 0
Dec 23 12:34:08 tolstoi kernel:   Type:   Processor                          ANSI SCSI revision: 02
Dec 23 12:34:08 tolstoi kernel: blk: queue f76eb218, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Dec 23 12:34:08 tolstoi kernel: mptscsih: ioc0: scsi0: Id=0 Lun=0: Queue depth=31
Dec 23 12:34:08 tolstoi kernel: mptscsih: ioc0: scsi0: Id=1 Lun=0: Queue depth=31
Dec 23 12:34:08 tolstoi kernel: mptscsih: ioc0: scsi0: Id=11 Lun=0: Queue depth=1
Dec 23 12:34:08 tolstoi kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Dec 23 12:34:08 tolstoi kernel: Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Dec 23 12:34:08 tolstoi kernel: SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Dec 23 12:34:08 tolstoi kernel: Partition check:
Dec 23 12:34:08 tolstoi kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
Dec 23 12:34:08 tolstoi kernel: SCSI device sdb: 35916548 512-byte hdwr sectors (18389 MB)
Dec 23 12:34:08 tolstoi kernel:  /dev/scsi/host0/bus0/target1/lun0: p1
Dec 23 12:34:08 tolstoi kernel: Journalled Block Device driver loaded
Dec 23 12:34:08 tolstoi kernel: kjournald starting.  Commit interval 5 seconds
Dec 23 12:34:08 tolstoi kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 23 12:34:08 tolstoi kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Dec 23 12:34:08 tolstoi kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
Dec 23 12:34:08 tolstoi kernel: Adding Swap: 1959888k swap-space (priority -1)
Dec 23 12:34:08 tolstoi kernel: reiserfs: found format "3.6" with standard journal
Dec 23 12:34:08 tolstoi kernel: reiserfs: checking transaction log (device sd(8,5)) ...
Dec 23 12:34:08 tolstoi kernel: for (sd(8,5))
Dec 23 12:34:08 tolstoi kernel: sd(8,5):Using r5 hash to sort names
Dec 23 12:34:08 tolstoi kernel: reiserfs: found format "3.6" with standard journal
Dec 23 12:34:08 tolstoi kernel: reiserfs: checking transaction log (device sd(8,6)) ...
Dec 23 12:34:08 tolstoi kernel: for (sd(8,6))
Dec 23 12:34:08 tolstoi kernel: sd(8,6):Using r5 hash to sort names
Dec 23 12:34:08 tolstoi kernel: reiserfs: found format "3.6" with standard journal
Dec 23 12:34:08 tolstoi kernel: reiserfs: checking transaction log (device sd(8,7)) ...
Dec 23 12:34:08 tolstoi kernel: for (sd(8,7))
Dec 23 12:34:08 tolstoi kernel: sd(8,7):Using r5 hash to sort names
Dec 23 12:34:08 tolstoi kernel: reiserfs: found format "3.6" with standard journal
Dec 23 12:34:08 tolstoi kernel: reiserfs: checking transaction log (device sd(8,8)) ...
Dec 23 12:34:08 tolstoi kernel: for (sd(8,8))
Dec 23 12:34:08 tolstoi kernel: sd(8,8):Using r5 hash to sort names
Dec 23 12:34:08 tolstoi kernel: kjournald starting.  Commit interval 5 seconds
Dec 23 12:34:08 tolstoi kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,17), internal journal
Dec 23 12:34:08 tolstoi kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 23 12:34:08 tolstoi kernel: usb.c: registered new driver usbdevfs
Dec 23 12:34:08 tolstoi kernel: usb.c: registered new driver hub
Dec 23 12:34:08 tolstoi kernel: usb-ohci.c: USB OHCI at membase 0xf8c62000, IRQ 11
Dec 23 12:34:08 tolstoi kernel: usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
Dec 23 12:34:08 tolstoi kernel: usb.c: new USB bus registered, assigned bus number 1
Dec 23 12:34:08 tolstoi kernel: hub.c: USB hub found
Dec 23 12:34:08 tolstoi kernel: hub.c: 4 ports detected
Dec 23 12:34:08 tolstoi kernel: usb.c: registered new driver usbmouse
Dec 23 12:34:08 tolstoi kernel: usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Dec 23 12:34:08 tolstoi kernel: usb.c: registered new driver hiddev
Dec 23 12:34:08 tolstoi kernel: usb.c: registered new driver hid
Dec 23 12:34:08 tolstoi kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Dec 23 12:34:08 tolstoi kernel: hid-core.c: USB HID support drivers
Dec 23 12:34:08 tolstoi kernel: mice: PS/2 mouse device common for all mice
Dec 23 12:34:08 tolstoi kernel: usb.c: registered new driver usbkbd
Dec 23 12:34:08 tolstoi kernel: usbkbd.c: :USB HID Boot Protocol keyboard driver
Dec 23 12:34:08 tolstoi kernel: ACPI: Power Button (FF) [PWRF]
Dec 23 12:34:08 tolstoi kernel: ACPI: Processor [CPU0] (supports C1)
Dec 23 12:34:08 tolstoi kernel: ACPI: Processor [CPU1] (supports C1)
Dec 23 12:34:08 tolstoi kernel: ACPI: Processor [CPU2] (supports C1)
Dec 23 12:34:08 tolstoi kernel: ACPI: Processor [CPU3] (supports C1)
Dec 23 12:34:08 tolstoi kernel: i2c-core.o: i2c core module version 2.6.1 (20010830)
Dec 23 12:34:08 tolstoi kernel: i2c-proc.o version 2.6.1 (20010830)
Dec 23 12:34:10 tolstoi kernel: Software Watchdog Timer: 0.05, timer margin: 60 sec
Dec 23 12:34:12 tolstoi kernel: Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Dec 23 12:34:12 tolstoi kernel: Copyright (c) 1999-2003 Intel Corporation.
Dec 23 12:34:12 tolstoi kernel: eth0: Intel(R) PRO/1000 Network Connection
Dec 23 12:34:12 tolstoi kernel: eth1: Intel(R) PRO/1000 Network Connection
Dec 23 12:34:14 tolstoi kernel: e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Dec 23 12:34:20 tolstoi kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[...]

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/6C9KxJmyeGcXPhERAiu1AJ0S/eGkQvwpb3qceIYb0QryGg4gwQCfY88r
qK2Wqkyr2Mo7GjqsK2YpKis=
=E8aT
-----END PGP SIGNATURE-----

