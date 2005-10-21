Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVJUPqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVJUPqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVJUPqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:46:43 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34293 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964990AbVJUPqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:46:42 -0400
Date: Fri, 21 Oct 2005 11:46:32 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: False positive (well not really) on RT backward clock check
In-Reply-To: <1129902741.15748.4.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0510211142060.5770@localhost.localdomain>
References: <Pine.LNX.4.58.0510210942180.3903@localhost.localdomain>
 <1129902741.15748.4.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Oct 2005, Thomas Gleixner wrote:

> On Fri, 2005-10-21 at 09:45 -0400, Steven Rostedt wrote:
> > Ingo,
> >
> > Just want to let you know that I got the warning of the clock going
> > backwards on boot up.  But it happened right after I got this message.
> >
> > Ktimers: Switched to high resolution mode CPU 0
> >
> > So I'm assuming that the clock can go backwards by the switch to high res
> > timers.
>
> Can you provide the boot messages up to the switch please ? It's more
> likely that this is the switch of the clocksource from jiffies to TSC.
> The ktimers high res switch is done in this context.
>

I think you're right about that.  Here it is.

Sorry for the late reply.  The original was from my custom kernel and I
wanted to get an output from Ingo's.  This is rc5-rt1.

-- Steve

Linux version 2.6.14-rc5-rt1 (root@rtsmp) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP PREEMPT Fri Oct 21 14:36:19 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099c00 (usable)
 BIOS-e820: 0000000000099c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
512MB LOWMEM available.
found SMP MP-table at 000f6a90
On node 0 totalpages: 131072
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126976 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
early console enabled
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6a20
ACPI: RSDT (v001 PTLTD    RSDT   0x06040001  LTP 0x00000000) @ 0x1fefbd7d
ACPI: FADT (v001 FSC    D1309    0x06040001      0x000f4240) @ 0x1fefbdb1
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040001 PTL  0x00000001) @ 0x1fefeef8
ACPI: MADT (v001 PTLTD  	 APIC   0x06040001  LTP 0x00000000) @ 0x1fefef48
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040001  LTP 0x00000001) @ 0x1fefefd8
ACPI: DSDT (v001 FSC    D1204    0x06040001 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
WARNING: maxcpus limit of 2 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
WARNING: maxcpus limit of 2 reached. Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
mapped IOAPIC to ffffc000 (fec00000)
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[16])
mapped IOAPIC to ffffb000 (fec10000)
IOAPIC[1]: apic_id 3, version 17, address 0xfec10000, GSI 16-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 2395.544 MHz processor.
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro  console=ttyS0,115200 console=tty0 nmi_watchdog=2 earlyprintk=ttyS0,115200 maxcpus=2 panic=30
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 65536 bytes)
Event source pit installed with caps set: 01
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 508724k/524288k available (2136k kernel code, 15088k reserved, 712k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4793.28 BogoMIPS (lpj=2396641)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring handled by SMI
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4790.12 BogoMIPS (lpj=2395061)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 2 processors activated (9583.40 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Event source lapic installed with caps set: 06
checking TSC synchronization across 2 CPUs: passed.
softlockup thread 0 started up.
Event source lapic installed with caps set: 06
Brought up 2 CPUs
softlockup thread 1 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfda31, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:04.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: Device [ECP] status [00000008]: functional but not present; setting present
ACPI: PCI Root Bridge [PCIA] (0000:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIA._PRT]
ACPI: PCI Root Bridge [PCIB] (0000:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Simple Boot Flag at 0x69 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
Time: tsc clocksource has been installed.
WARNING: non-monotonic time!
Ktimers: Switched to high resolution mode CPU 0
softirq-timer/1/14[CPU#1]: BUG in ktime_get at kernel/ktimers.c:101
 [<c0104433>] dump_stack+0x23/0x30 (20)
 [<c0121427>] __WARN_ON+0x67/0x80 (44)
 [<c013ad82>] ktime_get+0xd2/0x100 (48)
 [<c013c2b6>] ktimer_run_queues+0x56/0x130 (60)
 [<c012abbe>] run_timer_softirq+0x12e/0x450 (56)
 [<c01268b0>] ksoftirqd+0x120/0x1a0 (40)
 [<c01376eb>] kthread+0xbb/0xc0 (48)
 [<c01014a5>] kernel_thread_helper+0x5/0x10 (538427420)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0143edc>] .... add_preempt_count+0x1c/0x20
.....[<c01213db>] ..   ( <= __WARN_ON+0x1b/0x80)

Ktimers: Switched to high resolution mode CPU 1
