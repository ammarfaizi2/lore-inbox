Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUATOWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUATOWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:22:43 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:55449 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265563AbUATOWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:22:07 -0500
Date: Tue, 20 Jan 2004 15:22:05 +0100 (CET)
From: Pavel Marton <marton@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: irq 18: nobody cared!
Message-ID: <Pine.LNX.4.58.0401201519450.17355@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I tried to compile 2.6.1 kernel and I met serious troubles with IDE2
device - Western digital WD2000JD with Serial ATA connector. Problem is
(probably the same as in 2.4. kernel) irq 18 that is associated with ide2
device (in documentation file to kernel 2.6.1 "ide.txt" is standard irq
associated with ide2 irq=11).

The 2.6.1 kernel message is

Jan 19 22:50:36 marton kernel: irq 18: nobody cared!
Jan 19 22:50:36 marton kernel: Call Trace:
Jan 19 22:50:36 marton kernel:  [__report_bad_irq+50/140]
__report_bad_irq+0x32/0x8c
Jan 19 22:50:36 marton kernel:  [note_interrupt+80/120]
note_interrupt+0x50/0x78
Jan 19 22:50:36 marton kernel:  [do_IRQ+150/244] do_IRQ+0x96/0xf4
Jan 19 22:50:36 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:36 marton kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Jan 19 22:50:36 marton kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 19 22:50:36 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:36 marton kernel:  [default_idle+35/40]
default_idle+0x23/0x28
Jan 19 22:50:36 marton kernel:  [cpu_idle+37/52] cpu_idle+0x25/0x34
Jan 19 22:50:36 marton kernel:  [rest_init+25/28] _stext+0x19/0x1c
Jan 19 22:50:36 marton kernel:  [start_kernel+366/372]
start_kernel+0x16e/0x174
Jan 19 22:50:36 marton kernel:

in kernel 2.4 the message is
ide2: unexpected inteerrupt, status=0x90, count=5442



Problem possibly concerns IO APIC (see
syslog dump bellow). I tried to stop this messages by kernel parameters (as
were recomended in several mailing lists) in lilo.conf:

append="pci=noacpi" or append="acpi=off" or append="noirqdebug"

but no change appears.
I also used patch 2.6.1-bk2-libata1.patch.bz2  it didn't make any change.

below I attached my SYSLOG dump, and printout of files /PROC/INTERRUPTS,
/PROC/IOPORTS and output of routine LSPCI

		Thanks for any idea		Pavel

SYSLOG
Jan 19 22:50:32 marton kernel: klogd 1.4.1#10, log source = /proc/kmsg
started.
Jan 19 22:50:32 marton kernel: Inspecting /boot/System.map
Jan 19 22:50:33 marton kernel: Loaded 28470 symbols from /boot/System.map.
Jan 19 22:50:33 marton kernel: Symbols match kernel version 2.6.1.
Jan 19 22:50:33 marton kernel: No module symbols loaded - kernel modules
not enabled.
Jan 19 22:50:33 marton kernel: Linux version 2.6.1 (root@marton) (gcc
version 2.95.4 20011002 (Debian prerelease)) #1 Mon Jan 19 19:28:26 CET
2004
Jan 19 22:50:33 marton kernel: BIOS-provided physical RAM map:
Jan 19 22:50:33 marton kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Jan 19 22:50:33 marton kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Jan 19 22:50:33 marton kernel:  BIOS-e820: 00000000000e8000 -
0000000000100000 (reserved)
Jan 19 22:50:33 marton kernel:  BIOS-e820: 0000000000100000 -
000000003ff30000 (usable)
Jan 19 22:50:33 marton kernel:  BIOS-e820: 000000003ff30000 -
000000003ff40000 (ACPI data)
Jan 19 22:50:33 marton kernel:  BIOS-e820: 000000003ff40000 -
000000003fff0000 (ACPI NVS)
Jan 19 22:50:33 marton kernel:  BIOS-e820: 000000003fff0000 -
0000000040000000 (reserved)
Jan 19 22:50:33 marton kernel:  BIOS-e820: 00000000ffb80000 -
0000000100000000 (reserved)
Jan 19 22:50:33 marton kernel: 127MB HIGHMEM available.
Jan 19 22:50:33 marton kernel: 896MB LOWMEM available.
Jan 19 22:50:33 marton kernel: found SMP MP-table at 000ff780
Jan 19 22:50:33 marton kernel: hm, page 000ff000 reserved twice.
Jan 19 22:50:33 marton kernel: hm, page 00100000 reserved twice.
Jan 19 22:50:33 marton kernel: hm, page 000f1000 reserved twice.
Jan 19 22:50:33 marton kernel: hm, page 000f2000 reserved twice.
Jan 19 22:50:33 marton kernel: On node 0 totalpages: 261936
Jan 19 22:50:33 marton kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan 19 22:50:33 marton kernel:   Normal zone: 225280 pages, LIFO batch:16
Jan 19 22:50:33 marton kernel:   HighMem zone: 32560 pages, LIFO batch:7
Jan 19 22:50:33 marton kernel: DMI 2.3 present.
Jan 19 22:50:33 marton kernel: ACPI: RSDP (v000 ACPIAM
) @ 0x000f9e60
Jan 19 22:50:33 marton kernel: ACPI: RSDT (v001 A M I  OEMRSDT  0x09000302
MSFT 0x00000097) @ 0x3ff30000
Jan 19 22:50:33 marton kernel: ACPI: FADT (v002 A M I  OEMFACP  0x09000302
MSFT 0x00000097) @ 0x3ff30200
Jan 19 22:50:33 marton kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x09000302
MSFT 0x00000097) @ 0x3ff30390
Jan 19 22:50:33 marton kernel: ACPI: OEMB (v001 A M I  OEMBIOS  0x09000302
MSFT 0x00000097) @ 0x3ff40040
Jan 19 22:50:33 marton kernel: ACPI: DSDT (v001  P4CED P4CED091 0x00000091
INTL 0x02002026) @ 0x00000000
Jan 19 22:50:33 marton kernel: ACPI: Local APIC address 0xfee00000
Jan 19 22:50:33 marton kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00]
enabled)
Jan 19 22:50:33 marton kernel: Processor #0 15:2 APIC version 20
Jan 19 22:50:33 marton kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01]
enabled)
Jan 19 22:50:33 marton kernel: Processor #1 15:2 APIC version 20
Jan 19 22:50:33 marton kernel: NR_CPUS limit of 1 reached.  Cannot boot
CPU(apicid 0x1).
Jan 19 22:50:33 marton kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000]
global_irq_base[0x0])
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Assigned apic_id 2
Jan 19 22:50:33 marton kernel: IOAPIC[0]: apic_id 2, version 32, address
0xfec00000, IRQ 0-23
Jan 19 22:50:33 marton kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0]
global_irq[0x2] polarity[0x0] trigger[0x0])
Jan 19 22:50:33 marton kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9]
global_irq[0x9] polarity[0x1] trigger[0x3])
Jan 19 22:50:33 marton kernel: Enabling APIC mode:  Flat.  Using 1 I/O
APICs
Jan 19 22:50:33 marton kernel: Using ACPI (MADT) for SMP configuration
information
Jan 19 22:50:33 marton kernel: Building zonelist for node : 0
Jan 19 22:50:33 marton kernel: Kernel command line:
BOOT_IMAGE=Linux-2.6.1-min ro root=2101
Jan 19 22:50:33 marton kernel: Initializing CPU#0
Jan 19 22:50:33 marton kernel: PID hash table entries: 4096 (order 12:
32768 bytes)
Jan 19 22:50:33 marton kernel: Detected 2998.874 MHz processor.
Jan 19 22:50:33 marton kernel: Using tsc for high-res timesource
Jan 19 22:50:33 marton kernel: Console: colour VGA+ 80x25
Jan 19 22:50:33 marton kernel: Memory: 1032044k/1047744k available (2453k
kernel code, 14768k reserved, 1325k data, 236k init, 130240k highmem)
Jan 19 22:50:33 marton kernel: Checking if this processor honours the WP
bit even in supervisor mode... Ok.
Jan 19 22:50:33 marton kernel: Calibrating delay loop... 5931.00 BogoMIPS
Jan 19 22:50:33 marton kernel: Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)
Jan 19 22:50:33 marton kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Jan 19 22:50:33 marton kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Jan 19 22:50:33 marton kernel: CPU:     After generic identify, caps:
bfebfbff 00000000 00000000 00000000
Jan 19 22:50:33 marton kernel: CPU:     After vendor identify, caps:
bfebfbff 00000000 00000000 00000000
Jan 19 22:50:33 marton kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jan 19 22:50:33 marton kernel: CPU: L2 cache: 512K
Jan 19 22:50:33 marton kernel: CPU:     After all inits, caps: bfebfbff
00000000 00000000 00000080
Jan 19 22:50:33 marton kernel: CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping 09
Jan 19 22:50:33 marton kernel: Enabling fast FPU save and restore... done.
Jan 19 22:50:33 marton kernel: Enabling unmasked SIMD FPU exception
support... done.
Jan 19 22:50:33 marton kernel: Checking 'hlt' instruction... OK.
Jan 19 22:50:33 marton kernel: Checking for popad bug... OK.
Jan 19 22:50:33 marton kernel: POSIX conformance testing by UNIFIX
Jan 19 22:50:33 marton kernel: enabled ExtINT on CPU#0
Jan 19 22:50:33 marton kernel: ESR value before enabling vector: 00000000
Jan 19 22:50:33 marton kernel: ESR value after enabling vector: 00000000
Jan 19 22:50:33 marton kernel: ENABLING IO-APIC IRQs
Jan 19 22:50:33 marton kernel: init IO_APIC IRQs
Jan 19 22:50:33 marton kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17,
2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jan 19 22:50:33 marton kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jan 19 22:50:33 marton kernel: number of MP IRQ sources: 15.
Jan 19 22:50:33 marton kernel: number of IO-APIC #2 registers: 24.
Jan 19 22:50:33 marton kernel: testing the IO APIC.......................
Jan 19 22:50:33 marton kernel: IO APIC #2......
Jan 19 22:50:33 marton kernel: .... register #00: 02000000
Jan 19 22:50:33 marton kernel: .......    : physical APIC id: 02
Jan 19 22:50:33 marton kernel: .......    : Delivery Type: 0
Jan 19 22:50:33 marton kernel: .......    : LTS          : 0
Jan 19 22:50:33 marton kernel: .... register #01: 00178020
Jan 19 22:50:33 marton kernel: .......     : max redirection entries: 0017
Jan 19 22:50:33 marton kernel: .......     : PRQ implemented: 1
Jan 19 22:50:33 marton kernel: .......     : IO APIC version: 0020
Jan 19 22:50:33 marton kernel: .... IRQ redirection table:
Jan 19 22:50:33 marton kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest
Deli Vect:
Jan 19 22:50:33 marton kernel:  00 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  01 001 01  0    0    0   0   0    1    1
39
Jan 19 22:50:33 marton kernel:  02 001 01  0    0    0   0   0    1    1
31
Jan 19 22:50:33 marton kernel:  03 001 01  0    0    0   0   0    1    1
41
Jan 19 22:50:33 marton kernel:  04 001 01  0    0    0   0   0    1    1
49
Jan 19 22:50:33 marton kernel:  05 001 01  0    0    0   0   0    1    1
51
Jan 19 22:50:33 marton kernel:  06 001 01  0    0    0   0   0    1    1
59
Jan 19 22:50:33 marton kernel:  07 001 01  0    0    0   0   0    1    1
61
Jan 19 22:50:33 marton kernel:  08 001 01  0    0    0   0   0    1    1
69
Jan 19 22:50:33 marton kernel:  09 001 01  1    1    0   0   0    1    1
71
Jan 19 22:50:33 marton kernel:  0a 001 01  0    0    0   0   0    1    1
79
Jan 19 22:50:33 marton kernel:  0b 001 01  0    0    0   0   0    1    1
81
Jan 19 22:50:33 marton kernel:  0c 001 01  0    0    0   0   0    1    1
89
Jan 19 22:50:33 marton kernel:  0d 001 01  0    0    0   0   0    1    1
91
Jan 19 22:50:33 marton kernel:  0e 001 01  0    0    0   0   0    1    1
99
Jan 19 22:50:33 marton kernel:  0f 001 01  0    0    0   0   0    1    1
A1
Jan 19 22:50:33 marton kernel:  10 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  11 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  12 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  13 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  14 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  15 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  16 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel:  17 000 00  1    0    0   0   0    0    0
00
Jan 19 22:50:33 marton kernel: IRQ to pin mappings:
Jan 19 22:50:33 marton kernel: IRQ0 -> 0:2
Jan 19 22:50:33 marton kernel: IRQ1 -> 0:1
Jan 19 22:50:33 marton kernel: IRQ3 -> 0:3
Jan 19 22:50:33 marton kernel: IRQ4 -> 0:4
Jan 19 22:50:33 marton kernel: IRQ5 -> 0:5
Jan 19 22:50:33 marton kernel: IRQ6 -> 0:6
Jan 19 22:50:33 marton kernel: IRQ7 -> 0:7
Jan 19 22:50:33 marton kernel: IRQ8 -> 0:8
Jan 19 22:50:33 marton kernel: IRQ9 -> 0:9
Jan 19 22:50:33 marton kernel: IRQ10 -> 0:10
Jan 19 22:50:33 marton kernel: IRQ11 -> 0:11
Jan 19 22:50:33 marton kernel: IRQ12 -> 0:12
Jan 19 22:50:33 marton kernel: IRQ13 -> 0:13
Jan 19 22:50:33 marton kernel: IRQ14 -> 0:14
Jan 19 22:50:33 marton kernel: IRQ15 -> 0:15
Jan 19 22:50:33 marton kernel: .................................... done.
Jan 19 22:50:33 marton kernel: Using local APIC timer interrupts.
Jan 19 22:50:33 marton kernel: calibrating APIC timer ...
Jan 19 22:50:33 marton kernel: ..... CPU clock speed is 2998.0129 MHz.
Jan 19 22:50:33 marton kernel: ..... host bus clock speed is 199.0875 MHz.
Jan 19 22:50:33 marton kernel: NET: Registered protocol family 16
Jan 19 22:50:33 marton kernel: PCI: PCI BIOS revision 2.10 entry at
0xf0031, last bus=3
Jan 19 22:50:33 marton kernel: PCI: Using configuration type 1
Jan 19 22:50:33 marton kernel: mtrr: v2.0 (20020519)
Jan 19 22:50:33 marton kernel: ACPI: Subsystem revision 20031002
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-9 ->
0x71 -> IRQ 9 Mode:1 Active:0)
Jan 19 22:50:33 marton kernel: ACPI: Interpreter enabled
Jan 19 22:50:33 marton kernel: ACPI: Using IOAPIC for interrupt routing
Jan 19 22:50:33 marton kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jan 19 22:50:33 marton kernel: PCI: Probing PCI hardware (bus 00)
Jan 19 22:50:33 marton kernel: PCI: Ignoring BAR0-3 of IDE controller
0000:00:1f.1
Jan 19 22:50:33 marton kernel: Transparent bridge - 0000:00:1e.0
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P4._PRT]
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P2._PRT]
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5
6 7 *10 11 12 14 15)
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4
*5 6 7 10 11 12 14 15)
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4
*5 6 7 10 11 12 14 15)
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4
*5 6 7 10 11 12 14 15)
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4
*5 6 7 10 11 12 14 15)
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5
6 7 10 11 12 14 15)
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5
6 7 10 11 12 14 15)
Jan 19 22:50:33 marton kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5
6 7 10 *11 12 14 15)
Jan 19 22:50:33 marton kernel: SCSI subsystem initialized
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-18 ->
0xa9 -> IRQ 18 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:00:1f[A] -> 2-18 -> IRQ 18
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-17 ->
0xb1 -> IRQ 17 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:00:1f[B] -> 2-17 -> IRQ 17
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-16 ->
0xb9 -> IRQ 16 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:00:1d[A] -> 2-16 -> IRQ 16
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-19 ->
0xc1 -> IRQ 19 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:00:1d[B] -> 2-19 -> IRQ 19
Jan 19 22:50:33 marton kernel: Pin 2-18 already programmed
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-23 ->
0xc9 -> IRQ 23 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:00:1d[D] -> 2-23 -> IRQ 23
Jan 19 22:50:33 marton kernel: Pin 2-16 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-17 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-16 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-17 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-18 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-19 already programmed
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-20 ->
0xd1 -> IRQ 20 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:03:08[A] -> 2-20 -> IRQ 20
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-21 ->
0xd9 -> IRQ 21 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:03:09[A] -> 2-21 -> IRQ 21
Jan 19 22:50:33 marton kernel: IOAPIC[0]: Set PCI routing entry (2-22 ->
0xe1 -> IRQ 22 Mode:1 Active:1)
Jan 19 22:50:33 marton kernel: 00:03:09[B] -> 2-22 -> IRQ 22
Jan 19 22:50:33 marton kernel: Pin 2-23 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-20 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-22 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-23 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-20 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-21 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-23 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-20 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-21 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-22 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-20 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-21 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-22 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-23 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-21 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-22 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-23 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-20 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-20 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-23 already programmed
Jan 19 22:50:33 marton kernel: Pin 2-18 already programmed
Jan 19 22:50:33 marton kernel: PCI: Using ACPI for IRQ routing
Jan 19 22:50:33 marton kernel: PCI: if you experience problems, try using
option 'pci=noacpi' or even 'acpi=off'
Jan 19 22:50:33 marton kernel: IA-32 Microcode Update Driver: v1.13
<tigran@veritas.com>
Jan 19 22:50:33 marton kernel: highmem bounce pool size: 64 pages
Jan 19 22:50:33 marton kernel: VFS: Disk quotas dquot_6.5.1
Jan 19 22:50:33 marton kernel: NTFS driver 2.1.5 [Flags: R/O].
Jan 19 22:50:33 marton kernel: ACPI: Processor [CPU1] (supports C1)
Jan 19 22:50:33 marton kernel: pty: 256 Unix98 ptys configured
Jan 19 22:50:33 marton kernel: Real Time Clock Driver v1.12
Jan 19 22:50:33 marton kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP]
Jan 19 22:50:33 marton kernel: parport0: irq 7 detected
Jan 19 22:50:33 marton kernel: parport0: cpp_daisy: aa5500ff(38)
Jan 19 22:50:33 marton kernel: parport0: assign_addrs: aa5500ff(38)
Jan 19 22:50:33 marton kernel: parport0: cpp_daisy: aa5500ff(38)
Jan 19 22:50:33 marton kernel: parport0: assign_addrs: aa5500ff(38)
Jan 19 22:50:33 marton kernel: Using anticipatory io scheduler
Jan 19 22:50:33 marton kernel: Floppy drive(s): fd0 is 1.44M
Jan 19 22:50:33 marton kernel: FDC 0 is a post-1991 82077
Jan 19 22:50:33 marton kernel: RAMDISK driver initialized: 16 RAM disks of
4096K size 1024 blocksize
Jan 19 22:50:33 marton kernel: loop: loaded (max 8 devices)
Jan 19 22:50:33 marton kernel: xd: Out of memory.
Jan 19 22:50:33 marton kernel: Compaq CISS Driver (v 2.5.0)
Jan 19 22:50:33 marton kernel: pcnet32.c:v1.27b 01.10.2002
tsbogend@alpha.franken.de
Jan 19 22:50:33 marton kernel: PPP generic driver version 2.4.2
Jan 19 22:50:33 marton kernel: HDLC support module revision 1.16
Jan 19 22:50:33 marton kernel: Cronyx Ltd, Synchronous PPP and CISCO HDLC
(c) 1994
Jan 19 22:50:33 marton kernel: Linux port (c) 1998 Building Number Three
Ltd & Jan "Yenya" Kasprzak.
Jan 19 22:50:33 marton kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Jan 19 22:50:33 marton kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Jan 19 22:50:33 marton kernel: ICH5: IDE controller at PCI slot
0000:00:1f.1
Jan 19 22:50:33 marton kernel: PCI: Enabling device 0000:00:1f.1 (0005 ->
0007)
Jan 19 22:50:33 marton kernel: ICH5: chipset revision 2
Jan 19 22:50:33 marton kernel: ICH5: not 100%% native mode: will probe
irqs later
Jan 19 22:50:33 marton kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS
settings: hda:DMA, hdb:pio
Jan 19 22:50:33 marton kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS
settings: hdc:pio, hdd:pio
Jan 19 22:50:33 marton kernel: hda: TEAC DW-548D, ATAPI CD/DVD-ROM drive
Jan 19 22:50:33 marton kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 19 22:50:33 marton kernel: ICH5-SATA: IDE controller at PCI slot
0000:00:1f.2
Jan 19 22:50:33 marton kernel: ICH5-SATA: chipset revision 2
Jan 19 22:50:33 marton kernel: ICH5-SATA: 100%% native mode on irq 18
Jan 19 22:50:33 marton kernel:     ide2: BM-DMA at 0xef90-0xef97, BIOS
settings: hde:DMA, hdf:pio
Jan 19 22:50:33 marton kernel:     ide3: BM-DMA at 0xef98-0xef9f, BIOS
settings: hdg:pio, hdh:pio
Jan 19 22:50:33 marton kernel: hde: WDC WD2000JD-00FYB0, ATA DISK drive
Jan 19 22:50:33 marton kernel: ide2 at 0xefe0-0xefe7,0xefae on irq 18
Jan 19 22:50:33 marton kernel: hde: max request size: 1024KiB
Jan 19 22:50:33 marton kernel: hde: 390721968 sectors (200049 MB)
w/8192KiB Cache, CHS=24321/255/63
Jan 19 22:50:33 marton kernel:  hde: hde1 hde2 < hde5 >
Jan 19 22:50:33 marton kernel: hda: ATAPI 48X DVD-ROM CD-R/RW drive,
2048kB Cache
Jan 19 22:50:33 marton kernel: Uniform CD-ROM driver Revision: 3.12
Jan 19 22:50:33 marton kernel: ide-floppy driver 0.99.newide
Jan 19 22:50:33 marton kernel: scsi: <fdomain> Detection failed (no card)
Jan 19 22:50:33 marton kernel: sym53c416.c: Version 1.0.0-ac
Jan 19 22:50:33 marton kernel: irq 18: nobody cared!
Jan 19 22:50:33 marton kernel: Call Trace:
Jan 19 22:50:33 marton kernel:  [__report_bad_irq+50/140]
__report_bad_irq+0x32/0x8c
Jan 19 22:50:33 marton kernel:  [note_interrupt+80/120]
note_interrupt+0x50/0x78
Jan 19 22:50:33 marton kernel:  [do_IRQ+150/244] do_IRQ+0x96/0xf4
Jan 19 22:50:33 marton kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Jan 19 22:50:33 marton kernel:  [isp2x00_detect+1010/1032]
isp2x00_detect+0x3f2/0x408
Jan 19 22:50:33 marton kernel:  [init_this_scsi_driver+67/208]
init_this_scsi_driver+0x43/0xd0
Jan 19 22:50:33 marton kernel:  [do_initcalls+56/136]
do_initcalls+0x38/0x88
Jan 19 22:50:33 marton kernel:  [init+0/236] init+0x0/0xec
Jan 19 22:50:33 marton kernel:  [do_basic_setup+25/36]
do_basic_setup+0x19/0x24
Jan 19 22:50:33 marton kernel:  [init+31/236] init+0x1f/0xec
Jan 19 22:50:33 marton kernel:  [init+0/236] init+0x0/0xec
Jan 19 22:50:33 marton kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Jan 19 22:50:33 marton kernel:
Jan 19 22:50:33 marton kernel: handlers:
Jan 19 22:50:33 marton kernel: [ide_intr+0/276] (ide_intr+0x0/0x114)
Jan 19 22:50:33 marton kernel: Disabling IRQ #18
Jan 19 22:50:33 marton kernel: Failed initialization of WD-7000 SCSI card!
Jan 19 22:50:33 marton kernel: DC390: 0 adapters found
Jan 19 22:50:33 marton kernel: aec671x_detect:
Jan 19 22:50:33 marton kernel: GDT: Storage RAID Controller Driver.
Version: 2.08
Jan 19 22:50:33 marton kernel: GDT: Found 0 PCI Storage RAID Controllers
Jan 19 22:50:33 marton kernel: 3ware Storage Controller device driver for
Linux v1.02.00.037.
Jan 19 22:50:33 marton kernel: 3w-xxxx: No cards found.
Jan 19 22:50:33 marton kernel: ppa: Version 2.07 (for Linux 2.4.x)
Jan 19 22:50:33 marton kernel: WARNING - no ppa compatible devices found.
Jan 19 22:50:33 marton kernel:   As of 31/Aug/1998 Iomega started shipping
parallel
Jan 19 22:50:33 marton kernel:   port ZIP drives with a different
interface which is
Jan 19 22:50:33 marton kernel:   supported by the imm (ZIP Plus) driver.
If the
Jan 19 22:50:33 marton kernel:   cable is marked with "AutoDetect", this
is what has
Jan 19 22:50:33 marton kernel:   happened.
Jan 19 22:50:33 marton kernel: imm: Version 2.05 (for Linux 2.4.0)
Jan 19 22:50:33 marton kernel: osst :I: Tape driver with OnStream support
version 0.99.1
Jan 19 22:50:33 marton kernel: osst :I: $Id: osst.c,v 1.70 2003/12/23
14:22:12 wriede Exp $
Jan 19 22:50:33 marton kernel: slram: not enough parameters.
Jan 19 22:50:33 marton kernel: pd: pd version 1.05, major 45, cluster 64,
nice 0
Jan 19 22:50:33 marton kernel: request_module: failed /sbin/modprobe --
paride_protocol. error = -16
Jan 19 22:50:33 marton kernel: pda: Autoprobe failed
Jan 19 22:50:33 marton kernel: pd: no valid drive found
Jan 19 22:50:33 marton kernel: pcd: pcd version 1.07, major 46, nice 0
Jan 19 22:50:33 marton kernel: pcd0: Autoprobe failed
Jan 19 22:50:33 marton kernel: pcd: No CD-ROM drive found
Jan 19 22:50:33 marton kernel: pf: pf version 1.04, major 47, cluster 64,
nice 0
Jan 19 22:50:33 marton kernel: pf: No ATAPI disk detected
Jan 19 22:50:33 marton kernel: pg: pg version 1.02, major 97
Jan 19 22:50:33 marton kernel: pga: Autoprobe failed
Jan 19 22:50:33 marton kernel: pg: No ATAPI device detected
Jan 19 22:50:33 marton kernel: mice: PS/2 mouse device common for all mice
Jan 19 22:50:33 marton kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 19 22:50:33 marton kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 19 22:50:33 marton kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0
Jan 19 22:50:33 marton kernel: I2O Core - (C) Copyright 1999 Red Hat
Software
Jan 19 22:50:33 marton kernel: I2O: Event thread created as pid 12
Jan 19 22:50:33 marton kernel: i2o: Checking for PCI I2O controllers...
Jan 19 22:50:33 marton kernel: I2O configuration manager v 0.04.
Jan 19 22:50:33 marton kernel:   (C) Copyright 1999 Red Hat Software
Jan 19 22:50:33 marton kernel: I2O Block Storage OSM v0.9
Jan 19 22:50:33 marton kernel:    (c) Copyright 1999-2001 Red Hat
Software.
Jan 19 22:50:33 marton kernel: i2o_block: Checking for Boot device...
Jan 19 22:50:33 marton kernel: i2o_block: Checking for I2O Block
devices...
Jan 19 22:50:33 marton kernel: i2o_scsi.c: Version 0.1.2
Jan 19 22:50:33 marton kernel:   chain_pool: 0 bytes @ c1b32c00
Jan 19 22:50:33 marton kernel:   (512 byte buffers X 4 can_queue X 0 i2o
controllers)
Jan 19 22:50:33 marton kernel: device-mapper: 4.0.0-ioctl (2003-06-04)
initialised: dm@uk.sistina.com
Jan 19 22:50:33 marton kernel: NET: Registered protocol family 2
Jan 19 22:50:33 marton kernel: IP: routing cache hash table of 8192
buckets, 64Kbytes
Jan 19 22:50:33 marton kernel: TCP: Hash tables configured (established
262144 bind 65536)
Jan 19 22:50:33 marton kernel: NET: Registered protocol family 1
Jan 19 22:50:33 marton kernel: NET: Registered protocol family 17
Jan 19 22:50:33 marton kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Jan 19 22:50:33 marton kernel: Freeing unused kernel memory: 236k freed
Jan 19 22:50:33 marton kernel: Adding 1405112k swap on /dev/hde5.
Priority:-1 extents:1
Jan 19 22:50:33 marton kernel: irq 18: nobody cared!
Jan 19 22:50:33 marton kernel: Call Trace:
Jan 19 22:50:33 marton kernel:  [__report_bad_irq+50/140]
__report_bad_irq+0x32/0x8c
Jan 19 22:50:33 marton kernel:  [note_interrupt+80/120]
note_interrupt+0x50/0x78
Jan 19 22:50:33 marton kernel:  [do_IRQ+150/244] do_IRQ+0x96/0xf4
Jan 19 22:50:33 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:33 marton kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Jan 19 22:50:33 marton kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 19 22:50:33 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:33 marton kernel:  [default_idle+35/40]
default_idle+0x23/0x28
Jan 19 22:50:33 marton kernel:  [cpu_idle+37/52] cpu_idle+0x25/0x34
Jan 19 22:50:33 marton kernel:  [rest_init+25/28] _stext+0x19/0x1c
Jan 19 22:50:33 marton kernel:  [start_kernel+366/372]
start_kernel+0x16e/0x174
Jan 19 22:50:33 marton kernel:
Jan 19 22:50:33 marton kernel: handlers:
Jan 19 22:50:33 marton kernel: [ide_intr+0/276] (ide_intr+0x0/0x114)
Jan 19 22:50:33 marton kernel: Disabling IRQ #18
Jan 19 22:50:33 marton kernel: request_module: failed /sbin/modprobe --
char-major-4-64. error = 256
Jan 19 22:50:33 marton named[193]: starting BIND 9.2.1
Jan 19 22:50:33 marton named[193]: using 1 CPU
Jan 19 22:50:33 marton lwresd[200]: starting BIND 9.2.1
Jan 19 22:50:33 marton lwresd[200]: using 1 CPU
Jan 19 22:50:33 marton named[196]: loading configuration from
'/etc/bind/named.conf'
Jan 19 22:50:33 marton rpc.statd[203]: Version 1.0 Starting
Jan 19 22:50:33 marton lwresd[204]: loading configuration from
'/etc/bind/lwresd.conf'
Jan 19 22:50:33 marton lwresd[204]: none:0: open: /etc/bind/lwresd.conf:
file not found
Jan 19 22:50:33 marton lwresd[204]: loading configuration from
'/etc/resolv.conf'
Jan 19 22:50:33 marton lwresd[204]: loading configuration: syntax error
Jan 19 22:50:33 marton lwresd[204]: exiting (due to fatal error)
Jan 19 22:50:33 marton named[196]: no IPv6 interfaces found
Jan 19 22:50:33 marton named[196]: listening on IPv4 interface lo,
127.0.0.1#53
Jan 19 22:50:33 marton kernel: process `named' is using obsolete
setsockopt SO_BSDCOMPAT
Jan 19 22:50:33 marton named[196]: command channel listening on
127.0.0.1#953
Jan 19 22:50:33 marton named[196]: zone 0.in-addr.arpa/IN: loaded serial 1
Jan 19 22:50:33 marton named[196]: zone 127.in-addr.arpa/IN: loaded serial
1
Jan 19 22:50:33 marton named[196]: zone 255.in-addr.arpa/IN: loaded serial
1
Jan 19 22:50:33 marton named[196]: zone localhost/IN: loaded serial 1
Jan 19 22:50:33 marton named[196]: running
Jan 19 22:50:34 marton inndstart: Reading config from /etc/news/inn.conf
Jan 19 22:50:34 marton inndstart: Hostname does not resolve or 'domain' in
inn.conf is missing
Jan 19 22:50:34 marton lpd[253]: restarted
Jan 19 22:50:35 marton postgres[295]: [1] DEBUG:  database system was shut
down at 2004-01-19 22:49:50 CET
Jan 19 22:50:35 marton postgres[295]: [2] DEBUG:  checkpoint record is at
0/116274
Jan 19 22:50:35 marton postgres[295]: [3] DEBUG:  redo record is at
0/116274; undo record is at 0/0; shutdown TRUE
Jan 19 22:50:35 marton postgres[295]: [4] DEBUG:  next transaction id:
107; next oid: 16558
Jan 19 22:50:35 marton postgres[295]: [5] DEBUG:  database system is ready
Jan 19 22:50:36 marton kernel: irq 18: nobody cared!
Jan 19 22:50:36 marton kernel: Call Trace:
Jan 19 22:50:36 marton kernel:  [__report_bad_irq+50/140]
__report_bad_irq+0x32/0x8c
Jan 19 22:50:36 marton kernel:  [note_interrupt+80/120]
note_interrupt+0x50/0x78
Jan 19 22:50:36 marton kernel:  [do_IRQ+150/244] do_IRQ+0x96/0xf4
Jan 19 22:50:36 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:36 marton kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Jan 19 22:50:36 marton kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 19 22:50:36 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:36 marton kernel:  [default_idle+35/40]
default_idle+0x23/0x28
Jan 19 22:50:36 marton kernel:  [cpu_idle+37/52] cpu_idle+0x25/0x34
Jan 19 22:50:36 marton kernel:  [rest_init+25/28] _stext+0x19/0x1c
Jan 19 22:50:36 marton kernel:  [start_kernel+366/372]
start_kernel+0x16e/0x174
Jan 19 22:50:36 marton kernel:
Jan 19 22:50:36 marton kernel: handlers:
Jan 19 22:50:36 marton kernel: [ide_intr+0/276] (ide_intr+0x0/0x114)
Jan 19 22:50:36 marton kernel: Disabling IRQ #18
Jan 19 22:50:41 marton xfs: ignoring font path element
/usr/lib/X11/fonts/cyrillic/ (unreadable)
Jan 19 22:50:41 marton /usr/sbin/cron[320]: (CRON) INFO (pidfile fd = 3)
Jan 19 22:50:41 marton /usr/sbin/cron[321]: (CRON) STARTUP (fork ok)
Jan 19 22:50:41 marton /usr/sbin/cron[321]: (CRON) INFO (Running @reboot
jobs)
Jan 19 22:50:41 marton xfs: ignoring font path element
/usr/lib/X11/fonts/CID (unreadable)
Jan 19 22:50:42 marton kernel: irq 18: nobody cared!
Jan 19 22:50:42 marton kernel: Call Trace:
Jan 19 22:50:42 marton kernel:  [__report_bad_irq+50/140]
__report_bad_irq+0x32/0x8c
Jan 19 22:50:42 marton kernel:  [note_interrupt+80/120]
note_interrupt+0x50/0x78
Jan 19 22:50:42 marton kernel:  [do_IRQ+150/244] do_IRQ+0x96/0xf4
Jan 19 22:50:42 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:42 marton kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Jan 19 22:50:42 marton kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 19 22:50:42 marton kernel:  [rest_init+0/28] _stext+0x0/0x1c
Jan 19 22:50:42 marton kernel:  [default_idle+35/40]
default_idle+0x23/0x28
Jan 19 22:50:42 marton kernel:  [cpu_idle+37/52] cpu_idle+0x25/0x34
Jan 19 22:50:42 marton kernel:  [rest_init+25/28] _stext+0x19/0x1c
Jan 19 22:50:42 marton kernel:  [start_kernel+366/372]
start_kernel+0x16e/0x174
Jan 19 22:50:42 marton kernel:


/proc/interrupts
           CPU0
  0:     311215    IO-APIC-edge  timer
  1:        848    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          3    IO-APIC-edge  rtc
 14:         10    IO-APIC-edge  ide0
 18:    7901389   IO-APIC-level  ide2
NMI:          0
LOC:     311133
ERR:          0
MIS:        819

/proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0320-0323 : wd7000
0350-0353 : wd7000
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0400-041f : 0000:00:1f.3
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
  b000-b0ff : 0000:01:00.0
c000-cfff : PCI Bus #02
  cf80-cf9f : 0000:02:01.0
dc00-dc7f : 0000:03:03.0
e800-e8ff : 0000:00:1f.5
ee80-eebf : 0000:00:1f.5
ef00-ef1f : 0000:00:1d.0
ef20-ef3f : 0000:00:1d.1
ef40-ef5f : 0000:00:1d.2
ef90-ef9f : 0000:00:1f.2
  ef90-ef97 : ide2
  ef98-ef9f : ide3
efa0-efa7 : 0000:00:1f.2
efa8-efab : 0000:00:1f.2
efac-efaf : 0000:00:1f.2
  efae-efae : ide2
efe0-efe7 : 0000:00:1f.2
  efe0-efe7 : ide2
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1


printout from lspci

00:00.0 Host bridge: Intel Corp.: Unknown device 2578 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
00: 86 80 78 25 06 01 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 f6 80
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp.: Unknown device 2579 (rev 02) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fe800000-fe8fffff
	Prefetchable memory behind bridge: 9ff00000-dfefffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
00: 86 80 79 25 07 01 a0 00 02 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 b0 b0 a0 22
20: 80 fe 80 fe f0 9f e0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00

00:03.0 PCI bridge: Intel Corp.: Unknown device 257b (rev 02) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe900000-fe9fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: 86 80 7b 25 07 01 a0 00 02 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 c0 c0 a0 22
20: 90 fe 90 fe f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ef00 [size=32]
00: 86 80 d2 24 05 00 80 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at ef20 [size=32]
00: 86 80 d4 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at ef40 [size=32]
00: 86 80 d7 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 03 00 00

00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02) (prog-if
20)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]
00: 86 80 dd 24 06 01 90 02 02 20 03 0c 00 00 00 00
10: 00 fc bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev c2)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: 86 80 4e 24 07 01 80 00 c2 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 40 d0 d0 80 22
20: a0 fe a0 fe f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 d0 24 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) (prog-if
8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 db 24 07 00 88 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 fc 00 00 00 00 00 40 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02) (prog-if
8f [Master SecP SecO PriP PriO])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at efe0 [size=8]
	Region 1: I/O ports at efac [size=4]
	Region 2: I/O ports at efa0 [size=8]
	Region 3: I/O ports at efa8 [size=4]
	Region 4: I/O ports at ef90 [size=16]
00: 86 80 d1 24 05 00 a8 02 02 8f 01 01 00 00 00 00
10: e1 ef 00 00 ad ef 00 00 a1 ef 00 00 a9 ef 00 00
20: 91 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0400 [size=32]
00: 86 80 d3 24 01 00 80 02 02 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 04 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24d5 (rev
02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ee80 [size=64]
	Region 2: Memory at febff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at febff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 d5 24 07 00 90 02 02 00 01 04 00 00 00 00
10: 01 e8 00 00 81 ee 00 00 00 f8 bf fe 00 f4 bf fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 f3 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
4151 (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device c004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at b000 [size=256]
	Region 2: Memory at fe8f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fe8c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=255 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 51 41 07 01 b0 02 00 00 00 03 04 40 80 00
10: 08 00 00 c0 01 b0 00 00 00 00 8f fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 04 c0
30: 00 00 8c fe 58 00 00 00 00 00 00 00 0a 01 08 00

01:00.1 Display controller: ATI Technologies Inc: Unknown device 4171
	Subsystem: Asustek Computer, Inc.: Unknown device c005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 04
	Region 0: Memory at b0000000 (32-bit, prefetchable) [size=256M]
	Region 1: Memory at fe8e0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 71 41 07 00 b0 02 00 00 80 03 04 40 00 00
10: 08 00 00 b0 00 00 8e fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 05 c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00

02:01.0 Ethernet controller: Intel Corp.: Unknown device 1019
	Subsystem: Asustek Computer, Inc.: Unknown device 80f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63750ns min), cache line size 04
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fe9e0000 (32-bit, non-prefetchable)
[size=128K]
	Region 2: I/O ports at cf80 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 19 10 07 00 38 02 00 00 00 02 04 00 00 00
10: 00 00 9e fe 00 00 00 00 81 cf 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 f7 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 ff 00

03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. OHCI Compliant IEEE
1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at dc00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 44 30 17 01 10 02 46 10 00 0c 04 40 00 00
10: 00 f8 af fe 01 dc 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 8a 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 20
