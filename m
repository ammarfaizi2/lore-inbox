Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424173AbWKPP3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424173AbWKPP3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424170AbWKPP3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:29:49 -0500
Received: from jutrzenka.firma.o2.pl ([193.222.135.194]:44466 "EHLO
	jutrzenka.firma.o2.pl") by vger.kernel.org with ESMTP
	id S1424163AbWKPP3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:29:47 -0500
From: "Krzysztof Sierota" <Krzysztof.Sierota@firma.o2.pl>
Organization: o2.pl Sp z o.o.
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: 2.6.19-rc6: irq 48: nobody cared
Date: Thu, 16 Nov 2006 16:29:44 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161629.45149.Krzysztof.Sierota@firma.o2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting the following in dmesg with 2.6.19-rc5 and 2.6.19-rc6 kernels quad 
opteron server running 64bit kernel, and the network card gets disabled. 

On identical server running 32bit kernel, same cards, same slots, same 
configuration running rc5 I see no errors.

irq 48: nobody cared (try booting with the "irqpoll" option)

Call Trace:
 <IRQ>  [<ffffffff80249a2c>] __report_bad_irq+0x30/0x7d
 [<ffffffff80249c54>] note_interrupt+0x1db/0x21f
 [<ffffffff8024a47d>] handle_fasteoi_irq+0xa4/0xce
 [<ffffffff8020c3c7>] do_IRQ+0x7b/0xc0
 [<ffffffff80207c1e>] default_idle+0x0/0x47
 [<ffffffff80209ca1>] ret_from_intr+0x0/0xa
 <EOI>  [<ffffffff80207c47>] default_idle+0x29/0x47
 [<ffffffff80207dc3>] cpu_idle+0x50/0x6f
 [<ffffffff804f76bf>] start_kernel+0x1be/0x1c0
 [<ffffffff804f7179>] _sinittext+0x179/0x17d

handlers:
[<ffffffff8033bbc4>] (e1000_intr+0x0/0xeb)
Disabling IRQ #48

Some more info:

 [root@test ~]# cat /proc/modules
xt_NOTRACK 3328 12 - Live 0xffffffff88024000
iptable_raw 3392 1 - Live 0xffffffff88022000
ipt_ULOG 10888 1 - Live 0xffffffff8801e000
8021q 22480 0 - Live 0xffffffff88017000
bonding 87288 0 - Live 0xffffffff88000000
[root@test ~]# 

 [root@test ~]# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:        100         50          1      97726   IO-APIC-edge      timer
  1:          0          0          0          2   IO-APIC-edge      i8042
  8:          0          0          0          0   IO-APIC-edge      rtc
  9:          0          0          0          0   IO-APIC-fasteoi   acpi
 12:          0          0          0          3   IO-APIC-edge      i8042
 21:          0          0          0          0   IO-APIC-fasteoi   libata
 22:          1         39          0       8433   IO-APIC-fasteoi   libata
 41:        579          0          0          0   IO-APIC-fasteoi   eth2
 42:       1482          0          0          0   IO-APIC-fasteoi   eth3
 47:      36323          0          0          0   IO-APIC-fasteoi   eth4
 48:      99905         10         83          2   IO-APIC-fasteoi   eth5
508:          0          2          0       6328   PCI-MSI-edge      eth1
509:          2         91          1    1248894   PCI-MSI-edge      eth0
NMI:         77         27         27         42
LOC:      97828      97811      97794      97777
ERR:          0



 [root@test ~]# lspci
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet 
Controller (rev 06)
02:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet 
Controller (rev 06)
03:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8132 PCI-X Bridge (rev 
12)
04:01.1 PIC: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC (rev 12)
04:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8132 PCI-X Bridge (rev 
12)
04:02.1 PIC: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC (rev 12)
05:03.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet 
Controller (rev 03)
05:03.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet 
Controller (rev 03)
06:02.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet 
Controller (rev 03)
06:02.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet 
Controller (rev 03) 

Linux version 2.6.19-rc6 (X) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #1 
SMP Thu Nov 16 16:05:11 CET 2006
Command line: ro root=/dev/md3 clock=tsc
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
 BIOS-e820: 00000000dfff0000 - 00000000dfffe000 (ACPI data)
 BIOS-e820: 00000000dfffe000 - 00000000e0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 917488) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2097152) 2 entries of 3200 used
end_pfn_map = 2097152
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000fa190
ACPI: RSDT (v001 A M I  OEMRSDT  0x12000505 MSFT 0x00000097) @ 
0x00000000dfff0000
ACPI: FADT (v002 A M I  OEMFACP  0x12000505 MSFT 0x00000097) @ 
0x00000000dfff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x12000505 MSFT 0x00000097) @ 
0x00000000dfff0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x12000505 MSFT 0x00000097) @ 
0x00000000dfffe040
ACPI: SRAT (v001 A M I  OEMSRAT  0x12000505 MSFT 0x00000097) @ 
0x00000000dfff5990
ACPI: MCFG (v001 A M I  OEMMCFG  0x12000505 MSFT 0x00000097) @ 
0x00000000dfff5b30
ACPI: DSDT (v001  1HQC8 1HQC8003 0x00000003 INTL 0x02002026) @ 
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> Node 3
SRAT: Node 0 PXM 0 100000-80000000
Entering add_active_range(0, 256, 524288) 0 entries of 3200 used
SRAT: Node 1 PXM 1 80000000-e0000000
Entering add_active_range(1, 524288, 917488) 1 entries of 3200 used
SRAT: Node 2 PXM 2 100000000-180000000
Entering add_active_range(2, 1048576, 1572864) 2 entries of 3200 used
SRAT: Node 3 PXM 3 180000000-200000000
Entering add_active_range(3, 1572864, 2097152) 3 entries of 3200 used
SRAT: Node 1 PXM 1 80000000-100000000
Entering add_active_range(1, 524288, 917488) 4 entries of 3200 used
SRAT: Node 0 PXM 0 0-80000000
Entering add_active_range(0, 0, 159) 4 entries of 3200 used
Entering add_active_range(0, 256, 524288) 5 entries of 3200 used
NUMA: Using 31 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000080000000
Bootmem setup node 1 0000000080000000-0000000100000000
Bootmem setup node 2 0000000100000000-0000000180000000
Bootmem setup node 3 0000000180000000-0000000200000000
Zone PFN ranges:
  DMA           256 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  2097152
early_node_map[5] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524288
    1:   524288 ->   917488
    2:  1048576 ->  1572864
    3:  1572864 ->  2097152
On node 0 totalpages: 524032
  DMA zone: 60 pages used for memmap
  DMA zone: 939 pages reserved
  DMA zone: 2841 pages, LIFO batch:0
  DMA32 zone: 8128 pages used for memmap
  DMA32 zone: 512064 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
On node 1 totalpages: 393200
  DMA zone: 0 pages used for memmap
  DMA32 zone: 6143 pages used for memmap
  DMA32 zone: 387057 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
On node 2 totalpages: 524288
  DMA zone: 0 pages used for memmap
  DMA32 zone: 0 pages used for memmap
  Normal zone: 8192 pages used for memmap
  Normal zone: 516096 pages, LIFO batch:31
On node 3 totalpages: 524288
  DMA zone: 0 pages used for memmap
  DMA32 zone: 0 pages used for memmap
  Normal zone: 8192 pages used for memmap
  Normal zone: 516096 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x84] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x85] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x86] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x87] disabled)
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfeafe000] gsi_base[40])
IOAPIC[1]: apic_id 9, address 0xfeafe000, GSI 40-46
ACPI: IOAPIC (id[0x0a] address[0xfeaff000] gsi_base[47])
IOAPIC[2]: apic_id 10, address 0xfeaff000, GSI 47-53
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e8000
Nosave address range: 00000000000e8000 - 0000000000100000
Nosave address range: 00000000dfff0000 - 00000000dfffe000
Nosave address range: 00000000dfffe000 - 00000000e0000000
Nosave address range: 00000000e0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 00000000fec01000
Nosave address range: 00000000fec01000 - 00000000fee00000
Nosave address range: 00000000fee00000 - 00000000fee01000
Nosave address range: 00000000fee01000 - 00000000ff700000
Nosave address range: 00000000ff700000 - 0000000100000000
Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
PERCPU: Allocating 33024 bytes of per cpu data
Built 4 zonelists.  Total pages: 1934154
Kernel command line: ro root=/dev/md3 clock=tsc
Warning! clock= boot option is deprecated. Use clocksource=xyz
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Checking aperture...
CPU 0: aperture @ 4000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 4000000
Memory: 7650672k/8388608k available (2028k kernel code, 213196k reserved, 875k 
data, 312k init)
Calibrating delay using timer specific routine.. 6002.73 BogoMIPS 
(lpj=30013667)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
Freeing SMP alternatives: 24k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12500269
Detected 12.500 MHz APIC timer.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.21 BogoMIPS 
(lpj=30001051)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 1
AMD Opteron(tm) Processor 856 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -145 cycles, maxerr 1057 cycles)
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 6000.21 BogoMIPS 
(lpj=30001067)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 2
AMD Opteron(tm) Processor 856 stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -144 cycles, maxerr 1060 cycles)
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 6000.16 BogoMIPS 
(lpj=30000840)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 3
AMD Opteron(tm) Processor 856 stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -190 cycles, maxerr 1825 cycles)
Brought up 4 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 3000.063 MHz processor.
migration_cost=346
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Root Bridge [PCIB] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.POGA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.POGB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *3
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *7
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *5
ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *11
ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
SCSI subsystem initialized
libata version 2.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:01.1
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 4000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:09.0
  IO window: a000-afff
  MEM window: fc300000-fe3fffff
  PREFETCH window: e2000000-e20fffff
PCI: Bridge: 0000:00:0d.0
  IO window: 9000-9fff
  MEM window: fc200000-fc2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: 8000-8fff
  MEM window: fc100000-fc1fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Bridge: 0000:04:01.0
  IO window: f000-ffff
  MEM window: fe700000-fe9fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:02.0
  IO window: e000-efff
  MEM window: fe600000-fe6fffff
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
IPv4 FIB: Using LC-trie version 0.407
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Found HT MSI mapping on 0000:00:0d.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
ACPI: Getting cpuindex for acpiid 0x5
ACPI: Getting cpuindex for acpiid 0x6
ACPI: Getting cpuindex for acpiid 0x7
ACPI: Getting cpuindex for acpiid 0x8
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKD] -> GSI 19 (level, low) -> 
IRQ 19
PCI: Setting latency timer of device 0000:02:00.0 to 64
e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 
00:15:17:0b:82:13
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKC] -> GSI 18 (level, low) -> 
IRQ 18
PCI: Setting latency timer of device 0000:01:00.0 to 64
e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 
00:15:17:0b:81:ae
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 41 (level, low) -> IRQ 41
e1000: 0000:06:02.0: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:b0:6b:6e
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:06:02.1[B] -> GSI 42 (level, low) -> IRQ 42
e1000: 0000:06:02.1: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:b0:6b:6f
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:05:03.0[A] -> GSI 47 (level, low) -> IRQ 47
e1000: 0000:05:03.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:30:48:57:3e:a0
e1000: eth4: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:05:03.1[B] -> GSI 48 (level, low) -> IRQ 48
e1000: 0000:05:03.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:30:48:57:3e:a1
e1000: eth5: e1000_probe: Intel(R) PRO/1000 Network Connection
sata_nv 0000:00:07.0: version 2.0
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level, low) -> 
IRQ 22
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xCC00 irq 22
ata2: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xCC08 irq 22
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3250620NS      3.AE PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3250620NS      3.AE PQ: 0 ANSI: 5
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 >
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
ACPI: PCI Interrupt Link [LTIE] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LTIE] -> GSI 21 (level, low) -> 
IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xB800 irq 21
ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xBC02 bmdma 0xB808 irq 21
scsi2 : sata_nv
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
ip_conntrack version 2.4 (262144 buckets, 2097152 max) - 248 bytes per 
conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb9 ...
md:  adding sdb9 ...
md: sdb8 has different UUID to sdb9
md: sdb7 has different UUID to sdb9
md: sdb6 has different UUID to sdb9
md: sdb5 has different UUID to sdb9
md: sdb1 has different UUID to sdb9
md:  adding sda9 ...
md: sda8 has different UUID to sdb9
md: sda7 has different UUID to sdb9
md: sda6 has different UUID to sdb9
md: sda5 has different UUID to sdb9
md: sda1 has different UUID to sdb9
md: created md5
md: bind<sda9>
md: bind<sdb9>
md: running: <sdb9><sda9>
raid1: raid set md5 active with 2 out of 2 mirrors
md: considering sdb8 ...
md:  adding sdb8 ...
md: sdb7 has different UUID to sdb8
md: sdb6 has different UUID to sdb8
md: sdb5 has different UUID to sdb8
md: sdb1 has different UUID to sdb8
md:  adding sda8 ...
md: sda7 has different UUID to sdb8
md: sda6 has different UUID to sdb8
md: sda5 has different UUID to sdb8
md: sda1 has different UUID to sdb8
md: created md4
md: bind<sda8>
md: bind<sdb8>
md: running: <sdb8><sda8>
raid1: raid set md4 active with 2 out of 2 mirrors
md: considering sdb7 ...
md:  adding sdb7 ...
md: sdb6 has different UUID to sdb7
md: sdb5 has different UUID to sdb7
md: sdb1 has different UUID to sdb7
md:  adding sda7 ...
md: sda6 has different UUID to sdb7
md: sda5 has different UUID to sdb7
md: sda1 has different UUID to sdb7
md: created md3
md: bind<sda7>
md: bind<sdb7>
md: running: <sdb7><sda7>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb1 has different UUID to sdb6
md:  adding sda6 ...
md: sda5 has different UUID to sdb6
md: sda1 has different UUID to sdb6
md: created md2
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdb5 ...
md:  adding sdb5 ...
md: sdb1 has different UUID to sdb5
md:  adding sda5 ...
md: sda1 has different UUID to sdb5
md: created md1
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 312k freed
Ethernet Channel Bonding Driver: v3.1.1 (September 26, 2006)
bonding: MII link monitoring set to 100 ms
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on md3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1959800k swap on /dev/md1.  Priority:-1 extents:1 across:1959800k
