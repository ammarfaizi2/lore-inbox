Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267706AbSLGCVM>; Fri, 6 Dec 2002 21:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbSLGCVL>; Fri, 6 Dec 2002 21:21:11 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:21010 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267706AbSLGCU7>; Fri, 6 Dec 2002 21:20:59 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1AD3@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Tolga Tarhan'" <ttarhan@deltelco.com>, linux-kernel@vger.kernel.org
Subject: RE: Dual Xeon w/ HT: Kernel can't find second CPU
Date: Fri, 6 Dec 2002 18:27:37 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming that CONFIG_SMP has been turned on in your .config, can you check
in the BIOS if both the CPU's have been detected? Usually, it is under the
Advanced option -> Advanced Processor Option

Also, try to set HT off and see if both physical processors are detected ...

Thanks
Manish

-----Original Message-----
From: Tolga Tarhan [mailto:ttarhan@deltelco.com]
Sent: Friday, December 06, 2002 6:12 PM
To: linux-kernel@vger.kernel.org
Subject: Dual Xeon w/ HT: Kernel can't find second CPU


Hello all:

    I have a Dual PIV Xeon system.  It has two _physical_ Xeon's in
    it.

    Kernel versions 2.4.19 and 2.4.20 can't find the second physical
    CPU.  They find one physical processor and it's sibling, therefore
    reporting two virtual processors, when in-fact, there should be
    four virtual processors.

    How do I know that it's not finding the second physical processor
    and just not using HT?  It's simple:

	kernel: Initializing CPU#0
	<snip>
	kernel: CPU: Physical Processor ID: 0
	<snip>
	kernel: Initializing CPU#1
	<snip>
	kernel: CPU: Physical Processor ID: 0

	... and ...

	kernel: cpu_sibling_map[0] = 1
	kernel: cpu_sibling_map[1] = 0

    Also, /proc/cpuinfo reports the _exact_ same bogomips for both
    processors -- not very likely if they were two physical CPUs.

    I've tried changing a few kernel settings (and two different
    kernel versions) to no avail. 

    I'm not on the linux-kernel list, but I have searched the
    archives.  The closest thing I could find was someone asking why
    linux thought they had two processors when they had one -- quite
    the opposite problem.  If you reply to the list, please CC me
    as well.

    Any ideas?

    Here's the full bootlog (it's quite long, sorry):

kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
kernel: Inspecting /boot/System.map-2.4.20
kernel: Loaded 18769 symbols from /boot/System.map-2.4.20.
kernel: Symbols match kernel version 2.4.20.
kernel: No module symbols loaded.
kernel: Linux version 2.4.20 (root@speak) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 SMP Fri Dec 6 17:19:06 PST 2002
kernel: BIOS-provided physical RAM map:
kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
kernel:  BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
kernel:  BIOS-e820: 0000000000100000 - 00000000f7ef0000 (usable)
kernel:  BIOS-e820: 00000000f7ef0000 - 00000000f7efc000 (ACPI data)
kernel:  BIOS-e820: 00000000f7efc000 - 00000000f7f00000 (ACPI NVS)
kernel:  BIOS-e820: 00000000f7f00000 - 00000000f7f80000 (usable)
kernel:  BIOS-e820: 00000000f7f80000 - 00000000f8000000 (reserved)
kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
kernel: 3071MB HIGHMEM available.
kernel: 896MB LOWMEM available.
kernel: found SMP MP-table at 000f6760
kernel: hm, page 000f6000 reserved twice.
kernel: hm, page 000f7000 reserved twice.
kernel: hm, page 0009f000 reserved twice.
kernel: hm, page 000a0000 reserved twice.
kernel: On node 0 totalpages: 1015680
kernel: zone(0): 4096 pages.
kernel: zone(1): 225280 pages.
kernel: zone(2): 786304 pages.
kernel: ACPI: Searched entire block, no RSDP was found.
kernel: ACPI: RSDP located at physical address c00f67c0
kernel: RSD PTR  v0 [PTLTD ]
kernel: __va_range(0xf7ef82d7, 0x68): idx=8 mapped at ffff6000
kernel: ACPI table found: RSDT v1 [PTLTD    RSDT   1540.0]
kernel: __va_range(0xf7efbe94, 0x24): idx=8 mapped at ffff6000
kernel: __va_range(0xf7efbe94, 0x74): idx=8 mapped at ffff6000
kernel: ACPI table found: FACP v1 [INTEL  K_CANYON 1540.0]
kernel: __va_range(0xf7efbf08, 0x24): idx=8 mapped at ffff6000
kernel: __va_range(0xf7efbf08, 0x80): idx=8 mapped at ffff6000
kernel: ACPI table found: APIC v1 [PTLTD  ^I APIC   1540.0]
kernel: __va_range(0xf7efbf08, 0x80): idx=8 mapped at ffff6000
kernel: LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
kernel: CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC
version 16
kernel:
kernel: LAPIC (acpi_id[0x0001] id[0x1] enabled[1])
kernel: CPU 1 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC
version 16
kernel:
kernel: IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
kernel: IOAPIC (id[0x3] address[0xfec80000] global_irq_base[0x18])
kernel: IOAPIC (id[0x4] address[0xfec80400] global_irq_base[0x30])
kernel: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1]
trigger[0x1])
kernel: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
trigger[0x3])
kernel: LAPIC_NMI (acpi_id[0x0000] polarity[0x1] trigger[0x1] lint[0x1])
kernel: LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
kernel: 2 CPUs total
kernel: Local APIC address fee00000
kernel: __va_range(0xf7efbf88, 0x24): idx=8 mapped at ffff6000
kernel: __va_range(0xf7efbf88, 0x28): idx=8 mapped at ffff6000
kernel: ACPI table found: BOOT v1 [PTLTD  $SBFTBL$ 1540.0]
kernel: __va_range(0xf7efbfb0, 0x24): idx=8 mapped at ffff6000
kernel: __va_range(0xf7efbfb0, 0x50): idx=8 mapped at ffff6000
kernel: ACPI table found: SPCR v1 [PTLTD  $UCRTBL$ 1540.0]
kernel: Enabling the CPU's according to the ACPI table
kernel: Intel MultiProcessor Specification v1.4
kernel:     Virtual Wire compatibility mode.
kernel: OEM ID:   Product ID: Kings Canyon APIC at: 0xFEE00000
kernel: I/O APIC #2 Version 32 at 0xFEC00000.
kernel: I/O APIC #3 Version 32 at 0xFEC80000.
kernel: I/O APIC #4 Version 32 at 0xFEC80400.
kernel: Processors: 2
kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=803 maxcpus=4
kernel: Initializing CPU#0
kernel: Detected 2395.953 MHz processor.
kernel: Console: colour VGA+ 80x25
kernel: Calibrating delay loop... 4784.12 BogoMIPS
kernel: Memory: 4011668k/4062720k available (1503k kernel code, 50600k
reserved, 654k data, 108k init, 3145152k highmem)
kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
kernel: Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
kernel: Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
kernel: Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
kernel: CPU: L2 cache: 512K
kernel: CPU: Physical Processor ID: 0
kernel: Intel machine check architecture supported.
kernel: Intel machine check reporting enabled on CPU#0.
kernel: CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
kernel: CPU:             Common caps: 3febfbff 00000000 00000000 00000000
kernel: Enabling fast FPU save and restore... done.
kernel: Enabling unmasked SIMD FPU exception support... done.
kernel: Checking 'hlt' instruction... OK.
kernel: POSIX conformance testing by UNIFIX
kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
kernel: CPU: L2 cache: 512K
kernel: CPU: Physical Processor ID: 0
kernel: Intel machine check reporting enabled on CPU#0.
kernel: CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
kernel: CPU:             Common caps: 3febfbff 00000000 00000000 00000000
kernel: CPU0: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
kernel: per-CPU timeslice cutoff: 1462.93 usecs.
kernel: enabled ExtINT on CPU#0
kernel: ESR value before enabling vector: 00000000
kernel: ESR value after enabling vector: 00000000
kernel: Booting processor 1/1 eip 2000
kernel: Initializing CPU#1
kernel: masked ExtINT on CPU#1
kernel: ESR value before enabling vector: 00000000
kernel: ESR value after enabling vector: 00000000
kernel: Calibrating delay loop... 4784.12 BogoMIPS
kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
kernel: CPU: L2 cache: 512K
kernel: CPU: Physical Processor ID: 0
kernel: Intel machine check reporting enabled on CPU#1.
kernel: CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
kernel: CPU:             Common caps: 3febfbff 00000000 00000000 00000000
kernel: CPU1: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
kernel: Total of 2 processors activated (9568.25 BogoMIPS).
kernel: cpu_sibling_map[0] = 1
kernel: cpu_sibling_map[1] = 0
kernel: ENABLING IO-APIC IRQs
kernel: Setting 2 in the phys_id_present_map
kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
kernel: Setting 3 in the phys_id_present_map
kernel: ...changing IO-APIC physical APIC ID to 3 ... ok.
kernel: Setting 4 in the phys_id_present_map
kernel: ...changing IO-APIC physical APIC ID to 4 ... ok.
kernel: init IO_APIC IRQs
kernel:  IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-15, 2-20, 2-23, 3-1, 3-2,
3-3, 3-5, 3-6, 3-7, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3
kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
kernel: number of MP IRQ sources: 28.
kernel: number of IO-APIC #2 registers: 24.
kernel: number of IO-APIC #3 registers: 24.
kernel: number of IO-APIC #4 registers: 24.
kernel: testing the IO APIC.......................
kernel:
kernel: IO APIC #2......
kernel: .... register #00: 02008000
kernel: .......    : physical APIC id: 02
kernel:  WARNING: unexpected IO-APIC, please mail
kernel:           to linux-smp@vger.kernel.org
kernel: .... register #01: 00178020
kernel: .......     : max redirection entries: 0017
kernel: .......     : PRQ implemented: 1
kernel: .......     : IO APIC version: 0020
kernel: .... register #02: 00000000
kernel: .......     : arbitration: 00
kernel: .... IRQ redirection table:
kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
kernel:  00 000 00  1    0    0   0   0    0    0    00
kernel:  01 003 03  0    0    0   0   0    1    1    39
kernel:  02 003 03  0    0    0   0   0    1    1    31
kernel:  03 003 03  0    0    0   0   0    1    1    41
kernel:  04 003 03  0    0    0   0   0    1    1    49
kernel:  05 003 03  0    0    0   0   0    1    1    51
kernel:  06 003 03  0    0    0   0   0    1    1    59
kernel:  07 003 03  0    0    0   0   0    1    1    61
kernel:  08 003 03  0    0    0   0   0    1    1    69
kernel:  09 003 03  0    0    0   0   0    1    1    71
kernel:  0a 000 00  1    0    0   0   0    0    0    00
kernel:  0b 000 00  1    0    0   0   0    0    0    00
kernel:  0c 003 03  0    0    0   0   0    1    1    79
kernel:  0d 003 03  0    0    0   0   0    1    1    81
kernel:  0e 003 03  0    0    0   0   0    1    1    89
kernel:  0f 000 00  1    0    0   0   0    0    0    00
kernel:  10 003 03  1    1    0   1   0    1    1    91
kernel:  11 003 03  1    1    0   1   0    1    1    99
kernel:  12 003 03  1    1    0   1   0    1    1    A1
kernel:  13 003 03  1    1    0   1   0    1    1    A9
kernel:  14 000 00  1    0    0   0   0    0    0    00
kernel:  15 003 03  1    1    0   1   0    1    1    B1
kernel:  16 003 03  1    1    0   1   0    1    1    B9
kernel:  17 000 00  1    0    0   0   0    0    0    00
kernel:
kernel: IO APIC #3......
kernel: .... register #00: 03000000
kernel: .......    : physical APIC id: 03
kernel: .... register #01: 00178020
kernel: .......     : max redirection entries: 0017
kernel: .......     : PRQ implemented: 1
kernel: .......     : IO APIC version: 0020
kernel: .... register #02: 03000000
kernel: .......     : arbitration: 03
kernel: .... IRQ redirection table:
kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
kernel:  00 003 03  1    1    0   1   0    1    1    C1
kernel:  01 000 00  1    0    0   0   0    0    0    00
kernel:  02 000 00  1    0    0   0   0    0    0    00
kernel:  03 000 00  1    0    0   0   0    0    0    00
kernel:  04 003 03  1    1    0   1   0    1    1    C9
kernel:  05 000 00  1    0    0   0   0    0    0    00
kernel:  06 000 00  1    0    0   0   0    0    0    00
kernel:  07 000 00  1    0    0   0   0    0    0    00
kernel:  08 003 03  1    1    0   1   0    1    1    D1
kernel:  09 003 03  1    1    0   1   0    1    1    D9
kernel:  0a 000 00  1    0    0   0   0    0    0    00
kernel:  0b 000 00  1    0    0   0   0    0    0    00
kernel:  0c 000 00  1    0    0   0   0    0    0    00
kernel:  0d 000 00  1    0    0   0   0    0    0    00
kernel:  0e 000 00  1    0    0   0   0    0    0    00
kernel:  0f 000 00  1    0    0   0   0    0    0    00
kernel:  10 000 00  1    0    0   0   0    0    0    00
kernel:  11 000 00  1    0    0   0   0    0    0    00
kernel:  12 000 00  1    0    0   0   0    0    0    00
kernel:  13 000 00  1    0    0   0   0    0    0    00
kernel:  14 000 00  1    0    0   0   0    0    0    00
kernel:  15 000 00  1    0    0   0   0    0    0    00
kernel:  16 000 00  1    0    0   0   0    0    0    00
kernel:  17 000 00  1    0    0   0   0    0    0    00
kernel:
kernel: IO APIC #4......
kernel: .... register #00: 04000000
kernel: .......    : physical APIC id: 04
kernel: .... register #01: 00178020
kernel: .......     : max redirection entries: 0017
kernel: .......     : PRQ implemented: 1
kernel: .......     : IO APIC version: 0020
kernel: .... register #02: 04000000
kernel: .......     : arbitration: 04
kernel: .... IRQ redirection table:
kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
kernel:  00 003 03  1    1    0   1   0    1    1    E1
kernel:  01 003 03  1    1    0   1   0    1    1    E9
kernel:  02 000 00  1    0    0   0   0    0    0    00
kernel:  03 000 00  1    0    0   0   0    0    0    00
kernel:  04 000 00  1    0    0   0   0    0    0    00
kernel:  05 000 00  1    0    0   0   0    0    0    00
kernel:  06 003 03  1    1    0   1   0    1    1    32
kernel:  07 000 00  1    0    0   0   0    0    0    00
kernel:  08 000 00  1    0    0   0   0    0    0    00
kernel:  09 000 00  1    0    0   0   0    0    0    00
kernel:  0a 000 00  1    0    0   0   0    0    0    00
kernel:  0b 000 00  1    0    0   0   0    0    0    00
kernel:  0c 000 00  1    0    0   0   0    0    0    00
kernel:  0d 000 00  1    0    0   0   0    0    0    00
kernel:  0e 000 00  1    0    0   0   0    0    0    00
kernel:  0f 000 00  1    0    0   0   0    0    0    00
kernel:  10 000 00  1    0    0   0   0    0    0    00
kernel:  11 000 00  1    0    0   0   0    0    0    00
kernel:  12 000 00  1    0    0   0   0    0    0    00
kernel:  13 000 00  1    0    0   0   0    0    0    00
kernel:  14 000 00  1    0    0   0   0    0    0    00
kernel:  15 000 00  1    0    0   0   0    0    0    00
kernel:  16 000 00  1    0    0   0   0    0    0    00
kernel:  17 000 00  1    0    0   0   0    0    0    00
kernel: IRQ to pin mappings:
kernel: IRQ0 -> 0:2
kernel: IRQ1 -> 0:1
kernel: IRQ3 -> 0:3
kernel: IRQ4 -> 0:4
kernel: IRQ5 -> 0:5
kernel: IRQ6 -> 0:6
kernel: IRQ7 -> 0:7
kernel: IRQ8 -> 0:8
kernel: IRQ9 -> 0:9
kernel: IRQ12 -> 0:12
kernel: IRQ13 -> 0:13
kernel: IRQ14 -> 0:14
kernel: IRQ16 -> 0:16
kernel: IRQ17 -> 0:17
kernel: IRQ18 -> 0:18
kernel: IRQ19 -> 0:19
kernel: IRQ21 -> 0:21
kernel: IRQ22 -> 0:22
kernel: IRQ24 -> 1:0
kernel: IRQ28 -> 1:4
kernel: IRQ32 -> 1:8
kernel: IRQ33 -> 1:9
kernel: IRQ48 -> 2:0
kernel: IRQ49 -> 2:1
kernel: IRQ54 -> 2:6
kernel: .................................... done.
kernel: Using local APIC timer interrupts.
kernel: calibrating APIC timer ...
kernel: ..... CPU clock speed is 2395.8669 MHz.
kernel: ..... host bus clock speed is 99.8276 MHz.
kernel: cpu: 0, clocks: 998276, slice: 332758
kernel: CPU0<T0:998272,T1:665504,D:10,S:332758,C:998276>
kernel: cpu: 1, clocks: 998276, slice: 332758
kernel: CPU1<T0:998272,T1:332752,D:4,S:332758,C:998276>
kernel: checking TSC synchronization across CPUs: passed.
kernel: Waiting on wait_init_idle (map = 0x2)
kernel: All processors have done init_idle
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8b5, last bus=4
kernel: PCI: Using configuration type 1
kernel: PCI: Probing PCI hardware
kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
kernel: PCI: Discovered primary peer bus 10 [IRQ]
kernel: PCI: Discovered primary peer bus 11 [IRQ]
kernel: PCI: Discovered primary peer bus 12 [IRQ]
kernel: PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
kernel: PCI->APIC IRQ transform: (B0,I29,P0) -> 16
kernel: PCI->APIC IRQ transform: (B0,I29,P1) -> 19
kernel: PCI->APIC IRQ transform: (B0,I29,P2) -> 18
kernel: PCI->APIC IRQ transform: (B2,I1,P0) -> 48
kernel: PCI->APIC IRQ transform: (B2,I1,P1) -> 49
kernel: PCI->APIC IRQ transform: (B2,I3,P0) -> 54
kernel: PCI->APIC IRQ transform: (B3,I1,P0) -> 24
kernel: PCI->APIC IRQ transform: (B3,I2,P0) -> 32
kernel: PCI->APIC IRQ transform: (B3,I2,P1) -> 33
kernel: PCI->APIC IRQ transform: (B3,I3,P0) -> 28
kernel: PCI->APIC IRQ transform: (B4,I1,P0) -> 16
kernel: PCI->APIC IRQ transform: (B4,I2,P0) -> 17
kernel: PCI->APIC IRQ transform: (B4,I3,P0) -> 18
kernel: PCI->APIC IRQ transform: (B4,I4,P0) -> 21
kernel: PCI->APIC IRQ transform: (B4,I5,P0) -> 22
kernel: isapnp: Scanning for PnP cards...
kernel: isapnp: No Plug & Play device found
kernel: Linux NET4.0 for Linux 2.4
kernel: Based upon Swansea University Computer Society NET3.039
kernel: Initializing RT netlink socket
kernel: Starting kswapd
kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
kernel: ACPI: Core Subsystem version [20011018]
kernel: ACPI: Subsystem enabled
kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
kernel: parport0: irq 7 detected
kernel: Detected PS/2 Mouse Port.
kernel: pty: 256 Unix98 ptys configured
kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
kernel: lp0: using parport0 (polling).
kernel: Real Time Clock Driver v1.10e
kernel: i810_rng hardware driver 0.9.8 loaded
kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
kernel: ICH3: IDE controller on PCI bus 00 dev f9
kernel: PCI: Device 00:1f.1 not available because of resource collisions
kernel: PCI: No IRQ known for interrupt pin A of device 00:1f.1. Probably
buggy MP table.
kernel: ICH3: BIOS setup was incomplete.
kernel: ICH3: chipset revision 2
kernel: ICH3: not 100%% native mode: will probe irqs later
kernel:     ide0: BM-DMA at 0x2060-0x2067, BIOS settings: hda:pio, hdb:pio
kernel: keyboard: Timeout - AT keyboard not present?(ed)
kernel: keyboard: Timeout - AT keyboard not present?(f4)
kernel: Floppy drive(s): fd0 is 1.44M
kernel: FDC 0 is a post-1991 82077
kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:24:49:8E, IRQ 22.
kernel:   Board assembly 000000-000, Physical connectors present: RJ45
kernel:   Primary interface chip i82555 PHY #1.
kernel:   General self-test: passed.
kernel:   Serial sub-system self-test: passed.
kernel:   Internal registers self-test: passed.
kernel:   ROM checksum self-test: passed (0xb874c1d3).
kernel: SCSI subsystem driver Revision: 1.00
kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
kernel:         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
kernel:
kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
kernel:
kernel: Configuring GDT-PCI HA at 3/1 IRQ 24
kernel: scsi2 : GDT8543RZ
kernel:   Vendor: ICP       Model: Host Drive  #00   Rev:
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel:   Vendor: JMR ELEC  Model: FORTRA SERIES.    Rev: 1.21
kernel:   Type:   Processor                          ANSI SCSI revision: 02
kernel: Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
kernel: SCSI device sda: 286744185 512-byte hdwr sectors (146813 MB)
kernel: Partition check:
kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
kernel: Attached scsi generic sg1 at scsi2, channel 1, id 5, lun 0,  type 3
kernel: NET4: Linux TCP/IP 1.0 for NET4.0
kernel: IP Protocols: ICMP, UDP, TCP, IGMP
kernel: IP: routing cache hash table of 32768 buckets, 256Kbytes
kernel: TCP: Hash tables configured (established 262144 bind 65536)
kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kernel: VFS: Mounted root (ext2 filesystem) readonly.
kernel: Freeing unused kernel memory: 108k freed
kernel: Adding Swap: 2000084k swap-space (priority -1)


--
Tolga
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
