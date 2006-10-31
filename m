Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423109AbWJaKzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423109AbWJaKzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423117AbWJaKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:55:07 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:50933 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423109AbWJaKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:55:02 -0500
Date: Tue, 31 Oct 2006 12:54:52 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH] 0/3: Fix EH problems in libsas and implement more error handling
Message-ID: <20061031105452.GD28239@rhun.haifa.ibm.com>
References: <45468845.20400@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45468845.20400@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 03:18:29PM -0800, Darrick J. Wong wrote:

> In any case, these patches have been tested on a x206m, x260 and a x366.
>  They seemed pretty stable, though YMMV.  The patches should apply
> against linux-2.6.19-rc3 + scsi-misc + scsi-rc-fixes + aic94xx git trees
> in the order that they are posted.  They may also eat your disks.
> 
> Questions/comments?  This is still very much a work in progress and at
> this stage I'm merely seeking constructive feedback to mould this code
> into better shape.

I'm still seeing this on my x366 with the V17 sequencer firmware (with
the old Razor sequencer it happens as well, but rarely).

aic94xx: escb_tasklet_complete: REQ_TASK_ABORT, reason=0x6
aic94xx: tmf tasklet complete
aic94xx: tmf resp tasklet
aic94xx: tmf came back
aic94xx: task not done, clearing nexus
aic94xx: asd_clear_nexus_tag: PRE
aic94xx: asd_clear_nexus_tag: POST
aic94xx: asd_clear_nexus_tag: clear nexus posted, waiting...
aic94xx: task 0xffff81015ee59580 done with opcode 0x23 resp 0x0 stat 0x8d but aborted by upper layer!
aic94xx: asd_clear_nexus_tasklet_complete: here
aic94xx: asd_clear_nexus_tasklet_complete: opcode: 0x0
aic94xx: came back from clear nexus
aic94xx: task 0xffff81015ee59580 aborted, res: 0x0
sas: command 0xffff8100e2afcb00, task 0xffff81015ee59580, aborted by initiator: EH_NOT_HANDLED
sas: Enter sas_scsi_recover_host
sas: going over list...
sas: trying to find task 0xffff81015ee59580
sas: sas_scsi_find_task: task 0xffff81015ee59580 already aborted
sas: sas_scsi_recover_host: task 0xffff81015ee59580 is aborted
sas: --- Exit sas_scsi_recover_host

Full boot log:

Linux version 2.6.19-rc3mx (muli@cluwyn) (gcc version 4.0.3) #55 SMP Tue Oct 31 12:05:36 IST 2006
Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
 BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000e7f9c640 (usable)
 BIOS-e820: 00000000e7f9c640 - 00000000e7fa6a40 (ACPI data)
 BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
Entering add_active_range(0, 0, 153) 0 entries of 256 used
Entering add_active_range(0, 256, 950172) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1671168) 2 entries of 256 used
end_pfn_map = 1671168
DMI 2.3 present.
ACPI: RSDP (v000 IBM                                   ) @ 0x00000000000fdcf0
ACPI: RSDT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa69c0
ACPI: FADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6940
ACPI: MADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa6880
ACPI: SRAT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x00000000e7fa67c0
ACPI: SSDT (v001 IBM    VIGSSDT0 0x00001000 INTL 0x20030122) @ 0x00000000e7f9f440
ACPI: DSDT (v001 IBM    SER01ZEU 0x00001000 INTL 0x20030122) @ 0x0000000000000000
Entering add_active_range(0, 0, 153) 0 entries of 256 used
Entering add_active_range(0, 256, 950172) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1671168) 2 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1671168
early_node_map[3] active PFN ranges
    0:        0 ->      153
    0:      256 ->   950172
    0:  1048576 ->  1671168
On node 0 totalpages: 1572661
  DMA zone: 88 pages used for memmap
  DMA zone: 2707 pages reserved
  DMA zone: 1198 pages, LIFO batch:0
  DMA32 zone: 22440 pages used for memmap
  DMA32 zone: 923636 pages, LIFO batch:31
  Normal zone: 13376 pages used for memmap
  Normal zone: 609216 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x9c
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 15, address 0xfec00000, GSI 0-35
ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
IOAPIC[1]: apic_id 14, address 0xfec01000, GSI 35-70
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ8 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 0000000000099000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
Nosave address range: 00000000e7fa7000 - 00000000e8000000
Nosave address range: 00000000e8000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at ea000000 (gap: e8000000:16c00000)
PERCPU: Allocating 34048 bytes of per cpu data
Built 1 zonelists.  Total pages: 1534050
Kernel command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 1328 kB
 per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Checking aperture...
PCI-DMA: Calgary IOMMU detected.
PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabled.
Memory: 6082356k/6684672k available (3789k kernel code, 207844k reserved, 2729k data, 276k init)
Calibrating delay using timer specific routine.. 6346.29 BogoMIPS (lpj=12692580)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
Freeing SMP alternatives: 32k freed
ACPI: Core revision 20060707
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 10425425
Detected 10.425 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6339.08 BogoMIPS (lpj=12678173)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
               Intel(R) Xeon(TM) MP CPU 3.16GHz stepping 01
lockdep: not fixing up alternatives.
Booting processor 2/4 APIC 0x6
Initializing CPU#2
Calibrating delay using timer specific routine.. 6339.22 BogoMIPS (lpj=12678451)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU2: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
lockdep: not fixing up alternatives.
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6339.31 BogoMIPS (lpj=12678624)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU3: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
Brought up 4 CPUs
testing NMI watchdog ... OK.
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 3169.354 MHz processor.
migration_cost=20,798
checking if image is initramfs... it is
Freeing initrd memory: 15866k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [VP00] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:00:00.0
PCI: Calling quirk ffffffff804f210c for 0000:00:00.0
PCI: Found 0000:00:01.0 [1002/5159] 000300 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:01.0
PCI: Calling quirk ffffffff804f2605 for 0000:00:01.0
Boot video device is 0000:00:01.0
PCI: Calling quirk ffffffff804f210c for 0000:00:01.0
PCI: Found 0000:00:03.0 [1033/0035] 000c03 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:03.0
PCI: Calling quirk ffffffff804f2605 for 0000:00:03.0
PCI: Calling quirk ffffffff804f210c for 0000:00:03.0
PCI: Found 0000:00:03.1 [1033/0035] 000c03 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:03.1
PCI: Calling quirk ffffffff804f2605 for 0000:00:03.1
PCI: Calling quirk ffffffff804f210c for 0000:00:03.1
PCI: Found 0000:00:03.2 [1033/00e0] 000c03 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:03.2
PCI: Calling quirk ffffffff804f2605 for 0000:00:03.2
PCI: Calling quirk ffffffff804f210c for 0000:00:03.2
PCI: Found 0000:00:0f.0 [1166/0203] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:0f.0
PCI: Calling quirk ffffffff804f2605 for 0000:00:0f.0
PCI: Calling quirk ffffffff804f210c for 0000:00:0f.0
PCI: Found 0000:00:0f.1 [1166/0213] 000101 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:0f.1
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
PCI: Calling quirk ffffffff804f2605 for 0000:00:0f.1
PCI: Calling quirk ffffffff804f210c for 0000:00:0f.1
PCI: Found 0000:00:0f.3 [1166/0227] 000601 00
PCI: Calling quirk ffffffff80377e22 for 0000:00:0f.3
PCI: Calling quirk ffffffff804f2605 for 0000:00:0f.3
PCI: Calling quirk ffffffff804f210c for 0000:00:0f.3
PCI: Fixups for bus 0000:00
PCI: Bus scan for 0000:00 returning with max=00
ACPI: PCI Interrupt Routing Table [\_SB_.VP00._PRT]
ACPI: PCI Root Bridge [VP01] (0000:01)
PCI: Probing PCI hardware (bus 01)
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:01:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:01:00.0
PCI: Calling quirk ffffffff804f210c for 0000:01:00.0
PCI: Found 0000:01:01.0 [14e4/1648] 000200 00
PCI: Calling quirk ffffffff80377e22 for 0000:01:01.0
PCI: Calling quirk ffffffff804f2605 for 0000:01:01.0
PCI: Calling quirk ffffffff804f210c for 0000:01:01.0
PCI: Found 0000:01:01.1 [14e4/1648] 000200 00
PCI: Calling quirk ffffffff80377e22 for 0000:01:01.1
PCI: Calling quirk ffffffff804f2605 for 0000:01:01.1
PCI: Calling quirk ffffffff804f210c for 0000:01:01.1
PCI: Found 0000:01:02.0 [9005/041e] 000100 00
PCI: Calling quirk ffffffff80377e22 for 0000:01:02.0
PCI: Calling quirk ffffffff804f2605 for 0000:01:02.0
PCI: Calling quirk ffffffff804f210c for 0000:01:02.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
ACPI: PCI Interrupt Routing Table [\_SB_.VP01._PRT]
ACPI: PCI Root Bridge [VP02] (0000:02)
PCI: Probing PCI hardware (bus 02)
PCI: Scanning bus 0000:02
PCI: Found 0000:02:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:02:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:02:00.0
PCI: Calling quirk ffffffff804f210c for 0000:02:00.0
PCI: Found 0000:02:01.0 [10b7/9200] 000200 00
PCI: Calling quirk ffffffff80377e22 for 0000:02:01.0
PCI: Calling quirk ffffffff804f2605 for 0000:02:01.0
PCI: Calling quirk ffffffff804f210c for 0000:02:01.0
PCI: Fixups for bus 0000:02
PCI: Bus scan for 0000:02 returning with max=02
ACPI: PCI Interrupt Routing Table [\_SB_.VP02._PRT]
ACPI: PCI Root Bridge [VP03] (0000:04)
PCI: Probing PCI hardware (bus 04)
PCI: Scanning bus 0000:04
PCI: Found 0000:04:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:04:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:04:00.0
PCI: Calling quirk ffffffff804f210c for 0000:04:00.0
PCI: Fixups for bus 0000:04
PCI: Bus scan for 0000:04 returning with max=04
ACPI: PCI Interrupt Routing Table [\_SB_.VP03._PRT]
ACPI: PCI Root Bridge [VP04] (0000:06)
PCI: Probing PCI hardware (bus 06)
PCI: Scanning bus 0000:06
PCI: Found 0000:06:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:06:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:06:00.0
PCI: Calling quirk ffffffff804f210c for 0000:06:00.0
PCI: Fixups for bus 0000:06
PCI: Bus scan for 0000:06 returning with max=06
ACPI: PCI Interrupt Routing Table [\_SB_.VP04._PRT]
ACPI: PCI Root Bridge [VP05] (0000:08)
PCI: Probing PCI hardware (bus 08)
PCI: Scanning bus 0000:08
PCI: Found 0000:08:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:08:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:08:00.0
PCI: Calling quirk ffffffff804f210c for 0000:08:00.0
PCI: Fixups for bus 0000:08
PCI: Bus scan for 0000:08 returning with max=08
ACPI: PCI Interrupt Routing Table [\_SB_.VP05._PRT]
ACPI: PCI Root Bridge [VP06] (0000:0a)
PCI: Probing PCI hardware (bus 0a)
PCI: Scanning bus 0000:0a
PCI: Found 0000:0a:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:0a:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:0a:00.0
PCI: Calling quirk ffffffff804f210c for 0000:0a:00.0
PCI: Fixups for bus 0000:0a
PCI: Bus scan for 0000:0a returning with max=0a
ACPI: PCI Interrupt Routing Table [\_SB_.VP06._PRT]
ACPI: PCI Root Bridge [VP07] (0000:0c)
PCI: Probing PCI hardware (bus 0c)
PCI: Scanning bus 0000:0c
PCI: Found 0000:0c:00.0 [1014/02a1] 000600 00
PCI: Calling quirk ffffffff80377e22 for 0000:0c:00.0
PCI: Calling quirk ffffffff804f2605 for 0000:0c:00.0
PCI: Calling quirk ffffffff804f210c for 0000:0c:00.0
PCI: Fixups for bus 0000:0c
PCI: Bus scan for 0000:0c returning with max=0c
ACPI: PCI Interrupt Routing Table [\_SB_.VP07._PRT]
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Using Calgary IOMMU
Calgary: enabling translation on PHB 0x0
Calgary: errant DMAs will now be prevented on this bus.
Calgary: enabling translation on PHB 0x1
Calgary: errant DMAs will now be prevented on this bus.
Calgary: enabling translation on PHB 0x2
Calgary: errant DMAs will now be prevented on this bus.
PCI-GART: No AMD northbridge found.
  got res [f0000000:f001ffff] bus [f0000000:f001ffff] flags 7202 for BAR 6 of 0000:00:01.0
  got res [f0080000:f00fffff] bus [f0080000:f00fffff] flags 7200 for BAR 6 of 0000:01:02.0
  got res [f0020000:f003ffff] bus [f0020000:f003ffff] flags 7200 for BAR 6 of 0000:02:01.0
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Calling quirk ffffffff80377483 for 0000:00:00.0
PCI: Calling quirk ffffffff80496865 for 0000:00:00.0
PCI: Calling quirk ffffffff80377483 for 0000:00:01.0
PCI: Calling quirk ffffffff80496865 for 0000:00:01.0
PCI: Calling quirk ffffffff80377483 for 0000:00:03.0
PCI: Calling quirk ffffffff80496865 for 0000:00:03.0
PCI: Calling quirk ffffffff80377483 for 0000:00:03.1
PCI: Calling quirk ffffffff80496865 for 0000:00:03.1
PCI: Calling quirk ffffffff80377483 for 0000:00:03.2
PCI: Calling quirk ffffffff80496865 for 0000:00:03.2
PCI: Calling quirk ffffffff80377483 for 0000:00:0f.0
PCI: Calling quirk ffffffff80496865 for 0000:00:0f.0
PCI: Calling quirk ffffffff80377483 for 0000:00:0f.1
PCI: Calling quirk ffffffff80496865 for 0000:00:0f.1
PCI: Calling quirk ffffffff80377483 for 0000:00:0f.3
PCI: Calling quirk ffffffff80496865 for 0000:00:0f.3
PCI: Calling quirk ffffffff80377483 for 0000:01:00.0
PCI: Calling quirk ffffffff80496865 for 0000:01:00.0
PCI: Calling quirk ffffffff80377483 for 0000:01:01.0
PCI: Calling quirk ffffffff80496865 for 0000:01:01.0
PCI: Calling quirk ffffffff80377483 for 0000:01:01.1
PCI: Calling quirk ffffffff80496865 for 0000:01:01.1
PCI: Calling quirk ffffffff80377483 for 0000:01:02.0
PCI: Calling quirk ffffffff80496865 for 0000:01:02.0
PCI: Calling quirk ffffffff80377483 for 0000:02:00.0
PCI: Calling quirk ffffffff80496865 for 0000:02:00.0
PCI: Calling quirk ffffffff80377483 for 0000:02:01.0
PCI: Calling quirk ffffffff80496865 for 0000:02:01.0
PCI: Calling quirk ffffffff80377483 for 0000:04:00.0
PCI: Calling quirk ffffffff80496865 for 0000:04:00.0
PCI: Calling quirk ffffffff80377483 for 0000:06:00.0
PCI: Calling quirk ffffffff80496865 for 0000:06:00.0
PCI: Calling quirk ffffffff80377483 for 0000:08:00.0
PCI: Calling quirk ffffffff80496865 for 0000:08:00.0
PCI: Calling quirk ffffffff80377483 for 0000:0a:00.0
PCI: Calling quirk ffffffff80496865 for 0000:0a:00.0
PCI: Calling quirk ffffffff80377483 for 0000:0c:00.0
PCI: Calling quirk ffffffff80496865 for 0000:0c:00.0
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=143.00 Mhz, System=143.00 MHz
radeonfb: PLL min 12000 max 35000
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
Console: switching to colour frame buffer device 128x48
radeonfb (0000:00:01.0): ATI Radeon QY 
tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
hgafb: HGA card not detected.
hgafb: probe of hgafb.0 failed with error -22
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
fb1: VGA16 VGA frame buffer device
fb2: Virtual frame buffer device, using 1024K of video memory
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
Linux agpgart interface v0.101 (c) Dave Jones
ipmi message handler version 39.0
ipmi device interface
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:01.0: 3Com PCI 3c905C Tornado at ffffc20000042000.
tg3.c:v3.67 (October 18, 2006)
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 24
PCI: Enabling bus mastering for device 0000:01:01.0
eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:22
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 28
PCI: Enabling bus mastering for device 0000:01:01.1
eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:23
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
SvrWks CSB6: simplex device: DMA disabled
ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
Probing IDE interface ide0...
hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM drive, 256kB Cache<7>Losing some ticks... checking if CPU frequency changed.

Uniform CD-ROM driver Revision: 3.20
libata version 2.00 loaded.
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.0: created debug files
ohci_hcd 0000:00:03.0: irq 20, io mem 0xf2c10000
ohci_hcd 0000:00:03.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:03.0: OHCI controller state
ohci_hcd 0000:00:03.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:03.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:03.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:03.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:03.0: intrenable 0x8000005a MIE RHSC UE RD WDH
ohci_hcd 0000:00:03.0: hcca frame #001f
ohci_hcd 0000:00:03.0: roothub.a 0f000202 POTPGT=15 NPS NDP=2(2)
ohci_hcd 0000:00:03.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:03.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:03.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:03.0: roothub.portstatus [1] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc3mx ohci_hcd
usb usb1: SerialNumber: 0000:00:03.0
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 30ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: trying to enable port power on non-switchable hub
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.1: created debug files
ohci_hcd 0000:00:03.1: irq 20, io mem 0xf2c11000
ohci_hcd 0000:00:03.1: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:03.1: OHCI controller state
ohci_hcd 0000:00:03.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:03.1: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:03.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:03.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:03.1: intrenable 0x8000005a MIE RHSC UE RD WDH
ohci_hcd 0000:00:03.1: hcca frame #001f
ohci_hcd 0000:00:03.1: roothub.a 0f000202 POTPGT=15 NPS NDP=2(2)
ohci_hcd 0000:00:03.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:03.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:03.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:03.1: roothub.portstatus [1] 0x00000100 PPS
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc3mx ohci_hcd
usb usb2: SerialNumber: 0000:00:03.1
usb usb2: uevent
usb usb2: usb_probe_device
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 30ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: trying to enable port power on non-switchable hub
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
USB Universal Host Controller Interface driver v3.0
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
i2c /dev entries driver
i2c-parport: adapter type unspecified
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: multipath personality registered for level -4
input: PS/2 Generic Mouse as /class/input/input2
ohci_hcd 0000:00:03.0: auto-stop root hub
ohci_hcd 0000:00:03.1: auto-stop root hub
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
device-mapper: multipath emc: version 0.0.3 loaded
EDAC MC: Ver: 2.0.1 Oct 31 2006
pktgen v2.68: Packet Generator for packet performance testing.
u32 classifier
    OLD policer on 
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
SCTP: Hash tables configured (established 37449 bind 37449)
Freeing unused kernel memory: 276k freed
aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2 loaded
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 25
aic94xx: found Adaptec AIC-9410W SAS/SATA Host Adapter, device 0000:01:02.0
scsi0 : aic94xx
aic94xx: BIOS present (1,1), 1323
aic94xx: ue num:2, ue size:88
aic94xx: manuf sect SAS_ADDR 5005076a0112df00
aic94xx: manuf sect PCBA SN 
aic94xx: ms: num_phy_desc: 8
aic94xx: ms: phy0: ENEBLEABLE
aic94xx: ms: phy1: ENEBLEABLE
aic94xx: ms: phy2: ENEBLEABLE
aic94xx: ms: phy3: ENEBLEABLE
aic94xx: ms: phy4: ENEBLEABLE
aic94xx: ms: phy5: ENEBLEABLE
aic94xx: ms: phy6: ENEBLEABLE
aic94xx: ms: phy7: ENEBLEABLE
aic94xx: ms: max_phys:0x8, num_phys:0x8
aic94xx: ms: enabled_phys:0xff
aic94xx: ctrla: phy0: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy1: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy2: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy3: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy4: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy5: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy6: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy7: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: max_scbs:512, max_ddbs:128
aic94xx: setting phy0 addr to 5005076a0112df00
aic94xx: setting phy1 addr to 5005076a0112df00
aic94xx: setting phy2 addr to 5005076a0112df00
aic94xx: setting phy3 addr to 5005076a0112df00
aic94xx: setting phy4 addr to 5005076a0112df00
aic94xx: setting phy5 addr to 5005076a0112df00
aic94xx: setting phy6 addr to 5005076a0112df00
aic94xx: setting phy7 addr to 5005076a0112df00
aic94xx: num_edbs:21
aic94xx: num_escbs:3
aic94xx: using sequencer V17/10c6
aic94xx: downloading CSEQ...
aic94xx: dma-ing 8192 bytes
aic94xx: verified 8192 bytes, passed
aic94xx: downloading LSEQs...
aic94xx: dma-ing 14336 bytes
aic94xx: LSEQ0 verified 14336 bytes, passed
aic94xx: LSEQ1 verified 14336 bytes, passed
aic94xx: LSEQ2 verified 14336 bytes, passed
aic94xx: LSEQ3 verified 14336 bytes, passed
aic94xx: LSEQ4 verified 14336 bytes, passed
aic94xx: LSEQ5 verified 14336 bytes, passed
aic94xx: LSEQ6 verified 14336 bytes, passed
aic94xx: LSEQ7 verified 14336 bytes, passed
aic94xx: max_scbs:446
aic94xx: first_scb_site_no:0x20
aic94xx: last_scb_site_no:0x1fe
aic94xx: First SCB dma_handle: 0xd000
aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8 enabled phys, flash present, BIOS build 1323
aic94xx: posting 3 escbs
aic94xx: escbs posted
aic94xx: posting 8 control phy scbs
aic94xx: enabled phys
aic94xx: control_phy_tasklet_complete: phy0, lrate:0x9, proto:0xe
aic94xx: escb_tasklet_complete: phy0: BYTES_DMAED
aic94xx: SAS proto IDENTIFY:
aic94xx: 00: 10 00 00 08
aic94xx: 04: 00 00 00 00
aic94xx: 08: 00 00 00 00
aic94xx: 0c: 50 00 c5 00
aic94xx: 10: 00 32 f3 95
aic94xx: 14: 00 00 00 00
aic94xx: 18: 00 00 00 00
aic94xx: control_phy_tasklet_complete: phy4, lrate:0x9, proto:0xe
aic94xx: escb_tasklet_complete: phy4: BYTES_DMAED
aic94xx: SAS proto IDENTIFY:
aic94xx: 00: 10 00 00 08
aic94xx: 04: 00 00 00 00
aic94xx: 08: 00 00 00 00
aic94xx: 0c: 50 00 c5 00
aic94xx: 10: 00 32 f5 25
aic94xx: 14: 00 00 00 00
aic94xx: 18: 00 00 00 00
aic94xx: control_phy_tasklet_complete: phy1: no device present: oob_status:0x0
aic94xx: control_phy_tasklet_complete: phy2: no device present: oob_status:0x0
aic94xx: control_phy_tasklet_complete: phy3: no device present: oob_status:0x0
aic94xx: control_phy_tasklet_complete: phy5: no device present: oob_status:0x0
aic94xx: control_phy_tasklet_complete: phy6: no device present: oob_status:0x0
aic94xx: control_phy_tasklet_complete: phy7: no device present: oob_status:0x0
sas: phy0 added to port0, phy_mask:0x1
sas: phy4 added to port1, phy_mask:0x10
sas: DOING DISCOVERY on port 0, pid:1105
scsi 0:0:0:0: Direct-Access     IBM-ESXS ST936701SS    F  B512 PQ: 0 ANSI: 4
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: bb 00 10 08
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: bb 00 10 08
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
sas: DONE DISCOVERY on port 0, pid:1105, result:0
sas: DOING DISCOVERY on port 1, pid:1105
scsi 0:0:1:0: Direct-Access     IBM-ESXS ST936701SS    F  B512 PQ: 0 ANSI: 4
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: bb 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: bb 00 10 08
SCSI device sdb: drive cache: write through w/ FUA
 sdb: sdb1 sdb2
sd 0:0:1:0: Attached scsi disk sdb
sd 0:0:1:0: Attached scsi generic sg1 type 0
sas: DONE DISCOVERY on port 1, pid:1105, result:0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
warning: process `showconsole' used the removed sysctl system call
Adding 1048552k swap on /dev/sda1.  Priority:42 extents:1 across:1048552k
Adding 1048552k swap on /dev/sdb1.  Priority:42 extents:1 across:1048552k
warning: process `showconsole' used the removed sysctl system call
EXT3 FS on sda2, internal journal
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
warning: process `sleep' used the removed sysctl system call
warning: process `showconsole' used the removed sysctl system call
warning: process `sleep' used the removed sysctl system call
PM: Writing back config space on device 0000:01:01.0 at offset b (was 164814e4, writing 2e71014)
PM: Writing back config space on device 0000:01:01.0 at offset 3 (was 804000, writing 80f010)
PM: Writing back config space on device 0000:01:01.0 at offset 2 (was 2000000, writing 2000010)
PM: Writing back config space on device 0000:01:01.0 at offset 1 (was 2b00000, writing 2b00146)
tg3: eth1: Link is up at 100 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
PM: Writing back config space on device 0000:01:01.1 at offset b (was 164814e4, writing 2e71014)
PM: Writing back config space on device 0000:01:01.1 at offset 3 (was 804000, writing 80f010)
PM: Writing back config space on device 0000:01:01.1 at offset 2 (was 2000000, writing 2000010)
PM: Writing back config space on device 0000:01:01.1 at offset 1 (was 2b00000, writing 2b00146)
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
aic94xx: escb_tasklet_complete: REQ_TASK_ABORT, reason=0x6
aic94xx: tmf tasklet complete
aic94xx: tmf resp tasklet
aic94xx: tmf came back
aic94xx: task not done, clearing nexus
aic94xx: asd_clear_nexus_tag: PRE
aic94xx: asd_clear_nexus_tag: POST
aic94xx: asd_clear_nexus_tag: clear nexus posted, waiting...
aic94xx: task 0xffff81015ee59580 done with opcode 0x23 resp 0x0 stat 0x8d but aborted by upper layer!
aic94xx: asd_clear_nexus_tasklet_complete: here
aic94xx: asd_clear_nexus_tasklet_complete: opcode: 0x0
aic94xx: came back from clear nexus
aic94xx: task 0xffff81015ee59580 aborted, res: 0x0
sas: command 0xffff8100e2afcb00, task 0xffff81015ee59580, aborted by initiator: EH_NOT_HANDLED
sas: Enter sas_scsi_recover_host
sas: going over list...
sas: trying to find task 0xffff81015ee59580
sas: sas_scsi_find_task: task 0xffff81015ee59580 already aborted
sas: sas_scsi_recover_host: task 0xffff81015ee59580 is aborted
sas: --- Exit sas_scsi_recover_host
aic94xx: escb_tasklet_complete: REQ_TASK_ABORT, reason=0x5
aic94xx: tmf tasklet complete
aic94xx: tmf resp tasklet
aic94xx: tmf came back
aic94xx: task not done, clearing nexus
aic94xx: asd_clear_nexus_tag: PRE
aic94xx: asd_clear_nexus_tag: POST
aic94xx: asd_clear_nexus_tag: clear nexus posted, waiting...
aic94xx: task 0xffff81007b4d2580 done with opcode 0x23 resp 0x0 stat 0x8d but aborted by upper layer!
aic94xx: asd_clear_nexus_tasklet_complete: here
aic94xx: asd_clear_nexus_tasklet_complete: opcode: 0x0
aic94xx: came back from clear nexus
aic94xx: task 0xffff81007b4d2580 aborted, res: 0x0
sas: command 0xffff81016ae27800, task 0xffff81007b4d2580, aborted by initiator: EH_NOT_HANDLED
sas: Enter sas_scsi_recover_host
sas: going over list...
sas: trying to find task 0xffff81007b4d2580
sas: sas_scsi_find_task: task 0xffff81007b4d2580 already aborted
sas: sas_scsi_recover_host: task 0xffff81007b4d2580 is aborted
sas: --- Exit sas_scsi_recover_host
