Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSJ1WHP>; Mon, 28 Oct 2002 17:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSJ1WHP>; Mon, 28 Oct 2002 17:07:15 -0500
Received: from mail.bit-net.com ([208.146.132.6]:38160 "EHLO mail.bit-net.com")
	by vger.kernel.org with ESMTP id <S261561AbSJ1WHI>;
	Mon, 28 Oct 2002 17:07:08 -0500
Reply-To: <J_Fraser@bit-net.com>
From: "Jon Fraser" <J_Fraser@bit-net.com>
To: "Linux-Kernel \(E-mail\)" <linux-kernel@vger.kernel.org>
Cc: <j_fraser@bit-net.com>
Subject: smp affinity problems with intel e7500 chipset and hyperthread xeon cpus
Date: Mon, 28 Oct 2002 17:14:20 -0500
Message-ID: <000601c27ecf$5dca8a40$3701020a@CONCORDIA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

	We have an intel box with 2 hyperthreaded xeon cpus and the e7500
chipset.  We're seeing interrupt affinty problems on 2.4.20-pre11.
With an interrupt smp_affinity mask of 0xffff, interrupts
don't float; they appear to be bound to cpu 0.  Changing the mask to
1,2,4,8 will bind an interrupt to the appropriate cpu.  Is this a known
problem?  I didn't find anything by searching the archives.  I've copied
hopefully usefull information below.

	Thanks,
	Jon

Linux version 2.4.20-pre11smp (root@....) (gcc version 2.96 20000731 (Red
Hat Linux 7.3 2.96-110)) #20 SMP Wed Oct 23 18:55:35 EDT 2002

[root@wv root]# lspci
00:00.0 Host bridge: Intel Corp. e7500 DRAM Controller (rev 03)
00:00.1 Class ff00: Intel Corp. e7500 DRAM Controller Error Reporting (rev
03)
00:03.0 PCI bridge: Intel Corp. e7500 HI_C Virtual PCI-to-PCI Bridge (F0)
(rev 03)
00:03.1 Class ff00: Intel Corp. e7500 HI_C Virtual PCI-to-PCI Bridge (F1)
(rev 03)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
03:0a.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet Controller
(rev 02)
04:08.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller

[root@wv proc]# cat pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. e7500 [Plumas] DRAM Controller (rev 3).
  Bus  0, device   0, function  1:
    Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting
(rev 3).
  Bus  0, device   3, function  0:
    PCI bridge: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F0) (rev
3).
      Master Capable.  Latency=64.  Min Gnt=3.
  Bus  0, device   3, function  1:
    Class ff00: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F1) (rev
3).
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 2).
      IRQ 16.
      I/O at 0x4020 [0x403f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 2).
      IRQ 19.
      I/O at 0x4000 [0x401f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 66).
      Master Capable.  No bursts.  Min Gnt=11.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801CA IDE U100 (rev 2).
      IRQ 17.
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x3a0 [0x3af].
      Non-prefetchable 32 bit memory at 0x10000000 [0x100003ff].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801CA/CAM SMBus (rev 2).
      IRQ 17.
      I/O at 0x580 [0x59f].
  Bus  2, device  30, function  0:
    PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (#2) (rev 3).
      Non-prefetchable 32 bit memory at 0xfebf0000 [0xfebf0fff].
  Bus  2, device  28, function  0:
    PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 3).
      Non-prefetchable 32 bit memory at 0xfebe0000 [0xfebe0fff].
  Bus  2, device  31, function  0:
    PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (#2) (rev 3).
      Master Capable.  Latency=64.  Min Gnt=3.
  Bus  2, device  29, function  0:
    PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=3.
  Bus  4, device   8, function  0:
    Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller (rev 0).
      IRQ 48.
      Master Capable.  Latency=64.  Min Gnt=11.Max Lat=52.
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0xfeae0000 [0xfeae0fff].
  Bus  3, device  10, function  0:
    Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet Controller
(rev 2).
      IRQ 28.
      Master Capable.  Latency=64.  Min Gnt=255.
      Non-prefetchable 64 bit memory at 0xfe9e0000 [0xfe9fffff].
      Non-prefetchable 64 bit memory at 0xfe9c0000 [0xfe9dffff].
      I/O at 0x2000 [0x201f].
  Bus  1, device  12, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      I/O at 0x1000 [0x10ff].
      Non-prefetchable 32 bit memory at 0xfe7f0000 [0xfe7f0fff].

[root@wv proc]# cat cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.60GHz
stepping        : 7
cpu MHz         : 2592.416
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 5177.34

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.60GHz
stepping        : 7
cpu MHz         : 2592.416
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 5177.34


processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.60GHz
stepping        : 7
cpu MHz         : 2592.416
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 5177.34

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.60GHz
stepping        : 7
cpu MHz         : 2592.416
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 5177.34

[root@wv proc]# cat interrupts
           CPU0       CPU1       CPU2       CPU3
  0:      78169          0          0          0    IO-APIC-edge  timer
  1:       2371          0          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
 12:      15593          0          0          0    IO-APIC-edge  PS/2 Mouse
 14:       7122          0          0          0    IO-APIC-edge  ide0

 15:         51          0          0          0    IO-APIC-edge  ide1
 28:          6          0          0          0   IO-APIC-level  eth1
 48:       3090          0          0          0   IO-APIC-level  eth0
NMI:          0          0          0          0
LOC:      78043      78042      78004      78042
ERR:          0
MIS:          0

--------------------------- boot log ------------------------

 Linux version 2.4.20-pre11smp (root@.....) (gcc version 2.96 20000731 (Red
Hat Linux 7.3 2.96-110)) #20 SMP Wed Oct 23 18:55:35 EDT 2002
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
  BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
  BIOS-e820: 000000000fff0000 - 000000000ffff000 (ACPI data)
  BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 255MB LOWMEM available.
 found SMP MP-table at 000ff780
 hm, page 000ff000 reserved twice.
 hm, page 00100000 reserved twice.
 hm, page 000f1000 reserved twice.
 hm, page 000f2000 reserved twice.
 On node 0 totalpages: 65520
 zone(0): 4096 pages.
 zone(1): 61424 pages.
 zone(2): 0 pages.
 ACPI: Searched entire block, no RSDP was found.
 ACPI: RSDP located at physical address c00ff9b0
 RSD PTR  v0 [INTEL ]
 __va_range(0xfff0000, 0x68): idx=8 mapped at ffff6000
 ACPI table found: RSDT v1 [INTEL  SWV20    0.1]
 __va_range(0xfff0030, 0x24): idx=8 mapped at ffff6000
 __va_range(0xfff0030, 0x74): idx=8 mapped at ffff6000
 ACPI table found: FACP v1 [INTEL  SWV20    0.1]
 __va_range(0xfff00b0, 0x24): idx=8 mapped at ffff6000
 __va_range(0xfff00b0, 0x90): idx=8 mapped at ffff6000
 ACPI table found: APIC v1 [INTEL  SWV20    0.1]
 __va_range(0xfff00b0, 0x90): idx=8 mapped at ffff6000
 LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
 CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

 LAPIC (acpi_id[0x0001] id[0x6] enabled[1])
 CPU 1 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 16

 LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
 CPU 2 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16

 LAPIC (acpi_id[0x0003] id[0x7] enabled[1])
 CPU 3 (0x0700) enabledProcessor #7 Pentium 4(tm) XEON(tm) APIC version 16

 IOAPIC (id[0x8] address[0xfec00000] global_irq_base[0x0])
 IOAPIC (id[0x9] address[0xfec81000] global_irq_base[0x18])
 IOAPIC (id[0xa] address[0xfec81400] global_irq_base[0x30])
 INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
 INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
 LAPIC_NMI (acpi_id[0x0000] polarity[0x1] trigger[0x3] lint[0x1])
 LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x3] lint[0x1])
 4 CPUs total
 Local APIC address fee00000
  __va_range(0xfff0140, 0x24): idx=8 mapped at ffff6000
 __va_range(0xfff0140, 0x50): idx=8 mapped at ffff6000
 ACPI table found: OEMR v1 [INTEL  SWV20    0.1]
 Enabling the CPU's according to the ACPI table
 Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
 OEM ID: INTEL    Product ID: SWV20        APIC at: 0xFEE00000
 I/O APIC #8 Version 32 at 0xFEC00000.
 I/O APIC #9 Version 32 at 0xFEC81000.
 I/O APIC #10 Version 32 at 0xFEC81400.
 Processors: 4
 Kernel command line: ro root=/dev/hda3
 Initializing CPU#0
 Detected 2592.416 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 5177.34 BogoMIPS
 Memory: 256536k/262080k available (1105k kernel code, 5140k reserved, 327k
data, 268k init, 0k highmem)
 Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
 Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
 Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
 Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
 Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
 CPU: L1 I cache: 0K, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 0
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
Oct 28 16:01:49 wv portmap: portmap startup succeeded
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
 mtrr: detected mtrr type: Intel
 CPU: L1 I cache: 0K, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 0
 Intel machine check reporting enabled on CPU#0.
 CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
 per-CPU timeslice cutoff: 1462.71 usecs.
 enabled ExtINT on CPU#0
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Booting processor 1/1 eip 2000
 Initializing CPU#1
 masked ExtINT on CPU#1
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Calibrating delay loop... 5177.34 BogoMIPS
 CPU: L1 I cache: 0K, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 0
 Intel machine check reporting enabled on CPU#1.
   Intel machine check reporting enabled on CPU#1.
 CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
 Booting processor 2/6 eip 2000
 Initializing CPU#2
 masked ExtINT on CPU#2
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Calibrating delay loop... 5177.34 BogoMIPS
 CPU: L1 I cache: 0K, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 3
 Intel machine check reporting enabled on CPU#2.
 CPU2: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
 Booting processor 3/7 eip 2000
 Initializing CPU#3
 masked ExtINT on CPU#3
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Calibrating delay loop... 5177.34 BogoMIPS
 CPU: L1 I cache: 0K, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 3
 Intel machine check reporting enabled on CPU#3.
 CPU3: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
 Total of 4 processors activated (20709.37 BogoMIPS).
 cpu_sibling_map[0] = 1
 cpu_sibling_map[1] = 0
 cpu_sibling_map[2] = 3
 cpu_sibling_map[3] = 2
 ENABLING IO-APIC IRQs
 Setting 8 in the phys_id_present_map
 ...changing IO-APIC physical APIC ID to 8 ... ok.
 Setting 9 in the phys_id_present_map
 ...changing IO-APIC physical APIC ID to 9 ... ok.
 Setting 10 in the phys_id_present_map
 ...changing IO-APIC physical APIC ID to 10 ... ok.
 ..TIMER: vector=0x31 pin1=2 pin2=0
 testing the IO APIC.......................
 .................................... done.
 Using local APIC timer interrupts.
 calibrating APIC timer ...
 ..... CPU clock speed is 2592.2721 MHz.
 ..... host bus clock speed is 99.7027 MHz.
 cpu: 0, clocks: 997027, slice: 199405
 CPU0<T0:997024,T1:797616,D:3,S:199405,C:997027>
 cpu: 1, clocks: 997027, slice: 199405
 cpu: 3, clocks: 997027, slice: 199405
 cpu: 2, clocks: 997027, slice: 199405
 CPU1<T0:997024,T1:598208,D:6,S:199405,C:997027>
 CPU3<T0:997024,T1:199392,D:12,S:199405,C:997027>
 CPU2<T0:997024,T1:398800,D:9,S:199405,C:997027>
 checking TSC synchronization across CPUs: passed.
 Waiting on wait_init_idle (map = 0xe)
 All processors have done init_idle
 PCI: PCI BIOS revision 2.10 entry at 0xfdb85, last bus=4
 PCI: Using configuration type 1
 PCI: Probing PCI hardware
 PCI: Unable to handle 64-bit address space for
 PCI: Unable to handle 64-bit address space for
 Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
 PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
 PCI->APIC IRQ transform: (B0,I29,P0) -> 16
 PCI->APIC IRQ transform: (B0,I29,P1) -> 19
 PCI->APIC IRQ transform: (B0,I31,P0) -> 17
 PCI->APIC IRQ transform: (B0,I31,P1) -> 17
 PCI->APIC IRQ transform: (B4,I8,P0) -> 48
 PCI->APIC IRQ transform: (B3,I10,P0) -> 28
 PCI->APIC IRQ transform: (B1,I12,P0) -> 17
 isapnp: Scanning for PnP cards...

