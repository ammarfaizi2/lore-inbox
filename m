Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWARM2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWARM2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWARM2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:28:41 -0500
Received: from pm-mx6.mgn.net ([195.46.220.208]:59781 "EHLO pm-mx6.mx.noos.fr")
	by vger.kernel.org with ESMTP id S932469AbWARM2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:28:40 -0500
Date: Wed, 18 Jan 2006 13:26:31 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1 + reiser* from -rc1-mm1 : BUG with reiserfs
Message-ID: <20060118122631.GA12363@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Using 2.6.16-rc1, patched with *reiser* patches from mm1 (reiserfs and
reiser4) on a p4HT machine with 2 SATA drives, I got this error after
doing some file copying on a reiserfs partition. I include full dmesg
for reference.

Jan 18 10:38:05 brouette kernel: klogd 1.4.1#17.1, log source = /proc/kmsg started.
Jan 18 10:38:05 brouette kernel: Inspecting /boot/System.map-2.6.16-rc1-git-18012006dw
Jan 18 10:38:05 brouette kernel: Loaded 23050 symbols from /boot/System.map-2.6.16-rc1-git-18012006dw.
Jan 18 10:38:05 brouette kernel: Symbols match kernel version 2.6.16.
Jan 18 10:38:05 brouette kernel: No module symbols loaded - kernel modules not enabled. 
Jan 18 10:38:05 brouette kernel: Linux version 2.6.16-rc1-git-18012006dw (root@brouette) (gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #1 SMP Wed Jan 18 10:21:45 CET 2006
Jan 18 10:38:05 brouette kernel: BIOS-provided physical RAM map:
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 0000000000100000 - 000000007ff74000 (usable)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 000000007ff74000 - 000000007ff76000 (ACPI NVS)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 000000007ff76000 - 000000007ff97000 (ACPI data)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 000000007ff97000 - 0000000080000000 (reserved)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Jan 18 10:38:05 brouette kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Jan 18 10:38:05 brouette kernel: 1151MB HIGHMEM available.
Jan 18 10:38:05 brouette kernel: 896MB LOWMEM available.
Jan 18 10:38:05 brouette kernel: found SMP MP-table at 000fe710
Jan 18 10:38:05 brouette kernel: On node 0 totalpages: 524148
Jan 18 10:38:05 brouette kernel:   DMA zone: 4096 pages, LIFO batch:0
Jan 18 10:38:05 brouette kernel:   DMA32 zone: 0 pages, LIFO batch:0
Jan 18 10:38:05 brouette kernel:   Normal zone: 225280 pages, LIFO batch:31
Jan 18 10:38:05 brouette kernel:   HighMem zone: 294772 pages, LIFO batch:31
Jan 18 10:38:05 brouette kernel: DMI 2.3 present.
Jan 18 10:38:05 brouette kernel: ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
Jan 18 10:38:05 brouette kernel: ACPI: RSDT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1ca
Jan 18 10:38:05 brouette kernel: ACPI: FADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd1fe
Jan 18 10:38:05 brouette kernel: ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc929b
Jan 18 10:38:05 brouette kernel: ACPI: MADT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd272
Jan 18 10:38:05 brouette kernel: ACPI: BOOT (v001 DELL    8300    0x00000008 ASL  0x00000061) @ 0x000fd2de
Jan 18 10:38:05 brouette kernel: ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
Jan 18 10:38:05 brouette kernel: ACPI: PM-Timer IO Port: 0x808
Jan 18 10:38:05 brouette kernel: ACPI: Local APIC address 0xfee00000
Jan 18 10:38:05 brouette kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jan 18 10:38:05 brouette kernel: Processor #0 15:3 APIC version 20
Jan 18 10:38:05 brouette kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jan 18 10:38:05 brouette kernel: Processor #1 15:3 APIC version 20
Jan 18 10:38:05 brouette kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
Jan 18 10:38:05 brouette kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
Jan 18 10:38:05 brouette kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan 18 10:38:05 brouette kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jan 18 10:38:05 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan 18 10:38:05 brouette kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jan 18 10:38:05 brouette kernel: ACPI: IRQ0 used by override.
Jan 18 10:38:05 brouette kernel: ACPI: IRQ2 used by override.
Jan 18 10:38:05 brouette kernel: ACPI: IRQ9 used by override.
Jan 18 10:38:05 brouette kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jan 18 10:38:05 brouette kernel: Using ACPI (MADT) for SMP configuration information
Jan 18 10:38:05 brouette kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Jan 18 10:38:05 brouette kernel: Built 1 zonelists
Jan 18 10:38:05 brouette kernel: Kernel command line: root=/dev/sdb2 ro vga=0x31B selinux=0 elevator=cfq 
Jan 18 10:38:05 brouette kernel: mapped APIC to ffffd000 (fee00000)
Jan 18 10:38:05 brouette kernel: mapped IOAPIC to ffffc000 (fec00000)
Jan 18 10:38:05 brouette kernel: Enabling fast FPU save and restore... done.
Jan 18 10:38:05 brouette kernel: Enabling unmasked SIMD FPU exception support... done.
Jan 18 10:38:05 brouette kernel: Initializing CPU#0
Jan 18 10:38:05 brouette kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Jan 18 10:38:05 brouette kernel: Detected 2993.838 MHz processor.
Jan 18 10:38:05 brouette kernel: Using pmtmr for high-res timesource
Jan 18 10:38:05 brouette kernel: Console: colour dummy device 80x25
Jan 18 10:38:05 brouette kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan 18 10:38:05 brouette kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jan 18 10:38:05 brouette kernel: Memory: 2075016k/2096592k available (1931k kernel code, 20392k reserved, 702k data, 168k init, 1179088k highmem)
Jan 18 10:38:05 brouette kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan 18 10:38:05 brouette kernel: Calibrating delay using timer specific routine.. 5992.04 BogoMIPS (lpj=2996020)
Jan 18 10:38:05 brouette kernel: Mount-cache hash table entries: 512
Jan 18 10:38:05 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 18 10:38:05 brouette kernel: CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 18 10:38:05 brouette kernel: monitor/mwait feature present.
Jan 18 10:38:05 brouette kernel: using mwait in idle threads.
Jan 18 10:38:05 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jan 18 10:38:05 brouette kernel: CPU: L2 cache: 1024K
Jan 18 10:38:05 brouette kernel: CPU: Physical Processor ID: 0
Jan 18 10:38:05 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000041d 00000000 00000000
Jan 18 10:38:05 brouette kernel: Intel machine check architecture supported.
Jan 18 10:38:05 brouette kernel: Intel machine check reporting enabled on CPU#0.
Jan 18 10:38:05 brouette kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Jan 18 10:38:05 brouette kernel: CPU0: Thermal monitoring enabled
Jan 18 10:38:05 brouette kernel: mtrr: v2.0 (20020519)
Jan 18 10:38:05 brouette kernel: Checking 'hlt' instruction... OK.
Jan 18 10:38:05 brouette kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jan 18 10:38:05 brouette kernel: Booting processor 1/1 eip 2000
Jan 18 10:38:05 brouette kernel: Initializing CPU#1
Jan 18 10:38:05 brouette kernel: Calibrating delay using timer specific routine.. 5984.26 BogoMIPS (lpj=2992132)
Jan 18 10:38:05 brouette kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 18 10:38:05 brouette kernel: CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000041d 00000000 00000000
Jan 18 10:38:05 brouette kernel: monitor/mwait feature present.
Jan 18 10:38:05 brouette kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jan 18 10:38:05 brouette kernel: CPU: L2 cache: 1024K
Jan 18 10:38:05 brouette kernel: CPU: Physical Processor ID: 0
Jan 18 10:38:05 brouette kernel: CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000041d 00000000 00000000
Jan 18 10:38:05 brouette kernel: Intel machine check architecture supported.
Jan 18 10:38:05 brouette kernel: Intel machine check reporting enabled on CPU#1.
Jan 18 10:38:05 brouette kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Jan 18 10:38:05 brouette kernel: CPU1: Thermal monitoring enabled
Jan 18 10:38:05 brouette kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jan 18 10:38:05 brouette kernel: Total of 2 processors activated (11976.30 BogoMIPS).
Jan 18 10:38:05 brouette kernel: ENABLING IO-APIC IRQs
Jan 18 10:38:05 brouette kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan 18 10:38:05 brouette kernel: checking TSC synchronization across 2 CPUs: passed.
Jan 18 10:38:05 brouette kernel: Brought up 2 CPUs
Jan 18 10:38:05 brouette kernel: migration_cost=1000
Jan 18 10:38:05 brouette kernel: NET: Registered protocol family 16
Jan 18 10:38:05 brouette kernel: ACPI: bus type pci registered
Jan 18 10:38:05 brouette kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=2
Jan 18 10:38:05 brouette kernel: PCI: Using configuration type 1
Jan 18 10:38:05 brouette kernel: ACPI: Subsystem revision 20050902
Jan 18 10:38:05 brouette kernel: ACPI: Interpreter enabled
Jan 18 10:38:05 brouette kernel: ACPI: Using IOAPIC for interrupt routing
Jan 18 10:38:05 brouette kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan 18 10:38:05 brouette kernel: PCI: Probing PCI hardware (bus 00)
Jan 18 10:38:05 brouette kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Jan 18 10:38:05 brouette kernel: PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
Jan 18 10:38:05 brouette kernel: PCI quirk: region 0880-08bf claimed by ICH4 GPIO
Jan 18 10:38:05 brouette kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jan 18 10:38:05 brouette kernel: Boot video device is 0000:01:00.0
Jan 18 10:38:05 brouette kernel: PCI: Transparent bridge - 0000:00:1e.0
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Jan 18 10:38:05 brouette kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan 18 10:38:05 brouette kernel: pnp: PnP ACPI init
Jan 18 10:38:05 brouette kernel: pnp: PnP ACPI: found 11 devices
Jan 18 10:38:05 brouette kernel: SCSI subsystem initialized
Jan 18 10:38:05 brouette kernel: PCI: Using ACPI for IRQ routing
Jan 18 10:38:05 brouette kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jan 18 10:38:05 brouette kernel: pnp: 00:0a: ioport range 0x800-0x85f could not be reserved
Jan 18 10:38:05 brouette kernel: pnp: 00:0a: ioport range 0xc00-0xc7f has been reserved
Jan 18 10:38:05 brouette kernel: pnp: 00:0a: ioport range 0x860-0x8ff could not be reserved
Jan 18 10:38:05 brouette kernel: PCI: Bridge: 0000:00:01.0
Jan 18 10:38:05 brouette kernel:   IO window: disabled.
Jan 18 10:38:05 brouette kernel:   MEM window: fd000000-feafffff
Jan 18 10:38:05 brouette kernel:   PREFETCH window: f0000000-f7ffffff
Jan 18 10:38:05 brouette kernel: PCI: Bridge: 0000:00:1e.0
Jan 18 10:38:05 brouette kernel:   IO window: d000-dfff
Jan 18 10:38:05 brouette kernel:   MEM window: fcf00000-fcffffff
Jan 18 10:38:05 brouette kernel:   PREFETCH window: disabled.
Jan 18 10:38:05 brouette kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Jan 18 10:38:05 brouette kernel: Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Jan 18 10:38:05 brouette kernel: Simple Boot Flag at 0x7a set to 0x1
Jan 18 10:38:05 brouette kernel: Machine check exception polling timer started.
Jan 18 10:38:05 brouette kernel: highmem bounce pool size: 64 pages
Jan 18 10:38:05 brouette kernel: Loading Reiser4. See www.namesys.com for a description of Reiser4.
Jan 18 10:38:05 brouette kernel: Initializing Cryptographic API
Jan 18 10:38:05 brouette kernel: io scheduler noop registered
Jan 18 10:38:05 brouette kernel: io scheduler anticipatory registered
Jan 18 10:38:05 brouette kernel: io scheduler deadline registered
Jan 18 10:38:05 brouette kernel: io scheduler cfq registered (default)
Jan 18 10:38:05 brouette kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, using 10240k, total 131072k
Jan 18 10:38:05 brouette kernel: vesafb: mode is 1280x1024x32, linelength=5120, pages=0
Jan 18 10:38:05 brouette kernel: vesafb: protected mode interface info at c000:f080
Jan 18 10:38:05 brouette kernel: vesafb: scrolling: redraw
Jan 18 10:38:05 brouette kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Jan 18 10:38:05 brouette kernel: Console: switching to colour frame buffer device 160x64
Jan 18 10:38:05 brouette kernel: fb0: VESA VGA frame buffer device
Jan 18 10:38:05 brouette kernel: Real Time Clock Driver v1.12ac
Jan 18 10:38:05 brouette kernel: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Jan 18 10:38:05 brouette kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 18 10:38:05 brouette kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 18 10:38:05 brouette kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Jan 18 10:38:05 brouette kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
Jan 18 10:38:05 brouette kernel: e100: Copyright(c) 1999-2005 Intel Corporation
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 169
Jan 18 10:38:05 brouette kernel: e100: eth0: e100_probe: addr 0xfcfff000, irq 169, MAC addr 00:0C:F1:B6:BA:54
Jan 18 10:38:05 brouette kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 18 10:38:05 brouette kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 18 10:38:05 brouette kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
Jan 18 10:38:05 brouette kernel: ICH5: chipset revision 2
Jan 18 10:38:05 brouette kernel: ICH5: not 100%% native mode: will probe irqs later
Jan 18 10:38:05 brouette kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Jan 18 10:38:05 brouette kernel: Probing IDE interface ide1...
Jan 18 10:38:05 brouette kernel: hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
Jan 18 10:38:05 brouette kernel: hdd: SAMSUNG CD-R/RW SW-252S, ATAPI CD/DVD-ROM drive
Jan 18 10:38:05 brouette kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 18 10:38:05 brouette kernel: Probing IDE interface ide0...
Jan 18 10:38:05 brouette kernel: hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Jan 18 10:38:05 brouette kernel: Uniform CD-ROM driver Revision: 3.20
Jan 18 10:38:05 brouette kernel: hdd: ATAPI 16X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Jan 18 10:38:05 brouette kernel: Driver 'ide-scsi' needs updating - please use bus_type methods
Jan 18 10:38:05 brouette kernel: libata version 1.20 loaded.
Jan 18 10:38:05 brouette kernel: ata_piix 0000:00:1f.2: version 1.05
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
Jan 18 10:38:05 brouette kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Jan 18 10:38:05 brouette kernel: ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 177
Jan 18 10:38:05 brouette kernel: ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 177
Jan 18 10:38:05 brouette kernel: ata1: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
Jan 18 10:38:05 brouette kernel: ata1: dev 0 ATA-6, max UDMA/133, 144531250 sectors: LBA48
Jan 18 10:38:05 brouette kernel: ata1(0): applying bridge limits
Jan 18 10:38:05 brouette kernel: ata1: dev 0 configured for UDMA/100
Jan 18 10:38:05 brouette kernel: scsi0 : ata_piix
Jan 18 10:38:05 brouette kernel: ata2: dev 0 cfg 49:2f00 82:74e9 83:7f63 84:4003 85:74e9 86:3e43 87:4003 88:207f
Jan 18 10:38:05 brouette kernel: ata2: dev 0 ATA-6, max UDMA/133, 144531250 sectors: LBA48
Jan 18 10:38:05 brouette kernel: ata2(0): applying bridge limits
Jan 18 10:38:05 brouette kernel: ata2: dev 0 configured for UDMA/100
Jan 18 10:38:05 brouette kernel: scsi1 : ata_piix
Jan 18 10:38:05 brouette kernel:   Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
Jan 18 10:38:05 brouette kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jan 18 10:38:05 brouette kernel:   Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
Jan 18 10:38:05 brouette kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jan 18 10:38:05 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Jan 18 10:38:05 brouette kernel: sda: Write Protect is off
Jan 18 10:38:05 brouette kernel: sda: Mode Sense: 00 3a 00 00
Jan 18 10:38:05 brouette kernel: SCSI device sda: drive cache: write back
Jan 18 10:38:05 brouette kernel: SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
Jan 18 10:38:05 brouette kernel: sda: Write Protect is off
Jan 18 10:38:05 brouette kernel: sda: Mode Sense: 00 3a 00 00
Jan 18 10:38:05 brouette kernel: SCSI device sda: drive cache: write back
Jan 18 10:38:05 brouette kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Jan 18 10:38:05 brouette kernel: sd 0:0:0:0: Attached scsi disk sda
Jan 18 10:38:05 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Jan 18 10:38:05 brouette kernel: sdb: Write Protect is off
Jan 18 10:38:05 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Jan 18 10:38:05 brouette kernel: SCSI device sdb: drive cache: write back
Jan 18 10:38:05 brouette kernel: SCSI device sdb: 144531250 512-byte hdwr sectors (74000 MB)
Jan 18 10:38:05 brouette kernel: sdb: Write Protect is off
Jan 18 10:38:05 brouette kernel: sdb: Mode Sense: 00 3a 00 00
Jan 18 10:38:05 brouette kernel: SCSI device sdb: drive cache: write back
Jan 18 10:38:05 brouette kernel:  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 >
Jan 18 10:38:05 brouette kernel: sd 1:0:0:0: Attached scsi disk sdb
Jan 18 10:38:05 brouette kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan 18 10:38:05 brouette kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
Jan 18 10:38:05 brouette kernel: mice: PS/2 mouse device common for all mice
Jan 18 10:38:05 brouette kernel: NET: Registered protocol family 2
Jan 18 10:38:05 brouette kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Jan 18 10:38:05 brouette kernel: IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan 18 10:38:05 brouette kernel: TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
Jan 18 10:38:05 brouette kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Jan 18 10:38:05 brouette kernel: TCP: Hash tables configured (established 524288 bind 65536)
Jan 18 10:38:05 brouette kernel: TCP reno registered
Jan 18 10:38:05 brouette kernel: TCP bic registered
Jan 18 10:38:05 brouette kernel: NET: Registered protocol family 1
Jan 18 10:38:05 brouette kernel: NET: Registered protocol family 17
Jan 18 10:38:05 brouette kernel: Starting balanced_irq
Jan 18 10:38:05 brouette kernel: Using IPI Shortcut mode
Jan 18 10:38:05 brouette kernel: logips2pp: Detected unknown logitech mouse model 63
Jan 18 10:38:05 brouette kernel: kjournald starting.  Commit interval 5 seconds
Jan 18 10:38:05 brouette kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan 18 10:38:05 brouette kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jan 18 10:38:05 brouette kernel: Freeing unused kernel memory: 168k freed
Jan 18 10:38:05 brouette kernel: input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
Jan 18 10:38:05 brouette kernel: usbcore: registered new driver usbfs
Jan 18 10:38:05 brouette kernel: usbcore: registered new driver hub
Jan 18 10:38:05 brouette kernel: USB Universal Host Controller Interface driver v2.3
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 185
Jan 18 10:38:05 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.0: irq 185, io base 0x0000ff80
Jan 18 10:38:05 brouette kernel: usb usb1: configuration #1 chosen from 1 choice
Jan 18 10:38:05 brouette kernel: hub 1-0:1.0: USB hub found
Jan 18 10:38:05 brouette kernel: hub 1-0:1.0: 2 ports detected
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Jan 18 10:38:05 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.1: irq 193, io base 0x0000ff60
Jan 18 10:38:05 brouette kernel: usb usb2: configuration #1 chosen from 1 choice
Jan 18 10:38:05 brouette kernel: hub 2-0:1.0: USB hub found
Jan 18 10:38:05 brouette kernel: hub 2-0:1.0: 2 ports detected
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 177
Jan 18 10:38:05 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jan 18 10:38:05 brouette kernel: usb 1-1: new full speed USB device using uhci_hcd and address 2
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.2: irq 177, io base 0x0000ff40
Jan 18 10:38:05 brouette kernel: usb usb3: configuration #1 chosen from 1 choice
Jan 18 10:38:05 brouette kernel: hub 3-0:1.0: USB hub found
Jan 18 10:38:05 brouette kernel: hub 3-0:1.0: 2 ports detected
Jan 18 10:38:05 brouette kernel: input: PC Speaker as /class/input/input2
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 185
Jan 18 10:38:05 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
Jan 18 10:38:05 brouette kernel: uhci_hcd 0000:00:1d.3: irq 185, io base 0x0000ff20
Jan 18 10:38:05 brouette kernel: usb usb4: configuration #1 chosen from 1 choice
Jan 18 10:38:05 brouette kernel: hub 4-0:1.0: USB hub found
Jan 18 10:38:05 brouette kernel: hub 4-0:1.0: 2 ports detected
Jan 18 10:38:05 brouette kernel: parport: PnPBIOS parport detected.
Jan 18 10:38:05 brouette kernel: parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
Jan 18 10:38:05 brouette kernel: usb 1-1: configuration #1 chosen from 1 choice
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
Jan 18 10:38:05 brouette kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jan 18 10:38:05 brouette kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jan 18 10:38:05 brouette kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jan 18 10:38:05 brouette kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jan 18 10:38:05 brouette kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
Jan 18 10:38:05 brouette kernel: ehci_hcd 0000:00:1d.7: irq 201, io mem 0xffa80800
Jan 18 10:38:05 brouette kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jan 18 10:38:05 brouette kernel: usb usb5: configuration #1 chosen from 1 choice
Jan 18 10:38:05 brouette kernel: usb 1-1: USB disconnect, address 2
Jan 18 10:38:05 brouette kernel: hub 5-0:1.0: USB hub found
Jan 18 10:38:05 brouette kernel: hub 5-0:1.0: 8 ports detected
Jan 18 10:38:05 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 209
Jan 18 10:38:05 brouette kernel: usb 1-1: new full speed USB device using uhci_hcd and address 3
Jan 18 10:38:05 brouette kernel: usb 1-1: configuration #1 chosen from 1 choice
Jan 18 10:38:05 brouette kernel: Adding 2048248k swap on /dev/sdb10.  Priority:-1 extents:1 across:2048248k
Jan 18 10:38:05 brouette kernel: EXT3 FS on sdb2, internal journal
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb5: using ordered data mode
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb5: checking transaction log (sdb5)
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb5: Using r5 hash to sort names
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb6: using ordered data mode
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb6: journal params: device sdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb6: checking transaction log (sdb6)
Jan 18 10:38:05 brouette kernel: ReiserFS: sdb6: Using r5 hash to sort names
Jan 18 10:38:05 brouette kernel: JFS: nTxBlock = 8192, nTxLock = 65536
Jan 18 10:38:05 brouette kernel: SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
Jan 18 10:38:05 brouette kernel: XFS mounting filesystem sdb9
Jan 18 10:38:05 brouette kernel: Ending clean XFS mount for filesystem: sdb9
Jan 18 10:38:05 brouette kernel: XFS mounting filesystem sda5
Jan 18 10:38:05 brouette kernel: Ending clean XFS mount for filesystem: sda5
Jan 18 10:38:05 brouette kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Jan 18 11:10:14 brouette kernel: ------------[ cut here ]------------
Jan 18 11:10:14 brouette kernel: kernel BUG at fs/reiserfs/bitmap.c:1325!
Jan 18 11:10:14 brouette kernel: invalid opcode: 0000 [#1]
Jan 18 11:10:14 brouette kernel: SMP 
Jan 18 11:10:14 brouette kernel: Modules linked in: nls_iso8859_1 nls_cp437 vfat fat xfs jfs snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd parport_pc soundcore parport pcspkr ehci_hcd uhci_hcd usbcore
Jan 18 11:10:14 brouette kernel: CPU:    0
Jan 18 11:10:14 brouette kernel: EIP:    0060:[reiserfs_cache_bitmap_metadata+106/118]    Not tainted VLI
Jan 18 11:10:14 brouette kernel: EFLAGS: 00010246   (2.6.16-rc1-git-18012006dw) 
Jan 18 11:10:14 brouette kernel: EIP is at reiserfs_cache_bitmap_metadata+0x6a/0x76
Jan 18 11:10:14 brouette kernel: eax: 00000000   ebx: ee5ff000   ecx: 00000000   edx: 00000000
Jan 18 11:10:14 brouette kernel: esi: f93ad030   edi: 00000000   ebp: f7fa6800   esp: f446bd4c
Jan 18 11:10:14 brouette kernel: ds: 007b   es: 007b   ss: 0068
Jan 18 11:10:14 brouette kernel: Process svn (pid: 2404, threadinfo=f446a000 task=f7ca8030)
Jan 18 11:10:14 brouette kernel: Stack: <0>ee5c94b0 f93ad030 00001000 c017bced f7fa6800 ee5c94b0 f93ad030 f93ad030 
Jan 18 11:10:14 brouette kernel:        f7fa6800 ee5fbb10 ee5fb790 c017bd40 f7fa6800 0000000c 00000000 f446be9c 
Jan 18 11:10:14 brouette kernel:        ee5fb790 c0184038 ee5fbb10 00000000 f7fa6800 00000001 00000000 00000000 
Jan 18 11:10:14 brouette kernel: Call Trace:
Jan 18 11:10:14 brouette kernel:  [reiserfs_read_bitmap_block+148/158] reiserfs_read_bitmap_block+0x94/0x9e
Jan 18 11:10:14 brouette kernel:  [reiserfs_choose_packing+73/124] reiserfs_choose_packing+0x49/0x7c
Jan 18 11:10:14 brouette kernel:  [reiserfs_new_inode+105/1737] reiserfs_new_inode+0x69/0x6c9
Jan 18 11:10:14 brouette kernel:  [reiserfs_find_entry+101/717] reiserfs_find_entry+0x65/0x2cd
Jan 18 11:10:14 brouette kernel:  [d_rehash+79/93] d_rehash+0x4f/0x5d
Jan 18 11:10:14 brouette kernel:  [d_splice_alias+142/156] d_splice_alias+0x8e/0x9c
Jan 18 11:10:14 brouette kernel:  [do_journal_begin_r+103/614] do_journal_begin_r+0x67/0x266
Jan 18 11:10:14 brouette kernel:  [reiserfs_create+176/445] reiserfs_create+0xb0/0x1bd
Jan 18 11:10:14 brouette kernel:  [vfs_create+95/157] vfs_create+0x5f/0x9d
Jan 18 11:10:14 brouette kernel:  [open_namei+327/1335] open_namei+0x147/0x537
Jan 18 11:10:14 brouette kernel:  [filp_open+34/56] filp_open+0x22/0x38
Jan 18 11:10:14 brouette kernel:  [do_sys_open+60/175] do_sys_open+0x3c/0xaf
Jan 18 11:10:14 brouette kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Jan 18 11:10:14 brouette kernel: Code: 00 0f a3 0b 19 c0 85 c0 75 0a 8d 04 0f 66 89 06 66 ff 46 02 49 83 f9 ff 75 e7 4a 83 ef 08 83 c3 04 85 d2 7f bd 66 83 3e 00 75 08 <0f> 0b 2d 05 3a b4 2f c0 5b 5e 5f c3 8b 54 24 04 8b 82 80 01 00 
Jan 18 11:10:14 brouette kernel:  Badness in do_exit at kernel/exit.c:799
Jan 18 11:10:14 brouette kernel:  [do_exit+60/1725] do_exit+0x3c/0x6bd
Jan 18 11:10:14 brouette kernel:  [do_simd_coprocessor_error+0/335] do_simd_coprocessor_error+0x0/0x14f
Jan 18 11:10:14 brouette kernel:  [do_invalid_op+0/158] do_invalid_op+0x0/0x9e
Jan 18 11:10:14 brouette kernel:  [do_invalid_op+146/158] do_invalid_op+0x92/0x9e
Jan 18 11:10:14 brouette kernel:  [reiserfs_cache_bitmap_metadata+106/118] reiserfs_cache_bitmap_metadata+0x6a/0x76
Jan 18 11:10:14 brouette kernel:  [kobject_release+0/10] kobject_release+0x0/0xa
Jan 18 11:10:14 brouette kernel:  [scsi_request_fn+704/745] scsi_request_fn+0x2c0/0x2e9
Jan 18 11:10:14 brouette kernel:  [io_schedule+38/48] io_schedule+0x26/0x30
Jan 18 11:10:14 brouette kernel:  [error_code+79/84] error_code+0x4f/0x54
Jan 18 11:10:14 brouette kernel:  [reiserfs_cache_bitmap_metadata+106/118] reiserfs_cache_bitmap_metadata+0x6a/0x76
Jan 18 11:10:14 brouette kernel:  [reiserfs_read_bitmap_block+148/158] reiserfs_read_bitmap_block+0x94/0x9e
Jan 18 11:10:14 brouette kernel:  [reiserfs_choose_packing+73/124] reiserfs_choose_packing+0x49/0x7c
Jan 18 11:10:14 brouette kernel:  [reiserfs_new_inode+105/1737] reiserfs_new_inode+0x69/0x6c9
Jan 18 11:10:14 brouette kernel:  [reiserfs_find_entry+101/717] reiserfs_find_entry+0x65/0x2cd
Jan 18 11:10:14 brouette kernel:  [d_rehash+79/93] d_rehash+0x4f/0x5d
Jan 18 11:10:14 brouette kernel:  [d_splice_alias+142/156] d_splice_alias+0x8e/0x9c
Jan 18 11:10:14 brouette kernel:  [do_journal_begin_r+103/614] do_journal_begin_r+0x67/0x266
Jan 18 11:10:14 brouette kernel:  [reiserfs_create+176/445] reiserfs_create+0xb0/0x1bd
Jan 18 11:10:14 brouette kernel:  [vfs_create+95/157] vfs_create+0x5f/0x9d
Jan 18 11:10:14 brouette kernel:  [open_namei+327/1335] open_namei+0x147/0x537
Jan 18 11:10:14 brouette kernel:  [filp_open+34/56] filp_open+0x22/0x38
Jan 18 11:10:14 brouette kernel:  [do_sys_open+60/175] do_sys_open+0x3c/0xaf
Jan 18 11:10:14 brouette kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Jan 18 11:10:14 brouette kernel: BUG: svn/2404, lock held at task exit time!
Jan 18 11:10:14 brouette kernel:  [ee5fbb84] {inode_init_once}
Jan 18 11:10:14 brouette kernel: .. held by:               svn: 2404 [f7ca8030, 116]
Jan 18 11:10:14 brouette kernel: ... acquired at:               open_namei+0xd8/0x537
Jan 18 12:49:22 brouette kernel: SysRq : Emergency Sync

The two partitions foramatted as reiserfs have these options :

/dev/sdb5       /usr            reiserfs defaults,noatime           0       2
/dev/sdb6       /home           reiserfs defaults,noatime           0       2

-- 
Damien Wyart
