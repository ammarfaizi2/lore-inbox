Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTHUP5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTHUP5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:57:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52651 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262708AbTHUP5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:57:14 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Date: Thu, 21 Aug 2003 10:56:29 -0500
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308210910.07722.habanero@us.ibm.com> <1061477929.18883.1633.camel@nighthawk>
In-Reply-To: <1061477929.18883.1633.camel@nighthawk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tuOR/oUMGnxVdmR"
Message-Id: <200308211056.29876.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tuOR/oUMGnxVdmR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 21 August 2003 09:58, Dave Hansen wrote:
> On Thu, 2003-08-21 at 07:10, Andrew Theurer wrote:
> > So we only loop for the actual number processors found in mpparse.c? 
> > This seems to work for me.
>
> I think there's a reason it was done that way.  I think your patch
> breaks the visws subarch, too.
>
> Could you mark up that loop a bit and printk a bit, so we can see which
> continue you're missing?
>
> <pasting patch lazily in email because I can't be bothered to actually copy
> it from the machine I"m working on> diff -urp
> linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c
> linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c ---
> linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c  Wed Aug 20 19:54:29
> 2003 +++ linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c   Wed Aug 20
> 20:19:41 2003 @@ -1020,24 +1020,30 @@ static void __init
> smp_boot_cpus(unsigne
>         Dprintk("CPU present map: %lx\n",
> physids_coerce(phys_cpu_present_map));
>
>         kicked = 1;
> -       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
> +       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++, kicked++)

This patch (plus your first one) seems to work.  Perhaps the addition of 
kicked++ above helped?  Attached is the boot log.



--Boundary-00=_tuOR/oUMGnxVdmR
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.6.0-test3-bk8 (root@x4408way2) (gcc version 3.2.2) #1 SMP Thu Aug 21 12:21:15 CDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dffb6ec0 (usable)
 BIOS-e820: 00000000dffb6ec0 - 00000000dffbf800 (ACPI data)
 BIOS-e820: 00000000dffbf800 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000320000000 (usable)
get_memcfg_from_srat: assigning address to rsdp
RSD PTR  v0 [IBM   ]
Begin table scan....
CPU 0x00 in proximity domain 0x00
CPU 0x02 in proximity domain 0x00
CPU 0x10 in proximity domain 0x00
CPU 0x12 in proximity domain 0x00
CPU 0x20 in proximity domain 0x01
CPU 0x22 in proximity domain 0x01
CPU 0x30 in proximity domain 0x01
CPU 0x32 in proximity domain 0x01
CPU 0x01 in proximity domain 0x00
CPU 0x03 in proximity domain 0x00
CPU 0x11 in proximity domain 0x00
CPU 0x13 in proximity domain 0x00
CPU 0x21 in proximity domain 0x01
CPU 0x23 in proximity domain 0x01
CPU 0x31 in proximity domain 0x01
CPU 0x33 in proximity domain 0x01
Memory range 0x0 to 0xE0000 (type 0x1) in proximity domain 0x00 enabled
Memory range 0x100000 to 0x220000 (type 0x1) in proximity domain 0x00 enabled
Memory range 0x220000 to 0x320000 (type 0x1) in proximity domain 0x01 enabled
acpi20_parse_srat: Entry length value is zero; can't parse any further!
pxm bitmap: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
Number of logical nodes in system = 2
Number of memory chunks in system = 3
chunk 0 nid 0 start_pfn 00000000 end_pfn 000e0000
chunk 1 nid 0 start_pfn 00100000 end_pfn 00220000
chunk 2 nid 1 start_pfn 00220000 end_pfn 00320000
Reserving 11776 pages of KVA for lmem_map of node 1
Shrinking node 1 from 3276800 pages to 3265024 pages
Reserving total of 11776 pages for numa KVA remap
11904MB HIGHMEM available.
850MB LOWMEM available.
min_low_pfn = 1445, max_low_pfn = 217600, highstart_pfn = 229376
Low memory ends at vaddr f5200000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f5200000 - f8000000
High memory starts at vaddr f8000000
ACPI: S3 and PAE do not like each other for now, S3 disabled.
found SMP MP-table at 0009dd40
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 2097152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 213504 pages, LIFO batch:16
  HighMem zone: 1879552 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash
On node 1 totalpages: 1036800
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1036800 pages, LIFO batch:16
DMI 2.3 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
IBM eserver xSeries 440 detected: force use of acpi=ht
ACPI: RSDP (v000 IBM                                       ) @ 0x000fdba0
ACPI: RSDT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf780
ACPI: FADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf700
ACPI: MADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf580
ACPI: SRAT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf3c0
ACPI: DSDT (v001 IBM    SERVIGIL 0x00001000 INTL 0x02002025) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x10] enabled)
Processor #16 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
Processor #18 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x20] enabled)
Processor #32 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x22] enabled)
Processor #34 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x30] enabled)
Processor #48 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x32] enabled)
Processor #50 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x11] enabled)
Processor #17 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x13] enabled)
Processor #19 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x21] enabled)
Processor #33 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x23] enabled)
Processor #35 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x31] enabled)
Processor #49 15:1 APIC version 20
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x33] enabled)
Processor #51 15:1 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x09] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0a] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0b] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0c] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0d] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0e] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0f] polarity[0x0] trigger[0x0] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: VIGIL SMP    APIC at: 0xFEE00000
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Enabling APIC mode:  Summit.  Using 2 I/O APICs
Processors: 16
Building zonelist for node : 0
Building zonelist for node : 1
Kernel command line: ro root=/dev/sda7 console=ttyS0,38400n8
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Summit chipset: Starting Cyclone Counter.
Detected 1498.538 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 193.02 BogoMIPS
Initializing highpages for node 0
Initializing highpages for node 1
Memory: 12431384k/13107200k available (3113k kernel code, 102620k reserved, 1120k data, 204k init, 11665112k highmem)
Dentry cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Genuine CPU 1.50GHz stepping 01
per-CPU timeslice cutoff: 731.48 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Mapping cpu 0 to node 0
smp_boot_cpus() bit: 0
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 1
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 2
Booting processor 2/16 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 3
Booting processor 3/18 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 3
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 4
Booting processor 4/32 eip 2000
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#4.
CPU#4: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#4: Thermal monitoring enabled
CPU4: Intel(R) Genuine CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 5
Booting processor 5/34 eip 2000
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#5.
CPU#5: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#5: Thermal monitoring enabled
CPU5: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 6
Booting processor 6/48 eip 2000
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 10
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#6.
CPU#6: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#6: Thermal monitoring enabled
CPU6: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 7
Booting processor 7/50 eip 2000
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 11
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#7.
CPU#7: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#7: Thermal monitoring enabled
CPU7: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 8
Booting processor 8/1 eip 2000
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#8.
CPU#8: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#8: Thermal monitoring enabled
CPU8: Intel(R) Genuine CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 9
Booting processor 9/3 eip 2000
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#9.
CPU#9: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#9: Thermal monitoring enabled
CPU9: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 10
Booting processor 10/17 eip 2000
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#10.
CPU#10: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#10: Thermal monitoring enabled
CPU10: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 11
Booting processor 11/19 eip 2000
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 3
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#11.
CPU#11: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#11: Thermal monitoring enabled
CPU11: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 12
Booting processor 12/33 eip 2000
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#12.
CPU#12: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#12: Thermal monitoring enabled
CPU12: Intel(R) Genuine CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 13
Booting processor 13/35 eip 2000
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#13.
CPU#13: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#13: Thermal monitoring enabled
CPU13: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 14
Booting processor 14/49 eip 2000
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 10
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#14.
CPU#14: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#14: Thermal monitoring enabled
CPU14: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 15
Booting processor 15/51 eip 2000
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 11
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#15.
CPU#15: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#15: Thermal monitoring enabled
CPU15: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
Total of 16 processors activated (3177.98 BogoMIPS).
cpu_sibling_map[0] = 8
cpu_sibling_map[1] = 9
cpu_sibling_map[2] = 10
cpu_sibling_map[3] = 11
cpu_sibling_map[4] = 12
cpu_sibling_map[5] = 13
cpu_sibling_map[6] = 14
cpu_sibling_map[7] = 15
cpu_sibling_map[8] = 0
cpu_sibling_map[9] = 1
cpu_sibling_map[10] = 2
cpu_sibling_map[11] = 3
cpu_sibling_map[12] = 4
cpu_sibling_map[13] = 5
cpu_sibling_map[14] = 6
cpu_sibling_map[15] = 7
ENABLING IO-APIC IRQs
Setting 14 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 14 ... ok.
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 14-2, 14-3, 14-5, 14-7, 14-9, 14-10, 14-11, 14-15, 14-17, 14-20, 14-21, 14-22, 14-23, 14-24, 14-25, 14-26, 14-27, 14-28, 14-29, 14-30, 14-31, 14-32, 14-33, 14-34, 14-35, 14-36, 14-37, 14-38, 14-43, 14-44, 14-45, 14-46, 14-47, 14-48, 14-49, 14-50, 13-24, 13-25, 13-26, 13-27, 13-28, 13-29, 13-30, 13-31, 13-32, 13-33, 13-34, 13-35, 13-36, 13-37, 13-38, 13-39, 13-40, 13-41, 13-42, 13-43, 13-44, 13-45, 13-46, 13-47, 13-48, 13-49, 13-50 not connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
number of MP IRQ sources: 39.
number of IO-APIC #14 registers: 51.
number of IO-APIC #13 registers: 51.
testing the IO APIC.......................
IO APIC #14......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00320011
.......     : max redirection entries: 0032
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 0FF 0F  0    0    0   0   0    1    0    31
 01 0FF 0F  0    0    0   0   0    1    0    39
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 0FF 0F  0    0    0   0   0    1    0    41
 05 000 00  1    0    0   0   0    0    0    00
 06 0FF 0F  0    0    0   0   0    1    0    49
 07 000 00  1    0    0   0   0    0    0    00
 08 0FF 0F  0    0    0   1   0    1    0    51
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  0    0    0   0   0    1    0    59
 0d 0FF 0F  0    0    0   0   0    1    0    61
 0e 0FF 0F  0    0    0   0   0    1    0    69
 0f 000 00  1    0    0   0   0    0    0    00
 10 0FF 0F  1    1    0   1   0    1    0    71
 11 000 00  1    0    0   0   0    0    0    00
 12 0FF 0F  1    1    0   1   0    1    0    79
 13 0FF 0F  1    1    0   1   0    1    0    81
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
 18 000 00  1    0    0   0   0    0    0    00
 19 000 00  1    0    0   0   0    0    0    00
 1a 000 00  1    0    0   0   0    0    0    00
 1b 000 00  1    0    0   0   0    0    0    00
 1c 000 00  1    0    0   0   0    0    0    00
 1d 000 00  1    0    0   0   0    0    0    00
 1e 000 00  1    0    0   0   0    0    0    00
 1f 000 00  1    0    0   0   0    0    0    00
 20 000 00  1    0    0   0   0    0    0    00
 21 000 00  1    0    0   0   0    0    0    00
 22 000 00  1    0    0   0   0    0    0    00
 23 000 00  1    0    0   0   0    0    0    00
 24 000 00  1    0    0   0   0    0    0    00
 25 000 00  1    0    0   0   0    0    0    00
 26 000 00  1    0    0   0   0    0    0    00
 27 0FF 0F  1    1    0   1   0    1    0    89
 28 0FF 0F  1    1    0   1   0    1    0    91
 29 0FF 0F  1    1    0   1   0    1    0    99
 2a 0FF 0F  1    1    0   1   0    1    0    A1
 2b 000 00  1    0    0   0   0    0    0    00
 2c 000 00  1    0    0   0   0    0    0    00
 2d 000 00  1    0    0   0   0    0    0    00
 2e 000 00  1    0    0   0   0    0    0    00
 2f 000 00  1    0    0   0   0    0    0    00
 30 000 00  1    0    0   0   0    0    0    00
 31 000 00  1    0    0   0   0    0    0    00
 32 000 00  1    0    0   0   0    0    0    00
IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00320011
.......     : max redirection entries: 0032
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 0FF 0F  1    1    0   1   0    1    0    A9
 01 0FF 0F  1    1    0   1   0    1    0    B1
 02 0FF 0F  1    1    0   1   0    1    0    B9
 03 0FF 0F  1    1    0   1   0    1    0    C1
 04 0FF 0F  1    1    0   1   0    1    0    C9
 05 0FF 0F  1    1    0   1   0    1    0    D1
 06 0FF 0F  1    1    0   1   0    1    0    D9
 07 0FF 0F  1    1    0   1   0    1    0    E1
 08 0FF 0F  1    1    0   1   0    1    0    E9
 09 0FF 0F  1    1    0   1   0    1    0    32
 0a 0FF 0F  1    1    0   1   0    1    0    3A
 0b 0FF 0F  1    1    0   1   0    1    0    42
 0c 0FF 0F  1    1    0   1   0    1    0    4A
 0d 0FF 0F  1    1    0   1   0    1    0    52
 0e 0FF 0F  1    1    0   1   0    1    0    5A
 0f 0FF 0F  1    1    0   1   0    1    0    62
 10 0FF 0F  1    1    0   1   0    1    0    6A
 11 0FF 0F  1    1    0   1   0    1    0    72
 12 0FF 0F  1    1    0   1   0    1    0    7A
 13 0FF 0F  1    1    0   1   0    1    0    82
 14 0FF 0F  1    1    0   1   0    1    0    8A
 15 0FF 0F  1    1    0   1   0    1    0    92
 16 0FF 0F  1    1    0   1   0    1    0    9A
 17 0FF 0F  1    1    0   1   0    1    0    A2
 18 000 00  1    0    0   0   0    0    0    00
 19 000 00  1    0    0   0   0    0    0    00
 1a 000 00  1    0    0   0   0    0    0    00
 1b 000 00  1    0    0   0   0    0    0    00
 1c 000 00  1    0    0   0   0    0    0    00
 1d 000 00  1    0    0   0   0    0    0    00
 1e 000 00  1    0    0   0   0    0    0    00
 1f 000 00  1    0    0   0   0    0    0    00
 20 000 00  1    0    0   0   0    0    0    00
 21 000 00  1    0    0   0   0    0    0    00
 22 000 00  1    0    0   0   0    0    0    00
 23 000 00  1    0    0   0   0    0    0    00
 24 000 00  1    0    0   0   0    0    0    00
 25 000 00  1    0    0   0   0    0    0    00
 26 000 00  1    0    0   0   0    0    0    00
 27 000 00  1    0    0   0   0    0    0    00
 28 000 00  1    0    0   0   0    0    0    00
 29 000 00  1    0    0   0   0    0    0    00
 2a 000 00  1    0    0   0   0    0    0    00
 2b 000 00  1    0    0   0   0    0    0    00
 2c 000 00  1    0    0   0   0    0    0    00
 2d 000 00  1    0    0   0   0    0    0    00
 2e 000 00  1    0    0   0   0    0    0    00
 2f 000 00  1    0    0   0   0    0    0    00
 30 000 00  1    0    0   0   0    0    0    00
 31 000 00  1    0    0   0   0    0    0    00
 32 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ39 -> 0:39
IRQ40 -> 0:40
IRQ41 -> 0:41
IRQ42 -> 0:42
IRQ51 -> 1:0
IRQ52 -> 1:1
IRQ53 -> 1:2
IRQ54 -> 1:3
IRQ55 -> 1:4
IRQ56 -> 1:5
IRQ57 -> 1:6
IRQ58 -> 1:7
IRQ59 -> 1:8
IRQ60 -> 1:9
IRQ61 -> 1:10
IRQ62 -> 1:11
IRQ63 -> 1:12
IRQ64 -> 1:13
IRQ65 -> 1:14
IRQ66 -> 1:15
IRQ67 -> 1:16
IRQ68 -> 1:17
IRQ69 -> 1:18
IRQ70 -> 1:19
IRQ71 -> 1:20
IRQ72 -> 1:21
IRQ73 -> 1:22
IRQ74 -> 1:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1496.0636 MHz.
..... host bus clock speed is 99.0775 MHz.
checking TSC synchronization across 16 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has 7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 7903473 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has -7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has -7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has -7903468 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has -7903468 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has 7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 7903468 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has -7903467 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has -7903470 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has -7903468 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has -7903468 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
CPU 4 IS NOW UP!
Starting migration thread for cpu 4
Bringing up 5
CPU 5 IS NOW UP!
Starting migration thread for cpu 5
Bringing up 6
CPU 6 IS NOW UP!
Starting migration thread for cpu 6
Bringing up 7
CPU 7 IS NOW UP!
Starting migration thread for cpu 7
Bringing up 8
CPU 8 IS NOW UP!
Starting migration thread for cpu 8
Bringing up 9
CPU 9 IS NOW UP!
Starting migration thread for cpu 9
Bringing up 10
CPU 10 IS NOW UP!
Starting migration thread for cpu 10
Bringing up 11
CPU 11 IS NOW UP!
Starting migration thread for cpu 11
Bringing up 12
CPU 12 IS NOW UP!
Starting migration thread for cpu 12
Bringing up 13
CPU 13 IS NOW UP!
Starting migration thread for cpu 13
Bringing up 14
CPU 14 IS NOW UP!
Starting migration thread for cpu 14
Bringing up 15
CPU 15 IS NOW UP!
Starting migration thread for cpu 15
CPUS done 32
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd30d, last bus=11
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [pm]
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:03.0
PM: Adding info for pci:0000:00:04.0
PM: Adding info for pci:0000:00:05.0
PM: Adding info for pci:0000:00:05.1
PM: Adding info for pci:0000:00:05.2
PM: Adding info for pci:0000:00:05.3
PM: Adding info for pci:0000:00:05.4
PCI: Discovered peer bus 01
PM: Adding info for No Bus:pci0000:01
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:03.0
PM: Adding info for pci:0000:01:03.1
PM: Adding info for pci:0000:01:04.0
PCI: Discovered peer bus 02
PM: Adding info for No Bus:pci0000:02
PM: Adding info for pci:0000:02:00.0
PCI: Discovered peer bus 05
PM: Adding info for No Bus:pci0000:05
PM: Adding info for pci:0000:05:00.0
PCI: Discovered peer bus 07
PM: Adding info for No Bus:pci0000:07
PM: Adding info for pci:0000:07:00.0
PCI: Discovered peer bus 09
PM: Adding info for No Bus:pci0000:09
PM: Adding info for pci:0000:09:00.0
PCI->APIC IRQ transform: (B0,I3,P0) -> 39
PCI->APIC IRQ transform: (B0,I4,P0) -> 16
PCI->APIC IRQ transform: (B0,I5,P3) -> 18
PCI->APIC IRQ transform: (B0,I5,P3) -> 18
PCI->APIC IRQ transform: (B1,I3,P0) -> 40
PCI->APIC IRQ transform: (B1,I3,P1) -> 41
PCI->APIC IRQ transform: (B1,I4,P0) -> 42
pty: 256 Unix98 ptys configured
Starting balanced_irq
Total HugeTLB memory allocated, 0
ikconfig 0.5 with /proc/ikconfig
highmem bounce pool size: 64 pages
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
SGI XFS for Linux with no debug enabled
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:05.2, from 7 to 2
PCI: Via IRQ fixup for 0000:00:05.3, from 7 to 2
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport_pc: Via 686A parallel port disabled in BIOS
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
reset set in interrupt, calling c0326f91
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.1.13-k2
Copyright (c) 1999-2003 Intel Corporation.
tg3.c:v1.9 (August 3, 2003)
eth0: Tigon3 [partno(BCM95700A6) rev 7102 PHY(5401)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:02:55:dc:0e:32
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

PM: Adding info for No Bus:host0
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

PM: Adding info for No Bus:host1
(scsi1:A:12): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: GNHv1 S2          Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
PM: Adding info for scsi:1:0:9:0
  Vendor: IBM-PSG   Model: DPSS-336950M  M   Rev: S9HA
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:12:0: Tagged Queuing enabled.  Depth 64
PM: Adding info for scsi:1:0:12:0
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi1, channel 0, id 12, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 9, lun 0,  type 3
Attached scsi generic sg1 at scsi1, channel 0, id 12, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 131072 buckets, 1024Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sda7) for (sda7)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding 2097136k swap on /dev/sda10.  Priority:42 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 100 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.

--Boundary-00=_tuOR/oUMGnxVdmR--

