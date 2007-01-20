Return-Path: <linux-kernel-owner+w=401wt.eu-S965220AbXATHuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbXATHuM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 02:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbXATHuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 02:50:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:46336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965223AbXATHuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 02:50:06 -0500
X-Authenticated: #5039886
Date: Sat, 20 Jan 2007 08:50:01 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       htejun@gmail.com, jens.axboe@oracle.com, lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070120075001.GA4905@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Hancock <hancockr@shaw.ca>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
	htejun@gmail.com, jens.axboe@oracle.com, lwalton@real.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AC1DA3.5040104@shaw.ca> <45AC3006.9070705@garzik.org> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca> <20070120072755.GA4652@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070120072755.GA4652@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darn, didn't remove enough stuff (hit the 100K limit), next try. Sorry
if anyone gets this duplicated for whatever reason.

On 2007.01.20 08:27:55 +0100, Björn Steinbrink wrote:
> On 2007.01.19 20:41:36 -0600, Robert Hancock wrote:
> > Alistair John Strachan wrote:
> > >On Tuesday 16 January 2007 01:53, Jeff Garzik wrote:
> > >>Robert Hancock wrote:
> > >>>I'll try your stress test when I get a chance, but I doubt I'll run into
> > >>>the same problem and I haven't seen any similar reports. Perhaps it's
> > >>>some kind of wierd timing issue or incompatibility between the
> > >>>controller and that drive when running in ADMA mode? I seem to remember
> > >>>various reports of issues with certain Maxtor drives and some nForce
> > >>>SATA controllers under Windows at least..
> > >>Just to eliminate things, has disabling ADMA been attempted?
> > >>
> > >>It can be disabled using the sata_nv.adma module parameter.
> > >
> > >Setting this option fixes the problem for me. I suggest that ADMA defaults 
> > >off in 2.6.20, if there's still time to do that.
> > >
> > 
> > Can you guys that are having this problem try the attached debug patch? 
> > It's possible it will fix the problem, as I'm trying a private 
> > exec_command implementation that flushes the write by reading a 
> > controller register instead of reading altstatus from the drive like the 
> > libata core code does.
> > 
> > If the problem still happens, I also added some more debugging in to 
> > help figure out what is going on, so please post full dmesg.
> 
> Running it with my little test case produced almost 1MB of dmesg before
> it hit an exception. I'm not exactly sure, but the delay caused by that
> exception seemed to be about twice as long as without the patch, could
> be my imagination though...
> 
> As the messages seem to be the same all the time, I snipped a good bunch
> out of the log, if you really want to see the whole thing, let me know.
> 
> Thanks,
> Björn
> 
> 
> 
> Jan 20 07:14:55 atjola syslog-ng[1592]: syslog-ng starting up; version='2.0.0' 
> Jan 20 07:14:55 atjola kernel: Linux version 2.6.20-rc5-sata (doener@atjola) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #7 SMP Sat Jan 20 07:11:46 CET 2007
> Jan 20 07:14:55 atjola kernel: Command line: root=/dev/md0 ro quiet 
> Jan 20 07:14:55 atjola kernel: BIOS-provided physical RAM map:
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 0000000000100000 - 000000007fee0000 (usable)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 000000007fee0000 - 000000007fee3000 (ACPI NVS)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 000000007fee3000 - 000000007fef0000 (ACPI data)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 000000007fef0000 - 000000007ff00000 (reserved)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> Jan 20 07:14:55 atjola kernel: BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> Jan 20 07:14:55 atjola kernel: Entering add_active_range(0, 0, 159) 0 entries of 256 used
> Jan 20 07:14:55 atjola kernel: Entering add_active_range(0, 256, 524000) 1 entries of 256 used
> Jan 20 07:14:55 atjola kernel: end_pfn_map = 1048576
> Jan 20 07:14:55 atjola kernel: DMI 2.2 present.
> Jan 20 07:14:55 atjola kernel: ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7a70
> Jan 20 07:14:55 atjola kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fee3040
> Jan 20 07:14:55 atjola kernel: ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fee30c0
> Jan 20 07:14:55 atjola kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fee9540
> Jan 20 07:14:55 atjola kernel: ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fee9780
> Jan 20 07:14:55 atjola kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fee9480
> Jan 20 07:14:55 atjola kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
> Jan 20 07:14:55 atjola kernel: Entering add_active_range(0, 0, 159) 0 entries of 256 used
> Jan 20 07:14:55 atjola kernel: Entering add_active_range(0, 256, 524000) 1 entries of 256 used
> Jan 20 07:14:55 atjola kernel: Zone PFN ranges:
> Jan 20 07:14:55 atjola kernel: DMA             0 ->     4096
> Jan 20 07:14:55 atjola kernel: DMA32        4096 ->  1048576
> Jan 20 07:14:55 atjola kernel: Normal    1048576 ->  1048576
> Jan 20 07:14:55 atjola kernel: early_node_map[2] active PFN ranges
> Jan 20 07:14:55 atjola kernel: 0:        0 ->      159
> Jan 20 07:14:55 atjola kernel: 0:      256 ->   524000
> Jan 20 07:14:55 atjola kernel: On node 0 totalpages: 523903
> Jan 20 07:14:55 atjola kernel: DMA zone: 56 pages used for memmap
> Jan 20 07:14:55 atjola kernel: DMA zone: 1122 pages reserved
> Jan 20 07:14:55 atjola kernel: DMA zone: 2821 pages, LIFO batch:0
> Jan 20 07:14:55 atjola kernel: DMA32 zone: 7108 pages used for memmap
> Jan 20 07:14:55 atjola kernel: DMA32 zone: 512796 pages, LIFO batch:31
> Jan 20 07:14:55 atjola kernel: Normal zone: 0 pages used for memmap
> Jan 20 07:14:55 atjola kernel: Nvidia board detected. Ignoring ACPI timer override.
> Jan 20 07:14:55 atjola kernel: If you got timer trouble try acpi_use_timer_override
> Jan 20 07:14:55 atjola kernel: ACPI: PM-Timer IO Port: 0x1008
> Jan 20 07:14:55 atjola kernel: ACPI: Local APIC address 0xfee00000
> Jan 20 07:14:55 atjola kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Jan 20 07:14:55 atjola kernel: Processor #0 (Bootup-CPU)
> Jan 20 07:14:55 atjola kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Jan 20 07:14:55 atjola kernel: Processor #1
> Jan 20 07:14:55 atjola kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> Jan 20 07:14:55 atjola kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> Jan 20 07:14:55 atjola kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> Jan 20 07:14:55 atjola kernel: IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
> Jan 20 07:14:55 atjola kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Jan 20 07:14:55 atjola kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
> Jan 20 07:14:55 atjola kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
> Jan 20 07:14:55 atjola kernel: ACPI: IRQ9 used by override.
> Jan 20 07:14:55 atjola kernel: ACPI: IRQ14 used by override.
> Jan 20 07:14:55 atjola kernel: ACPI: IRQ15 used by override.
> Jan 20 07:14:55 atjola kernel: Setting APIC routing to flat
> Jan 20 07:14:55 atjola kernel: Using ACPI (MADT) for SMP configuration information
> Jan 20 07:14:55 atjola kernel: Nosave address range: 000000000009f000 - 00000000000a0000
> Jan 20 07:14:55 atjola kernel: Nosave address range: 00000000000a0000 - 00000000000f0000
> Jan 20 07:14:55 atjola kernel: Nosave address range: 00000000000f0000 - 0000000000100000
> Jan 20 07:14:55 atjola kernel: Allocating PCI resources starting at 80000000 (gap: 7ff00000:60100000)
> Jan 20 07:14:55 atjola kernel: PERCPU: Allocating 32000 bytes of per cpu data
> Jan 20 07:14:55 atjola kernel: Built 1 zonelists.  Total pages: 515617
> Jan 20 07:14:55 atjola kernel: Kernel command line: root=/dev/md0 ro quiet 
> Jan 20 07:14:55 atjola kernel: Initializing CPU#0
> Jan 20 07:14:55 atjola kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
> Jan 20 07:14:55 atjola kernel: Console: colour VGA+ 80x25
> Jan 20 07:14:55 atjola kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Jan 20 07:14:55 atjola kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Jan 20 07:14:55 atjola kernel: Checking aperture...
> Jan 20 07:14:55 atjola kernel: CPU 0: aperture @ 7a74000000 size 32 MB
> Jan 20 07:14:55 atjola kernel: Aperture too small (32 MB)
> Jan 20 07:14:55 atjola kernel: No AGP bridge found
> Jan 20 07:14:55 atjola kernel: Memory: 2059000k/2096000k available (2796k kernel code, 36392k reserved, 1088k data, 224k init)
> Jan 20 07:14:55 atjola kernel: Calibrating delay using timer specific routine.. 2010.39 BogoMIPS (lpj=10051993)
> Jan 20 07:14:55 atjola kernel: Mount-cache hash table entries: 256
> Jan 20 07:14:55 atjola kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> Jan 20 07:14:55 atjola kernel: CPU: L2 Cache: 1024K (64 bytes/line)
> Jan 20 07:14:55 atjola kernel: CPU: Physical Processor ID: 0
> Jan 20 07:14:55 atjola kernel: CPU: Processor Core ID: 0
> Jan 20 07:14:55 atjola kernel: Freeing SMP alternatives: 28k freed
> Jan 20 07:14:55 atjola kernel: ACPI: Core revision 20060707
> Jan 20 07:14:55 atjola kernel: Using local APIC timer interrupts.
> Jan 20 07:14:55 atjola kernel: result 12558007
> Jan 20 07:14:55 atjola kernel: Detected 12.558 MHz APIC timer.
> Jan 20 07:14:55 atjola kernel: Booting processor 1/2 APIC 0x1
> Jan 20 07:14:55 atjola kernel: Initializing CPU#1
> Jan 20 07:14:55 atjola kernel: Calibrating delay using timer specific routine.. 2009.30 BogoMIPS (lpj=10046526)
> Jan 20 07:14:55 atjola kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> Jan 20 07:14:55 atjola kernel: CPU: L2 Cache: 1024K (64 bytes/line)
> Jan 20 07:14:55 atjola kernel: CPU: Physical Processor ID: 0
> Jan 20 07:14:55 atjola kernel: CPU: Processor Core ID: 1
> Jan 20 07:14:55 atjola kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
> Jan 20 07:14:55 atjola kernel: CPU 1: Syncing TSC to CPU 0.
> Jan 20 07:14:55 atjola kernel: CPU 1: synchronized TSC with CPU 0 (last diff 22 cycles, maxerr 344 cycles)
> Jan 20 07:14:55 atjola kernel: Brought up 2 CPUs
> Jan 20 07:14:55 atjola kernel: testing NMI watchdog ... OK.
> Jan 20 07:14:55 atjola kernel: Disabling vsyscall due to use of PM timer
> Jan 20 07:14:55 atjola kernel: time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
> Jan 20 07:14:55 atjola kernel: time.c: Detected 1004.639 MHz processor.
> Jan 20 07:14:55 atjola kernel: migration_cost=453
> Jan 20 07:14:55 atjola kernel: NET: Registered protocol family 16
> Jan 20 07:14:55 atjola kernel: ACPI: bus type pci registered
> Jan 20 07:14:55 atjola kernel: PCI: Using configuration type 1
> Jan 20 07:14:55 atjola kernel: ACPI: Interpreter enabled
> Jan 20 07:14:55 atjola kernel: ACPI: Using IOAPIC for interrupt routing
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
> Jan 20 07:14:55 atjola kernel: PCI: Probing PCI hardware (bus 00)
> Jan 20 07:14:55 atjola kernel: PCI: Transparent bridge - 0000:00:09.0
> Jan 20 07:14:55 atjola kernel: Boot video device is 0000:05:00.0
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 5 7 9 10 *11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 *5 7 9 10 11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 5 7 9 *10 11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 *5 7 9 10 11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 3 5 *7 9 10 11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs *3 5 7 9 10 11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 5 *7 9 10 11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 3 5 7 9 *10 11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LSID] (IRQs 3 5 7 9 10 *11 12 14 15)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LFID] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [LPCA] (IRQs 3 5 7 9 10 11 12 14 15) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
> Jan 20 07:14:55 atjola kernel: SCSI subsystem initialized
> Jan 20 07:14:55 atjola kernel: libata version 2.00 loaded.
> Jan 20 07:14:55 atjola kernel: usbcore: registered new interface driver usbfs
> Jan 20 07:14:55 atjola kernel: usbcore: registered new interface driver hub
> Jan 20 07:14:55 atjola kernel: usbcore: registered new device driver usb
> Jan 20 07:14:55 atjola kernel: PCI: Using ACPI for IRQ routing
> Jan 20 07:14:55 atjola kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> Jan 20 07:14:55 atjola kernel: PCI: Bridge: 0000:00:09.0
> Jan 20 07:14:55 atjola kernel: IO window: c000-cfff
> Jan 20 07:14:55 atjola kernel: MEM window: fc000000-fdffffff
> Jan 20 07:14:55 atjola kernel: PREFETCH window: fea00000-feafffff
> Jan 20 07:14:55 atjola kernel: PCI: Bridge: 0000:00:0b.0
> Jan 20 07:14:55 atjola kernel: IO window: b000-bfff
> Jan 20 07:14:55 atjola kernel: MEM window: fe900000-fe9fffff
> Jan 20 07:14:55 atjola kernel: PREFETCH window: fe800000-fe8fffff
> Jan 20 07:14:55 atjola kernel: PCI: Bridge: 0000:00:0c.0
> Jan 20 07:14:55 atjola kernel: IO window: a000-afff
> Jan 20 07:14:55 atjola kernel: MEM window: fe700000-fe7fffff
> Jan 20 07:14:55 atjola kernel: PREFETCH window: fe600000-fe6fffff
> Jan 20 07:14:55 atjola kernel: PCI: Bridge: 0000:00:0d.0
> Jan 20 07:14:55 atjola kernel: IO window: 9000-9fff
> Jan 20 07:14:55 atjola kernel: MEM window: fe500000-fe5fffff
> Jan 20 07:14:55 atjola kernel: PREFETCH window: fe400000-fe4fffff
> Jan 20 07:14:55 atjola kernel: PCI: Bridge: 0000:00:0e.0
> Jan 20 07:14:55 atjola kernel: IO window: 8000-8fff
> Jan 20 07:14:55 atjola kernel: MEM window: f4000000-fbffffff
> Jan 20 07:14:55 atjola kernel: PREFETCH window: d0000000-dfffffff
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:09.0 to 64
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0b.0 to 64
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0c.0 to 64
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0d.0 to 64
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0e.0 to 64
> Jan 20 07:14:55 atjola kernel: NET: Registered protocol family 2
> Jan 20 07:14:55 atjola kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
> Jan 20 07:14:55 atjola kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> Jan 20 07:14:55 atjola kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> Jan 20 07:14:55 atjola kernel: TCP: Hash tables configured (established 262144 bind 65536)
> Jan 20 07:14:55 atjola kernel: TCP reno registered
> Jan 20 07:14:55 atjola kernel: io scheduler noop registered
> Jan 20 07:14:55 atjola kernel: io scheduler deadline registered (default)
> Jan 20 07:14:55 atjola kernel: 0000:00:02.1 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
> Jan 20 07:14:55 atjola kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0b.0
> Jan 20 07:14:55 atjola kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
> Jan 20 07:14:55 atjola kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0c.0
> Jan 20 07:14:55 atjola kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
> Jan 20 07:14:55 atjola kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0d.0
> Jan 20 07:14:55 atjola kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
> Jan 20 07:14:55 atjola kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0e.0
> Jan 20 07:14:55 atjola kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0b.0 to 64
> Jan 20 07:14:55 atjola kernel: assign_interrupt_mode Found MSI capability
> Jan 20 07:14:55 atjola kernel: Allocate Port Service[0000:00:0b.0:pcie00]
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0c.0 to 64
> Jan 20 07:14:55 atjola kernel: assign_interrupt_mode Found MSI capability
> Jan 20 07:14:55 atjola kernel: Allocate Port Service[0000:00:0c.0:pcie00]
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0d.0 to 64
> Jan 20 07:14:55 atjola kernel: assign_interrupt_mode Found MSI capability
> Jan 20 07:14:55 atjola kernel: Allocate Port Service[0000:00:0d.0:pcie00]
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0e.0 to 64
> Jan 20 07:14:55 atjola kernel: assign_interrupt_mode Found MSI capability
> Jan 20 07:14:55 atjola kernel: Allocate Port Service[0000:00:0e.0:pcie00]
> Jan 20 07:14:55 atjola kernel: input: Power Button (FF) as /class/input/input0
> Jan 20 07:14:55 atjola kernel: ACPI: Power Button (FF) [PWRF]
> Jan 20 07:14:55 atjola kernel: input: Power Button (CM) as /class/input/input1
> Jan 20 07:14:55 atjola kernel: ACPI: Power Button (CM) [PWRB]
> Jan 20 07:14:55 atjola kernel: ACPI: Thermal Zone [THRM] (40 C)
> Jan 20 07:14:55 atjola kernel: Real Time Clock Driver v1.12ac
> Jan 20 07:14:55 atjola kernel: Linux agpgart interface v0.101 (c) Dave Jones
> Jan 20 07:14:55 atjola kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
> Jan 20 07:14:55 atjola kernel: tg3.c:v3.72 (January 8, 2007)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:04:00.0 to 64
> Jan 20 07:14:55 atjola kernel: eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000Base-T Ethernet 00:e0:81:55:09:b0
> Jan 20 07:14:55 atjola kernel: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
> Jan 20 07:14:55 atjola kernel: eth0: dma_rwctrl[76180000] dma_mask[64-bit]
> Jan 20 07:14:55 atjola kernel: tun: Universal TUN/TAP device driver, 1.6
> Jan 20 07:14:55 atjola kernel: tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> Jan 20 07:14:55 atjola kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Jan 20 07:14:55 atjola kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Jan 20 07:14:55 atjola kernel: NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
> Jan 20 07:14:55 atjola kernel: NFORCE-CK804: chipset revision 242
> Jan 20 07:14:55 atjola kernel: NFORCE-CK804: not 100% native mode: will probe irqs later
> Jan 20 07:14:55 atjola kernel: NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
> Jan 20 07:14:55 atjola kernel: ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:DMA
> Jan 20 07:14:55 atjola kernel: Probing IDE interface ide0...
> Jan 20 07:14:55 atjola kernel: hda: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
> Jan 20 07:14:55 atjola kernel: hdb: AOPEN CD-RW CRW4852 1.00 20030123, ATAPI CD/DVD-ROM drive
> Jan 20 07:14:55 atjola kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Jan 20 07:14:55 atjola kernel: Probing IDE interface ide1...
> Jan 20 07:14:55 atjola kernel: hda: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
> Jan 20 07:14:55 atjola kernel: Uniform CD-ROM driver Revision: 3.20
> Jan 20 07:14:55 atjola kernel: hdb: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Jan 20 07:14:55 atjola kernel: sata_nv 0000:00:07.0: version 3.2
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 23
> Jan 20 07:14:55 atjola kernel: sata_nv 0000:00:07.0: Using ADMA mode
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:07.0 to 64
> Jan 20 07:14:55 atjola kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000004480 ctl 0xFFFFC200000044A0 bmdma 0xD400 irq 23
> Jan 20 07:14:55 atjola kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000004580 ctl 0xFFFFC200000045A0 bmdma 0xD408 irq 23
> Jan 20 07:14:55 atjola kernel: scsi0 : sata_nv
> Jan 20 07:14:55 atjola kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Jan 20 07:14:55 atjola kernel: ata1.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
> Jan 20 07:14:55 atjola kernel: ata1.00: ata1: dev 0 multi count 16
> Jan 20 07:14:55 atjola kernel: ata1.00: configured for UDMA/133
> Jan 20 07:14:55 atjola kernel: scsi1 : sata_nv
> Jan 20 07:14:55 atjola kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Jan 20 07:14:55 atjola kernel: ata2.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
> Jan 20 07:14:55 atjola kernel: ata2.00: ata2: dev 0 multi count 16
> Jan 20 07:14:55 atjola kernel: ata2.00: configured for UDMA/133
> Jan 20 07:14:55 atjola kernel: scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
> Jan 20 07:14:55 atjola kernel: ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
> Jan 20 07:14:55 atjola kernel: SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
> Jan 20 07:14:55 atjola kernel: sda: Write Protect is off
> Jan 20 07:14:55 atjola kernel: sda: Mode Sense: 00 3a 00 00
> Jan 20 07:14:55 atjola kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 20 07:14:55 atjola kernel: SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
> Jan 20 07:14:55 atjola kernel: sda: Write Protect is off
> Jan 20 07:14:55 atjola kernel: sda: Mode Sense: 00 3a 00 00
> Jan 20 07:14:55 atjola kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 20 07:14:55 atjola kernel: sda: sda1 sda2 sda3
> Jan 20 07:14:55 atjola kernel: sd 0:0:0:0: Attached scsi disk sda
> Jan 20 07:14:55 atjola kernel: scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
> Jan 20 07:14:55 atjola kernel: ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
> Jan 20 07:14:55 atjola kernel: SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
> Jan 20 07:14:55 atjola kernel: sdb: Write Protect is off
> Jan 20 07:14:55 atjola kernel: sdb: Mode Sense: 00 3a 00 00
> Jan 20 07:14:55 atjola kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 20 07:14:55 atjola kernel: SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
> Jan 20 07:14:55 atjola kernel: sdb: Write Protect is off
> Jan 20 07:14:55 atjola kernel: sdb: Mode Sense: 00 3a 00 00
> Jan 20 07:14:55 atjola kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 20 07:14:55 atjola kernel: sdb: sdb1 sdb2 sdb3
> Jan 20 07:14:55 atjola kernel: sd 1:0:0:0: Attached scsi disk sdb
> Jan 20 07:14:55 atjola kernel: usbmon: debugfs is not available
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 22 (level, low) -> IRQ 22
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:02.1 to 64
> Jan 20 07:14:55 atjola kernel: ehci_hcd 0000:00:02.1: EHCI Host Controller
> Jan 20 07:14:55 atjola kernel: ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
> Jan 20 07:14:55 atjola kernel: ehci_hcd 0000:00:02.1: debug port 1
> Jan 20 07:14:55 atjola kernel: PCI: cache line size of 64 is not supported by device 0000:00:02.1
> Jan 20 07:14:55 atjola kernel: ehci_hcd 0000:00:02.1: irq 22, io mem 0xfeb00000
> Jan 20 07:14:55 atjola kernel: ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> Jan 20 07:14:55 atjola kernel: usb usb1: configuration #1 chosen from 1 choice
> Jan 20 07:14:55 atjola kernel: hub 1-0:1.0: USB hub found
> Jan 20 07:14:55 atjola kernel: hub 1-0:1.0: 8 ports detected
> Jan 20 07:14:55 atjola kernel: ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 (level, low) -> IRQ 21
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
> Jan 20 07:14:55 atjola kernel: ohci_hcd 0000:00:02.0: OHCI Host Controller
> Jan 20 07:14:55 atjola kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
> Jan 20 07:14:55 atjola kernel: ohci_hcd 0000:00:02.0: irq 21, io mem 0xfebff000
> Jan 20 07:14:55 atjola kernel: usb usb2: configuration #1 chosen from 1 choice
> Jan 20 07:14:55 atjola kernel: hub 2-0:1.0: USB hub found
> Jan 20 07:14:55 atjola kernel: hub 2-0:1.0: 8 ports detected
> Jan 20 07:14:55 atjola kernel: usb 1-5: new high speed USB device using ehci_hcd and address 2
> Jan 20 07:14:55 atjola kernel: usb 1-5: configuration #1 chosen from 1 choice
> Jan 20 07:14:55 atjola kernel: usb 2-6: new full speed USB device using ohci_hcd and address 2
> Jan 20 07:14:55 atjola kernel: usb 2-6: configuration #1 chosen from 1 choice
> Jan 20 07:14:55 atjola kernel: hub 2-6:1.0: USB hub found
> Jan 20 07:14:55 atjola kernel: hub 2-6:1.0: 4 ports detected
> Jan 20 07:14:55 atjola kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0022
> Jan 20 07:14:55 atjola kernel: usb 2-6.3: new low speed USB device using ohci_hcd and address 3
> Jan 20 07:14:55 atjola kernel: usb 2-6.3: configuration #1 chosen from 1 choice
> Jan 20 07:14:55 atjola kernel: usb 2-6.4: new low speed USB device using ohci_hcd and address 4
> Jan 20 07:14:55 atjola kernel: usb 2-6.4: configuration #1 chosen from 1 choice
> Jan 20 07:14:55 atjola kernel: usbcore: registered new interface driver usblp
> Jan 20 07:14:55 atjola kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Jan 20 07:14:55 atjola kernel: Initializing USB Mass Storage driver...
> Jan 20 07:14:55 atjola kernel: usbcore: registered new interface driver usb-storage
> Jan 20 07:14:55 atjola kernel: USB Mass Storage support registered.
> Jan 20 07:14:55 atjola kernel: usbcore: registered new interface driver hiddev
> Jan 20 07:14:55 atjola kernel: input: Lite-On Tech IBM USB Keyboard with UltraNav as /class/input/input2
> Jan 20 07:14:55 atjola kernel: input: USB HID v1.10 Keyboard [Lite-On Tech IBM USB Keyboard with UltraNav] on usb-0000:00:02.0-6.3
> Jan 20 07:14:55 atjola kernel: input: Lite-On Tech IBM USB Keyboard with UltraNav as /class/input/input3
> Jan 20 07:14:55 atjola kernel: input: USB HID v1.10 Device [Lite-On Tech IBM USB Keyboard with UltraNav] on usb-0000:00:02.0-6.3
> Jan 20 07:14:55 atjola kernel: input: Synaptics Inc. Composite TouchPad / TrackPoint as /class/input/input4
> Jan 20 07:14:55 atjola kernel: input: USB HID v1.00 Mouse [Synaptics Inc. Composite TouchPad / TrackPoint] on usb-0000:00:02.0-6.4
> Jan 20 07:14:55 atjola kernel: input: Synaptics Inc. Composite TouchPad / TrackPoint as /class/input/input5
> Jan 20 07:14:55 atjola kernel: input: USB HID v1.00 Mouse [Synaptics Inc. Composite TouchPad / TrackPoint] on usb-0000:00:02.0-6.4
> Jan 20 07:14:55 atjola kernel: usbcore: registered new interface driver usbhid
> Jan 20 07:14:55 atjola kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> Jan 20 07:14:55 atjola kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> Jan 20 07:14:55 atjola kernel: mice: PS/2 mouse device common for all mice
> Jan 20 07:14:55 atjola kernel: md: raid1 personality registered for level 1
> Jan 20 07:14:55 atjola kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
> Jan 20 07:14:55 atjola kernel: Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Tue Jan 09 09:56:17 2007 UTC).
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
> Jan 20 07:14:55 atjola kernel: gameport: EMU10K1 is pci0000:01:08.1/gameport0, io 0xc400, speed 1194kHz
> Jan 20 07:14:55 atjola kernel: input: Microsoft SideWinder GamePad as /class/input/input6
> Jan 20 07:14:55 atjola kernel: ALSA device list:
> Jan 20 07:14:55 atjola kernel: #0: Audigy 1 [SB0090] (rev.3, serial:0x531102) at 0xc800, irq 19
> Jan 20 07:14:55 atjola kernel: TCP cubic registered
> Jan 20 07:14:55 atjola kernel: NET: Registered protocol family 1
> Jan 20 07:14:55 atjola kernel: NET: Registered protocol family 17
> Jan 20 07:14:55 atjola kernel: NET: Registered protocol family 15
> Jan 20 07:14:55 atjola kernel: powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ processors (version 2.00.00)
> Jan 20 07:14:55 atjola kernel: powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
> Jan 20 07:14:55 atjola kernel: powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
> Jan 20 07:14:55 atjola kernel: powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
> Jan 20 07:14:55 atjola kernel: powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0xe
> Jan 20 07:14:55 atjola kernel: md: Autodetecting RAID arrays.
> Jan 20 07:14:55 atjola kernel: md: autorun ...
> Jan 20 07:14:55 atjola kernel: md: considering sdb3 ...
> Jan 20 07:14:55 atjola kernel: md:  adding sdb3 ...
> Jan 20 07:14:55 atjola kernel: md: sdb1 has different UUID to sdb3
> Jan 20 07:14:55 atjola kernel: md:  adding sda3 ...
> Jan 20 07:14:55 atjola kernel: md: sda1 has different UUID to sdb3
> Jan 20 07:14:55 atjola kernel: md: created md1
> Jan 20 07:14:55 atjola kernel: md: bind<sda3>
> Jan 20 07:14:55 atjola kernel: md: bind<sdb3>
> Jan 20 07:14:55 atjola kernel: md: running: <sdb3><sda3>
> Jan 20 07:14:55 atjola kernel: raid1: raid set md1 active with 2 out of 2 mirrors
> Jan 20 07:14:55 atjola kernel: md: considering sdb1 ...
> Jan 20 07:14:55 atjola kernel: md:  adding sdb1 ...
> Jan 20 07:14:55 atjola kernel: md:  adding sda1 ...
> Jan 20 07:14:55 atjola kernel: md: created md0
> Jan 20 07:14:55 atjola kernel: md: bind<sda1>
> Jan 20 07:14:55 atjola kernel: md: bind<sdb1>
> Jan 20 07:14:55 atjola kernel: md: running: <sdb1><sda1>
> Jan 20 07:14:55 atjola kernel: raid1: raid set md0 active with 2 out of 2 mirrors
> Jan 20 07:14:55 atjola kernel: md: ... autorun DONE.
> Jan 20 07:14:55 atjola kernel: kjournald starting.  Commit interval 5 seconds
> Jan 20 07:14:55 atjola kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jan 20 07:14:55 atjola kernel: VFS: Mounted root (ext3 filesystem) readonly.
> Jan 20 07:14:55 atjola kernel: Freeing unused kernel memory: 224k freed
> Jan 20 07:14:55 atjola kernel: forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
> Jan 20 07:14:55 atjola kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 20 (level, low) -> IRQ 20
> Jan 20 07:14:55 atjola kernel: PCI: Setting latency timer of device 0000:00:0a.0 to 64
> Jan 20 07:14:55 atjola kernel: forcedeth: using HIGHDMA
> Jan 20 07:14:55 atjola kernel: eth1: forcedeth.c: subsystem: 010f1:2865 bound to 0000:00:0a.0
> Jan 20 07:14:55 atjola kernel: Adding 979956k swap on /dev/sda2.  Priority:-1 extents:1 across:979956k
> Jan 20 07:14:55 atjola kernel: Adding 979956k swap on /dev/sdb2.  Priority:-2 extents:1 across:979956k
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: EXT3 FS on md0, internal journal
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: kjournald starting.  Commit interval 5 seconds
> Jan 20 07:14:55 atjola kernel: EXT3 FS on dm-4, internal journal
> Jan 20 07:14:55 atjola kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jan 20 07:14:55 atjola kernel: kjournald starting.  Commit interval 5 seconds
> Jan 20 07:14:55 atjola kernel: EXT3 FS on dm-0, internal journal
> Jan 20 07:14:55 atjola kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jan 20 07:14:55 atjola kernel: kjournald starting.  Commit interval 5 seconds
> Jan 20 07:14:55 atjola kernel: EXT3 FS on dm-1, internal journal
> Jan 20 07:14:55 atjola kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jan 20 07:14:55 atjola kernel: kjournald starting.  Commit interval 5 seconds
> Jan 20 07:14:55 atjola kernel: EXT3 FS on dm-3, internal journal
> Jan 20 07:14:55 atjola kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: eth1: no link during initialization.
> Jan 20 07:14:55 atjola kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
> Jan 20 07:14:55 atjola kernel: tg3: eth0: Flow control is off for TX and off for RX.
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:55 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:55 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:55 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:56 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:56 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:56 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:56 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:56 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:56 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:56 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:56 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:56 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:56 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:56 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:57 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:57 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:58 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:58 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:58 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:58 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:58 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:58 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:58 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:14:58 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:58 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:14:58 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:14:58 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:14:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10

[-- SNIP --]

> Jan 20 07:15:09 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:09 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:09 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:09 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:09 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:09 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:09 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:09 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:09 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:09 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:09 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:09 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:09 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:11 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:11 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:11 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:11 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:11 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:11 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:11 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:12 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:12 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:12 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:13 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:13 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:13 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:13 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:13 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1

[-- SNIP --]

> Jan 20 07:15:22 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:22 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:22 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:22 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:22 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:22 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:22 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:22 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:22 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:22 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:22 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:22 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:22 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:23 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:23 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:23 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:23 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:15:24 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:15:24 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> 
> [-- SNIP --]
> 
> Jan 20 07:26:38 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:38 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:38 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:38 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:38 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:38 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:38 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:38 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:38 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:38 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:38 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:38 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:38 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:38 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:41 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:41 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:41 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:41 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:41 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:41 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:42 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:42 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:46 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:46 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:46 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:46 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:46 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:46 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:47 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:47 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:47 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:47 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:47 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:47 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:47 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1

[-- SNIP --]

> Jan 20 07:26:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:57 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:26:57 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:26:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:57 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:26:57 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:26:57 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:26:58 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:00 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:01 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:02 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:27 atjola kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> Jan 20 07:27:27 atjola kernel: ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
> Jan 20 07:27:27 atjola kernel: res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Jan 20 07:27:28 atjola kernel: ata1: soft resetting port
> Jan 20 07:27:28 atjola kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Jan 20 07:27:28 atjola kernel: ata1.00: configured for UDMA/133
> Jan 20 07:27:28 atjola kernel: ata1: EH complete
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: sda: Write Protect is off
> Jan 20 07:27:28 atjola kernel: sda: Mode Sense: 00 3a 00 00
> Jan 20 07:27:28 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active but stat 0x10
> Jan 20 07:27:28 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata1: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata2: cmd 0xe7 active but stat 0x0
> Jan 20 07:27:28 atjola kernel: ata2: cmd 0xe7 active, stat = 0x1, handled = 0x1
> Jan 20 07:27:28 atjola kernel: ata2: issue flush cmd 0xe7
> Jan 20 07:27:28 atjola kernel: ata1: issue flush cmd 0xe7
> 
> [More of the same...]
