Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbTHUREB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTHUREB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:04:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:55004 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262822AbTHURCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:02:53 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Date: Thu, 21 Aug 2003 12:02:02 -0500
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308211056.29876.habanero@us.ibm.com> <1061482159.19036.1716.camel@nighthawk>
In-Reply-To: <1061482159.19036.1716.camel@nighthawk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KsPR/p62gqUEFU+"
Message-Id: <200308211202.02871.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_KsPR/p62gqUEFU+
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 21 August 2003 11:09, Dave Hansen wrote:
> On Thu, 2003-08-21 at 08:56, Andrew Theurer wrote:
> > On Thursday 21 August 2003 09:58, Dave Hansen wrote:
> > > On Thu, 2003-08-21 at 07:10, Andrew Theurer wrote:
> > > > So we only loop for the actual number processors found in mpparse.c?
> > > > This seems to work for me.
> > >
> > > I think there's a reason it was done that way.  I think your patch
> > > breaks the visws subarch, too.
> > >
> > > Could you mark up that loop a bit and printk a bit, so we can see which
> > > continue you're missing?
> > >
> > > <pasting patch lazily in email because I can't be bothered to actually
> > > copy it from the machine I"m working on> diff -urp
> > > linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c
> > > linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c ---
> > > linux-2.6.0-test3-clean/arch/i386/kernel/smpboot.c  Wed Aug 20 19:54:29
> > > 2003 +++ linux-2.6.0-test3-work/arch/i386/kernel/smpboot.c   Wed Aug 20
> > > 20:19:41 2003 @@ -1020,24 +1020,30 @@ static void __init
> > > smp_boot_cpus(unsigne
> > >         Dprintk("CPU present map: %lx\n",
> > > physids_coerce(phys_cpu_present_map));
> > >
> > >         kicked = 1;
> > > -       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
> > > +       for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++,
> > > kicked++)
> >
> > This patch (plus your first one) seems to work.  Perhaps the addition of
> > kicked++ above helped?  Attached is the boot log.
>
> I missed that.  But, it's incorrect.  You're doubly incrementing kicked
> in the case of CPUs that are booted correctly and getting to kicked >=
> NR_CPUS a lot quicker.  That's why you're booting correctly.
>
> Secondly, we can actually boot up to NR_CPUS cpus, and we can *fail* to
> boot a lot more than that.  At least that's what the code is trying to
> do.  Whether it is "the right thing" is debatable.

Boot log with extra kicked++ removed...


--Boundary-00=_KsPR/p62gqUEFU+
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg2"

Filesystem type is ext2fs, partition type 0x83
kernel /bzImage-2.6.0-test3-bk8 ro root=/dev/sda7 console=ttyS0,38400n8
   [Linux-bzImage, setup=0xc00, size=0x1fc92d]

Linux version 2.6.0-test3-bk8 (root@x4408way2) (gcc version 3.2.2) #2 SMP Thu Aug 21 13:26:38 CDT 2003
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
Detected 1498.432 MHz processor.
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 3
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
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
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 10
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
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 11
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 3
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
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
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 10
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
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 11
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#15.
CPU#15: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#15: Thermal monitoring enabled
CPU15: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 16
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 17
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 18
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 19
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 20
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 21
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 22
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 23
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 24
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 25
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 26
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 27
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 28
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 29
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 30
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 31
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 000000ff boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 32
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 33
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 34
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 35
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 36
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 37
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 38
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 39
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 40
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 41
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 42
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 43
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 44
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 45
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 46
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 47
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 48
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 49
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 50
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 51
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 52
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 53
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 54
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 55
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 56
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 57
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 58
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 59
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 60
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 61
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 62
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 63
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 64
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 65
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 66
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 67
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 68
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 69
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 70
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 71
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 72
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 73
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 74
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 75
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 76
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 77
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 78
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 79
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 80
Booting processor 16/114 eip 2000
Not responding.
Unmapping cpu 16 from all nodes
CPU #114 not responding - cannot use it.
smp_boot_cpus() bit: 81
Booting processor 16/159 eip 2000
Not responding.
Unmapping cpu 16 from all nodes
CPU #159 not responding - cannot use it.
smp_boot_cpus() bit: 82
Booting processor 16/17 eip 2000
Initializing CPU#16
masked ExtINT on CPU#16
Leaving ESR disabled.
Mapping cpu 16 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#16.
CPU#16: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#16: Thermal monitoring enabled
CPU16: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 83
Booting processor 17/192 eip 2000
Not responding.
Unmapping cpu 17 from all nodes
CPU #192 not responding - cannot use it.
smp_boot_cpus() bit: 84
Booting processor 17/17 eip 2000
Initializing CPU#17
masked ExtINT on CPU#17
Leaving ESR disabled.
Mapping cpu 17 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#17.
CPU#17: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#17: Thermal monitoring enabled
CPU17: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 85
Booting processor 18/160 eip 2000
Not responding.
Unmapping cpu 18 from all nodes
CPU #160 not responding - cannot use it.
smp_boot_cpus() bit: 86
Booting processor 18/17 eip 2000
Initializing CPU#18
masked ExtINT on CPU#18
Leaving ESR disabled.
Mapping cpu 18 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#18.
CPU#18: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#18: Thermal monitoring enabled
CPU18: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 87
Booting processor 19/192 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #192 not responding - cannot use it.
smp_boot_cpus() bit: 88
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 89
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 90
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 91
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 92
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 93
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 94
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 95
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 96
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 97
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 98
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 99
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 100
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 101
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 102
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 103
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 104
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 105
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 106
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 107
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 108
Booting processor 19/108 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #108 not responding - cannot use it.
smp_boot_cpus() bit: 109
Booting processor 19/97 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #97 not responding - cannot use it.
smp_boot_cpus() bit: 110
Booting processor 19/112 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #112 not responding - cannot use it.
smp_boot_cpus() bit: 111
Booting processor 19/105 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #105 not responding - cannot use it.
smp_boot_cpus() bit: 112
Booting processor 19/99 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #99 not responding - cannot use it.
smp_boot_cpus() bit: 113
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 114
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 115
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 116
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 117
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 118
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 119
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 120
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 121
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 122
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 123
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 124
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 125
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 126
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 127
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 128
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 129
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 130
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 131
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 132
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 133
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 134
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 135
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 136
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 137
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 138
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 139
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 140
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 141
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 142
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 143
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 144
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 145
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 146
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 147
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 148
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 149
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 150
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 151
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 152
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 153
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 154
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 155
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 156
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 157
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 158
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 159
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 160
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 161
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 162
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 163
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 164
Booting processor 19/160 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #160 not responding - cannot use it.
smp_boot_cpus() bit: 165
Booting processor 19/186 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #186 not responding - cannot use it.
smp_boot_cpus() bit: 166
Booting processor 19/72 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #72 not responding - cannot use it.
smp_boot_cpus() bit: 167
Booting processor 19/192 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #192 not responding - cannot use it.
smp_boot_cpus() bit: 168
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 169
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 170
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 171
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 172
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 173
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 174
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 175
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 176
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 177
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 178
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 179
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 180
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 181
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 182
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 183
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 184
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 185
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 186
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 187
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 188
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 189
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 190
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 191
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 192
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 193
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 194
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 195
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 196
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 197
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 198
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 199
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 200
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 201
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 202
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 203
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 204
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 205
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 206
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 207
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 208
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 209
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 210
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 211
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 212
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 213
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 214
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 215
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 216
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 217
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 218
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 219
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 220
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 221
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 222
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 223
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 224
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 225
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 226
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 227
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 228
Booting processor 19/232 eip 2000
Not responding.
Unmapping cpu 19 from all nodes
CPU #232 not responding - cannot use it.
smp_boot_cpus() bit: 229
Booting processor 19/3 eip 2000
Initializing CPU#19
masked ExtINT on CPU#19
Leaving ESR disabled.
Mapping cpu 19 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#19.
CPU#19: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#19: Thermal monitoring enabled
CPU19: Intel(R) Xeon(TM) CPU 1.50GHz stepping 01
smp_boot_cpus() bit: 230
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 231
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 232
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 233
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 234
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 235
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 236
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 237
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 238
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 239
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 240
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 241
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 242
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 243
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 244
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 245
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 246
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 247
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 248
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 249
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 250
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 251
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 252
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 253
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 254
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
smp_boot_cpus() bit: 255
(apicid == boot_cpu_apicid) || (apicid == BAD_APICID)
apicid: 00000000 boot_cpu_apicid: 00000000 BAD_APICID: 000000ff
Total of 20 processors activated (3975.16 BogoMIPS).
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
cpu_sibling_map[16] = 2
cpu_sibling_map[17] = 2
cpu_sibling_map[18] = 2
cpu_sibling_map[19] = 1
ENABLING IO-APIC IRQs
Setting 14 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 14 ... ok.
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
..TIMER: vector=0x31 pin1=0 pin2=-1
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1496.0819 MHz.
..... host bus clock speed is 99.0787 MHz.
checking TSC synchronization across 20 CPUs: 

--Boundary-00=_KsPR/p62gqUEFU+--

