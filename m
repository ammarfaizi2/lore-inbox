Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbTFQRLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264852AbTFQRLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:11:41 -0400
Received: from palrel11.hp.com ([156.153.255.246]:22934 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264851AbTFQRLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:11:05 -0400
Date: Tue, 17 Jun 2003 19:24:57 +0200
From: Bruno Cornec <Bruno.Cornec@hp.com>
To: linux-kernel@vger.kernel.org
Cc: sophie.pasquier@hp.com, bruno.cornec@hp.com
Subject: PROBLEM: DL760 G2 issue on 2.4.21 with Hyper-Threading
Message-ID: <20030617192457.Q9969@morley.grenoble.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
X-Humor: Linux is to Windows what early music is to military music
X-Operating-System: Linux morley.grenoble.hp.com 2.4.20-13.7
X-Current-Uptime: 8:35pm  up 21 days,  8:46,  2 users,  load average: 0.78, 0.29, 0.17
X-HP-HOWTO-URL: http://www.HyPer-Linux.org/HP-HOWTO/current
X-eurolinux: http://eurolinux.grenoble.hp.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First this is my first mail on that mailing-list so even if I try reading
all the guidelines before posting, I may have missed some, as I'm not
reading it regularly but only through kernel-traffic.
[So please keep the Cc: if you answer to that mail]

PROBLEM: DL760 G2 issue on 2.4.21 with Hyper-Threading (HT)

When activating HT on the machine in the BIOS, the system boots correctly
as it seems (detecting the 16 CPUs it should detect) but then it hangs 
during the remaining phases of the boot (before launching the X session
generally). Whatever the runlevel (S, 2, 3, 4), results is the same.
The base distribution is SLES 8. So I tried first their kernel
(k_smp-2.4.19-113), then their updated kernel (k_smp-2.4.19-257), then
a RedHat kernel (2.4.20-18.9bigmem), then a std 2.4.21 kernel, with always
the same result, soon or less a hang. No other messages at the console.

The same machines with the same kernels without HT enabled in BIOS works
like a charm.

Tests were made initialy with 24 GB of RAM, then with 4 GB of RAM, just
to be in a safe conf.

Here are some more precise info:

--------------------------------------------------------------------
The latest BIOS has been put on the system (P44 - 2003-02-18)
--------------------------------------------------------------------
cat /proc/cmdline :
root=/dev/cciss/c0d0p1  ide=nodma apm=off acpi=off  (8 CPUs)
root=/dev/cciss/c0d0p1  ide=nodma apm=off acpi=off noapic (16 CPUs)

The noapic option seems mandatory as the system does a kernel panic
without it in HT mode due to errors in IO-APIC.

--------------------------------------------------------------------
cat /proc/cpuinfo (8 CPUs) :

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3984.58

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3997.69

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3997.69

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3997.69

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3997.69

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3997.69

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3997.69

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) XEON(TM) MP CPU 2.00GHz
stepping	: 2
cpu MHz		: 1999.320
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3997.69

--------------------------------------------------------------------
boot.log (8 CPU - without noapic )

Inspecting /boot/System.map
Loaded 18066 symbols from /boot/System.map.
Symbols match kernel version 2.4.21.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.21 (root@linux) (gcc version 3.2) #3 SMP Tue Jun 17 17:32:56 CEST 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
<4> BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
<4> BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
<4> BIOS-e820: 0000000100000000 - 000000010ffff000 (usable)
<5>3455MB HIGHMEM available.
<5>896MB LOWMEM available.
<4>found SMP MP-table at 000f4fd0
<4>hm, page 000f4000 reserved twice.
<4>hm, page 000f5000 reserved twice.
<4>hm, page 000f7000 reserved twice.
<4>hm, page 000f8000 reserved twice.
<4>On node 0 totalpages: 1114111
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 884735 pages.
<6>ACPI: Searched entire block, no RSDP was found.
<6>ACPI: RSDP located at physical address c00f4f70
<6>RSD PTR  v0 [HP    ]
<4>__va_range(0xefff0000, 0x68): idx=8 mapped at ffff6000
<6>ACPI table found: RSDT v1 [HP     P44      0.1]
<4>__va_range(0xefff0040, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff0040, 0x74): idx=8 mapped at ffff6000
<6>ACPI table found: FACP v1 [HP     P44      0.1]
<4>__va_range(0xefff0100, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff0100, 0xe0): idx=8 mapped at ffff6000
<6>ACPI table found: APIC v1 [HP     P44      0.1]
<4>__va_range(0xefff0100, 0xe0): idx=8 mapped at ffff6000
<6>LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
<6>CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
<6>CPU 1 (0x0200) enabledProcessor #2 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0003] id[0x4] enabled[1])
<6>CPU 2 (0x0400) enabledProcessor #4 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0004] id[0x6] enabled[1])
<6>CPU 3 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0005] id[0x8] enabled[1])
<6>CPU 4 (0x0800) enabledProcessor #8 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0006] id[0xa] enabled[1])
<6>CPU 5 (0x0a00) enabledProcessor #10 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0007] id[0xc] enabled[1])
<6>CPU 6 (0x0c00) enabledProcessor #12 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0008] id[0xe] enabled[1])
<6>CPU 7 (0x0e00) enabledProcessor #14 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0009] id[0x1] enabled[0])
<6>CPU 8 (0x0100) disabled
<6>LAPIC (acpi_id[0x000a] id[0x3] enabled[0])
<6>CPU 9 (0x0300) disabled
<6>LAPIC (acpi_id[0x000b] id[0x5] enabled[0])
<6>CPU 10 (0x0500) disabled
<6>LAPIC (acpi_id[0x000c] id[0x7] enabled[0])
<6>CPU 11 (0x0700) disabled
<6>LAPIC (acpi_id[0x000d] id[0x9] enabled[0])
<6>CPU 12 (0x0900) disabled
<6>LAPIC (acpi_id[0x000e] id[0xb] enabled[0])
<6>CPU 13 (0x0b00) disabled
<6>LAPIC (acpi_id[0x000f] id[0xd] enabled[0])
<6>CPU 14 (0x0d00) disabled
<6>LAPIC (acpi_id[0x0010] id[0xf] enabled[0])
<6>CPU 15 (0x0f00) disabled
<6>IOAPIC (id[0x8] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC (id[0x9] address[0xfec01000] global_irq_base[0x10])
<6>IOAPIC (id[0xa] address[0xfec02000] global_irq_base[0x20])
<6>INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
<6>LAPIC_NMI (acpi_id[0x00ff] polarity[0x0] trigger[0x0] lint[0x1])
<6>16 CPUs total
<6>Local APIC address fee00000
<4>__va_range(0xefff01e0, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff01e0, 0x58): idx=8 mapped at ffff6000
<6>ACPI table found: SRAT v1 [HP     P44      0.3]
<4>__va_range(0xefff0238, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff0238, 0x50): idx=8 mapped at ffff6000
<6>ACPI table found: SPCR v1 [HP     P44      0.1]
<4>__va_range(0xefff8000, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff8000, 0x4fae): idx=8 mapped at ffff6000
<6>ACPI table found: SSDT v1 [HP     P44      0.2]
<4>Enabling the CPU's according to the ACPI table
<4>Intel MultiProcessor Specification v1.4
<4>    Virtual Wire compatibility mode.
<4>OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
<4>I/O APIC #8 Version 17 at 0xFEC00000.
<4>I/O APIC #9 Version 17 at 0xFEC01000.
<4>I/O APIC #10 Version 17 at 0xFEC02000.
<4>Enabling APIC mode: Flat.	Using 3 I/O APICs
<4>Processors: 8
<4>Kernel command line: root=/dev/cciss/c0d0p1  ide=nodma apm=off acpi=off  
<6>ide_setup: ide=nodma : Prevented DMA
<6>Initializing CPU#0
<4>Detected 1999.320 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 3984.58 BogoMIPS
<6>Memory: 4138352k/4456444k available (1594k kernel code, 55496k reserved, 397k data, 500k init, 3276732k highmem)
<6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<4>Buffer-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>per-CPU timeslice cutoff: 1462.74 usecs.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/2 eip 2000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 2/4 eip 2000
<6>Initializing CPU#2
<4>masked ExtINT on CPU#2
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#2.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 3/6 eip 2000
<6>Initializing CPU#3
<4>masked ExtINT on CPU#3
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#3.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 4/8 eip 2000
<6>Initializing CPU#4
<4>masked ExtINT on CPU#4
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#4.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU4: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 5/10 eip 2000
<6>Initializing CPU#5
<4>masked ExtINT on CPU#5
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#5.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU5: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 6/12 eip 2000
<6>Initializing CPU#6
<4>masked ExtINT on CPU#6
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#6.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU6: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 7/14 eip 2000
<6>Initializing CPU#7
<4>masked ExtINT on CPU#7
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#7.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU7: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<6>Total of 8 processors activated (31968.46 BogoMIPS).
<4>ENABLING IO-APIC IRQs
<3>BIOS bug, IO-APIC#0 ID 8 is already used!...
<3>... fixing up to 1. (tell your hw vendor)
<6>...changing IO-APIC physical APIC ID to 1 ... ok.
<4>Setting 9 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 9 ... ok.
<3>BIOS bug, IO-APIC#2 ID 10 is already used!...
<3>... fixing up to 3. (tell your hw vendor)
<6>...changing IO-APIC physical APIC ID to 3 ... ok.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 1-0, 1-3, 1-5, 1-7, 1-11, 3-1, 3-2, 3-4 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 68.
<7>number of IO-APIC #1 registers: 16.
<7>number of IO-APIC #9 registers: 16.
<7>number of IO-APIC #3 registers: 16.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #1......
<7>.... register #00: 01000000
<7>.......    : physical APIC id: 01
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 01000000
<7>.......     : arbitration: 01
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 0FF 0F  0    0    0   0   0    1    1    39
<7> 02 0FF 0F  0    0    0   0   0    1    1    31
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 0FF 0F  0    0    0   0   0    1    1    41
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 0FF 0F  0    0    0   0   0    1    1    49
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 0FF 0F  0    0    0   0   0    1    1    51
<7> 09 0FF 0F  1    1    0   1   0    1    1    59
<7> 0a 0FF 0F  1    1    0   1   0    1    1    61
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 0FF 0F  0    0    0   0   0    1    1    69
<7> 0d 0FF 0F  1    1    0   1   0    1    1    71
<7> 0e 0FF 0F  0    0    0   0   0    1    1    79
<7> 0f 0FF 0F  0    0    0   0   0    1    1    81
<4>
<7>IO APIC #9......
<7>.... register #00: 09000000
<7>.......    : physical APIC id: 09
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 09000000
<7>.......     : arbitration: 09
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 0FF 0F  1    1    0   1   0    1    1    89
<7> 01 0FF 0F  1    1    0   1   0    1    1    91
<7> 02 0FF 0F  1    1    0   1   0    1    1    99
<7> 03 0FF 0F  1    1    0   1   0    1    1    A1
<7> 04 0FF 0F  1    1    0   1   0    1    1    A9
<7> 05 0FF 0F  1    1    0   1   0    1    1    B1
<7> 06 0FF 0F  1    1    0   1   0    1    1    B9
<7> 07 0FF 0F  1    1    0   1   0    1    1    C1
<7> 08 0FF 0F  1    1    0   1   0    1    1    C9
<7> 09 0FF 0F  1    1    0   1   0    1    1    D1
<7> 0a 0FF 0F  1    1    0   1   0    1    1    D9
<7> 0b 0FF 0F  1    1    0   1   0    1    1    E1
<7> 0c 0FF 0F  1    1    0   1   0    1    1    E9
<7> 0d 0FF 0F  1    1    0   1   0    1    1    32
<7> 0e 0FF 0F  1    1    0   1   0    1    1    3A
<7> 0f 0FF 0F  1    1    0   1   0    1    1    42
<4>
<7>IO APIC #3......
<7>.... register #00: 03000000
<7>.......    : physical APIC id: 03
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 03000000
<7>.......     : arbitration: 03
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 0FF 0F  1    1    0   1   0    1    1    4A
<7> 01 000 00  1    0    0   0   0    0    0    00
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 0FF 0F  1    1    0   1   0    1    1    52
<7> 04 000 00  1    0    0   0   0    0    0    00
<7> 05 0FF 0F  1    1    0   1   0    1    1    5A
<7> 06 0FF 0F  1    1    0   1   0    1    1    62
<7> 07 0FF 0F  1    1    0   1   0    1    1    6A
<7> 08 0FF 0F  1    1    0   1   0    1    1    72
<7> 09 0FF 0F  1    1    0   1   0    1    1    7A
<7> 0a 0FF 0F  1    1    0   1   0    1    1    82
<7> 0b 0FF 0F  1    1    0   1   0    1    1    8A
<7> 0c 0FF 0F  1    1    0   1   0    1    1    92
<7> 0d 0FF 0F  1    1    0   1   0    1    1    9A
<7> 0e 0FF 0F  1    1    0   1   0    1    1    A2
<7> 0f 0FF 0F  1    1    0   1   0    1    1    AA
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ4 -> 0:4
<7>IRQ6 -> 0:6
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 1:0
<7>IRQ17 -> 1:1
<7>IRQ18 -> 1:2
<7>IRQ19 -> 1:3
<7>IRQ20 -> 1:4
<7>IRQ21 -> 1:5
<7>IRQ22 -> 1:6
<7>IRQ23 -> 1:7
<7>IRQ24 -> 1:8
<7>IRQ25 -> 1:9
<7>IRQ26 -> 1:10
<7>IRQ27 -> 1:11
<7>IRQ28 -> 1:12
<7>IRQ29 -> 1:13
<7>IRQ30 -> 1:14
<7>IRQ31 -> 1:15
<7>IRQ32 -> 2:0
<7>IRQ35 -> 2:3
<7>IRQ37 -> 2:5
<7>IRQ38 -> 2:6
<7>IRQ39 -> 2:7
<7>IRQ40 -> 2:8
<7>IRQ41 -> 2:9
<7>IRQ42 -> 2:10
<7>IRQ43 -> 2:11
<7>IRQ44 -> 2:12
<7>IRQ45 -> 2:13
<7>IRQ46 -> 2:14
<7>IRQ47 -> 2:15
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1999.2879 MHz.
<4>..... host bus clock speed is 99.9641 MHz.
<4>cpu: 0, clocks: 999641, slice: 111071
<4>CPU0<T0:999632,T1:888560,D:1,S:111071,C:999641>
<4>cpu: 2, clocks: 999641, slice: 111071
<4>cpu: 3, clocks: 999641, slice: 111071
<4>cpu: 1, clocks: 999641, slice: 111071
<4>cpu: 7, clocks: 999641, slice: 111071
<4>cpu: 4, clocks: 999641, slice: 111071
<4>cpu: 6, clocks: 999641, slice: 111071
<4>cpu: 5, clocks: 999641, slice: 111071
<4>CPU1<T0:999632,T1:777488,D:2,S:111071,C:999641>
<4>CPU2<T0:999632,T1:666416,D:3,S:111071,C:999641>
<4>CPU3<T0:999632,T1:555344,D:4,S:111071,C:999641>
<4>CPU5<T0:999632,T1:333200,D:6,S:111071,C:999641>
<4>CPU4<T0:999632,T1:444272,D:5,S:111071,C:999641>
<4>CPU6<T0:999632,T1:222128,D:7,S:111071,C:999641>
<4>CPU7<T0:999632,T1:111056,D:8,S:111071,C:999641>
<4>checking TSC synchronization across CPUs: 
<4>BIOS BUG: CPU#0 improperly initialized, has -2 usecs TSC skew! FIXED.
<4>BIOS BUG: CPU#2 improperly initialized, has -2 usecs TSC skew! FIXED.
<4>BIOS BUG: CPU#3 improperly initialized, has 4 usecs TSC skew! FIXED.
<4>BIOS BUG: CPU#6 improperly initialized, has 2 usecs TSC skew! FIXED.
<4>Waiting on wait_init_idle (map = 0xfe)
<4>All processors have done init_idle
<6>PCI: PCI BIOS revision 2.10 entry at 0xf1135, last bus=22
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<6>PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
<6>PCI: Discovered primary peer bus 03 [IRQ]
<6>PCI: Discovered primary peer bus 07 [IRQ]
<6>PCI: Discovered primary peer bus 0b [IRQ]
<6>PCI: Discovered primary peer bus 0f [IRQ]
<6>PCI: Discovered primary peer bus 13 [IRQ]
<6>PCI->APIC IRQ transform: (B0,I12,P0) -> 37
<6>PCI->APIC IRQ transform: (B0,I13,P0) -> 41
<6>PCI->APIC IRQ transform: (B0,I14,P0) -> 40
<6>PCI->APIC IRQ transform: (B0,I15,P0) -> 10
<6>PCI->APIC IRQ transform: (B0,I16,P0) -> 39
<6>PCI->APIC IRQ transform: (B0,I16,P1) -> 32
<6>PCI->APIC IRQ transform: (B0,I16,P2) -> 38
<6>PCI->APIC IRQ transform: (B0,I30,P0) -> 35
<6>PCI->APIC IRQ transform: (B3,I2,P0) -> 43
<6>PCI->APIC IRQ transform: (B3,I30,P0) -> 35
<6>PCI->APIC IRQ transform: (B7,I30,P0) -> 35
<6>PCI->APIC IRQ transform: (B11,I30,P0) -> 35
<6>PCI->APIC IRQ transform: (B15,I30,P0) -> 35
<6>PCI->APIC IRQ transform: (B19,I30,P0) -> 35
<4>PCI: Device 00:78 not found by BIOS
<4>PCI: Device 00:7b not found by BIOS
<4>PCI: Device 00:b8 not found by BIOS
<4>PCI: Device 00:c0 not found by BIOS
<4>PCI: Device 00:c2 not found by BIOS
<4>PCI: Device 00:c4 not found by BIOS
<4>PCI: Device 00:c6 not found by BIOS
<4>PCI: Device 00:c8 not found by BIOS
<4>PCI: Device 00:ca not found by BIOS
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a National Semiconductor PC87306
<6>loop: loaded (max 8 devices)
<6>HP CISS Driver (v 2.4.42)
<7>cciss: Device 0xb178 has been found at bus 0 dev 14 func 0
<4>cciss: using DAC cycles
<6>      blocks= 35553120 block_size= 512
<6>      heads= 255, sectors= 32, cylinders= 4357 RAID 1(0+1)
<4>
<6>      blocks= 35553120 block_size= 512
<6>      heads= 255, sectors= 32, cylinders= 4357 RAID 1(0+1)
<4>
<4>blk: queue c03d1000, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<6>Partition check:
<6> cciss/c0d0: p1 p2 p3 p4 < p5 p6 >
<6> cciss/c0d1: p1
<6>tg3.c:v1.5 (March 21, 2003)
<6>eth0: Tigon3 [partno(284685-003) rev 0105 PHY(5701)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:cd:52:3d:68
<6>bonding.c:v2.4.20-20030320 (March 20, 2003)
<3>bonding_init(): either miimon or arp_interval and arp_ip_target module parameters must be specified, otherwise bonding will not detect link failures! see bonding.txt for details.
<6>bond0 registered without MII link monitoring, in load balancing (round-robin) mode.
<6>bond0 registered without ARP monitoring
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 203M
<7>agpgart: no supported devices found.
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>SvrWks CSB5: IDE controller at PCI slot 00:0f.1
<6>SvrWks CSB5: chipset revision 147
<6>SvrWks CSB5: not 100%% native mode: will probe irqs later
<6>SvrWks CSB5: simplex device: DMA forced
<6>    ide0: BM-DMA at 0x2820-0x2827, BIOS settings: hda:pio, hdb:pio
<6>SvrWks CSB5: simplex device: DMA forced
<6>    ide1: BM-DMA at 0x2828-0x282f, BIOS settings: hdc:pio, hdd:pio
<4>hda: COMPAQ CD-ROM SN-124, ATAPI CD/DVD-ROM drive
<4>hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
<4>hda: set_drive_speed_status: error=0x04
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hda: attached ide-cdrom driver.
<6>hda: ATAPI 24X CD-ROM drive, 128kB Cache
<6>Uniform CD-ROM driver Revision: 3.12
<6>SCSI subsystem driver Revision: 1.00
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 65536 buckets, 512Kbytes
<6>TCP: Hash tables configured (established 262144 bind 65536)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>reiserfs: checking transaction log (device 68:01) ...
<4>reiserfs: replayed 6 transactions in 0 seconds
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 500k freed
<6>Adding Swap: 2097136k swap-space (priority 42)
<4>reiserfs: checking transaction log (device 68:11) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 68:06) ...
<4>reiserfs: replayed 3 transactions in 0 seconds
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 68:02) ...
<4>reiserfs: replayed 5 transactions in 0 seconds
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 68:03) ...
<4>reiserfs: replayed 3 transactions in 0 seconds
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25

--------------------------------------------------------------------
Of course I've seen the messages:
<3>BIOS bug, IO-APIC#0 ID 8 is already used!...
<3>... fixing up to 1. (tell your hw vendor)

This is where without noapic the system hangs in HT mode.
are they better solutions to allow HT to work than noapic ?

--------------------------------------------------------------------
boot.log (8 CPU - with noapic which is the potion used for HT)

Inspecting /boot/System.map
Loaded 18066 symbols from /boot/System.map.
Symbols match kernel version 2.4.21.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.21 (root@linux) (gcc version 3.2) #3 SMP Tue Jun 17 17:32:56 CEST 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
<4> BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
<4> BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
<4> BIOS-e820: 0000000100000000 - 000000010ffff000 (usable)
<5>3455MB HIGHMEM available.
<5>896MB LOWMEM available.
<4>found SMP MP-table at 000f4fd0
<4>hm, page 000f4000 reserved twice.
<4>hm, page 000f5000 reserved twice.
<4>hm, page 000f7000 reserved twice.
<4>hm, page 000f8000 reserved twice.
<4>On node 0 totalpages: 1114111
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 884735 pages.
<6>ACPI: Searched entire block, no RSDP was found.
<6>ACPI: RSDP located at physical address c00f4f70
<6>RSD PTR  v0 [HP    ]
<4>__va_range(0xefff0000, 0x68): idx=8 mapped at ffff6000
<6>ACPI table found: RSDT v1 [HP     P44      0.1]
<4>__va_range(0xefff0040, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff0040, 0x74): idx=8 mapped at ffff6000
<6>ACPI table found: FACP v1 [HP     P44      0.1]
<4>__va_range(0xefff0100, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff0100, 0xe0): idx=8 mapped at ffff6000
<6>ACPI table found: APIC v1 [HP     P44      0.1]
<4>__va_range(0xefff0100, 0xe0): idx=8 mapped at ffff6000
<6>LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
<6>CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
<6>CPU 1 (0x0200) enabledProcessor #2 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0003] id[0x4] enabled[1])
<6>CPU 2 (0x0400) enabledProcessor #4 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0004] id[0x6] enabled[1])
<6>CPU 3 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0005] id[0x8] enabled[1])
<6>CPU 4 (0x0800) enabledProcessor #8 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0006] id[0xa] enabled[1])
<6>CPU 5 (0x0a00) enabledProcessor #10 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0007] id[0xc] enabled[1])
<6>CPU 6 (0x0c00) enabledProcessor #12 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0008] id[0xe] enabled[1])
<6>CPU 7 (0x0e00) enabledProcessor #14 Pentium 4(tm) XEON(tm) APIC version 16
<4>
<6>LAPIC (acpi_id[0x0009] id[0x1] enabled[0])
<6>CPU 8 (0x0100) disabled
<6>LAPIC (acpi_id[0x000a] id[0x3] enabled[0])
<6>CPU 9 (0x0300) disabled
<6>LAPIC (acpi_id[0x000b] id[0x5] enabled[0])
<6>CPU 10 (0x0500) disabled
<6>LAPIC (acpi_id[0x000c] id[0x7] enabled[0])
<6>CPU 11 (0x0700) disabled
<6>LAPIC (acpi_id[0x000d] id[0x9] enabled[0])
<6>CPU 12 (0x0900) disabled
<6>LAPIC (acpi_id[0x000e] id[0xb] enabled[0])
<6>CPU 13 (0x0b00) disabled
<6>LAPIC (acpi_id[0x000f] id[0xd] enabled[0])
<6>CPU 14 (0x0d00) disabled
<6>LAPIC (acpi_id[0x0010] id[0xf] enabled[0])
<6>CPU 15 (0x0f00) disabled
<6>IOAPIC (id[0x8] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC (id[0x9] address[0xfec01000] global_irq_base[0x10])
<6>IOAPIC (id[0xa] address[0xfec02000] global_irq_base[0x20])
<6>INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
<6>LAPIC_NMI (acpi_id[0x00ff] polarity[0x0] trigger[0x0] lint[0x1])
<6>16 CPUs total
<6>Local APIC address fee00000
<4>__va_range(0xefff01e0, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff01e0, 0x58): idx=8 mapped at ffff6000
<6>ACPI table found: SRAT v1 [HP     P44      0.3]
<4>__va_range(0xefff0238, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff0238, 0x50): idx=8 mapped at ffff6000
<6>ACPI table found: SPCR v1 [HP     P44      0.1]
<4>__va_range(0xefff8000, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xefff8000, 0x4fae): idx=8 mapped at ffff6000
<6>ACPI table found: SSDT v1 [HP     P44      0.2]
<4>Enabling the CPU's according to the ACPI table
<4>Intel MultiProcessor Specification v1.4
<4>    Virtual Wire compatibility mode.
<4>OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
<4>I/O APIC #8 Version 17 at 0xFEC00000.
<4>I/O APIC #9 Version 17 at 0xFEC01000.
<4>I/O APIC #10 Version 17 at 0xFEC02000.
<4>Enabling APIC mode: Flat.	Using 3 I/O APICs
<4>Processors: 8
<4>Kernel command line: root=/dev/cciss/c0d0p1  ide=nodma apm=off acpi=off  noapic
<6>ide_setup: ide=nodma : Prevented DMA
<6>Initializing CPU#0
<4>Detected 1999.339 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 3984.58 BogoMIPS
<6>Memory: 4138352k/4456444k available (1594k kernel code, 55496k reserved, 397k data, 500k init, 3276732k highmem)
<6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<4>Buffer-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>per-CPU timeslice cutoff: 1462.74 usecs.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/2 eip 2000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 2/4 eip 2000
<6>Initializing CPU#2
<4>masked ExtINT on CPU#2
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#2.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 3/6 eip 2000
<6>Initializing CPU#3
<4>masked ExtINT on CPU#3
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#3.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 4/8 eip 2000
<6>Initializing CPU#4
<4>masked ExtINT on CPU#4
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#4.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU4: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 5/10 eip 2000
<6>Initializing CPU#5
<4>masked ExtINT on CPU#5
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#5.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU5: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 6/12 eip 2000
<6>Initializing CPU#6
<4>masked ExtINT on CPU#6
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#6.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU6: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<4>Booting processor 7/14 eip 2000
<6>Initializing CPU#7
<4>masked ExtINT on CPU#7
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3997.69 BogoMIPS
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 2048K
<6>CPU: Hyper-Threading is disabled
<6>Intel machine check reporting enabled on CPU#7.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU7: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
<6>Total of 8 processors activated (31968.46 BogoMIPS).
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1999.3407 MHz.
<4>..... host bus clock speed is 99.9668 MHz.
<4>cpu: 0, clocks: 999668, slice: 111074
<4>CPU0<T0:999664,T1:888576,D:14,S:111074,C:999668>
<4>cpu: 2, clocks: 999668, slice: 111074
<4>cpu: 1, clocks: 999668, slice: 111074
<4>cpu: 3, clocks: 999668, slice: 111074
<4>cpu: 6, clocks: 999668, slice: 111074
<4>cpu: 7, clocks: 999668, slice: 111074
<4>cpu: 5, clocks: 999668, slice: 111074
<4>cpu: 4, clocks: 999668, slice: 111074
<4>CPU1<T0:999664,T1:777504,D:12,S:111074,C:999668>
<4>CPU3<T0:999664,T1:555360,D:8,S:111074,C:999668>
<4>CPU2<T0:999664,T1:666432,D:10,S:111074,C:999668>
<4>CPU4<T0:999664,T1:444288,D:6,S:111074,C:999668>
<4>CPU7<T0:999664,T1:111072,D:0,S:111074,C:999668>
<4>CPU5<T0:999664,T1:333216,D:4,S:111074,C:999668>
<4>CPU6<T0:999664,T1:222144,D:2,S:111074,C:999668>
<4>checking TSC synchronization across CPUs: 
<4>BIOS BUG: CPU#0 improperly initialized, has -3 usecs TSC skew! FIXED.
<4>BIOS BUG: CPU#1 improperly initialized, has -2 usecs TSC skew! FIXED.
<4>BIOS BUG: CPU#3 improperly initialized, has 7 usecs TSC skew! FIXED.
<4>BIOS BUG: CPU#6 improperly initialized, has -2 usecs TSC skew! FIXED.
<4>Waiting on wait_init_idle (map = 0xfe)
<4>All processors have done init_idle
<6>PCI: PCI BIOS revision 2.10 entry at 0xf1135, last bus=22
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<6>PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
<6>PCI: Discovered primary peer bus 03 [IRQ]
<6>PCI: Discovered primary peer bus 07 [IRQ]
<6>PCI: Discovered primary peer bus 0b [IRQ]
<6>PCI: Discovered primary peer bus 0f [IRQ]
<6>PCI: Discovered primary peer bus 13 [IRQ]
<4>PCI: Device 00:78 not found by BIOS
<4>PCI: Device 00:7b not found by BIOS
<4>PCI: Device 00:b8 not found by BIOS
<4>PCI: Device 00:c0 not found by BIOS
<4>PCI: Device 00:c2 not found by BIOS
<4>PCI: Device 00:c4 not found by BIOS
<4>PCI: Device 00:c6 not found by BIOS
<4>PCI: Device 00:c8 not found by BIOS
<4>PCI: Device 00:ca not found by BIOS
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a National Semiconductor PC87306
<6>loop: loaded (max 8 devices)
<6>HP CISS Driver (v 2.4.42)
<7>cciss: Device 0xb178 has been found at bus 0 dev 14 func 0
<4>cciss: using DAC cycles
<6>      blocks= 35553120 block_size= 512
<6>      heads= 255, sectors= 32, cylinders= 4357 RAID 1(0+1)
<4>
<6>      blocks= 35553120 block_size= 512
<6>      heads= 255, sectors= 32, cylinders= 4357 RAID 1(0+1)
<4>
<4>blk: queue c03d1000, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<6>Partition check:
<6> cciss/c0d0: p1 p2 p3 p4 < p5 p6 >
<6> cciss/c0d1: p1
<6>tg3.c:v1.5 (March 21, 2003)
<6>eth0: Tigon3 [partno(284685-003) rev 0105 PHY(5701)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0b:cd:52:3d:68
<6>bonding.c:v2.4.20-20030320 (March 20, 2003)
<3>bonding_init(): either miimon or arp_interval and arp_ip_target module parameters must be specified, otherwise bonding will not detect link failures! see bonding.txt for details.
<6>bond0 registered without MII link monitoring, in load balancing (round-robin) mode.
<6>bond0 registered without ARP monitoring
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 203M
<7>agpgart: no supported devices found.
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>SvrWks CSB5: IDE controller at PCI slot 00:0f.1
<6>SvrWks CSB5: chipset revision 147
<6>SvrWks CSB5: not 100%% native mode: will probe irqs later
<6>SvrWks CSB5: simplex device: DMA forced
<6>    ide0: BM-DMA at 0x2820-0x2827, BIOS settings: hda:pio, hdb:pio
<6>SvrWks CSB5: simplex device: DMA forced
<6>    ide1: BM-DMA at 0x2828-0x282f, BIOS settings: hdc:pio, hdd:pio
<4>hda: COMPAQ CD-ROM SN-124, ATAPI CD/DVD-ROM drive
<4>hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
<4>hda: set_drive_speed_status: error=0x04
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hda: attached ide-cdrom driver.
<6>hda: ATAPI 24X CD-ROM drive, 128kB Cache
<6>Uniform CD-ROM driver Revision: 3.12
<6>SCSI subsystem driver Revision: 1.00
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 65536 buckets, 512Kbytes
<6>TCP: Hash tables configured (established 262144 bind 65536)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>reiserfs: checking transaction log (device 68:01) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 500k freed
<6>Adding Swap: 2097136k swap-space (priority 42)
<4>reiserfs: checking transaction log (device 68:11) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 68:06) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 68:02) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 68:03) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
--------------------------------------------------------------------
I've also messages like this one in /var/log/messages:
Jun 17 17:49:24 linux kernel: mtrr: type mismatch for f6000000,800000 old: write-back new: write-combining
--------------------------------------------------------------------

Let me know if I need to send other logs from the system. 
Any hint to help me solve the issue would be welcome.

Thanks in advance,
Bruno.
-- 
Linux Solution Consultant         Tél: +33 476 143 278 - Fax: +33 476 146 105
HP/Intel Solution Center http://hpintelco.net Hewlett-Packard Grenoble/France
Des infos sur Linux?  http://www.HyPer-Linux.org      http://www.hp.com/linux
La musique ancienne?  http://www.musique-ancienne.org http://www.medieval.org
