Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWG1UnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWG1UnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWG1UnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:43:21 -0400
Received: from www.osadl.org ([213.239.205.134]:31660 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161292AbWG1UnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:43:20 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       alokk@calsoftinc.com, kiran@scalex86.org
In-Reply-To: <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com>
References: <1154044607.27297.101.camel@localhost.localdomain>
	 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
	 <1154067247.27297.104.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
	 <1154117501.10196.2.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
	 <1154118476.10196.5.camel@localhost.localdomain>
	 <1154118947.10196.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 22:47:37 +0200
Message-Id: <1154119658.10196.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 13:36 -0700, Christoph Lameter wrote:
> On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> 
> > Let me know, if you need more info
> 
> What type of NUMA system is this? How many nodes? Is memory exhausted on 
> some so that allocations are redirected? Are cpusets or memory policies
> used to redirect allocations?

Dual dual core opteron board, only one CPU brought up. This happens
during bootup, so no special settings involved.

	tglx


[    0.000000] Bootdata ok (command line is root=/dev/md0 ro maxcpus=1)
[    0.000000] Linux version 2.6.18-rc2 (tglx@cruncher) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #35 SMP PREEMPT Fri Jul 28 22:20:01 CEST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000fbff0000 (usable)
[    0.000000]  BIOS-e820: 00000000fbff0000 - 00000000fbfff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fbfff000 - 00000000fc000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f6d20
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x06000513 MSFT 0x00000097) @ 0x00000000fbff0000
[    0.000000] ACPI: FADT (v001 A M I  OEMFACP  0x06000513 MSFT 0x00000097) @ 0x00000000fbff0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x06000513 MSFT 0x00000097) @ 0x00000000fbff0380
[    0.000000] ACPI: OEMB (v001 A M I  OEMBIOS  0x06000513 MSFT 0x00000097) @ 0x00000000fbfff040
[    0.000000] ACPI: SRAT (v001 A M I  OEMSRAT  0x06000513 MSFT 0x00000097) @ 0x00000000fbff3b10
[    0.000000] ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x00000000fbff3c20
[    0.000000] ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x0000000000000000
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 1 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 2 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 3 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 100000-80000000
[    0.000000] SRAT: Node 1 PXM 1 80000000-fc000000
[    0.000000] SRAT: Node 1 PXM 1 80000000-100000000
[    0.000000] SRAT: Node 0 PXM 0 0-80000000
[    0.000000] NUMA: Using 31 for the hash shift.
[    0.000000] Bootmem setup node 0 0000000000000000-0000000080000000
[    0.000000] Bootmem setup node 1 0000000080000000-00000000fbff0000
[    0.000000] On node 0 totalpages: 510753
[    0.000000]   DMA zone: 1737 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 509016 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 496977
[    0.000000]   DMA32 zone: 496977 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] Processor #2 15:1 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] Processor #3 15:1 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x05] address[0xfebff000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 5, version 17, address 0xfebff000, GSI 24-27
[    0.000000] ACPI: IOAPIC (id[0x06] address[0xfebfe000] gsi_base[28])
[    0.000000] IOAPIC[2]: apic_id 6, version 17, address 0xfebfe000, GSI 28-31
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at fc400000 (gap: fc000000:3780000)
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] Built 2 zonelists.  Total pages: 1007730
[    0.000000] Kernel command line: root=/dev/md0 ro maxcpus=1
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Disabling vsyscall due to use of PM timer
[    0.000000] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[    0.000000] time.c: Detected 1991.696 MHz processor.
[  123.210551] Console: colour VGA+ 80x25
[  123.215777] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[  123.215930] ... MAX_LOCKDEP_SUBCLASSES:    8
[  123.216037] ... MAX_LOCK_DEPTH:          30
[  123.216143] ... MAX_LOCKDEP_KEYS:        2048
[  123.216250] ... CLASSHASH_SIZE:           1024
[  123.216358] ... MAX_LOCKDEP_ENTRIES:     8192
[  123.216465] ... MAX_LOCKDEP_CHAINS:      8192
[  123.216573] ... CHAINHASH_SIZE:          4096
[  123.216690]  memory used by lock dependency info: 1120 kB
[  123.216802]  per task-struct memory footprint: 1680 bytes
[  123.218883] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[  123.222305] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[  123.223549] Checking aperture...
[  123.223655] CPU 0: aperture @ 4472000000 size 32 MB
[  123.223779] Aperture too small (32 MB)
[  123.230869] No AGP bridge found
[  123.288294] Memory: 4024308k/4128704k available (2734k kernel code, 104008k reserved, 1848k data, 216k init)
[  123.348627] Calibrating delay using timer specific routine.. 3986.63 BogoMIPS (lpj=1993317)
[  123.348991] Security Framework v1.0.0 initialized
[  123.349103] SELinux:  Disabled at boot.
[  123.349277] Mount-cache hash table entries: 256
[  123.349664] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[  123.349784] CPU: L2 Cache: 1024K (64 bytes/line)
[  123.349893] CPU 0/0 -> Node 0
[  123.349995] CPU: Physical Processor ID: 0
[  123.350100] CPU: Processor Core ID: 0
[  123.350223] lockdep: not fixing up alternatives.
[  123.350332] ACPI: Core revision 20060707
[  123.364499] Using local APIC timer interrupts.
[  123.414803] result 12448117
[  123.414904] Detected 12.448 MHz APIC timer.
[  123.415675] Brought up 1 CPUs
[  123.415814] testing NMI watchdog ... OK.
[  123.426015] migration_cost=0
[  123.426900] NET: Registered protocol family 16
[  123.427245] ACPI: bus type pci registered
[  123.427358] PCI: Using configuration type 1
[  123.447436] ACPI: Interpreter enabled
[  123.447543] ACPI: Using IOAPIC for interrupt routing
[  123.448820] ACPI: PCI Root Bridge [PCI0] (0000:00)
[  123.448938] PCI: Probing PCI hardware (bus 00)
[  123.453171] Boot video device is 0000:03:06.0
[  123.453692] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[  123.458468] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[  123.466577] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
[  123.467938] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
[  123.471656] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[  123.472951] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[  123.474236] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[  123.475546] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[  123.476558] Linux Plug and Play Support v0.97 (c) Adam Belay
[  123.476702] pnp: PnP ACPI init
[  123.484169] pnp: PnP ACPI: found 15 devices
[  123.484309] AMD768 RNG detected
[  123.484804] SCSI subsystem initialized
[  123.484980] PCI: Using ACPI for IRQ routing
[  123.485088] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  123.485492] PCI-DMA: Disabling IOMMU.
[  123.487167] pnp: 00:0a: ioport range 0x680-0x6ff has been reserved
[  123.487284] pnp: 00:0a: ioport range 0x295-0x296 has been reserved
[  123.487401] pnp: 00:0a: ioport range 0x778-0x77f has been reserved
[  123.487517] pnp: 00:0a: ioport range 0xb78-0xb7f has been reserved
[  123.487639] pnp: 00:0a: ioport range 0xf78-0xf7f has been reserved
[  123.488274] PCI: Bridge: 0000:00:06.0
[  123.488381]   IO window: 9000-bfff
[  123.488489]   MEM window: fc900000-feafffff
[  123.488611]   PREFETCH window: disabled.
[  123.488720] PCI: Bridge: 0000:00:0a.0
[  123.488825]   IO window: disabled.
[  123.488930]   MEM window: fc800000-fc8fffff
[  123.489039]   PREFETCH window: ff500000-ff5fffff
[  123.489150] PCI: Bridge: 0000:00:0b.0
[  123.489254]   IO window: disabled.
[  123.489359]   MEM window: disabled.
[  123.489463]   PREFETCH window: disabled.
[  123.489791] NET: Registered protocol family 2
[  123.499681] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[  123.500670] TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
[  123.505897] TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
[  123.508528] TCP: Hash tables configured (established 65536 bind 32768)
[  123.508668] TCP reno registered
[  123.511300] audit: initializing netlink socket (disabled)
[  123.511436] audit(1154118366.247:1): initialized
[  123.511902] VFS: Disk quotas dquot_6.5.1
[  123.512042] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[  123.512397] Initializing Cryptographic API
[  123.512514] io scheduler noop registered
[  123.512698] io scheduler anticipatory registered (default)
[  123.512945] io scheduler deadline registered
[  123.513148] io scheduler cfq registered
[  123.513320] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
[  123.513476] PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
[  123.551821] Real Time Clock Driver v1.12ac
[  123.552016] hpet_acpi_add: no address or irqs in _CRS
[  123.552133] Linux agpgart interface v0.101 (c) Dave Jones
[  123.552246] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[  123.552673] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  123.552987] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  123.553761] 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  123.554142] 00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  123.555637] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[  123.555791] e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
[  123.555906] e100: Copyright(c) 1999-2005 Intel Corporation
[  123.556106] GSI 16 sharing vector 0xA9 and IRQ 16
[  123.556217] ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 18 (level, low) -> IRQ 169
[  123.629160] e100: eth0: e100_probe: addr 0xfeafb000, irq 169, MAC addr 00:E0:81:31:35:29
[  123.629392] tg3.c:v3.63 (July 25, 2006)
[  123.629514] GSI 17 sharing vector 0xB1 and IRQ 17
[  123.629626] ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 177
[  123.636712] eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:31:35:48
[  123.637233] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  123.637389] eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[  123.637544] GSI 18 sharing vector 0xB9 and IRQ 18
[  123.637655] ACPI: PCI Interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 185
[  123.651237] eth2: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:31:35:49
[  123.651763] eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[  123.651919] eth2: dma_rwctrl[769f4000] dma_mask[64-bit]
[  123.652297] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  123.652415] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  123.652893] libata version 2.00 loaded.
[  123.653025] sata_sil 0000:03:05.0: version 2.0
[  123.653044] GSI 19 sharing vector 0xC1 and IRQ 19
[  123.653155] ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 19 (level, low) -> IRQ 193
[  123.653664] ata1: SATA max UDMA/100 cmd 0xFFFFC2000001AC80 ctl 0xFFFFC2000001AC8A bmdma 0xFFFFC2000001AC00 irq 193
[  123.655627] ata2: SATA max UDMA/100 cmd 0xFFFFC2000001ACC0 ctl 0xFFFFC2000001ACCA bmdma 0xFFFFC2000001AC08 irq 193
[  123.655833] ata3: SATA max UDMA/100 cmd 0xFFFFC2000001AE80 ctl 0xFFFFC2000001AE8A bmdma 0xFFFFC2000001AE00 irq 193
[  123.656037] ata4: SATA max UDMA/100 cmd 0xFFFFC2000001AEC0 ctl 0xFFFFC2000001AECA bmdma 0xFFFFC2000001AE08 irq 193
[  123.656221] scsi0 : sata_sil
[  124.109450] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  124.111264] ata1.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
[  124.111422] ata1.00: ata1: dev 0 multi count 16
[  124.114232] ata1.00: configured for UDMA/100
[  124.114352] scsi1 : sata_sil
[  124.568327] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  124.570154] ata2.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
[  124.570309] ata2.00: ata2: dev 0 multi count 16
[  124.573327] ata2.00: configured for UDMA/100
[  124.573443] scsi2 : sata_sil
[  124.876222] ata3: SATA link down (SStatus 0 SControl 310)
[  124.876345] scsi3 : sata_sil
[  125.179142] ata4: SATA link down (SStatus 0 SControl 310)
[  125.179392]   Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
[  125.181296]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  125.181783]   Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
[  125.183685]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  125.184385] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
[  125.184521] sda: Write Protect is off
[  125.184626] sda: Mode Sense: 00 3a 00 00
[  125.184655] SCSI device sda: drive cache: write back
[  125.184871] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
[  125.185006] sda: Write Protect is off
[  125.185110] sda: Mode Sense: 00 3a 00 00
[  125.185151] SCSI device sda: drive cache: write back
[  125.185266]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
[  125.241119] sd 0:0:0:0: Attached scsi disk sda
[  125.241332] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
[  125.241465] sdb: Write Protect is off
[  125.241570] sdb: Mode Sense: 00 3a 00 00
[  125.241600] SCSI device sdb: drive cache: write back
[  125.241780] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
[  125.241916] sdb: Write Protect is off
[  125.242021] sdb: Mode Sense: 00 3a 00 00
[  125.242052] SCSI device sdb: drive cache: write back
[  125.242166]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
[  125.310203] sd 1:0:0:0: Attached scsi disk sdb
[  125.310410] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  125.310590] sd 1:0:0:0: Attached scsi generic sg1 type 0
[  125.310838] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[  125.310954] PNP: PS/2 controller doesn't have AUX irq; using default 12
[  125.312621] serio: i8042 AUX port at 0x60,0x64 irq 12
[  125.312855] serio: i8042 KBD port at 0x60,0x64 irq 1
[  125.313210] mice: PS/2 mouse device common for all mice
[  125.313361] md: linear personality registered for level -1
[  125.313474] md: raid0 personality registered for level 0
[  125.313586] md: raid1 personality registered for level 1
[  125.313698] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[  125.313816] md: bitmap version 4.39
[  125.314037] TCP bic registered
[  125.314186] NET: Registered protocol family 1
[  125.314300] NET: Registered protocol family 17
[  125.314417] NET: Registered protocol family 8
[  125.314525] NET: Registered protocol family 20
[  125.315119] ACPI: (supports S0 S1 S5)
[  125.315703] md: Autodetecting RAID arrays.
[  125.444208] md: autorun ...
[  125.444309] md: considering sdb7 ...
[  125.444422] md:  adding sdb7 ...
[  125.444526] md: sdb6 has different UUID to sdb7
[  125.444635] md: sdb5 has different UUID to sdb7
[  125.444747] md: sdb2 has different UUID to sdb7
[  125.444860] md:  adding sda7 ...
[  125.444964] md: sda6 has different UUID to sdb7
[  125.445075] md: sda5 has different UUID to sdb7
[  125.445184] md: sda2 has different UUID to sdb7
[  125.445396] md: created md3
[  125.445499] md: bind<sda7>
[  125.445635] md: bind<sdb7>
[  125.445757] md: running: <sdb7><sda7>
[  125.446128] md3: setting max_sectors to 128, segment boundary to 32767
[  125.446246] raid0: looking at sdb7
[  125.446350] raid0:   comparing sdb7(19518848) with sdb7(19518848)
[  125.446523] raid0:   END
[  125.446622] raid0:   ==> UNIQUE
[  125.446727] raid0: 1 zones
[  125.446827] raid0: looking at sda7
[  125.446931] raid0:   comparing sda7(19518848) with sdb7(19518848)
[  125.447109] raid0:   EQUAL
[  125.447209] raid0: FINAL 1 zones
[  125.447314] raid0: done.
[  125.447413] raid0 : md_size is 39037696 blocks.
[  125.447522] raid0 : conf->hash_spacing is 39037696 blocks.
[  125.447634] raid0 : nb_zone is 1.
[  125.447739] raid0 : Allocating 8 bytes for hash.
[  125.447865] md: considering sdb6 ...
[  125.447975] md:  adding sdb6 ...
[  125.448084] md: sdb5 has different UUID to sdb6
[  125.448193] md: sdb2 has different UUID to sdb6
[  125.448307] md:  adding sda6 ...
[  125.448411] md: sda5 has different UUID to sdb6
[  125.448519] md: sda2 has different UUID to sdb6
[  125.448741] md: created md2
[  125.448843] md: bind<sda6>
[  125.448959] md: bind<sdb6>
[  125.449093] md: running: <sdb6><sda6>
[  125.449429] md2: setting max_sectors to 128, segment boundary to 32767
[  125.449547] raid0: looking at sdb6
[  125.449650] raid0:   comparing sdb6(97659008) with sdb6(97659008)
[  125.449826] raid0:   END
[  125.449925] raid0:   ==> UNIQUE
[  125.450027] raid0: 1 zones
[  125.450135] raid0: looking at sda6
[  125.450239] raid0:   comparing sda6(97659008) with sdb6(97659008)
[  125.450411] raid0:   EQUAL
[  125.450511] raid0: FINAL 1 zones
[  125.450615] raid0: done.
[  125.450717] raid0 : md_size is 195318016 blocks.
[  125.450826] raid0 : conf->hash_spacing is 195318016 blocks.
[  125.450939] raid0 : nb_zone is 1.
[  125.451041] raid0 : Allocating 8 bytes for hash.
[  125.451160] md: considering sdb5 ...
[  125.451268] md:  adding sdb5 ...
[  125.451371] md: sdb2 has different UUID to sdb5
[  125.451483] md:  adding sda5 ...
[  125.451587] md: sda2 has different UUID to sdb5
[  125.451801] md: created md1
[  125.451902] md: bind<sda5>
[  125.452019] md: bind<sdb5>
[  125.452146] md: running: <sdb5><sda5>
[  125.452482] md1: setting max_sectors to 128, segment boundary to 32767
[  125.452600] raid0: looking at sdb5
[  125.452706] raid0:   comparing sdb5(146480512) with sdb5(146480512)
[  125.452880] raid0:   END
[  125.452979] raid0:   ==> UNIQUE
[  125.453091] raid0: 1 zones
[  125.453192] raid0: looking at sda5
[  125.453296] raid0:   comparing sda5(146480512) with sdb5(146480512)
[  125.453470] raid0:   EQUAL
[  125.453570] raid0: FINAL 1 zones
[  125.453673] raid0: done.
[  125.453775] raid0 : md_size is 292961024 blocks.
[  125.453884] raid0 : conf->hash_spacing is 292961024 blocks.
[  125.453997] raid0 : nb_zone is 1.
[  125.454101] raid0 : Allocating 8 bytes for hash.
[  125.454218] md: considering sdb2 ...
[  125.454327] md:  adding sdb2 ...
[  125.454435] md:  adding sda2 ...
[  125.454538] md: created md0
[  125.454639] md: bind<sda2>
[  125.454761] md: bind<sdb2>
[  125.454877] md: running: <sdb2><sda2>
[  125.455225] md0: setting max_sectors to 128, segment boundary to 32767
[  125.455343] raid0: looking at sdb2
[  125.455447] raid0:   comparing sdb2(29294400) with sdb2(29294400)
[  125.455620] raid0:   END
[  125.455722] raid0:   ==> UNIQUE
[  125.455824] raid0: 1 zones
[  125.455924] raid0: looking at sda2
[  125.456027] raid0:   comparing sda2(29294400) with sdb2(29294400)
[  125.456203] raid0:   EQUAL
[  125.456303] raid0: FINAL 1 zones
[  125.456406] raid0: done.
[  125.456506] raid0 : md_size is 58588800 blocks.
[  125.456614] raid0 : conf->hash_spacing is 58588800 blocks.
[  125.456729] raid0 : nb_zone is 1.
[  125.456831] raid0 : Allocating 8 bytes for hash.
[  125.456947] md: ... autorun DONE.
[  125.500795] kjournald starting.  Commit interval 5 seconds
[  125.500944] EXT3-fs: mounted filesystem with ordered data mode.
[  125.501124] VFS: Mounted root (ext3 filesystem) readonly.
[  125.501284] Freeing unused kernel memory: 216k freed
[  125.530611] input: AT Translated Set 2 keyboard as /class/input/input0
[  128.510384] 
[  128.510386] =============================================
[  128.512303] [ INFO: possible recursive locking detected ]
[  128.512415] ---------------------------------------------
[  128.512527] events/0/5 is trying to acquire lock:
[  128.512636]  (&nc->lock){.+..}, at: [<ffffffff802908c1>] kmem_cache_free+0x141/0x210
[  128.513024] 
[  128.513025] but task is already holding lock:
[  128.513225]  (&nc->lock){.+..}, at: [<ffffffff80291bc1>] cache_reap+0xd1/0x290
[  128.513608] 
[  128.513609] other info that might help us debug this:
[  128.513813] 3 locks held by events/0/5:
[  128.513917]  #0:  (cache_chain_mutex){--..}, at: [<ffffffff80291b18>] cache_reap+0x28/0x290
[  128.514362]  #1:  (&nc->lock){.+..}, at: [<ffffffff80291bc1>] cache_reap+0xd1/0x290
[  128.514803]  #2:  (&parent->list_lock){.+..}, at: [<ffffffff80290c32>] __drain_alien_cache+0x42/0x90
[  128.515253] 
[  128.515253] stack backtrace:
[  128.515448] 
[  128.515449] Call Trace:
[  128.515740]  [<ffffffff8020b75e>] show_trace+0xae/0x280
[  128.515864]  [<ffffffff8020bb75>] dump_stack+0x15/0x20
[  128.515987]  [<ffffffff8025447c>] __lock_acquire+0x8cc/0xcb0
[  128.516178]  [<ffffffff80254b82>] lock_acquire+0x52/0x70
[  128.516369]  [<ffffffff804a8374>] _spin_lock+0x34/0x50
[  128.516562]  [<ffffffff802908c1>] kmem_cache_free+0x141/0x210
[  128.516799]  [<ffffffff80290a48>] slab_destroy+0xb8/0xf0
[  128.517034]  [<ffffffff80290b88>] free_block+0x108/0x170
[  128.517270]  [<ffffffff80290c58>] __drain_alien_cache+0x68/0x90
[  128.517509]  [<ffffffff80291d5f>] cache_reap+0x26f/0x290
[  128.517745]  [<ffffffff80249b93>] run_workqueue+0xc3/0x120
[  128.517926]  [<ffffffff80249e11>] worker_thread+0x121/0x160
[  128.518105]  [<ffffffff8024d93a>] kthread+0xda/0x110
[  128.518286]  [<ffffffff8020af2a>] child_rip+0x8/0x12
[  129.180199] Adding 39037688k swap on /dev/md3.  Priority:-1 extents:1 across:39037688k
[  129.200450] PM: Writing back config space on device 0000:02:09.0 at offset b (was 164814e4, writing 164414e4)
[  129.200657] PM: Writing back config space on device 0000:02:09.0 at offset 3 (was 804000, writing 804010)
[  129.200821] PM: Writing back config space on device 0000:02:09.0 at offset 2 (was 2000000, writing 2000003)
[  129.200986] PM: Writing back config space on device 0000:02:09.0 at offset 1 (was 2b00000, writing 2b00106)
[  129.655486] EXT3 FS on md0, internal journal
[  132.485370] tg3: eth1: Link is up at 1000 Mbps, full duplex.
[  132.485519] tg3: eth1: Flow control is on for TX and on for RX.
[  132.697481] kjournald starting.  Commit interval 5 seconds
[  132.697734] EXT3 FS on sda1, internal journal
[  132.697904] EXT3-fs: mounted filesystem with ordered data mode.
[  132.712956] kjournald starting.  Commit interval 5 seconds
[  132.713346] EXT3 FS on md1, internal journal
[  132.713516] EXT3-fs: mounted filesystem with ordered data mode.


