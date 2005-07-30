Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVG3FmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVG3FmY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVG3FmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:42:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262939AbVG3Flw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:41:52 -0400
Date: Fri, 29 Jul 2005 22:40:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] Fix NUMA node sizing in nr_free_zone_pages
Message-Id: <20050729224043.7ce56d4e.akpm@osdl.org>
In-Reply-To: <240970000.1122661910@[10.10.2.4]>
References: <240970000.1122661910@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> We are iterating over all nodes in nr_free_zone_pages(). Because the 
>  fallback zonelists contain all nodes in the system, and we walk all
>  the zonelists, we're counting memory multiple times (once for each
>  node). This caused us to make a size estimate of 32GB for an 8GB
>  AMD64 box, which makes all the dirty ratio calculations, etc incorrect.
> 
>  There's still a further bug to fix from e820 holes causing overestimation
>  as well, but this fix is separate, and good as is, and fixes one class
>  of problems. Problem found by Badari, and tested by Ram Pai - thanks!

Alas my non-NUMA EMT64 box still gets it wrong.

nr_free_pagecache_pages() is still returning 1572864 on a 4G box.

Bootdata ok (command line is ro root=/dev/sda3)
Linux version 2.6.13-rc4-mm1 (akpm@x) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #134 SMP PREEMPT Fri Jul 29 21:38:37 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebbd0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffd0000 (usable)
 BIOS-e820: 000000007ffd0000 - 000000007ffdf000 (ACPI data)
 BIOS-e820: 000000007ffdf000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f6710
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0000
ACPI: FADT (v002 A M I  OEMFACP  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0200
ACPI: MADT (v001 A M I  OEMAPIC  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0390
ACPI: MCFG (v001 Intel  Cayuse   0x00000001 MSFT 0x00000001) @ 0x000000007ffd0420
ACPI: OEMB (v001 A M I  AMI_OEM  0x05000427 MSFT 0x00000097) @ 0x000000007ffdf040
ACPI: HPET (v001 A M I  OEMHPET  0x05000427 MSFT 0x00000097) @ 0x000000007ffd7460
ACPI: DSDT (v001  CYCRB CYCRB039 0x00000039 INTL 0x02002026) @ 0x0000000000000000
On node 0 totalpages: 1572864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1568768 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 16
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Checking aperture...
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/sda3
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 3400.235 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Placing software IO TLB between 0x706d000 - 0x906d000
Memory: 4056592k/6291456k available (2892k kernel code, 136908k reserved, 1528k data, 192k init)
Calibrating delay using timer specific routine.. 6806.09 BogoMIPS (lpj=13612190)
Mount-cache hash table entries: 256
total_pages=1572864
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
 tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..................................................................................................................................
Table [DSDT](id 0004) - 461 Objects with 50 Devices 130 Methods 11 Regions
ACPI Namespace successfully loaded at root ffffffff805b1060
evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 6800.36 BogoMIPS (lpj=13600721)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
APIC error on CPU1: 00(40)
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/4 APIC 0x1
softlockup thread 1 started up.
CPU 1: synchronized TSC with CPU 0 (last diff 8 cycles, maxerr 1267 cycles)
Initializing CPU#2
Calibrating delay using timer specific routine.. 6799.74 BogoMIPS (lpj=13599492)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
APIC error on CPU2: 00(40)
CPU 2: Syncing TSC to CPU 0.
softlockup thread 2 started up.
CPU 2: synchronized TSC with CPU 0 (last diff 2 cycles, maxerr 782 cycles)
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6800.24 BogoMIPS (lpj=13600482)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
APIC error on CPU3: 00(40)
CPU 3: Syncing TSC to CPU 0.
Brought up 4 CPUs
time.c: Using HPET/TSC based timekeeping.
softlockup thread 3 started up.
CPU 3: synchronized TSC with CPU 0 (last diff 13 cycles, maxerr 1454 cycles)
testing NMI watchdog ... OK.
-> [0][1][  65536]   0.0 [  0.0] (1): (   30802    15401)
-> [0][1][  68985]   0.0 [  0.0] (1): (   28878     8662)
-> [0][1][  72615]   0.0 [  0.0] (1): (   31982     5883)
-> [0][1][  76436]   0.0 [  0.0] (1): (   33671     3786)
-> [0][1][  80458]   0.0 [  0.0] (1): (   36464     3289)
-> [0][1][  84692]   0.0 [  0.0] (1): (   37640     2232)
-> [0][1][  89149]   0.0 [  0.0] (1): (   41782     3187)
-> [0][1][  93841]   0.0 [  0.0] (1): (   43251     2328)
-> [0][1][  98780]   0.0 [  0.0] (1): (   49783     4430)
-> [0][1][ 103978]   0.0 [  0.0] (1): (   48679     2767)
-> [0][1][ 109450]   0.0 [  0.0] (1): (   49901     1994)
-> [0][1][ 115210]   0.0 [  0.0] (1): (   51129     1611)
-> [0][1][ 121273]   0.0 [  0.0] (1): (   58000     4241)
-> [0][1][ 127655]   0.0 [  0.0] (1): (   60912     3576)
-> [0][1][ 134373]   0.0 [  0.0] (1): (   64481     3572)
-> [0][1][ 141445]   0.0 [  0.0] (1): (   69376     4233)
-> [0][1][ 148889]   0.0 [  0.0] (1): (   70247     2552)
-> [0][1][ 156725]   0.0 [  0.0] (1): (   74568     3436)
-> [0][1][ 164973]   0.0 [  0.0] (1): (   72684     2660)
-> [0][1][ 173655]   0.0 [  0.0] (1): (   82089     6032)
-> [0][1][ 182794]   0.0 [  0.0] (1): (   86093     5018)
-> [0][1][ 192414]   0.0 [  0.0] (1): (   87915     3420)
-> [0][1][ 202541]   0.1 [  0.1] (1): (  105832    10668)
-> [0][1][ 213201]   0.1 [  0.1] (1): (  106195     5515)
-> [0][1][ 224422]   0.1 [  0.1] (1): (  115242     7281)
-> [0][1][ 236233]   0.1 [  0.1] (1): (  112956     4783)
-> [0][1][ 248666]   0.1 [  0.1] (1): (  119121     5474)
-> [0][1][ 261753]   0.1 [  0.1] (1): (  126591     6472)
-> [0][1][ 275529]   0.1 [  0.1] (1): (  125830     3616)
-> [0][1][ 290030]   0.1 [  0.1] (1): (  144454    11120)
-> [0][1][ 305294]   0.1 [  0.1] (1): (  149530     8098)
-> [0][1][ 321362]   0.1 [  0.1] (1): (  156193     7380)
-> [0][1][ 338275]   0.1 [  0.1] (1): (  169114    10150)
-> [0][1][ 356078]   0.1 [  0.1] (1): (  176278     8657)
-> [0][1][ 374818]   0.1 [  0.1] (1): (  180310     6344)
-> [0][1][ 394545]   0.1 [  0.1] (1): (  198031    12032)
-> [0][1][ 415310]   0.2 [  0.2] (1): (  206920    10460)
-> [0][1][ 437168]   0.2 [  0.2] (1): (  219614    11577)
-> [0][1][ 460176]   0.2 [  0.2] (1): (  228004     9983)
-> [0][1][ 484395]   0.2 [  0.2] (1): (  234777     8378)
-> [0][1][ 509889]   0.2 [  0.2] (1): (  248846    11223)
-> [0][1][ 536725]   0.2 [  0.2] (1): (  261244    11810)
-> [0][1][ 564973]   0.2 [  0.2] (1): (  286512    18539)
-> [0][1][ 594708]   0.2 [  0.2] (1): (  288002    10014)
-> [0][1][ 626008]   0.3 [  0.3] (1): (  305148    13580)
-> [0][1][ 658955]   0.3 [  0.3] (1): (  313304    10868)
-> [0][1][ 693636]   0.3 [  0.3] (1): (  339551    18557)
-> [0][1][ 730143]   0.3 [  0.3] (1): (  345809    12407)
-> [0][1][ 768571]   0.3 [  0.3] (1): (  393721    30159)
-> [0][1][ 809022]   0.4 [  0.4] (1): (  422795    29616)
-> [0][1][ 851602]   0.4 [  0.4] (1): (  434075    20448)
-> [0][1][ 896423]   0.4 [  0.4] (1): (  435383    10878)
-> [0][1][ 943603]   0.4 [  0.4] (1): (  479267    27381)
-> [0][1][ 993266]   0.4 [  0.4] (1): (  416849    44899)
-> [0][1][1045543]   0.4 [  0.4] (1): (  400165    30791)
-> [0][1][1100571]   0.4 [  0.4] (1): (  402364    16495)
-> [0][1][1158495]   0.3 [  0.4] (1): (  308598    55130)
-> [0][1][1219468]   0.0 [  0.4] (1): (   59030   152349)
-> [0][1][1283650]   0.0 [  0.4] (1): (   43242    84068)
-> found max.
[0][1] working set size found: 943603, cost: 479267
-> [0][2][  65536]   0.0 [  0.0] (0): (     444      222)
-> [0][2][  68985]   0.0 [  0.0] (0): (      36      315)
-> [0][2][  72615]   0.0 [  0.0] (0): (     560      419)
-> [0][2][  76436]   0.0 [  0.0] (0): (    2733     1296)
-> [0][2][  80458]   0.0 [  0.0] (0): (     144     1942)
-> [0][2][  84692]   0.0 [  0.0] (0): (     577     1187)
-> [0][2][  89149]   0.0 [  0.0] (0): (     469      647)
-> [0][2][  93841]   0.0 [  0.0] (0): (    1103      640)
-> [0][2][  98780]   0.0 [  0.0] (0): (    -415     1079)
-> [0][2][ 103978]   0.0 [  0.0] (0): (    2606     2050)
-> [0][2][ 109450]   0.0 [  0.0] (0): (    2440     1108)
-> [0][2][ 115210]   0.0 [  0.0] (0): (    2284      632)
-> [0][2][ 121273]   0.0 [  0.0] (0): (    2535      441)
-> [0][2][ 127655]   0.0 [  0.0] (0): (     183     1396)
-> found max.
[0][2] working set size found: 76436, cost: 2733
---------------------
| migration cost matrix (max_cache_size: 0, cpu: 3400 MHz):
---------------------
          [00]    [01]    [02]    [03]
[00]:     -     0.9(1)  0.0(0)  0.9(1)
[01]:   0.9(1)    -     0.9(1)  0.0(0)
[02]:   0.0(0)  0.9(1)    -     0.9(1)
[03]:   0.9(1)  0.0(0)  0.9(1)    -   
--------------------------------
| cacheflush times [2]: 0.0 (5466) 0.9 (958534)
| calibration delay: 0 seconds
--------------------------------
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050708
evgpeblk-1019 [06] acpi_ev_create_gpe_blo: GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1027 [06] acpi_ev_create_gpe_blo: Found 8 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..............................................................................................
Initialized 10/11 Regions 26/26 Fields 36/36 Buffers 22/23 Packages (470 nodes)
Executing all Device _STA and_INI methods:........................................................
56 Devices found containing: 56 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:05:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:02:00.0
  IO window: d000-dfff
  MEM window: fa400000-fa6fffff
  PREFETCH window: bfe00000-bfefffff
PCI: Bridge: 0000:02:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: d000-dfff
  MEM window: fa400000-fa8fffff
  PREFETCH window: bfe00000-bfefffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: fa900000-feafffff
  PREFETCH window: bff00000-dfefffff
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: fa300000-fa3fffff
  PREFETCH window: 80000000-800fffff
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
PCI: Setting latency timer of device 0000:02:00.0 to 64
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
PCI: Setting latency timer of device 0000:02:00.2 to 64
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 64-bit timers
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Intel E7520/7320/7525 detected.<6>ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
ACPI: CPU2 (power states: C1[C1])
ACPI: CPU3 (power states: C1[C1])
Real Time Clock Driver v1.12
hpet_acpi_add: no address or irqs in _CRS
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
cn_fork is registered
cn_exit is registered
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 17 (level, low) -> IRQ 17
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.35.
netconsole: not configured, aborting
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 30 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:04:03.1[B] -> GSI 31 (level, low) -> IRQ 19
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

(scsi0:A:5): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
(scsi0:A:6): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
  Vendor: MAXTOR    Model: ATLAS10K4_73WLS   Rev: DFV0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:5:0: Tagged Queuing enabled.  Depth 64
  Vendor: MAXTOR    Model: ATLAS10K4_73WLS   Rev: DFV0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 64
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

3ware Storage Controller device driver for Linux v1.26.02.001.
libata version 1.11 loaded.
ata_piix version 1.03
ata_piix: combined mode detected
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata1: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0407
ata1: dev 0 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
scsi2 : ata_piix
isa bounce pool size: 16 pages
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
ATA: abnormal status 0x7F on port 0x177
ata2: disabling port
scsi3 : ata_piix
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 5, lun 0
SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 5, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 0
usbmon: debugs is not available
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xfebff400
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e080
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 22, io base 0x0000e400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 20, io base 0x0000e480
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Intel 810 + AC97 Audio, version 1.01, 21:31:06 Jul 29 2005
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH5 found at IO 0xe880 and 0xec00, MEM 0xfebffc00 and 0xfebff800, IRQ 17
i810: Intel ICH5 mmio at 0xffffc20000010c00 and 0xffffc20000012800
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS116 (Analog Devices AD1981B)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
TCP htcp registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Using generic hotkey driver
ibm_acpi: Using generic hotkey driver
toshiba_acpi: Using generic hotkey driver
EXT3 FS on sda3, internal journal
vm_dirty_ratio=40 unmapped_ratio=100 dirty_ratio=40
dirty_ratio=40 available_memory=1572864 dirty=629145
background_thresh=157286 dirty_thresh=629145 nr_dirty=581 nr_unstable=0 nr_reclaimable=581 wbs.nr_writeback=0
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 4096532k swap on /dev/sda5.  Priority:-1 extents:1 across:4096532k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
eth0: no IPv6 routers present

