Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVDCCQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVDCCQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 21:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDCCQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 21:16:35 -0500
Received: from omc1-s15.bay6.hotmail.com ([65.54.248.217]:11585 "EHLO
	OMC1-S15.phx.gbl") by vger.kernel.org with ESMTP id S261434AbVDCCQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 21:16:08 -0500
Message-ID: <BAY10-F5413AE1988EF69D4405392D93A0@phx.gbl>
X-Originating-IP: [146.229.160.228]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <1112491074.27149.95.camel@localhost.localdomain>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched /HT processor
Date: Sun, 03 Apr 2005 07:46:06 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 03 Apr 2005 02:16:06.0804 (UTC) FILETIME=[17EEE540:01C537F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I attached the 'dmesg' output because there it shows that my kernel 
recogonized 2 cpu's.As said earlier , are they treated as 2 physical cpu's 
or logical cpu's?

>From: Steven Rostedt <rostedt@goodmis.org>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: LKML <linux-kernel@vger.kernel.org>
>Subject: Re: sched /HT processor
>Date: Sat, 02 Apr 2005 20:17:54 -0500
>
>On Sun, 2005-04-03 at 06:07 +0530, Arun Srinivas wrote:
> > HI
> >
> > I have pentium4 hyperthreaded processor.I am using kernel 2.6.5 and i
> > rebuilt my kernel with CONFIG_SMP enabled (in this kernel source there 
>is
> > nothing such as CONFIG_SMT...i noticed this only in recent 2.6.11).
> >
>
>I don't have a 2.6.5 available, but I do have a 2.6.9 to look at.
>
> > 1)  So, after I rebulit it with CONFIG_SMP enabled does linux recogonize 
>my
> > machine as hyperthreaded or as 2 seperate processor? Also, if it does 
>not
> > recogonize it as hyperthreaded(but only as 2 seperate CPU's), does the
> > scheduler schedule instruction in the 2 cpu's independently? (does it
> > maintain 2 seperate runqueues?
> >
>
>I believe even HT on 2.6.11 maintains two different runqueues.  But it
>doesn't care so much to jump from one runqueue to the next if it is HT.
>
> > 2) If it has indeed recogonized this as hyperthreaded processor...does 
>the
> > scheduler use a common runqueue for the 2 logical processor?
> >
>
>No, you wouldn't want to.
>
>
> > (please read below)
>
>What do you want us to see?
>
> > 
>*********************************************************************************************************
> > (I am attaching the ouput of  'dmesg' (command)  on my machine)
> > 
>*************************************************************************************************************
> > Apr  2 17:43:12 kulick2 kernel: Linux version 2.6.5-1.358custom
> > (root@kulick2) (gcc version 3.3
> > .3 20040412 (Red Hat Linux 3.3.3-7)) #133 SMP Wed Mar 30 12:16:27 CST 
>2005
> > Apr  2 17:43:12 kulick2 kernel: BIOS-provided physical RAM map:
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 0000000000000000 -
> > 00000000000a0000 (usable)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 00000000000f0000 -
> > 0000000000100000 (reserved)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 0000000000100000 -
> > 000000001f770000 (usable)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 000000001f770000 -
> > 000000001f772000 (ACPI NVS)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 000000001f772000 -
> > 000000001f793000 (ACPI data)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 000000001f793000 -
> > 000000001f800000 (reserved)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 00000000fec00000 -
> > 00000000fec10000 (reserved)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 00000000fecf0000 -
> > 00000000fecf1000 (reserved)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 00000000fed20000 -
> > 00000000fed90000 (reserved)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 00000000fee00000 -
> > 00000000fee10000 (reserved)
> > Apr  2 17:43:12 kulick2 kernel:  BIOS-e820: 00000000ffb00000 -
> > 0000000100000000 (reserved)
> > Apr  2 17:43:12 kulick2 kernel: 0MB HIGHMEM available.
> > Apr  2 17:43:12 kulick2 kernel: 503MB LOWMEM available.
> > Apr  2 17:43:12 kulick2 kernel: ACPI: S3 and PAE do not like each other 
>for
> > now, S3 disabled.
> > Apr  2 17:43:12 kulick2 kernel: found SMP MP-table at 000fe710
> > Apr  2 17:43:12 kulick2 kernel: On node 0 totalpages: 128880
> > Apr  2 17:43:12 kulick2 kernel:   DMA zone: 4096 pages, LIFO batch:1
> > Apr  2 17:43:12 kulick2 kernel:   Normal zone: 124784 pages, LIFO 
>batch:16
> > Apr  2 17:43:12 kulick2 kernel:   HighMem zone: 0 pages, LIFO batch:1
> > Apr  2 17:43:12 kulick2 kernel: DMI 2.3 present.
> > Apr  2 17:43:12 kulick2 kernel: Using APIC driver default
> > Apr  2 17:43:12 kulick2 kernel: ACPI: RSDP (v000 DELL
> >                ) @
> > 0x000feba0
> > Apr  2 17:43:12 kulick2 kernel: ACPI: RSDT (v001 DELL    GX270   
>0x00000007
> > ASL  0x00000061) @
> > 0x000fd192
> > Apr  2 17:43:12 kulick2 kernel: ACPI: FADT (v001 DELL    GX270   
>0x00000007
> > ASL  0x00000061) @
> > 0x000fd1ca
> > Apr  2 17:43:12 kulick2 kernel: ACPI: SSDT (v001   DELL    st_ex 
>0x00001000
> > MSFT 0x0100000d) @
> > 0xfffd4eee
> > Apr  2 17:43:12 kulick2 irqbalance: irqbalance startup succeeded
> > Apr  2 17:43:12 kulick2 kernel: ACPI: MADT (v001 DELL    GX270   
>0x00000007
> > ASL  0x00000061) @
> > 0x000fd23e
> > Apr  2 17:43:12 kulick2 kernel: ACPI: BOOT (v001 DELL    GX270   
>0x00000007
> > ASL  0x00000061) @
> > 0x000fd2aa
> > Apr  2 17:43:12 kulick2 kernel: ACPI: ASF! (v016 DELL    GX270   
>0x00000007
> > ASL  0x00000061) @
> > 0x000fd2d2
> > Apr  2 17:43:12 kulick2 kernel: ACPI: DSDT (v001   DELL    dt_ex 
>0x00001000
> > MSFT 0x0100000d) @
> > 0x00000000
> > Apr  2 17:43:12 kulick2 kernel: ACPI: PM-Timer IO Port: 0x808
> > Apr  2 17:43:12 kulick2 kernel: ACPI: LAPIC (acpi_id[0x01] 
>lapic_id[0x00]
> > enabled)
> > Apr  2 17:43:12 kulick2 kernel: Processor #0 15:2 APIC version 20
> > Apr  2 17:43:12 kulick2 kernel: ACPI: LAPIC (acpi_id[0x02] 
>lapic_id[0x01]
> > enabled)
> > Apr  2 17:43:12 kulick2 kernel: Processor #1 15:2 APIC version 20
> > Apr  2 17:43:12 kulick2 kernel: ACPI: LAPIC (acpi_id[0x03] 
>lapic_id[0x01]
> > disabled)
> > Apr  2 17:43:12 kulick2 kernel: ACPI: LAPIC (acpi_id[0x04] 
>lapic_id[0x03]
> > disabled)
> > Apr  2 17:43:12 kulick2 kernel: ACPI: IOAPIC (id[0x02] 
>address[0xfec00000]
> > global_irq_base[0x0]
> > )
> > Apr  2 17:43:12 kulick2 kernel: IOAPIC[0]: Assigned apic_id 2
> > Apr  2 17:43:12 kulick2 kernel: IOAPIC[0]: apic_id 2, version 32, 
>address
> > 0xfec00000, GSI 0-23
> > Apr  2 17:43:12 kulick2 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
> > global_irq 2 dfl dfl)
> > Apr  2 17:43:12 kulick2 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
> > global_irq 9 high level)
> > Apr  2 17:43:12 kulick2 kernel: Enabling APIC mode:  Flat.  Using 1 I/O
> > APICs
> > Apr  2 17:43:12 kulick2 kernel: Using ACPI (MADT) for SMP configuration
> > information
> > Apr  2 17:43:12 kulick2 portmap: portmap startup succeeded
> > Apr  2 17:43:12 kulick2 kernel: Built 1 zonelists
> > Apr  2 17:43:12 kulick2 kernel: Kernel command line: ro root=LABEL=/ 
>rhgb
> > quiet
> > Apr  2 17:43:12 kulick2 kernel: mapped 4G/4G trampoline to fffeb000.
> > Apr  2 17:43:12 kulick2 kernel: Initializing CPU#0
> > Apr  2 17:43:12 kulick2 kernel: CPU 0 irqstacks, hard=023cb000 
>soft=023ab000
> > Apr  2 17:43:12 kulick2 kernel: PID hash table entries: 2048 (order 11:
> > 16384 bytes)
> > Apr  2 17:43:12 kulick2 kernel: Detected 2993.225 MHz processor.
> > Apr  2 17:43:12 kulick2 kernel: Using pmtmr for high-res timesource
> > Apr  2 17:43:12 kulick2 kernel: Console: colour VGA+ 80x25
> > Apr  2 17:43:12 kulick2 kernel: Memory: 505996k/515520k available (1744k
> > kernel code, 8772k res
> > erved, 756k data, 180k init, 0k highmem)
> > Apr  2 17:43:12 kulick2 kernel: Calibrating delay loop... 5931.00 
>BogoMIPS
> > Apr  2 17:43:12 kulick2 kernel: Security Scaffold v1.0.0 initialized
> > Apr  2 17:43:12 kulick2 kernel: SELinux:  Initializing.
> > Apr  2 17:43:12 kulick2 kernel: SELinux:  Starting in permissive mode
> > Apr  2 17:43:12 kulick2 kernel: There is already a security framework
> > initialized, register_sec
> > urity failed.
> > Apr  2 17:43:12 kulick2 kernel: Failure registering capabilities with 
>the
> > kernel
> > Apr  2 17:43:12 kulick2 kernel: selinux_register_security:  Registering
> > secondary module capabi
> > lity
> > Apr  2 17:43:12 kulick2 kernel: Capability LSM initialized
> > Apr  2 17:43:12 kulick2 kernel: Dentry cache hash table entries: 32768
> > (order: 5, 131072 bytes)
> > Apr  2 17:43:12 kulick2 kernel: Inode-cache hash table entries: 32768
> > (order: 5, 131072 bytes)
> > Apr  2 17:43:12 kulick2 kernel: Mount-cache hash table entries: 512 
>(order:
> > 0, 4096 bytes)
> > Apr  2 17:43:12 kulick2 kernel: CPU: Trace cache: 12K uops, L1 D cache: 
>8K
> > Apr  2 17:43:12 kulick2 rpc.statd[2019]: Version 1.0.6 Starting
> > Apr  2 17:43:12 kulick2 kernel: CPU: L2 cache: 512K
> > Apr  2 17:43:12 kulick2 kernel: CPU: Physical Processor ID: 0
> > Apr  2 17:43:12 kulick2 rpc.statd[2019]: gethostbyname error for kulick2
> > Apr  2 17:43:12 kulick2 kernel: Intel machine check architecture 
>supported.
> > Apr  2 17:43:12 kulick2 kernel: Intel machine check reporting enabled on
> > CPU#0.
> > Apr  2 17:43:12 kulick2 nfslock: rpc.statd startup succeeded
> > Apr  2 17:43:12 kulick2 kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs 
>(12)
> > available
> > Apr  2 17:43:12 kulick2 kernel: CPU#0: Thermal monitoring enabled
> > Apr  2 17:43:12 kulick2 kernel: Enabling fast FPU save and restore... 
>done.
> > Apr  2 17:43:12 kulick2 kernel: Enabling unmasked SIMD FPU exception
> > support... done.
> > Apr  2 17:43:12 kulick2 kernel: Checking 'hlt' instruction... OK.
> > Apr  2 17:43:12 kulick2 kernel: POSIX conformance testing by UNIFIX
> > Apr  2 17:43:12 kulick2 kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz
> > stepping 09
> > Apr  2 17:43:12 kulick2 kernel: per-CPU timeslice cutoff: 1462.93 usecs.
> > Apr  2 17:43:12 kulick2 kernel: task migration cache decay timeout: 2 
>msecs.
> > Apr  2 17:43:12 kulick2 kernel: enabled ExtINT on CPU#0
> > Apr  2 17:43:12 kulick2 kernel: ESR value before enabling vector: 
>00000040
> > Apr  2 17:43:12 kulick2 kernel: ESR value after enabling vector: 
>00000000
> > Apr  2 17:43:12 kulick2 kernel: Booting processor 1/1 eip 2000
> > Apr  2 17:43:12 kulick2 kernel: CPU 1 irqstacks, hard=023cc000 
>soft=023ac000
> > Apr  2 17:43:12 kulick2 kernel: Initializing CPU#1
> > Apr  2 17:43:12 kulick2 kernel: masked ExtINT on CPU#1
> > Apr  2 17:43:12 kulick2 kernel: ESR value before enabling vector: 
>00000000
> > Apr  2 17:43:12 kulick2 kernel: ESR value after enabling vector: 
>00000000
> > Apr  2 17:43:12 kulick2 kernel: Calibrating delay loop... 5980.16 
>BogoMIPS
> > Apr  2 17:43:12 kulick2 kernel: CPU: Trace cache: 12K uops, L1 D cache: 
>8K
> > Apr  2 17:43:12 kulick2 kernel: CPU: L2 cache: 512K
> > Apr  2 17:43:12 kulick2 kernel: CPU: Physical Processor ID: 0
> > Apr  2 17:43:12 kulick2 kernel: Intel machine check architecture 
>supported.
> > Apr  2 17:43:12 kulick2 kernel: Intel machine check reporting enabled on
> > CPU#1.
> > Apr  2 17:43:12 kulick2 kernel: CPU#1: Intel P4/Xeon Extended MCE MSRs 
>(12)
> > available
> > Apr  2 17:43:12 kulick2 kernel: CPU#1: Thermal monitoring enabled
> > Apr  2 17:43:12 kulick2 kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz
> > stepping 09
> > Apr  2 17:43:12 kulick2 kernel: Total of 2 processors activated 
>(11911.16
> > BogoMIPS).
> > Apr  2 17:43:12 kulick2 kernel: cpu_sibling_map[0] = 1
> > Apr  2 17:43:12 kulick2 kernel: cpu_sibling_map[1] = 0
>
>Here you see that you have two CPUs.  0 is the sibling of 1 and 1 to 0.
>This just shows that you have HT.  If you were to have a dual xeon, then
>you would see 4 CPUs and two pairs.
>
>-- Steve
>

_________________________________________________________________
Make money with Zero Investment. 
http://adfarm.mediaplex.com/ad/ck/4686-26272-10936-31?ck=RegSell Start your 
business.

