Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWIBDZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWIBDZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWIBDZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 23:25:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45548 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750753AbWIBDZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 23:25:16 -0400
Date: Fri, 1 Sep 2006 20:24:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com,
       apw@shadowen.org, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       kmannth@gmail.com, tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: Re: x86_64 account-for-memmap patch in 2.6.18-rc4-mm3 doesn't boot.
Message-Id: <20060901202430.0681f5c5.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com>
	<Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie>
	<20060831100156.24fc0521.pj@sgi.com>
	<Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is a bit of a sickener. It may be worth getting your good lab tech 
> to check if there is a configuration setting in the hardware for 
> simulating console output before you make the trip.

Apparently my lab setup simply lacks correct flow control on the serial
console line.  I hacked the 8250 serial driver in my kernel to put a one
msec delay between each character output, and it no longer drops
console output during boot.

> > This may take a day or three to yield results, unless I get lucky.
> >
> 
> I have Keith's problem with reserve-based-hot-add to keep me occupied in 
> the meantime. Whenever you get the chance will be fine. Thanks a lot

Ok, below is the console output for one of these crashes.

This output is missing the first couple dozen lines commencing with
grub announcing it is loading my kernel, as those lines seem to go via
a different serial driver that I didn't chase down to hack.  Those
initial lines were still dropping lotsa chars.  If you need those
initial lines bad, holler, and I can probably hack something to get
them to show up.

By the way, the crash continues to happen 100% with the patch:

  patches/account-for-memmap-and-optionally-the-kernel-image-as-holes.patch

and zero percent without it.  So this patch continues to be suspect
number one.  There is no suspect number two ;).

Notice the really bogus looking memory size numbers on the line near
the end that begins "Node 0 DMA free: ...".  No, this is not a
gazillion petabyte Altix.  It's a mundane 2 GByte, 2 processor package
(4 cores total) Xeon system.

Without further ado ...
=======================

CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 20781258
Detected 20.781 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 5320.09 BogoMIPS (lpj=10640184)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/6 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM2)
Genuine Intel(R) CPU                  @ 2.66GHz stepping 04
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 5320.27 BogoMIPS (lpj=10640543)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 2/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM2)
Genuine Intel(R) CPU                  @ 2.66GHz stepping 04
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 5320.03 BogoMIPS (lpj=10640065)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 3/7 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 1
CPU3: Thermal monitoring enabled (TM2)
Genuine Intel(R) CPU                  @ 2.66GHz stepping 04
Brought up 4 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2660.003 MHz processor.
migration_cost=26,7972
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at a0000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 7 10 *11)
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:03:00.0
  IO window: disabled.
  MEM window: b8900000-b89fffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:03:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: b8900000-b89fffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:02:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:02.0
  IO window: 2000-2fff
  MEM window: b8000000-b88fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.0
  IO window: 2000-2fff
  MEM window: b8000000-b89fffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:01:00.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: 2000-2fff
  MEM window: b8000000-b8afffff
  PREFETCH window: b8b00000-b8bfffff
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:0c:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:0c:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: b8c00000-b8cfffff
  PREFETCH window: b0000000-b7ffffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with large block/inode numbers, no debug enabled
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
aer: probe of 0000:00:02.0:pcie01 failed with error 2
aer: probe of 0000:00:03.0:pcie01 failed with error 1
aer: probe of 0000:00:04.0:pcie01 failed with error 2
aer: probe of 0000:00:05.0:pcie01 failed with error 2
aer: probe of 0000:00:06.0:pcie01 failed with error 2
aer: probe of 0000:00:07.0:pcie01 failed with error 2
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Invalid PBLK length [5]
ACPI: Invalid PBLK length [5]
ACPI: Invalid PBLK length [5]
ACPI: Invalid PBLK length [5]
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x4
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x5
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x6
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x7
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.1.9-k6
Copyright (c) 1999-2006 Intel Corporation.
GSI 17 sharing vector 0x42 and IRQ 17
ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level, low) -> IRQ 66
e1000: 0000:07:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x4) 00:04:23:cf:2d:d2e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 18 sharing vector 0x4A and IRQ 18
ACPI: PCI Interrupt 0000:07:00.1[B] -> GSI 19 (level, low) -> IRQ 74
e1000: 0000:07:00.1: e1000_probe: (PCI Express:2.5Gb/s:Width x4) 00:04:23:cf:2d:d3
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k4-NAPI
e100: Cohda: DV-28E-N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
megaraid: 2.20.4.9 (Release Date: Sun Jul 16 12:27:22 EST 2006)
megasas: 00.00.03.01 Sun May 14 22:49:52 PDT 2006
megasas: 0x1000:0x0411:0x8086:0x3501: bus 4:slot 14:func 0
ACPI: PCI Interrupt 0000:04:0e.0[A] -> GSI 18 (level, low) -> IRQ 66
scsi0 : LSI Logic SAS based MegaRAID driver
scsi 0:0:0:0: Direct-Access     ATA      HDT722525DLA380  A80A PQ: 0 ANSI: 5
scsi 0:0:1:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:0:2:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:0:3:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:0:4:0: Direct-Access     ATA      HDS725050KLA360  AB0A PQ: 0 ANSI: 5
scsi 0:2:0:0: Direct-Access     INTEL    SROMBSAS18E      1.00 PQ: 0 ANSI: 5
scsi 0:2:1:0: Direct-Access     INTEL    SROMBSAS18E      1.00 PQ: 0 ANSI: 5
swapper invoked oom-killer: gfp_mask=0xd1, order=0, oomkilladj=0

Call Trace:
 [<ffffffff8020acfa>] show_trace+0x34/0x47
 [<ffffffff8020ad1f>] dump_stack+0x12/0x17
 [<ffffffff8025a27f>] out_of_memory+0x79/0x282
 [<ffffffff8025bce3>] __alloc_pages+0x229/0x2b2
 [<ffffffff80274ec2>] cache_grow+0x134/0x333
 [<ffffffff802753d2>] cache_alloc_refill+0x17e/0x1cc
 [<ffffffff80275820>] kmem_cache_alloc+0x6c/0x76
 [<ffffffff8047b8fb>] sd_revalidate_disk+0x3a/0xcdb
 [<ffffffff8047d39d>] sd_probe+0x28b/0x31e
 [<ffffffff803ee8b7>] really_probe+0x47/0xc9
 [<ffffffff803eeaa8>] __driver_attach+0x6f/0xaf
 [<ffffffff803ee29c>] bus_for_each_dev+0x43/0x6e
 [<ffffffff803eddbc>] bus_add_driver+0x6b/0x18d
 [<ffffffff80207184>] init+0x13e/0x306
 [<ffffffff8020a3f8>] child_rip+0xa/0x12
DWARF2 unwinder stuck at child_rip+0xa/0x12
Leftover inexact backtrace:
 [<ffffffff803abf92>] acpi_ds_init_one_object+0x0/0x82
 [<ffffffff80207046>] init+0x0/0x306
 [<ffffffff8020a3ee>] child_rip+0x0/0x12

Mem-info:
Node 0 DMA per-cpu:
cpu 0 hot: high 186, batch 31 used:0
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:0
cpu 1 cold: high 62, batch 15 used:0
cpu 2 hot: high 186, batch 31 used:0
cpu 2 cold: high 62, batch 15 used:0
cpu 3 hot: high 186, batch 31 used:0
cpu 3 cold: high 62, batch 15 used:0
Node 0 DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:19
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:16
cpu 1 cold: high 62, batch 15 used:0
cpu 2 hot: high 186, batch 31 used:158
cpu 2 cold: high 62, batch 15 used:0
cpu 3 hot: high 186, batch 31 used:10
cpu 3 cold: high 62, batch 15 used:0
Node 0 Normal per-cpu: empty
Active:0 inactive:0 dirty:0 writeback:0 unstable:0 free:509486 slab:1362 mapped:0 pagetables:0
Node 0 DMA free:1616kB min:143085642166168kB low:178857052707708kB high:214628463249252kB active:0kB inactive:0kB present:18446744073709538996kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2026 2026
Node 0 DMA32 free:2036328kB min:5776kB low:7220kB high:8664kB active:0kB inactive:0kB present:2075356kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA: 2*4kB 3*8kB 1*16kB 1*32kB 2*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1616kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 5*64kB 8*128kB 3*256kB 1*512kB 0*1024kB 1*2048kB 496*4096kB = 2036328kB
Node 0 Normal: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
523264 pages of RAM
10232 reserved pages
0 pages shared
0 pages swap cached
Kernel panic - not syncing: Out of memory and no killable processes...



-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

-- 
VGER BF report: U 0.5
