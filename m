Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWBIWBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWBIWBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWBIWBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:01:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:23198 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750806AbWBIWBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:01:46 -0500
Date: Thu, 9 Feb 2006 17:01:12 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: x86_64: check_timer() panic in kdump kernel (2.6.16-rc2)
Message-ID: <20060209220112.GA16504@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

check_timer() panics on my Dual core amd opteron box while second kernel is
booting after a crash (kdump). It stops seeing the timer interrupts.

Problem goes away if second kernel is a UP. It also works if booted with
"noapic" commandline. I have noticed this problem with AMD 8000 as well
as Broadcom HT 1000 chipset.

Attached is the serial console output. Can't think of a reason why timer
interrupts are not coming.

I have printed the IOAPIC routing entries and they are same for first kernel
and second kernel. LAPIC settings also are same. PIT seems to be still
firing. I read the count and it was decreasing.

Any clue, what to try next shall be helpful.

Thanks
Vivek 

# SysRq : Trigger a crashdump
Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 console=tty0 console=ttyS0,115200 irqpoll selinux=0 maxcpus=1 apic=debug loglevel=8 memmap=exactmap memmap=640K@0K memmap=5456K@16384K memmap=59439K@22481K elfcorehdr=22480K memmap=72K#2096512K)
Linux version 2.6.16-rc2-16M (root@wildhorse.rhts.boston.redhat.com) (gcc version 3.4.5 20051201 (Red Hat 3.4.5-2)) #1 SMP Thu Feb 9 17:41:27 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff60000 (usable)
 BIOS-e820: 000000007ff60000 - 000000007ff72000 (ACPI data)
 BIOS-e820: 000000007ff72000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000c0000000 - 00000000c0002000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 0000000001554000 (usable)
 user: 00000000015f4400 - 0000000005000000 (usable)
 user: 000000007ff60000 - 000000007ff72000 (ACPI data)
ACPI: RSDP (v002 PTLTD                                 ) @ 0x00000000000f6d90
ACPI: XSDT (v001 PTLTD           XSDT   0x06040000  LTP 0x00000000) @ 0x000000007ff6caab
ACPI: FADT (v003 AMD    HAMMER   0x06040000 PTEC 0x000f4240) @ 0x000000007ff71ca3
ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 0x000000007ff71d97
ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000) @ 0x000000007ff71e7f
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 0x000000007ff71ebb
ACPI: ASF! (v016    MBI     CETP 0x06040000 PTL  0x00000001) @ 0x000000007ff71f59
ACPI: DSDT (v001 AMD-K8  AMDACPI 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-80000000
SRAT: Node 1 PXM 1 100000000-180000000
NUMA: Using 63 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000005000000
On node 0 totalpages: 16095
  DMA zone: 96 pages, LIFO batch:0
  DMA32 zone: 15999 pages, LIFO batch:3
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xc0000000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xc0000000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xc0001000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xc0001000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xc0500000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xc0500000, GSI 32-55
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ff72000:8008e000)
Checking aperture...
CPU 0: aperture @ 8000000 size 64 MB
CPU 1: aperture @ 8000000 size 64 MB
SMP: Allowing 4 CPUs, 0 hotplug CPUs
cpu with no node 2, num_online_nodes 1
cpu with no node 3, num_online_nodes 1
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 console=tty0 console=ttyS0,115200 irqpoll selinux=0 maxcpus=1 apic=debug loglevel=8 memmap=exactmap memmap=640K@0K memmap=5456K@16384K memmap=59439K@22481K elfcorehdr=22480K memmap=72K#2096512K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 256 (order: 8, 8192 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2193.798 MHz processor.
Console: colour VGA+ 80x25
unexpected IRQ trap at vector 89
unexpected IRQ trap at vector 29
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
PCI-DMA: Disabling IOMMU.
Memory: 57348k/81920k available (3022k kernel code, 8184k reserved, 1507k data, 232k init)
Calibrating delay using timer specific routine.. 4400.09 BogoMIPS (lpj=8800191)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 5-0, 5-1, 5-2, 5-3, 6-0, 6-1, 6-2, 6-3, 7-0, 7-1, 7-2, 7-3, 7-4, 7-5, 7-6, 7-7, 7-8, 7-9, 7-10, 7-11, 7-12, 7-13, 7-14, 7-15, 7-16, 7-17, 7-18, 7-19, 7-20, 7-21, 7-22, 7-23 not connected.
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found apic 0 pin 0) ... failed.
timer doesn't work through the IO-APIC - disabling NMI Watchdog!
...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for unknown reason 31.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
 failed.
...trying to set up timer as ExtINT IRQ... failed :(.
Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter


