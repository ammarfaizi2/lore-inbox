Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUJCNPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUJCNPE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUJCNPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 09:15:04 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:36777 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S267918AbUJCNNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 09:13:42 -0400
Date: Sun, 3 Oct 2004 15:13:38 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: EIP in d_splice_alias with 2.6.8.1 #1 SMP
Message-ID: <20041003131338.GT24377@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, our squid proxy server wasn't processing ICP requests anymore.

After checking the box I found squid running and the network
interfaces to be up - I was able to login remotely using ssh.
Nevertheless squid wasn't working as usual, e.g. I couldn't connect to
it.

dmesg showed an EIP (see below). After a reboot, normal operation
were restore immediately:

Linux spiderboy 2.6.8.1 #1 SMP Fri Sep 24 18:18:57 CEST 2004 i686 GNU/Linux

The EIP:

Oct  3 06:30:02 spiderboy squid[894]: CACHEMGR: <unknown>@127.0.0.1 requesting 'info' 
Oct  3 06:30:02 spiderboy squid[894]: CACHEMGR: <unknown>@127.0.0.1 requesting 'diskd' 
Oct  3 06:30:02 spiderboy squid[894]: CACHEMGR: <unknown>@127.0.0.1 requesting 'store_io' 
Oct  3 06:30:54 spiderboy kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000040
Oct  3 06:30:54 spiderboy kernel:  printing eip:
Oct  3 06:30:54 spiderboy kernel: c015f684
Oct  3 06:30:54 spiderboy kernel: *pde = 00000000
Oct  3 06:30:54 spiderboy kernel: Oops: 0000 [#1]
Oct  3 06:30:54 spiderboy kernel: SMP 
Oct  3 06:30:54 spiderboy kernel: Modules linked in: psmouse ipt_state iptable_filter ip_tables ip_conntrack_ftp ip_conntrack tg3 rtc
Oct  3 06:30:54 spiderboy kernel: CPU:    0
Oct  3 06:30:54 spiderboy kernel: EIP:    0060:[d_splice_alias+28/205]    Not tainted
Oct  3 06:30:54 spiderboy kernel: EFLAGS: 00010202   (2.6.8.1) 
Oct  3 06:30:54 spiderboy kernel: EIP is at d_splice_alias+0x1c/0xcd
Oct  3 06:30:54 spiderboy kernel: eax: 00000020   ebx: 00000020   ecx: d9ac3d20   edx: da14ecb0
Oct  3 06:30:54 spiderboy kernel: esi: da14ecb0   edi: 00000020   ebp: 00000000   esp: d5696e44
Oct  3 06:30:54 spiderboy kernel: ds: 007b   es: 007b   ss: 0068
Oct  3 06:30:54 spiderboy kernel: Process find (pid: 10743, threadinfo=d5696000 task=efffc1b0)
Oct  3 06:30:54 spiderboy kernel: Stack: c03506e0 da14ecb0 00000020 efd79820 c01f76e5 00000000 00000000 00000000 
Oct  3 06:30:54 spiderboy kernel:        00000000 c0350a80 fffffff4 efd7988c c0155f33 da14ecb0 d5696f1c d5696ed4 
Oct  3 06:30:54 spiderboy kernel:        00000000 d5696f1c d5696ecc d5696ed4 c0156175 f7fc3a00 d5696ed4 00000000 
Oct  3 06:30:54 spiderboy kernel: Call Trace:
Oct  3 06:30:54 spiderboy kernel:  [linvfs_lookup+115/141] linvfs_lookup+0x73/0x8d
Oct  3 06:30:54 spiderboy kernel:  [real_lookup+186/219] real_lookup+0xba/0xdb
Oct  3 06:30:54 spiderboy kernel:  [do_lookup+126/137] do_lookup+0x7e/0x89
Oct  3 06:30:54 spiderboy kernel:  [link_path_walk+1683/3361] link_path_walk+0x693/0xd21
Oct  3 06:30:54 spiderboy kernel:  [copy_to_user+50/69] copy_to_user+0x32/0x45
Oct  3 06:30:54 spiderboy kernel:  [path_lookup+145/334] path_lookup+0x91/0x14e
Oct  3 06:30:54 spiderboy kernel:  [__user_walk+68/84] __user_walk+0x44/0x54
Oct  3 06:30:54 spiderboy kernel:  [vfs_lstat+26/75] vfs_lstat+0x1a/0x4b
Oct  3 06:30:54 spiderboy kernel:  [sys_lstat64+18/43] sys_lstat64+0x12/0x2b
Oct  3 06:30:54 spiderboy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  3 06:30:54 spiderboy kernel: Code: 0f b7 40 20 25 00 f0 00 00 3d 00 40 00 00 74 25 89 da 89 f0 

lspci -v output:

0000:00:00.0 Host bridge: ServerWorks CMIC-WS Host Bridge (GC-LE chipset) (rev 13)
	Flags: fast devsel

0000:00:00.1 Host bridge: ServerWorks CMIC-WS Host Bridge (GC-LE chipset)
	Flags: fast devsel

0000:00:00.2 Host bridge: ServerWorks CMIC-LE
	Flags: fast devsel

0000:00:04.0 ff00: Dell Embedded Remote Access or ERA/O
	Subsystem: Dell Embedded Remote Access or ERA/O
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at feb80000 (32-bit, prefetchable) [size=4K]
	I/O ports at ecf8 [size=8]
	I/O ports at ece8 [size=8]
	Expansion ROM at fe000000 [disabled] [size=64K]
	Capabilities: [48] Power Management version 2

0000:00:04.1 ff00: Dell Remote Access Card III
	Subsystem: Dell Remote Access Card III
	Flags: medium devsel, IRQ 23
	Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ec80 [size=64]
	Memory at feb00000 (32-bit, prefetchable) [size=512K]
	Capabilities: [48] Power Management version 2

0000:00:04.2 0c07: Dell Embedded Remote Access: BMC/SMIC device
	Subsystem: Dell Embedded Remote Access: BMC/SMIC device
	Flags: medium devsel, IRQ 27
	I/O ports at ecf4 [size=4]
	Capabilities: [48] Power Management version 2

0000:00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Dell: Unknown device 0121
	Flags: bus master, VGA palette snoop, stepping, medium devsel, latency 32
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at e800 [size=256]
	Memory at fe100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [5c] Power Management version 2

0000:00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
	Subsystem: ServerWorks CSB5 South Bridge
	Flags: bus master, medium devsel, latency 32

0000:00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 82 [Master PriP])
	Subsystem: ServerWorks CSB5 IDE Controller
	Flags: bus master, medium devsel, latency 0
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 08b0 [size=16]

0000:00:0f.3 ISA bridge: ServerWorks CSB5 LPC bridge
	Subsystem: ServerWorks: Unknown device 0230
	Flags: bus master, medium devsel, latency 0

0000:00:10.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 03)
	Flags: 66MHz, medium devsel
	Capabilities: [60] 
0000:00:10.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 03)
	Flags: 66MHz, medium devsel
	Capabilities: [60] 
0000:00:11.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 03)
	Flags: 66MHz, medium devsel
	Capabilities: [60] 
0000:00:11.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 03)
	Flags: 66MHz, medium devsel
	Capabilities: [60] 
0000:03:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
	Subsystem: Dell Broadcom BCM5701 1000Base-T
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 28
	Memory at fcf10000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

0000:03:08.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
	Subsystem: Dell Broadcom BCM5701 1000Base-T
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 29
	Memory at fcf00000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

0000:04:08.0 PCI bridge: Intel Corp. 80303 I/O Processor PCI-to-PCI Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, slow devsel, latency 32
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fcc00000-fcdfffff
	Capabilities: [68] Power Management version 2

0000:05:06.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
	Subsystem: Dell: Unknown device 0121
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 30
	BIST result: 00
	I/O ports at cc00 [disabled] [size=256]
	Memory at fccff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fcd00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

0000:05:06.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
	Subsystem: Dell: Unknown device 0121
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 31
	BIST result: 00
	I/O ports at c800 [disabled] [size=256]
	Memory at fccfe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fcd00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2


dmesg output after reboot:

root@spiderboy) (gcc version 3.3.4 (Debian 1:3.3.4-7)) #1 SMP Fri Sep 24 18:18:57 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fffec00 (ACPI data)
 BIOS-e820: 000000007fffec00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294896 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                      ) @ 0x000fdc60
ACPI: RSDT (v001 DELL   PE2650   0x00000001 MSFT 0x0100000a) @ 0x000fdc74
ACPI: FADT (v001 DELL   PE2650   0x00000001 MSFT 0x0100000a) @ 0x000fdca4
ACPI: MADT (v001 DELL   PE2650   0x00000001 MSFT 0x0100000a) @ 0x000fdd18
ACPI: SPCR (v001 DELL   PE2650   0x00000001 MSFT 0x0100000a) @ 0x000fdda0
ACPI: DSDT (v001 DELL   PE2650   0x00000001 MSFT 0x0100000a) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 0121      APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
I/O APIC #4 Version 17 at 0xFEC02000.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=808 aic7xxx=reverse_scan panic=10
Initializing CPU#0
CPU 0 irqstacks, hard=c0404000 soft=c0402000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2787.292 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075176k/2097088k available (1993k kernel code, 20784k reserved, 897k data, 164k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5488.64 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
per-CPU timeslice cutoff: 1462.49 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0405000 soft=c0403000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5554.17 BogoMIPS
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
Total of 2 processors activated (11042.81 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-3, 2-4, 2-5, 2-7, 2-10, 2-11, 2-13, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 30.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
number of IO-APIC #4 registers: 16.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    41
 07 000 00  1    0    0   0   0    0    0    00
 08 001 01  0    0    0   0   0    1    1    49
 09 001 01  0    0    0   0   0    1    1    51
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    59
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    61
 0f 001 01  0    0    0   0   0    1    1    69
IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    71
 01 001 01  1    1    0   1   0    1    1    79
 02 001 01  1    1    0   1   0    1    1    81
 03 001 01  1    1    0   1   0    1    1    89
 04 001 01  1    1    0   1   0    1    1    91
 05 001 01  1    1    0   1   0    1    1    99
 06 001 01  1    1    0   1   0    1    1    A1
 07 001 01  1    1    0   1   0    1    1    A9
 08 001 01  1    1    0   1   0    1    1    B1
 09 001 01  1    1    0   1   0    1    1    B9
 0a 001 01  1    1    0   1   0    1    1    C1
 0b 001 01  1    1    0   1   0    1    1    C9
 0c 001 01  1    1    0   1   0    1    1    D1
 0d 001 01  1    1    0   1   0    1    1    D9
 0e 001 01  1    1    0   1   0    1    1    E1
 0f 001 01  1    1    0   1   0    1    1    E9
IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ26 -> 1:10
IRQ27 -> 1:11
IRQ28 -> 1:12
IRQ29 -> 1:13
IRQ30 -> 1:14
IRQ31 -> 1:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2785.0501 MHz.
..... host bus clock speed is 99.0482 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:  online
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc98e, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
PCI: Discovered peer bus 03
PCI: Discovered peer bus 04
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 0000:00:0f.0
PCI->APIC IRQ transform: (B0,I4,P0) -> 19
PCI->APIC IRQ transform: (B0,I4,P1) -> 23
PCI->APIC IRQ transform: (B0,I4,P2) -> 27
PCI->APIC IRQ transform: (B3,I6,P0) -> 28
PCI->APIC IRQ transform: (B3,I8,P0) -> 29
PCI->APIC IRQ transform: (B5,I6,P0) -> 30
PCI->APIC IRQ transform: (B5,I6,P1) -> 31
Starting balanced_irq
highmem bounce pool size: 64 pages
SGI XFS with no debug enabled
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:3): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST318406LC        Rev: 8A03
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST318406LC        Rev: 8A03
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST318406LC        Rev: 8A03
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST318406LC        Rev: 8A03
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:3:0: Tagged Queuing enabled.  Depth 253
  Vendor: PE/PV     Model: 1x5 SCSI BP       Rev: 0.34
  Type:   Processor                          ANSI SCSI revision: 02
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

SCSI device sda: 35566478 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
 sda: sda1 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35566478 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 < sdb5 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 35566478 512-byte hdwr sectors (18210 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1 < sdc5 >
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
SCSI device sdd: 35566478 512-byte hdwr sectors (18210 MB)
SCSI device sdd: drive cache: write through
 sdd: sdd1 < sdd5 >
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 2096440k swap on /dev/sda6.  Priority:-1 extents:1
Adding 2096440k swap on /dev/sda7.  Priority:-2 extents:1
EXT3 FS on sda8, internal journal
Real Time Clock Driver v1.12
tg3.c:v3.8 (July 14, 2004)
eth0: Tigon3 [partno(BCM95701A10) rev 0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:06:5b:f1:0d:38
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
eth1: Tigon3 [partno(BCM95701A10) rev 0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:06:5b:f1:0d:39
eth1: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
XFS mounting filesystem sdb5
Ending clean XFS mount for filesystem: sdb5
XFS mounting filesystem sdc5
Ending clean XFS mount for filesystem: sdc5
XFS mounting filesystem sdd5
Starting XFS recovery on filesystem: sdd5 (dev: sdd5)
Ending XFS recovery on filesystem: sdd5 (dev: sdd5)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 300 bytes per conntrack
tg3: eth1: Link is up at 100 Mbps, half duplex.
tg3: eth1: Flow control is off for TX and off for RX.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ip_tables: (C) 2000-2002 Netfilter core team
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-8445-4447
IT-Zentrum Standort CBF                                   AIM.  ralfpostfix
