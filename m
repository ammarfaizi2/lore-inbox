Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753456AbWKLW7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbWKLW7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 17:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbWKLW7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 17:59:04 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:40464 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1753456AbWKLW7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 17:59:00 -0500
Date: Mon, 13 Nov 2006 10:01:02 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18.2: BUG: soft lockup detected on CPU#1!
Message-ID: <20061112230102.GA3155@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following BUG output whilst doing mke2fs on a Dell 2950
with a Woodcrest 5130 CPU, 4GB RAM and a megaraid SAS RAID card. The
kernel is compiled for emt64 and is monolithic (no modules). Below is
the full dmesg since bootup. A few debuggy things as I've not settled
on a final config for the box so if anyone needs any testing done I can
actually do stuff to it as it's not in production yet.

Oh. I was using the server via the DRAC card with serial over lan (so
console via serial).

Nov 13 08:50:13 localhost kernel: Kernel logging (proc) stopped.
Nov 13 08:50:13 localhost kernel: Kernel log daemon terminating.
Nov 13 09:16:05 localhost kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Nov 13 09:16:05 localhost kernel: Inspecting /boot/System.map-2.6.18.2-20061110-122152
Nov 13 09:16:05 localhost kernel: Loaded 28974 symbols from /boot/System.map-2.6.18.2-20061110-122152.
Nov 13 09:16:05 localhost kernel: Symbols match kernel version 2.6.18.
Nov 13 09:16:05 localhost kernel: No module symbols loaded - kernel modules not enabled. 
Nov 13 09:16:05 localhost kernel: Bootdata ok (command line is auto BOOT_IMAGE=l ro root=801 console=ttyS1,115200 console=tty0 elevator=cfq)
Nov 13 09:16:05 localhost kernel: Linux version 2.6.18.2-20061110-122152 (root@chestnut) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Fri Nov 10 12:26:56 EST 2006
Nov 13 09:16:05 localhost kernel: BIOS-provided physical RAM map:
Nov 13 09:16:05 localhost kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Nov 13 09:16:05 localhost kernel:  BIOS-e820: 0000000000100000 - 00000000cffa8000 (usable)
Nov 13 09:16:05 localhost kernel:  BIOS-e820: 00000000cffa8000 - 00000000cffb7c00 (ACPI data)
Nov 13 09:16:05 localhost kernel:  BIOS-e820: 00000000cffb7c00 - 00000000d0000000 (reserved)
Nov 13 09:16:05 localhost kernel:  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Nov 13 09:16:05 localhost kernel:  BIOS-e820: 00000000fe000000 - 0000000100000000 (reserved)
Nov 13 09:16:05 localhost kernel:  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
Nov 13 09:16:05 localhost kernel: DMI 2.4 present.
Nov 13 09:16:05 localhost kernel: ACPI: RSDP (v002 DELL                                  ) @ 0x00000000000f2a00
Nov 13 09:16:05 localhost kernel: ACPI: XSDT (v001 DELL   PE_SC3   0x00000001 DELL 0x00000001) @ 0x00000000000f2a80
Nov 13 09:16:05 localhost kernel: ACPI: FADT (v003 DELL   PE_SC3   0x00000001 DELL 0x00000001) @ 0x00000000000f2b88
Nov 13 09:16:05 localhost kernel: ACPI: MADT (v001 DELL   PE_SC3   0x00000001 DELL 0x00000001) @ 0x00000000000f2c7c
Nov 13 09:16:05 localhost kernel: ACPI: SPCR (v001 DELL   PE_SC3   0x00000001 DELL 0x00000001) @ 0x00000000000f2d5d
Nov 13 09:16:05 localhost kernel: ACPI: HPET (v001 DELL   PE_SC3   0x00000001 DELL 0x00000001) @ 0x00000000000f2dad
Nov 13 09:16:05 localhost kernel: ACPI: MCFG (v001 DELL   PE_SC3   0x00000001 DELL 0x00000001) @ 0x00000000000f2de5
Nov 13 09:16:05 localhost kernel: ACPI: DSDT (v001 DELL   PE_SC3   0x00000001 MSFT 0x0100000e) @ 0x0000000000000000
Nov 13 09:16:05 localhost kernel: On node 0 totalpages: 1019206
Nov 13 09:16:05 localhost kernel:   DMA zone: 1478 pages, LIFO batch:0
Nov 13 09:16:05 localhost kernel:   DMA32 zone: 825344 pages, LIFO batch:31
Nov 13 09:16:05 localhost kernel:   Normal zone: 192384 pages, LIFO batch:31
Nov 13 09:16:05 localhost kernel: ACPI: PM-Timer IO Port: 0x808
Nov 13 09:16:05 localhost kernel: ACPI: Local APIC address 0xfee00000
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Nov 13 09:16:05 localhost kernel: Processor #0 6:15 APIC version 20
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Nov 13 09:16:05 localhost kernel: Processor #1 6:15 APIC version 20
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] disabled)
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] disabled)
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] disabled)
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] disabled)
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] disabled)
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] disabled)
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
Nov 13 09:16:05 localhost kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Nov 13 09:16:05 localhost kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Nov 13 09:16:05 localhost kernel: ACPI: IOAPIC (id[0x03] address[0xfec81000] gsi_base[64])
Nov 13 09:16:05 localhost kernel: IOAPIC[1]: apic_id 3, version 32, address 0xfec81000, GSI 64-87
Nov 13 09:16:05 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Nov 13 09:16:05 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Nov 13 09:16:05 localhost kernel: ACPI: IRQ0 used by override.
Nov 13 09:16:05 localhost kernel: ACPI: IRQ2 used by override.
Nov 13 09:16:05 localhost kernel: ACPI: IRQ9 used by override.
Nov 13 09:16:05 localhost kernel: Setting APIC routing to flat
Nov 13 09:16:05 localhost kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
Nov 13 09:16:05 localhost kernel: Using ACPI (MADT) for SMP configuration information
Nov 13 09:16:05 localhost kernel: Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
Nov 13 09:16:05 localhost kernel: Built 1 zonelists.  Total pages: 1019206
Nov 13 09:16:05 localhost kernel: Kernel command line: auto BOOT_IMAGE=l ro root=801 console=ttyS1,115200 console=tty0 elevator=cfq
Nov 13 09:16:05 localhost kernel: Initializing CPU#0
Nov 13 09:16:05 localhost kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Nov 13 09:16:05 localhost kernel: time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
Nov 13 09:16:05 localhost kernel: time.c: Detected 1995.003 MHz processor.
Nov 13 09:16:05 localhost kernel: Console: colour VGA+ 80x25
Nov 13 09:16:05 localhost kernel: Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
Nov 13 09:16:05 localhost kernel: ... MAX_LOCKDEP_SUBCLASSES:    8
Nov 13 09:16:05 localhost kernel: ... MAX_LOCK_DEPTH:          30
Nov 13 09:16:05 localhost kernel: ... MAX_LOCKDEP_KEYS:        2048
Nov 13 09:16:05 localhost kernel: ... CLASSHASH_SIZE:           1024
Nov 13 09:16:05 localhost kernel: ... MAX_LOCKDEP_ENTRIES:     8192
Nov 13 09:16:05 localhost kernel: ... MAX_LOCKDEP_CHAINS:      8192
Nov 13 09:16:05 localhost kernel: ... CHAINHASH_SIZE:          4096
Nov 13 09:16:05 localhost kernel:  memory used by lock dependency info: 1120 kB
Nov 13 09:16:05 localhost kernel:  per task-struct memory footprint: 1680 bytes
Nov 13 09:16:05 localhost kernel: ------------------------
Nov 13 09:16:05 localhost kernel: | Locking API testsuite:
Nov 13 09:16:05 localhost kernel: ----------------------------------------------------------------------------
Nov 13 09:16:05 localhost kernel:                                  | spin |wlock |rlock |mutex | wsem | rsem |
Nov 13 09:16:05 localhost kernel:   --------------------------------------------------------------------------
Nov 13 09:16:05 localhost kernel:                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:   --------------------------------------------------------------------------
Nov 13 09:16:05 localhost kernel:               recursive read-lock:             |  ok  |             |  ok  |
Nov 13 09:16:05 localhost kernel:            recursive read-lock #2:             |  ok  |             |  ok  |
Nov 13 09:16:05 localhost kernel:             mixed read-write-lock:             |  ok  |             |  ok  |
Nov 13 09:16:05 localhost kernel:             mixed write-read-lock:             |  ok  |             |  ok  |
Nov 13 09:16:05 localhost kernel:   --------------------------------------------------------------------------
Nov 13 09:16:05 localhost kernel:      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq read-recursion/123:  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq read-recursion/123:  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq read-recursion/132:  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq read-recursion/132:  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq read-recursion/213:  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq read-recursion/213:  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq read-recursion/231:  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq read-recursion/231:  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq read-recursion/312:  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq read-recursion/312:  ok  |
Nov 13 09:16:05 localhost kernel:       hard-irq read-recursion/321:  ok  |
Nov 13 09:16:05 localhost kernel:       soft-irq read-recursion/321:  ok  |
Nov 13 09:16:05 localhost kernel: -------------------------------------------------------
Nov 13 09:16:05 localhost kernel: Good, all 218 testcases passed! |
Nov 13 09:16:05 localhost kernel: ---------------------------------
Nov 13 09:16:05 localhost kernel: Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Nov 13 09:16:05 localhost kernel: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Nov 13 09:16:05 localhost kernel: Checking aperture...
Nov 13 09:16:05 localhost kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Nov 13 09:16:05 localhost kernel: Placing software IO TLB between 0x7ee8000 - 0xbee8000
Nov 13 09:16:05 localhost kernel: Memory: 4003932k/4980736k available (3209k kernel code, 189252k reserved, 2460k data, 224k init)
Nov 13 09:16:05 localhost kernel: Calibrating delay using timer specific routine.. 3995.41 BogoMIPS (lpj=7990834)
Nov 13 09:16:05 localhost kernel: Mount-cache hash table entries: 256
Nov 13 09:16:05 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Nov 13 09:16:05 localhost kernel: CPU: L2 cache: 4096K
Nov 13 09:16:05 localhost kernel: using mwait in idle threads.
Nov 13 09:16:05 localhost kernel: CPU: Physical Processor ID: 0
Nov 13 09:16:05 localhost kernel: CPU: Processor Core ID: 0
Nov 13 09:16:05 localhost kernel: CPU0: Thermal monitoring enabled (TM1)
Nov 13 09:16:05 localhost kernel: Freeing SMP alternatives: 28k freed
Nov 13 09:16:05 localhost kernel: ACPI: Core revision 20060707
Nov 13 09:16:05 localhost kernel: Using local APIC timer interrupts.
Nov 13 09:16:05 localhost kernel: result 20781277
Nov 13 09:16:05 localhost kernel: Detected 20.781 MHz APIC timer.
Nov 13 09:16:05 localhost kernel: lockdep: not fixing up alternatives.
Nov 13 09:16:05 localhost kernel: Booting processor 1/2 APIC 0x1
Nov 13 09:16:05 localhost kernel: Initializing CPU#1
Nov 13 09:16:05 localhost kernel: Calibrating delay using timer specific routine.. 3990.11 BogoMIPS (lpj=7980222)
Nov 13 09:16:05 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Nov 13 09:16:05 localhost kernel: CPU: L2 cache: 4096K
Nov 13 09:16:05 localhost kernel: CPU: Physical Processor ID: 0
Nov 13 09:16:05 localhost kernel: CPU: Processor Core ID: 1
Nov 13 09:16:05 localhost kernel: CPU1: Thermal monitoring enabled (TM2)
Nov 13 09:16:05 localhost kernel: Intel(R) Xeon(R) CPU            5130  @ 2.00GHz stepping 06
Nov 13 09:16:05 localhost kernel: Brought up 2 CPUs
Nov 13 09:16:05 localhost kernel: testing NMI watchdog ... OK.
Nov 13 09:16:05 localhost kernel: migration_cost=30
Nov 13 09:16:05 localhost kernel: NET: Registered protocol family 16
Nov 13 09:16:05 localhost kernel: ACPI: bus type pci registered
Nov 13 09:16:05 localhost kernel: PCI: Using MMCONFIG at e0000000
Nov 13 09:16:05 localhost kernel: ACPI: Interpreter enabled
Nov 13 09:16:05 localhost kernel: ACPI: Using IOAPIC for interrupt routing
Nov 13 09:16:05 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Nov 13 09:16:05 localhost kernel: PCI: Probing PCI hardware (bus 00)
Nov 13 09:16:05 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Nov 13 09:16:05 localhost kernel: Boot video device is 0000:10:0d.0
Nov 13 09:16:05 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2.UPST._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2.UPST.DWN1._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2.UPST.DWN2._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3.PE2P._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX6._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.SBEX._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.COMP._PRT]
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK00] (IRQs 3 4 *5 6 7 10 11 12)
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK01] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK02] (IRQs 3 4 5 *6 7 10 11 12)
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK03] (IRQs 3 4 5 6 7 10 *11 12)
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK04] (IRQs 3 4 5 6 7 *10 11 12)
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK05] (IRQs 3 4 5 6 7 10 *11 12)
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK06] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Nov 13 09:16:05 localhost kernel: ACPI: PCI Interrupt Link [LK07] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
Nov 13 09:16:05 localhost kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Nov 13 09:16:05 localhost kernel: pnp: PnP ACPI init
Nov 13 09:16:05 localhost kernel: pnp: PnP ACPI: found 12 devices
Nov 13 09:16:05 localhost kernel: SCSI subsystem initialized
Nov 13 09:16:05 localhost kernel: usbcore: registered new driver usbfs
Nov 13 09:16:05 localhost kernel: usbcore: registered new driver hub
Nov 13 09:16:05 localhost kernel: PCI: Using ACPI for IRQ routing
Nov 13 09:16:05 localhost kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Nov 13 09:16:05 localhost kernel: hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
Nov 13 09:16:05 localhost kernel: hpet0: 3 64-bit timers, 14318180 Hz
Nov 13 09:16:05 localhost kernel: PCI-GART: No AMD northbridge found.
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0x800-0x87f could not be reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0x880-0x8bf has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0x8c0-0x8df has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0x8e0-0x8e3 has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0xc00-0xc7f has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0xca0-0xca7 has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0xca9-0xcab has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:08: ioport range 0xcad-0xcaf has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:09: ioport range 0xca8-0xca8 has been reserved
Nov 13 09:16:05 localhost kernel: pnp: 00:09: ioport range 0xcac-0xcac has been reserved
Nov 13 09:16:05 localhost kernel: PCI: Bridge: 0000:08:00.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: f4000000-f7ffffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:07:00.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: f4000000-f7ffffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:07:01.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: disabled.
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:06:00.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: f4000000-f7ffffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:06:00.3
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: disabled.
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:02.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: f2000000-f7ffffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:01:00.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: fc400000-fc5fffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: d8000000-d80fffff
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:01:00.2
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: disabled.
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:03.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: fc300000-fc5fffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: d8000000-d80fffff
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:04.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: disabled.
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:05.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: disabled.
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:06.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: disabled.
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:07.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: disabled.
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:04:00.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: f8000000-fbffffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:1c.0
Nov 13 09:16:06 localhost kernel:   IO window: disabled.
Nov 13 09:16:06 localhost kernel:   MEM window: f8000000-fbffffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: disabled.
Nov 13 09:16:06 localhost kernel: PCI: Bridge: 0000:00:1e.0
Nov 13 09:16:06 localhost kernel:   IO window: e000-efff
Nov 13 09:16:06 localhost kernel:   MEM window: fc100000-fc2fffff
Nov 13 09:16:06 localhost kernel:   PREFETCH window: d0000000-d7ffffff
Nov 13 09:16:06 localhost kernel: GSI 16 sharing vector 0xA9 and IRQ 16
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:06:00.0 to 64
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:07:00.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:08:00.0 to 64
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:07:01.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:07:01.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:06:00.3 to 64
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:03.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:01:00.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:01:00.2 to 64
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:04.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:05.0 to 64
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:07.0 to 64
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:04:00.0 to 64
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Nov 13 09:16:06 localhost kernel: NET: Registered protocol family 2
Nov 13 09:16:06 localhost kernel: IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
Nov 13 09:16:06 localhost kernel: TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
Nov 13 09:16:06 localhost kernel: TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
Nov 13 09:16:06 localhost kernel: TCP: Hash tables configured (established 65536 bind 32768)
Nov 13 09:16:06 localhost kernel: TCP reno registered
Nov 13 09:16:06 localhost kernel: Initializing RT-Tester: OK
Nov 13 09:16:06 localhost kernel: Initializing Cryptographic API
Nov 13 09:16:06 localhost kernel: io scheduler noop registered
Nov 13 09:16:06 localhost kernel: io scheduler anticipatory registered
Nov 13 09:16:06 localhost kernel: io scheduler deadline registered
Nov 13 09:16:06 localhost kernel: io scheduler cfq registered (default)
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:02.0:pcie00]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:02.0:pcie01]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:03.0 to 64
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:03.0:pcie00]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:03.0:pcie01]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:04.0 to 64
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:04.0:pcie00]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:04.0:pcie01]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:05.0 to 64
Nov 13 09:16:06 localhost kernel: pcie_portdrv_probe->Dev[25e5:8086] has invalid IRQ. Check vendor BIOS
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:05.0:pcie00]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:05.0:pcie01]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:06.0:pcie00]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:06.0:pcie01]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:07.0 to 64
Nov 13 09:16:06 localhost kernel: pcie_portdrv_probe->Dev[25e7:8086] has invalid IRQ. Check vendor BIOS
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:07.0:pcie00]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:07.0:pcie01]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:1c.0:pcie00]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:00:1c.0:pcie03]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:06:00.0 to 64
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:06:00.0:pcie10]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:06:00.0:pcie11]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:07:00.0 to 64
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:07:00.0:pcie20]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:07:00.0:pcie21]
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:07:01.0 to 64
Nov 13 09:16:06 localhost kernel: assign_interrupt_mode Found MSI capability
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:07:01.0:pcie20]
Nov 13 09:16:06 localhost kernel: Allocate Port Service[0000:07:01.0:pcie21]
Nov 13 09:16:06 localhost kernel: ACPI: Power Button (FF) [PWRF]
Nov 13 09:16:06 localhost kernel: ACPI: Getting cpuindex for acpiid 0x3
Nov 13 09:16:06 localhost kernel: ACPI: Getting cpuindex for acpiid 0x4
Nov 13 09:16:06 localhost kernel: ACPI: Getting cpuindex for acpiid 0x5
Nov 13 09:16:06 localhost kernel: ACPI: Getting cpuindex for acpiid 0x6
Nov 13 09:16:06 localhost kernel: ACPI: Getting cpuindex for acpiid 0x7
Nov 13 09:16:06 localhost kernel: ACPI: Getting cpuindex for acpiid 0x8
Nov 13 09:16:06 localhost kernel: Real Time Clock Driver v1.12ac
Nov 13 09:16:06 localhost kernel: hpet_resources: 0xfed00000 is busy
Nov 13 09:16:06 localhost kernel: Linux agpgart interface v0.101 (c) Dave Jones
Nov 13 09:16:06 localhost kernel: ipmi message handler version 39.0
Nov 13 09:16:06 localhost kernel: ipmi device interface
Nov 13 09:16:06 localhost kernel: IPMI System Interface driver.
Nov 13 09:16:06 localhost kernel: ipmi_si: Trying SMBIOS-specified KCS state machine at I/O address 0xca8, slave address 0x20, irq 0
Nov 13 09:16:06 localhost kernel: ipmi: Found new BMC (man_id: 0x0002a2,  prod_id: 0x0100, dev_id: 0x20)
Nov 13 09:16:06 localhost kernel:  IPMI KCS interface initialized
Nov 13 09:16:06 localhost kernel: IPMI Watchdog: driver initialized
Nov 13 09:16:06 localhost kernel: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
Nov 13 09:16:06 localhost kernel: IPMI poweroff: Found a chassis style poweroff function
Nov 13 09:16:06 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Nov 13 09:16:06 localhost kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 13 09:16:06 localhost kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Nov 13 09:16:06 localhost kernel: 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 13 09:16:06 localhost kernel: 00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Nov 13 09:16:06 localhost kernel: floppy0: no floppy controllers found
Nov 13 09:16:06 localhost kernel: loop: loaded (max 8 devices)
Nov 13 09:16:06 localhost kernel: Intel(R) PRO/1000 Network Driver - version 7.1.9-k4-NAPI
Nov 13 09:16:06 localhost kernel: Copyright (c) 1999-2006 Intel Corporation.
Nov 13 09:16:06 localhost kernel: Broadcom NetXtreme II Gigabit Ethernet Driver bnx2 v1.4.44 (August 10, 2006)
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:09:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: eth0: Broadcom NetXtreme II BCM5708 1000Base-T (B1) PCI-X 64-bit 133MHz found at mem f4000000, IRQ 16, node addr 00188b431151
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: eth1: Broadcom NetXtreme II BCM5708 1000Base-T (B1) PCI-X 64-bit 133MHz found at mem f8000000, IRQ 16, node addr 00188b43114f
Nov 13 09:16:06 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov 13 09:16:06 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 13 09:16:06 localhost kernel: ESB2: IDE controller at PCI slot 0000:00:1f.1
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
Nov 13 09:16:06 localhost kernel: ESB2: chipset revision 9
Nov 13 09:16:06 localhost kernel: ESB2: not 100%% native mode: will probe irqs later
Nov 13 09:16:06 localhost kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Nov 13 09:16:06 localhost kernel: Probing IDE interface ide0...
Nov 13 09:16:06 localhost kernel: hda: HL-DT-ST DVD-ROM GDR-8084N, ATAPI CD/DVD-ROM drive
Nov 13 09:16:06 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 13 09:16:06 localhost kernel: hda: ATAPI 24X DVD-ROM drive, 2048kB Cache, UDMA(33)
Nov 13 09:16:06 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Nov 13 09:16:06 localhost kernel: megasas: 00.00.03.01 Sun May 14 22:49:52 PDT 2006
Nov 13 09:16:06 localhost kernel: megasas: 0x1028:0x0015:0x1028:0x1f03: bus 2:slot 14:func 0
Nov 13 09:16:06 localhost kernel: GSI 17 sharing vector 0xB1 and IRQ 17
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 78 (level, low) -> IRQ 17
Nov 13 09:16:06 localhost kernel: scsi0 : LSI Logic SAS based MegaRAID driver
Nov 13 09:16:06 localhost kernel:   Vendor: MAXTOR    Model: ATLAS10K5_073SAS  Rev: BP00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: MAXTOR    Model: ATLAS10K5_073SAS  Rev: BP00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: MAXTOR    Model: ATLAS10K5_147SAS  Rev: BP00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: MAXTOR    Model: ATLAS10K5_147SAS  Rev: BP00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: MAXTOR    Model: ATLAS10K5_147SAS  Rev: BP00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: MAXTOR    Model: ATLAS10K5_147SAS  Rev: BP00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: DP        Model: BACKPLANE         Rev: 1.00
Nov 13 09:16:06 localhost kernel:   Type:   Enclosure                          ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: DELL      Model: PERC 5/i          Rev: 1.00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel:   Vendor: DELL      Model: PERC 5/i          Rev: 1.00
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 13 09:16:06 localhost kernel: libata version 2.00 loaded.
Nov 13 09:16:06 localhost kernel: SCSI device sda: 142082048 512-byte hdwr sectors (72746 MB)
Nov 13 09:16:06 localhost kernel: sda: test WP failed, assume Write Enabled
Nov 13 09:16:06 localhost kernel: sda: asking for cache data failed
Nov 13 09:16:06 localhost kernel: sda: assuming drive cache: write through
Nov 13 09:16:06 localhost kernel: SCSI device sda: 142082048 512-byte hdwr sectors (72746 MB)
Nov 13 09:16:06 localhost kernel: sda: test WP failed, assume Write Enabled
Nov 13 09:16:06 localhost kernel: sda: asking for cache data failed
Nov 13 09:16:06 localhost kernel: sda: assuming drive cache: write through
Nov 13 09:16:06 localhost kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
Nov 13 09:16:06 localhost kernel: sd 0:2:0:0: Attached scsi disk sda
Nov 13 09:16:06 localhost kernel: SCSI device sdb: 570949632 512-byte hdwr sectors (292326 MB)
Nov 13 09:16:06 localhost kernel: sdb: test WP failed, assume Write Enabled
Nov 13 09:16:06 localhost kernel: sdb: asking for cache data failed
Nov 13 09:16:06 localhost kernel: sdb: assuming drive cache: write through
Nov 13 09:16:06 localhost kernel: SCSI device sdb: 570949632 512-byte hdwr sectors (292326 MB)
Nov 13 09:16:06 localhost kernel: sdb: test WP failed, assume Write Enabled
Nov 13 09:16:06 localhost kernel: sdb: asking for cache data failed
Nov 13 09:16:06 localhost kernel: sdb: assuming drive cache: write through
Nov 13 09:16:06 localhost kernel:  sdb: sdb1
Nov 13 09:16:06 localhost kernel: sd 0:2:1:0: Attached scsi disk sdb
Nov 13 09:16:06 localhost kernel: GSI 18 sharing vector 0xB9 and IRQ 18
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 18
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Nov 13 09:16:06 localhost kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Nov 13 09:16:06 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Nov 13 09:16:06 localhost kernel: ehci_hcd 0000:00:1d.7: debug port 1
Nov 13 09:16:06 localhost kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Nov 13 09:16:06 localhost kernel: ehci_hcd 0000:00:1d.7: irq 18, io mem 0xfc600000
Nov 13 09:16:06 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Nov 13 09:16:06 localhost kernel: usb usb1: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: hub 1-0:1.0: USB hub found
Nov 13 09:16:06 localhost kernel: hub 1-0:1.0: 6 ports detected
Nov 13 09:16:06 localhost kernel: USB Universal Host Controller Interface driver v3.0
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 18
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.0: irq 18, io base 0x0000dce0
Nov 13 09:16:06 localhost kernel: usb usb2: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: hub 2-0:1.0: USB hub found
Nov 13 09:16:06 localhost kernel: hub 2-0:1.0: 2 ports detected
Nov 13 09:16:06 localhost kernel: GSI 19 sharing vector 0xC1 and IRQ 19
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 20 (level, low) -> IRQ 19
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000dcc0
Nov 13 09:16:06 localhost kernel: usb usb3: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: hub 3-0:1.0: USB hub found
Nov 13 09:16:06 localhost kernel: hub 3-0:1.0: 2 ports detected
Nov 13 09:16:06 localhost kernel: usb 1-1: new high speed USB device using ehci_hcd and address 2
Nov 13 09:16:06 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 18
Nov 13 09:16:06 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Nov 13 09:16:06 localhost kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000dca0
Nov 13 09:16:06 localhost kernel: usb usb4: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: hub 4-0:1.0: USB hub found
Nov 13 09:16:06 localhost kernel: hub 4-0:1.0: 2 ports detected
Nov 13 09:16:06 localhost kernel: usb 1-1: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: hub 1-1:1.0: USB hub found
Nov 13 09:16:06 localhost kernel: hub 1-1:1.0: 2 ports detected
Nov 13 09:16:06 localhost kernel: Initializing USB Mass Storage driver...
Nov 13 09:16:06 localhost kernel: usb 1-5: new high speed USB device using ehci_hcd and address 3
Nov 13 09:16:06 localhost kernel: usb 1-5: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: hub 1-5:1.0: USB hub found
Nov 13 09:16:06 localhost kernel: hub 1-5:1.0: 4 ports detected
Nov 13 09:16:06 localhost kernel: usb 1-1.1: new full speed USB device using ehci_hcd and address 4
Nov 13 09:16:06 localhost kernel: usb 1-1.1: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: usb 1-1.2: new high speed USB device using ehci_hcd and address 5
Nov 13 09:16:06 localhost kernel: usb 1-1.2: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: usb 1-5.2: new low speed USB device using ehci_hcd and address 6
Nov 13 09:16:06 localhost kernel: usb 1-5.2: configuration #1 chosen from 1 choice
Nov 13 09:16:06 localhost kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Nov 13 09:16:06 localhost kernel: usb-storage: device found at 5
Nov 13 09:16:06 localhost kernel: usb-storage: waiting for device to settle before scanning
Nov 13 09:16:06 localhost kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Nov 13 09:16:06 localhost kernel: usb-storage: device found at 5
Nov 13 09:16:06 localhost kernel: usb-storage: waiting for device to settle before scanning
Nov 13 09:16:06 localhost kernel: usbcore: registered new driver usb-storage
Nov 13 09:16:06 localhost kernel: USB Mass Storage support registered.
Nov 13 09:16:06 localhost kernel: usbcore: registered new driver hiddev
Nov 13 09:16:06 localhost kernel: input: Dell DRAC5 as /class/input/input0
Nov 13 09:16:06 localhost kernel: input: USB HID v1.10 Keyboard [Dell DRAC5] on usb-0000:00:1d.7-1.1
Nov 13 09:16:06 localhost kernel: input: Dell DRAC5 as /class/input/input1
Nov 13 09:16:06 localhost kernel: input: USB HID v1.10 Mouse [Dell DRAC5] on usb-0000:00:1d.7-1.1
Nov 13 09:16:06 localhost kernel: input: HID 1267:0103 as /class/input/input2
Nov 13 09:16:06 localhost kernel: input: USB HID v1.10 Keyboard [HID 1267:0103] on usb-0000:00:1d.7-5.2
Nov 13 09:16:06 localhost kernel: input: HID 1267:0103 as /class/input/input3
Nov 13 09:16:06 localhost kernel: input: USB HID v1.10 Device [HID 1267:0103] on usb-0000:00:1d.7-5.2
Nov 13 09:16:06 localhost kernel: usbcore: registered new driver usbhid
Nov 13 09:16:06 localhost kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Nov 13 09:16:06 localhost kernel: usbcore: registered new driver usbserial
Nov 13 09:16:06 localhost kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
Nov 13 09:16:06 localhost kernel: usbcore: registered new driver usbserial_generic
Nov 13 09:16:06 localhost kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core
Nov 13 09:16:06 localhost kernel: PNP: No PS/2 controller found. Probing ports directly.
Nov 13 09:16:06 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 13 09:16:06 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 13 09:16:06 localhost kernel: mice: PS/2 mouse device common for all mice
Nov 13 09:16:06 localhost kernel: I2O subsystem v1.325
Nov 13 09:16:06 localhost kernel: i2o: max drivers = 8
Nov 13 09:16:06 localhost kernel: I2O Configuration OSM v1.323
Nov 13 09:16:06 localhost kernel: I2O Bus Adapter OSM v1.317
Nov 13 09:16:06 localhost kernel: I2O Block Device OSM v1.325
Nov 13 09:16:06 localhost kernel: I2O SCSI Peripheral OSM v1.316
Nov 13 09:16:06 localhost kernel: I2O ProcFS OSM v1.316
Nov 13 09:16:06 localhost kernel: i2c-core: driver [x1205] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [isl1208] registered
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.0: rtc intf: sysfs
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.0: rtc intf: proc
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.0: rtc intf: dev (252:0)
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.0: rtc core: registered test as rtc0
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.1: rtc intf: sysfs
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.1: rtc intf: dev (252:1)
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.1: rtc core: registered test as rtc1
Nov 13 09:16:06 localhost kernel: i2c-core: driver [ds1307] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [ds1672] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [pcf8563] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [pcf8583] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [rs5c372] registered
Nov 13 09:16:06 localhost kernel: max6902 spi driver
Nov 13 09:16:06 localhost kernel: i2c /dev entries driver
Nov 13 09:16:06 localhost kernel: i2c-core: driver [dev_driver] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-9191: ISA main adapter registered
Nov 13 09:16:06 localhost kernel: i2c-pca-isa: i/o base 0x000330. irq 10
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: adapter [PCA9564 ISA Adapter] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x6f
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x6f, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x68
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x68, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c-dev: adapter [PCA9564 ISA Adapter] registered as minor 0
Nov 13 09:16:06 localhost kernel: i2c-core: driver [ds1337] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x68
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x68, len=0
Nov 13 09:16:06 localhost kernel:   Vendor: Dell      Model: Virtual  <5>  Vendor: Dell      Model: Virtual  Floppy   Rev: 123 
Nov 13 09:16:06 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Nov 13 09:16:06 localhost kernel: CDROM    Rev: 123 
Nov 13 09:16:06 localhost kernel:   Type:   CD-ROM                             ANSI SCSI revision: 00<7>i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c-core: driver [ds1374] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x68
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x68, len=0
Nov 13 09:16:06 localhost kernel: 
Nov 13 09:16:06 localhost kernel: sd 2:0:0:0: Attached scsi removable disk sdc
Nov 13 09:16:06 localhost kernel: usb-storage: device scan complete
Nov 13 09:16:06 localhost kernel: usb-storage: device scan complete
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c-core: driver [eeprom] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x50
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x50, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x51
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x51, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x52
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x52, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x53
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x53, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x54
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x54, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x55
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x55, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x56
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x56, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x57
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x57, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c-core: driver [max6875] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [pca9539] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x74
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x74, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x75
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x75, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x76
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x76, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x77
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x77, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c-core: driver [pcf8574] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x20
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x20, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x21
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x21, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x22
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x22, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x23
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x23, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x24
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x24, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x25
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x25, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x26
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x26, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x27
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x27, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x38
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x38, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x39
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x39, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3a
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x3a, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3b
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x3b, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3c
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x3c, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3d
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x3d, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3e
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x3e, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x3f
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x3f, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c-core: driver [pcf8591] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x48
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x48, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x49
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x49, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4a
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x4a, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4b
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x4b, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4c
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x4c, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4d
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x4d, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4e
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x4e, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x4f
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: master_xfer[0] W, addr=0x4f, len=0
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-0: bus is not idle. status is 0xff
Nov 13 09:16:06 localhost kernel: i2c-core: driver [w83792d] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [w83781d] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-9191: Driver w83781d-isa registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-9191: Detection of w83781d chip failed at step 2 (0x7f != 0x0 at 0x295)
Nov 13 09:16:06 localhost kernel: i2c-core: driver [w83791d] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [adm1021] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [adm1025] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [adm1026] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [adm1031] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [adm9240] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [atxp1] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [ds1621] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [fscher] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [fscpos] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [gl518sm] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [gl520sm] registered
Nov 13 09:16:06 localhost kernel: hdaps: supported laptop not found!
Nov 13 09:16:06 localhost kernel: hdaps: driver init failed (ret=-19)!
Nov 13 09:16:06 localhost kernel: i2c-core: driver [it87] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm63] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm75] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm77] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm78] registered
Nov 13 09:16:06 localhost kernel: i2c_adapter i2c-9191: Driver lm78-isa registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm80] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm83] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm87] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm90] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [lm92] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [max1619] registered
Nov 13 09:16:06 localhost kernel: pc87360: PC8736x not detected, module not inserted.
Nov 13 09:16:06 localhost kernel: i2c-core: driver [smsc47m192] registered
Nov 13 09:16:06 localhost kernel: i2c-core: driver [w83l785ts] registered
Nov 13 09:16:06 localhost kernel: md: raid1 personality registered for level 1
Nov 13 09:16:06 localhost kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
Nov 13 09:16:06 localhost kernel: md: bitmap version 4.39
Nov 13 09:16:06 localhost kernel: EDAC MC: Ver: 2.0.1 Nov 10 2006
Nov 13 09:16:06 localhost kernel: EDAC DEBUG: edac_sysfs_memctrl_setup()
Nov 13 09:16:06 localhost kernel: EDAC DEBUG: Registered '.../edac/mc' kobject
Nov 13 09:16:06 localhost kernel: EDAC DEBUG: edac_sysfs_pci_setup()
Nov 13 09:16:06 localhost kernel: EDAC DEBUG: Registered '.../edac/pci' kobject
Nov 13 09:16:06 localhost kernel: dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-2)
Nov 13 09:16:06 localhost kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Nov 13 09:16:06 localhost kernel: TCP bic registered
Nov 13 09:16:06 localhost kernel: NET: Registered protocol family 1
Nov 13 09:16:06 localhost kernel: NET: Registered protocol family 17
Nov 13 09:16:06 localhost kernel: NET: Registered protocol family 15
Nov 13 09:16:06 localhost kernel: rtc-test rtc-test.0: setting the system clock to 2006-11-12 21:57:43 (1163368663)
Nov 13 09:16:06 localhost kernel: md: Autodetecting RAID arrays.
Nov 13 09:16:06 localhost kernel: md: autorun ...
Nov 13 09:16:06 localhost kernel: md: ... autorun DONE.
Nov 13 09:16:06 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov 13 09:16:06 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 13 09:16:06 localhost kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov 13 09:16:06 localhost kernel: Freeing unused kernel memory: 224k freed
Nov 13 09:16:06 localhost kernel: Adding 979924k swap on /dev/sda5.  Priority:-1 extents:1 across:979924k
Nov 13 09:16:06 localhost kernel: EXT3 FS on sda1, internal journal
Nov 13 09:16:06 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov 13 09:16:06 localhost kernel: EXT3 FS on sda2, internal journal
Nov 13 09:16:06 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 13 09:16:06 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov 13 09:16:06 localhost kernel: EXT3 FS on sda6, internal journal
Nov 13 09:16:06 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 13 09:16:06 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov 13 09:16:06 localhost kernel: EXT3 FS on sda7, internal journal
Nov 13 09:16:06 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 13 09:16:06 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov 13 09:16:06 localhost kernel: EXT3 FS on sda8, internal journal
Nov 13 09:16:06 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 13 09:16:06 localhost kernel: bnx2: eth0 NIC Link is Up, 100 Mbps full duplex, receive & transmit flow control ON
Nov 13 09:46:04 localhost kernel: BUG: soft lockup detected on CPU#1!
Nov 13 09:46:04 localhost kernel: 
Nov 13 09:46:04 localhost kernel: Call Trace:
Nov 13 09:46:04 localhost kernel:  [show_trace+185/628] show_trace+0xb9/0x274
Nov 13 09:46:04 localhost kernel:  [dump_stack+21/26] dump_stack+0x15/0x1a
Nov 13 09:46:04 localhost kernel:  [softlockup_tick+231/264] softlockup_tick+0xe7/0x108
Nov 13 09:46:04 localhost kernel:  [run_local_timers+19/21] run_local_timers+0x13/0x15
Nov 13 09:46:04 localhost kernel:  [update_process_times+83/137] update_process_times+0x53/0x89
Nov 13 09:46:04 localhost kernel:  [smp_local_timer_interrupt+46/89] smp_local_timer_interrupt+0x2e/0x59
Nov 13 09:46:04 localhost kernel:  [smp_apic_timer_interrupt+92/106] smp_apic_timer_interrupt+0x5c/0x6a
Nov 13 09:46:04 localhost kernel:  [apic_timer_interrupt+107/112] apic_timer_interrupt+0x6b/0x70
Nov 13 09:46:04 localhost kernel:  [_write_unlock_irqrestore+81/95] _write_unlock_irqrestore+0x51/0x5f
Nov 13 09:46:04 localhost kernel:  [test_clear_page_dirty+189/224] test_clear_page_dirty+0xbd/0xe0
Nov 13 09:46:04 localhost kernel:  [try_to_free_buffers+123/174] try_to_free_buffers+0x7b/0xae
Nov 13 09:46:04 localhost kernel:  [try_to_release_page+68/74] try_to_release_page+0x44/0x4a
Nov 13 09:46:04 localhost kernel:  [invalidate_complete_page+54/191] invalidate_complete_page+0x36/0xbf
Nov 13 09:46:04 localhost kernel:  [invalidate_mapping_pages+157/280] invalidate_mapping_pages+0x9d/0x118
Nov 13 09:46:04 localhost kernel:  [invalidate_inode_pages+18/20] invalidate_inode_pages+0x12/0x14
Nov 13 09:46:04 localhost kernel:  [invalidate_bdev+47/56] invalidate_bdev+0x2f/0x38
Nov 13 09:46:04 localhost kernel:  [kill_bdev+25/52] kill_bdev+0x19/0x34
Nov 13 09:46:04 localhost kernel:  [__blkdev_put+88/314] __blkdev_put+0x58/0x13a
Nov 13 09:46:04 localhost kernel:  [blkdev_put+11/13] blkdev_put+0xb/0xd
Nov 13 09:46:04 localhost kernel:  [blkdev_close+52/61] blkdev_close+0x34/0x3d
Nov 13 09:46:04 localhost kernel:  [__fput+170/306] __fput+0xaa/0x132
Nov 13 09:46:04 localhost kernel:  [fput+21/23] fput+0x15/0x17
Nov 13 09:46:04 localhost kernel:  [filp_close+109/129] filp_close+0x6d/0x81
Nov 13 09:46:04 localhost kernel:  [sys_close+140/168] sys_close+0x8c/0xa8
Nov 13 09:46:04 localhost kernel:  [system_call+126/131] system_call+0x7e/0x83
Nov 13 09:46:04 localhost kernel:  [phys_startup_64+-1072859838/2147483392]
Nov 13 09:46:04 localhost kernel: BUG: soft lockup detected on CPU#1!
Nov 13 09:46:04 localhost kernel: 
Nov 13 09:46:04 localhost kernel: Call Trace:
Nov 13 09:46:04 localhost kernel:  [show_trace+185/628] show_trace+0xb9/0x274
Nov 13 09:46:04 localhost kernel:  [dump_stack+21/26] dump_stack+0x15/0x1a
Nov 13 09:46:04 localhost kernel:  [softlockup_tick+231/264] softlockup_tick+0xe7/0x108
Nov 13 09:46:04 localhost kernel:  [run_local_timers+19/21] run_local_timers+0x13/0x15
Nov 13 09:46:04 localhost kernel:  [update_process_times+83/137] update_process_times+0x53/0x89
Nov 13 09:46:04 localhost kernel:  [smp_local_timer_interrupt+46/89] smp_local_timer_interrupt+0x2e/0x59
Nov 13 09:46:04 localhost kernel:  [smp_apic_timer_interrupt+92/106] smp_apic_timer_interrupt+0x5c/0x6a
Nov 13 09:46:04 localhost kernel:  [apic_timer_interrupt+107/112] apic_timer_interrupt+0x6b/0x70
Nov 13 09:46:04 localhost kernel:  [_write_unlock_irqrestore+81/95] _write_unlock_irqrestore+0x51/0x5f
Nov 13 09:46:04 localhost kernel:  [test_clear_page_dirty+189/224] test_clear_page_dirty+0xbd/0xe0
Nov 13 09:46:04 localhost kernel:  [try_to_free_buffers+123/174] try_to_free_buffers+0x7b/0xae
Nov 13 09:46:04 localhost kernel:  [try_to_release_page+68/74] try_to_release_page+0x44/0x4a
Nov 13 09:46:04 localhost kernel:  [invalidate_complete_page+54/191] invalidate_complete_page+0x36/0xbf
Nov 13 09:46:04 localhost kernel:  [invalidate_mapping_pages+157/280] invalidate_mapping_pages+0x9d/0x118
Nov 13 09:46:04 localhost kernel:  [invalidate_inode_pages+18/20] invalidate_inode_pages+0x12/0x14
Nov 13 09:46:04 localhost kernel:  [invalidate_bdev+47/56] invalidate_bdev+0x2f/0x38
Nov 13 09:46:04 localhost kernel:  [kill_bdev+25/52] kill_bdev+0x19/0x34
Nov 13 09:46:04 localhost kernel:  [__blkdev_put+88/314] __blkdev_put+0x58/0x13a
Nov 13 09:46:04 localhost kernel:  [blkdev_put+11/13] blkdev_put+0xb/0xd
Nov 13 09:46:04 localhost kernel:  [blkdev_close+52/61] blkdev_close+0x34/0x3d
Nov 13 09:46:04 localhost kernel:  [__fput+170/306] __fput+0xaa/0x132
Nov 13 09:46:04 localhost kernel:  [fput+21/23] fput+0x15/0x17
Nov 13 09:46:04 localhost kernel:  [filp_close+109/129] filp_close+0x6d/0x81
Nov 13 09:46:04 localhost kernel:  [sys_close+140/168] sys_close+0x8c/0xa8
Nov 13 09:46:04 localhost kernel:  [system_call+126/131] system_call+0x7e/0x83
Nov 13 09:46:04 localhost kernel:  [phys_startup_64+-1072859838/2147483392]
Nov 13 09:46:04 localhost kernel: BUG: soft lockup detected on CPU#1!
Nov 13 09:46:04 localhost kernel: 
Nov 13 09:46:04 localhost kernel: Call Trace:
Nov 13 09:46:04 localhost kernel:  [show_trace+185/628] show_trace+0xb9/0x274
Nov 13 09:46:04 localhost kernel:  [dump_stack+21/26] dump_stack+0x15/0x1a
Nov 13 09:46:04 localhost kernel:  [softlockup_tick+231/264] softlockup_tick+0xe7/0x108
Nov 13 09:46:04 localhost kernel:  [run_local_timers+19/21] run_local_timers+0x13/0x15
Nov 13 09:46:04 localhost kernel:  [update_process_times+83/137] update_process_times+0x53/0x89
Nov 13 09:46:04 localhost kernel:  [smp_local_timer_interrupt+46/89] smp_local_timer_interrupt+0x2e/0x59
Nov 13 09:46:04 localhost kernel:  [smp_apic_timer_interrupt+92/106] smp_apic_timer_interrupt+0x5c/0x6a
Nov 13 09:46:04 localhost kernel:  [apic_timer_interrupt+107/112] apic_timer_interrupt+0x6b/0x70
Nov 13 09:46:04 localhost kernel:  [_write_unlock_irqrestore+81/95] _write_unlock_irqrestore+0x51/0x5f
Nov 13 09:46:04 localhost kernel:  [test_clear_page_dirty+189/224] test_clear_page_dirty+0xbd/0xe0
Nov 13 09:46:04 localhost kernel:  [try_to_free_buffers+123/174] try_to_free_buffers+0x7b/0xae
Nov 13 09:46:04 localhost kernel:  [try_to_release_page+68/74] try_to_release_page+0x44/0x4a
Nov 13 09:46:04 localhost kernel:  [invalidate_complete_page+54/191] invalidate_complete_page+0x36/0xbf
Nov 13 09:46:04 localhost kernel:  [invalidate_mapping_pages+157/280] invalidate_mapping_pages+0x9d/0x118
Nov 13 09:46:04 localhost kernel:  [invalidate_inode_pages+18/20] invalidate_inode_pages+0x12/0x14
Nov 13 09:46:04 localhost kernel:  [invalidate_bdev+47/56] invalidate_bdev+0x2f/0x38
Nov 13 09:46:04 localhost kernel:  [kill_bdev+25/52] kill_bdev+0x19/0x34
Nov 13 09:46:04 localhost kernel:  [__blkdev_put+88/314] __blkdev_put+0x58/0x13a
Nov 13 09:46:04 localhost kernel:  [blkdev_put+11/13] blkdev_put+0xb/0xd
Nov 13 09:46:04 localhost kernel:  [blkdev_close+52/61] blkdev_close+0x34/0x3d
Nov 13 09:46:04 localhost kernel:  [__fput+170/306] __fput+0xaa/0x132
Nov 13 09:46:04 localhost kernel:  [fput+21/23] fput+0x15/0x17
Nov 13 09:46:04 localhost kernel:  [filp_close+109/129] filp_close+0x6d/0x81
Nov 13 09:46:04 localhost kernel:  [sys_close+140/168] sys_close+0x8c/0xa8
Nov 13 09:46:04 localhost kernel:  [system_call+126/131] system_call+0x7e/0x83
Nov 13 09:46:04 localhost kernel:  [phys_startup_64+-1072859838/2147483392]
Nov 13 09:46:04 localhost kernel: kjournald starting.  Commit interval 5 seconds
Nov 13 09:46:04 localhost kernel: EXT3 FS on sdb1, internal journal
Nov 13 09:46:04 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
