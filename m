Return-Path: <linux-kernel-owner+w=401wt.eu-S965349AbXATSuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349AbXATSuk (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 13:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbXATSuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 13:50:40 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:43341 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965349AbXATSui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 13:50:38 -0500
From: Chr <chunkeey@web.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Sat, 20 Jan 2007 19:50:14 +0100
User-Agent: KMail/1.9.5
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jeff Garzik <jeff@garzik.org>,
       =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com, chunkeey@web.de
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca>
In-Reply-To: <45B18160.9020602@shaw.ca>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nRmsFZItxm7lRC2"
Message-Id: <200701201950.15321.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_nRmsFZItxm7lRC2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday, 20. January 2007 03:41, Robert Hancock wrote:
> Alistair John Strachan wrote:
> > On Tuesday 16 January 2007 01:53, Jeff Garzik wrote:
> >> Robert Hancock wrote:
> >>> I'll try your stress test when I get a chance, but I doubt I'll run
> >>> into the same problem and I haven't seen any similar reports. Perhaps
> >>> it's some kind of wierd timing issue or incompatibility between the
> >>> controller and that drive when running in ADMA mode? I seem to remember
> >>> various reports of issues with certain Maxtor drives and some nForce
> >>> SATA controllers under Windows at least..
> >>
> >> Just to eliminate things, has disabling ADMA been attempted?
> >>
> >> It can be disabled using the sata_nv.adma module parameter.
> >
> > Setting this option fixes the problem for me. I suggest that ADMA
> > defaults off in 2.6.20, if there's still time to do that.
>
> Can you guys that are having this problem try the attached debug patch?
> It's possible it will fix the problem, as I'm trying a private
> exec_command implementation that flushes the write by reading a
> controller register instead of reading altstatus from the drive like the
> libata core code does.
>
> If the problem still happens, I also added some more debugging in to
> help figure out what is going on, so please post full dmesg.
>
> By the way, I assume that you guys are using reiserfs or xfs, as it
> appears no other file systems issue flush commands automatically. I had
> to test this by "echo 1 > delete" on the SCSI disk in sysfs, as I am
> using ext3.
Yes, I've some reiserfs partitions, but I don't think it's reiserfs fault ;). 
Here is the log. (I cut out some parts, because it was too big.) 


BTW: please CC, I'm not on the list!

--Boundary-00=_nRmsFZItxm7lRC2
Content-Type: text/x-log;
  charset="iso-8859-15";
  name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kern.log"

18:17:29 sys kernel: Linux version 2.6.20-rc5 (root@sys) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP PREEMPT Sat 18:07:36 CET 2007
18:17:29 sys kernel: Command line: root=/dev/md1 ro 
18:17:29 sys kernel: BIOS-provided physical RAM map:
18:17:29 sys kernel: BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
18:17:29 sys kernel: BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
18:17:29 sys kernel: BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
18:17:29 sys kernel: BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
18:17:29 sys kernel: BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
18:17:29 sys kernel: BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
18:17:29 sys kernel: BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
18:17:29 sys kernel: BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
18:17:29 sys kernel: Entering add_active_range(0, 0, 159) 0 entries of 256 used
18:17:29 sys kernel: Entering add_active_range(0, 256, 524272) 1 entries of 256 used
18:17:29 sys kernel: end_pfn_map = 1048576
18:17:29 sys kernel: DMI 2.3 present.
18:17:29 sys kernel: ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
18:17:29 sys kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff3040
18:17:29 sys kernel: ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff30c0
18:17:29 sys kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fff9900
18:17:29 sys kernel: ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fff9b40
18:17:29 sys kernel: ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9c40
18:17:29 sys kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9840
18:17:29 sys kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
18:17:29 sys kernel: Entering add_active_range(0, 0, 159) 0 entries of 256 used
18:17:29 sys kernel: Entering add_active_range(0, 256, 524272) 1 entries of 256 used
18:17:29 sys kernel: Zone PFN ranges:
18:17:29 sys kernel: DMA             0 ->     4096
18:17:29 sys kernel: DMA32        4096 ->  1048576
18:17:29 sys kernel: Normal    1048576 ->  1048576
18:17:29 sys kernel: early_node_map[2] active PFN ranges
18:17:29 sys kernel: 0:        0 ->      159
18:17:29 sys kernel: 0:      256 ->   524272
18:17:29 sys kernel: On node 0 totalpages: 524175
18:17:29 sys kernel: DMA zone: 56 pages used for memmap
18:17:29 sys kernel: DMA zone: 10 pages reserved
18:17:29 sys kernel: DMA zone: 3933 pages, LIFO batch:0
18:17:29 sys kernel: DMA32 zone: 7111 pages used for memmap
18:17:29 sys kernel: DMA32 zone: 513065 pages, LIFO batch:31
18:17:29 sys kernel: Normal zone: 0 pages used for memmap
18:17:29 sys kernel: Nvidia board detected. Ignoring ACPI timer override.
18:17:29 sys kernel: If you got timer trouble try acpi_use_timer_override
18:17:29 sys kernel: ACPI: PM-Timer IO Port: 0x4008
18:17:29 sys kernel: ACPI: Local APIC address 0xfee00000
18:17:29 sys kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
18:17:29 sys kernel: Processor #0 (Bootup-CPU)
18:17:29 sys kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
18:17:29 sys kernel: Processor #1
18:17:29 sys kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
18:17:29 sys kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
18:17:29 sys kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
18:17:29 sys kernel: IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
18:17:29 sys kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
18:17:29 sys kernel: ACPI: BIOS IRQ0 pin2 override ignored.
18:17:29 sys kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
18:17:29 sys kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
18:17:29 sys kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
18:17:29 sys kernel: ACPI: IRQ9 used by override.
18:17:29 sys kernel: ACPI: IRQ14 used by override.
18:17:29 sys kernel: ACPI: IRQ15 used by override.
18:17:29 sys kernel: Setting APIC routing to physical flat
18:17:29 sys kernel: Using ACPI (MADT) for SMP configuration information
18:17:29 sys kernel: Nosave address range: 000000000009f000 - 00000000000a0000
18:17:29 sys kernel: Nosave address range: 00000000000a0000 - 00000000000f0000
18:17:29 sys kernel: Nosave address range: 00000000000f0000 - 0000000000100000
18:17:29 sys kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
18:17:29 sys kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
18:17:29 sys kernel: PERCPU: Allocating 32320 bytes of per cpu data
18:17:29 sys kernel: Built 1 zonelists.  Total pages: 516998
18:17:29 sys kernel: Kernel command line: root=/dev/md1 ro 
18:17:29 sys kernel: Initializing CPU#0
18:17:29 sys kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
18:17:29 sys kernel: Console: colour VGA+ 80x25
18:17:29 sys kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
18:17:29 sys kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
18:17:29 sys kernel: Checking aperture...
18:17:29 sys kernel: CPU 0: aperture @ 1844000000 size 32 MB
18:17:29 sys kernel: Aperture too small (32 MB)
18:17:29 sys kernel: No AGP bridge found
18:17:29 sys kernel: Memory: 2059096k/2097088k available (3034k kernel code, 37160k reserved, 1443k data, 212k init)
18:17:29 sys kernel: Calibrating delay using timer specific routine.. 4425.38 BogoMIPS (lpj=8850763)
18:17:29 sys kernel: Security Framework v1.0.0 initialized
18:17:29 sys kernel: SELinux:  Disabled at boot.
18:17:29 sys kernel: Capability LSM initialized
18:17:29 sys kernel: Mount-cache hash table entries: 256
18:17:29 sys kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
18:17:29 sys kernel: CPU: L2 Cache: 512K (64 bytes/line)
18:17:29 sys kernel: CPU: Physical Processor ID: 0
18:17:29 sys kernel: CPU: Processor Core ID: 0
18:17:29 sys kernel: SMP alternatives: switching to UP code
18:17:29 sys kernel: ACPI: Core revision 20060707
18:17:29 sys kernel: Using local APIC timer interrupts.
18:17:29 sys kernel: result 12564593
18:17:29 sys kernel: Detected 12.564 MHz APIC timer.
18:17:29 sys kernel: SMP alternatives: switching to SMP code
18:17:29 sys kernel: Booting processor 1/2 APIC 0x1
18:17:29 sys kernel: Initializing CPU#1
18:17:29 sys kernel: Calibrating delay using timer specific routine.. 4423.04 BogoMIPS (lpj=8846096)
18:17:29 sys kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
18:17:29 sys kernel: CPU: L2 Cache: 512K (64 bytes/line)
18:17:29 sys kernel: CPU: Physical Processor ID: 0
18:17:29 sys kernel: CPU: Processor Core ID: 1
18:17:29 sys kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
18:17:29 sys kernel: CPU 1: Syncing TSC to CPU 0.
18:17:29 sys kernel: CPU 1: synchronized TSC with CPU 0 (last diff 21 cycles, maxerr 507 cycles)
18:17:29 sys kernel: Brought up 2 CPUs
18:17:29 sys kernel: testing NMI watchdog ... OK.
18:17:29 sys kernel: Disabling vsyscall due to use of PM timer
18:17:29 sys kernel: time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
18:17:29 sys kernel: time.c: Detected 2211.364 MHz processor.
18:17:29 sys kernel: migration_cost=216
18:17:29 sys kernel: NET: Registered protocol family 16
18:17:29 sys kernel: ACPI: bus type pci registered
18:17:29 sys kernel: PCI: Using MMCONFIG at e0000000
18:17:29 sys kernel: PCI: No mmconfig possible on device 00:18
18:17:29 sys kernel: ACPI: Interpreter enabled
18:17:29 sys kernel: ACPI: Using IOAPIC for interrupt routing
18:17:29 sys kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
18:17:29 sys kernel: PCI: Probing PCI hardware (bus 00)
18:17:29 sys kernel: PCI: Transparent bridge - 0000:00:09.0
18:17:29 sys kernel: Boot video device is 0000:01:00.0
18:17:29 sys kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
18:17:29 sys kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 *12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 *4 5 7 9 10 11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 *7 9 10 11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
18:17:29 sys kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
18:17:29 sys kernel: pnp: PnP ACPI init
18:17:29 sys kernel: pnp: PnP ACPI: found 11 devices
18:17:29 sys kernel: SCSI subsystem initialized
18:17:29 sys kernel: libata version 2.00 loaded.
18:17:29 sys kernel: usbcore: registered new interface driver usbfs
18:17:29 sys kernel: usbcore: registered new interface driver hub
18:17:29 sys kernel: usbcore: registered new device driver usb
18:17:29 sys kernel: PCI: Using ACPI for IRQ routing
18:17:29 sys kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
18:17:29 sys kernel: pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
18:17:29 sys kernel: pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
18:17:29 sys kernel: pnp: 00:01: ioport range 0x4400-0x447f has been reserved
18:17:29 sys kernel: pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
18:17:29 sys kernel: pnp: 00:01: ioport range 0x4800-0x487f has been reserved
18:17:29 sys kernel: pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
18:17:29 sys kernel: PCI: Bridge: 0000:00:09.0
18:17:29 sys kernel: IO window: a000-afff
18:17:29 sys kernel: MEM window: d0000000-d1ffffff
18:17:29 sys kernel: PREFETCH window: 88000000-880fffff
18:17:29 sys kernel: PCI: Bridge: 0000:00:0b.0
18:17:29 sys kernel: IO window: disabled.
18:17:29 sys kernel: MEM window: disabled.
18:17:29 sys kernel: PREFETCH window: disabled.
18:17:29 sys kernel: PCI: Bridge: 0000:00:0c.0
18:17:29 sys kernel: IO window: disabled.
18:17:29 sys kernel: MEM window: disabled.
18:17:29 sys kernel: PREFETCH window: disabled.
18:17:29 sys kernel: PCI: Bridge: 0000:00:0d.0
18:17:29 sys kernel: IO window: disabled.
18:17:29 sys kernel: MEM window: disabled.
18:17:29 sys kernel: PREFETCH window: disabled.
18:17:29 sys kernel: PCI: Bridge: 0000:00:0e.0
18:17:29 sys kernel: IO window: disabled.
18:17:29 sys kernel: MEM window: c8000000-cfffffff
18:17:29 sys kernel: PREFETCH window: c0000000-c7ffffff
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:09.0 to 64
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0b.0 to 64
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0c.0 to 64
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0d.0 to 64
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0e.0 to 64
18:17:29 sys kernel: NET: Registered protocol family 2
18:17:29 sys kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
18:17:29 sys kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
18:17:29 sys kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
18:17:29 sys kernel: TCP: Hash tables configured (established 262144 bind 65536)
18:17:29 sys kernel: TCP reno registered
18:17:29 sys kernel: audit: initializing netlink socket (disabled)
18:17:29 sys kernel: audit(1169313393.480:1): initialized
18:17:29 sys kernel: VFS: Disk quotas dquot_6.5.1
18:17:29 sys kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
18:17:29 sys kernel: JFS: nTxBlock = 8192, nTxLock = 65536
18:17:29 sys kernel: SGI XFS with large block/inode numbers, no debug enabled
18:17:29 sys kernel: SGI XFS Quota Management subsystem
18:17:29 sys kernel: io scheduler noop registered
18:17:29 sys kernel: io scheduler cfq registered (default)
18:17:29 sys kernel: PCI: Linking AER extended capability on 0000:00:0b.0
18:17:29 sys kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0b.0
18:17:29 sys kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
18:17:29 sys kernel: PCI: Linking AER extended capability on 0000:00:0c.0
18:17:29 sys kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0c.0
18:17:29 sys kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
18:17:29 sys kernel: PCI: Linking AER extended capability on 0000:00:0d.0
18:17:29 sys kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0d.0
18:17:29 sys kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
18:17:29 sys kernel: PCI: Linking AER extended capability on 0000:00:0e.0
18:17:29 sys kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0e.0
18:17:29 sys kernel: PCI: Found enabled HT MSI Mapping on 0000:00:00.0
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0b.0 to 64
18:17:29 sys kernel: assign_interrupt_mode Found MSI capability
18:17:29 sys kernel: Allocate Port Service[0000:00:0b.0:pcie00]
18:17:29 sys kernel: Allocate Port Service[0000:00:0b.0:pcie03]
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0c.0 to 64
18:17:29 sys kernel: assign_interrupt_mode Found MSI capability
18:17:29 sys kernel: Allocate Port Service[0000:00:0c.0:pcie00]
18:17:29 sys kernel: Allocate Port Service[0000:00:0c.0:pcie03]
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0d.0 to 64
18:17:29 sys kernel: assign_interrupt_mode Found MSI capability
18:17:29 sys kernel: Allocate Port Service[0000:00:0d.0:pcie00]
18:17:29 sys kernel: Allocate Port Service[0000:00:0d.0:pcie03]
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0e.0 to 64
18:17:29 sys kernel: assign_interrupt_mode Found MSI capability
18:17:29 sys kernel: Allocate Port Service[0000:00:0e.0:pcie00]
18:17:29 sys kernel: Allocate Port Service[0000:00:0e.0:pcie03]
18:17:29 sys kernel: input: Power Button (FF) as /class/input/input0
18:17:29 sys kernel: ACPI: Power Button (FF) [PWRF]
18:17:29 sys kernel: input: Power Button (CM) as /class/input/input1
18:17:29 sys kernel: ACPI: Power Button (CM) [PWRB]
18:17:29 sys kernel: Real Time Clock Driver v1.12ac
18:17:29 sys kernel: Linux agpgart interface v0.101 (c) Dave Jones
18:17:29 sys kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
18:17:29 sys kernel: Floppy drive(s): fd0 is 1.44M
18:17:29 sys kernel: FDC 0 is a post-1991 82077
18:17:29 sys kernel: RAMDISK driver initialized: 4 RAM disks of 4096K size 1024 blocksize
18:17:29 sys kernel: loop: loaded (max 8 devices)
18:17:29 sys kernel: sata_nv 0000:00:07.0: version 3.2
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 23
18:17:29 sys kernel: sata_nv 0000:00:07.0: Using ADMA mode
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:07.0 to 64
18:17:29 sys kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000028480 ctl 0xFFFFC200000284A0 bmdma 0xD800 irq 23
18:17:29 sys kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000028580 ctl 0xFFFFC200000285A0 bmdma 0xD808 irq 23
18:17:29 sys kernel: scsi0 : sata_nv
18:17:29 sys kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
18:17:29 sys kernel: ata1.00: ATAPI, max UDMA/33
18:17:29 sys kernel: ata1.00: configured for UDMA/33
18:17:29 sys kernel: scsi1 : sata_nv
18:17:29 sys kernel: ata2: SATA link down (SStatus 0 SControl 300)
18:17:29 sys kernel: scsi 0:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB00 PQ: 0 ANSI: 5
18:17:29 sys kernel: ata1: bounce limit 0xFFFFFFFF, segment boundary 0xFFFF, hw segs 127
18:17:29 sys kernel: sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
18:17:29 sys kernel: Uniform CD-ROM driver Revision: 3.20
18:17:29 sys kernel: sr 0:0:0:0: Attached scsi CD-ROM sr0
18:17:29 sys kernel: sr 0:0:0:0: Attached scsi generic sg0 type 5
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 22
18:17:29 sys kernel: sata_nv 0000:00:08.0: Using ADMA mode
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:08.0 to 64
18:17:29 sys kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC2000002A480 ctl 0xFFFFC2000002A4A0 bmdma 0xC400 irq 22
18:17:29 sys kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC2000002A580 ctl 0xFFFFC2000002A5A0 bmdma 0xC408 irq 22
18:17:29 sys kernel: scsi2 : sata_nv
18:17:29 sys kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
18:17:29 sys kernel: ata3.00: ATA-7, max UDMA/133, 488395055 sectors: LBA48 
18:17:29 sys kernel: ata3.00: ata3: dev 0 multi count 1
18:17:29 sys kernel: ata3.00: configured for UDMA/133
18:17:29 sys kernel: scsi3 : sata_nv
18:17:29 sys kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
18:17:29 sys kernel: ata4.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 1)
18:17:29 sys kernel: ata4.00: ata4: dev 0 multi count 1
18:17:29 sys kernel: ata4.00: configured for UDMA/133
18:17:29 sys kernel: scsi 2:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
18:17:29 sys kernel: ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
18:17:29 sys kernel: SCSI device sda: 488395055 512-byte hdwr sectors (250058 MB)
18:17:29 sys kernel: sda: Write Protect is off
18:17:29 sys kernel: sda: Mode Sense: 00 3a 00 00
18:17:29 sys kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
18:17:29 sys kernel: SCSI device sda: 488395055 512-byte hdwr sectors (250058 MB)
18:17:29 sys kernel: sda: Write Protect is off
18:17:29 sys kernel: sda: Mode Sense: 00 3a 00 00
18:17:29 sys kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
18:17:29 sys kernel: sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
18:17:29 sys kernel: sd 2:0:0:0: Attached scsi disk sda
18:17:29 sys kernel: sd 2:0:0:0: Attached scsi generic sg1 type 0
18:17:29 sys kernel: scsi 3:0:0:0: Direct-Access     ATA      WDC WD2500YD-01N 10.0 PQ: 0 ANSI: 5
18:17:29 sys kernel: ata4: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
18:17:29 sys kernel: SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
18:17:29 sys kernel: sdb: Write Protect is off
18:17:29 sys kernel: sdb: Mode Sense: 00 3a 00 00
18:17:29 sys kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
18:17:29 sys kernel: SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
18:17:29 sys kernel: sdb: Write Protect is off
18:17:29 sys kernel: sdb: Mode Sense: 00 3a 00 00
18:17:29 sys kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
18:17:29 sys kernel: sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12 >
18:17:29 sys kernel: sd 3:0:0:0: Attached scsi disk sdb
18:17:29 sys kernel: sd 3:0:0:0: Attached scsi generic sg2 type 0
18:17:29 sys kernel: pata_amd 0000:00:06.0: version 0.2.7
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
18:17:29 sys kernel: ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
18:17:29 sys kernel: ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
18:17:29 sys kernel: scsi4 : pata_amd
18:17:29 sys kernel: ata5.00: ATA-6, max UDMA/100, 156299375 sectors: LBA48 
18:17:29 sys kernel: ata5.00: ata5: dev 0 multi count 1
18:17:29 sys kernel: ata5.00: configured for UDMA/100
18:17:29 sys kernel: scsi5 : pata_amd
18:17:29 sys kernel: ata6.00: ATAPI, max UDMA/33
18:17:29 sys kernel: ata6.00: configured for UDMA/33
18:17:29 sys kernel: scsi 4:0:0:0: Direct-Access     ATA      WDC WD800JB-00ET 77.0 PQ: 0 ANSI: 5
18:17:29 sys kernel: SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
18:17:29 sys kernel: sdc: Write Protect is off
18:17:29 sys kernel: sdc: Mode Sense: 00 3a 00 00
18:17:29 sys kernel: SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
18:17:29 sys kernel: SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
18:17:29 sys kernel: sdc: Write Protect is off
18:17:29 sys kernel: sdc: Mode Sense: 00 3a 00 00
18:17:29 sys kernel: SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
18:17:29 sys kernel: sdc: sdc1 sdc2
18:17:29 sys kernel: sd 4:0:0:0: Attached scsi disk sdc
18:17:29 sys kernel: sd 4:0:0:0: Attached scsi generic sg3 type 0
18:17:29 sys kernel: scsi 5:0:0:0: CD-ROM            PIONEER  DVD-ROM DVD-105  1.33 PQ: 0 ANSI: 5
18:17:29 sys kernel: sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
18:17:29 sys kernel: sr 5:0:0:0: Attached scsi CD-ROM sr1
18:17:29 sys kernel: sr 5:0:0:0: Attached scsi generic sg4 type 5
18:17:29 sys kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
18:17:29 sys kernel: PNP: PS/2 controller doesn't have AUX irq; using default 12
18:17:29 sys kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
18:17:29 sys kernel: mice: PS/2 mouse device common for all mice
18:17:29 sys kernel: input: PC Speaker as /class/input/input2
18:17:29 sys kernel: input: AT Translated Set 2 keyboard as /class/input/input3
18:17:29 sys kernel: md: linear personality registered for level -1
18:17:29 sys kernel: md: raid0 personality registered for level 0
18:17:29 sys kernel: md: raid1 personality registered for level 1
18:17:29 sys kernel: md: raid10 personality registered for level 10
18:17:29 sys kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
18:17:29 sys kernel: device-mapper: multipath: version 1.0.5 loaded
18:17:29 sys kernel: device-mapper: multipath round-robin: version 1.0.0 loaded
18:17:29 sys kernel: EDAC MC: Ver: 2.0.1 2007
18:17:29 sys kernel: TCP cubic registered
18:17:29 sys kernel: Initializing XFRM netlink socket
18:17:29 sys kernel: NET: Registered protocol family 1
18:17:29 sys kernel: NET: Registered protocol family 17
18:17:29 sys kernel: NET: Registered protocol family 15
18:17:29 sys kernel: ieee80211: 802.11 data/management/control stack, git-1.1.13
18:17:29 sys kernel: ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
18:17:29 sys kernel: ieee80211_crypt: registered algorithm 'NULL'
18:17:29 sys kernel: ieee80211_crypt: registered algorithm 'WEP'
18:17:29 sys kernel: ACPI: (supports S0 S1 S3 S4 S5)
18:17:29 sys kernel: drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
18:17:29 sys kernel: md: Autodetecting RAID arrays.
18:17:29 sys kernel: md: autorun ...
[..]
18:17:29 sys kernel: md: ... autorun DONE.
18:17:29 sys kernel: ReiserFS: md1: found reiserfs format "3.6" with standard journal
18:17:29 sys kernel: ReiserFS: md1: using ordered data mode
18:17:29 sys kernel: ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
18:17:29 sys kernel: ReiserFS: md1: checking transaction log (md1)
18:17:29 sys kernel: ReiserFS: md1: Using r5 hash to sort names
18:17:29 sys kernel: VFS: Mounted root (reiserfs filesystem) readonly.
18:17:29 sys kernel: Freeing unused kernel memory: 212k freed
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
18:17:29 sys kernel: skge 1.9 addr 0xd1004000 irq 17 chip Yukon-Lite rev 9
18:17:29 sys kernel: skge eth0: addr 00:15:f2:50:d7:70
18:17:29 sys kernel: forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 21 (level, low) -> IRQ 21
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:0a.0 to 64
18:17:29 sys kernel: forcedeth: using HIGHDMA
18:17:29 sys kernel: ieee1394: Initialized config rom entry `ip1394'
18:17:29 sys kernel: eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:05:07.2[B] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
18:17:29 sys kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[d100f000-d100f7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
18:17:29 sys kernel: ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
18:17:29 sys kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, low) -> IRQ 20
[..]
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 (level, low) -> IRQ 23
18:17:29 sys kernel: PCI: Setting latency timer of device 0000:00:02.1 to 64
18:17:29 sys kernel: ehci_hcd 0000:00:02.1: EHCI Host Controller
18:17:29 sys kernel: ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
18:17:29 sys kernel: ehci_hcd 0000:00:02.1: debug port 1
18:17:29 sys kernel: PCI: cache line size of 64 is not supported by device 0000:00:02.1
18:17:29 sys kernel: ehci_hcd 0000:00:02.1: irq 23, io mem 0xfeb00000
18:17:29 sys kernel: ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
18:17:29 sys kernel: usb usb2: configuration #1 chosen from 1 choice
18:17:29 sys kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
18:17:29 sys kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
18:17:29 sys kernel: gameport: EMU10K1 is pci0000:05:07.1/gameport0, io 0xa400, speed 1205kHz
18:17:29 sys kernel: ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
18:17:29 sys kernel: Installing spdif_bug patch: Audigy 2 ZS [SB0350]
18:17:29 sys kernel: usb 1-4: new low speed USB device using ohci_hcd and address 2
18:17:29 sys kernel: usb 1-4: configuration #1 chosen from 1 choice
18:17:29 sys kernel: usbcore: registered new interface driver hiddev
18:17:29 sys kernel: input: Logitech USB-PS/2 Optical Mouse as /class/input/input4
18:17:29 sys kernel: input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.0-4
18:17:29 sys kernel: usbcore: registered new interface driver usbhid
18:17:29 sys kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
18:17:29 sys kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c015112bb16]
18:17:29 sys kernel: eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
18:17:29 sys kernel: eth1394: eth3: IEEE-1394 IPv4 over 1394 Ethernet (fw-host1)
18:17:29 sys kernel: ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800007ab4d6]
18:17:29 sys kernel: it87: Found IT8712F chip at 0x290, revision 7
18:17:29 sys kernel: it87: in3 is VCC (+5V)
18:17:29 sys kernel: it87: in7 is VCCH (+5V Stand-By)
18:17:29 sys kernel: powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors (version 2.00.00)
18:17:29 sys kernel: powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
18:17:29 sys kernel: powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
18:17:29 sys kernel: powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
18:17:29 sys kernel: powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
18:17:29 sys kernel: usbcore: registered new interface driver usbmouse
18:17:29 sys kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
18:17:29 sys kernel: Initializing USB Mass Storage driver...
18:17:29 sys kernel: usbcore: registered new interface driver usb-storage
18:17:29 sys kernel: USB Mass Storage support registered.
18:17:29 sys kernel: sr1: CDROM not ready.  Make sure there is a disc in the drive.
18:17:29 sys kernel: ata4: issue flush cmd 0xea
18:17:29 sys kernel: ata3: issue flush cmd 0xea
18:17:29 sys kernel: ata3: cmd 0xea active but stat 0x10
18:17:29 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:17:29 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:17:29 sys kernel: ata4: issue flush cmd 0xea
18:17:29 sys kernel: ata4: cmd 0xea active but stat 0x0
18:17:29 sys kernel: ata3: issue flush cmd 0xea
18:17:29 sys kernel: ata3: cmd 0xea active but stat 0x10
18:17:29 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:17:29 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
[..]
18:17:29 sys kernel: NET: Registered protocol family 10
18:17:29 sys kernel: lo: Disabled Privacy Extensions
18:17:33 sys kernel: eth0: no IPv6 routers present
18:17:38 sys kernel: lp: driver loaded but no devices found
18:17:38 sys kernel: ppdev: user-space parallel port driver
18:17:46 sys kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
18:17:47 sys kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
18:17:47 sys kernel: NFSD: starting 90-second grace period
18:17:53 sys kernel: Bluetooth: Core ver 2.11
18:17:53 sys kernel: NET: Registered protocol family 31
18:17:53 sys kernel: Bluetooth: HCI device and connection manager initialized
18:17:53 sys kernel: Bluetooth: HCI socket layer initialized
18:17:53 sys kernel: Bluetooth: L2CAP ver 2.8
18:17:53 sys kernel: Bluetooth: L2CAP socket layer initialized
18:17:54 sys kernel: Bluetooth: RFCOMM socket layer initialized
18:17:54 sys kernel: Bluetooth: RFCOMM TTY layer initialized
18:17:54 sys kernel: Bluetooth: RFCOMM ver 1.8
18:18:09 sys kernel: ata4: issue flush cmd 0xea
18:18:09 sys kernel: ata3: issue flush cmd 0xea
18:18:09 sys kernel: ata3: cmd 0xea active but stat 0x10
18:18:09 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:18:09 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:18:09 sys kernel: ata4: issue flush cmd 0xea
18:18:09 sys kernel: ata4: cmd 0xea active but stat 0x0
18:18:09 sys kernel: ata3: issue flush cmd 0xea
18:18:09 sys kernel: ata3: cmd 0xea active but stat 0x10
18:18:09 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:18:09 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:18:09 sys kernel: ata4: issue flush cmd 0xea
18:18:09 sys kernel: ata3: issue flush cmd 0xea
18:18:09 sys kernel: ata3: cmd 0xea active but stat 0x10
18:18:09 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:18:09 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
[..]
18:18:28 sys kernel: ata3: cmd 0xea active but stat 0x10
18:18:28 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:18:28 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:18:28 sys kernel: ata4: issue flush cmd 0xea
18:18:28 sys kernel: ata4: cmd 0xea active but stat 0x0
18:18:28 sys kernel: ata4: cmd 0xea active but stat 0x0
18:18:28 sys kernel: ata4: cmd 0xea active but stat 0x0
18:18:28 sys kernel: ata4: cmd 0xea active but stat 0x0
18:18:28 sys kernel: ata4: cmd 0xea active but stat 0x0
18:18:28 sys kernel: ata4: cmd 0xea active but stat 0x0
18:18:28 sys kernel: ata3: issue flush cmd 0xea
18:18:28 sys kernel: ata3: cmd 0xea active but stat 0x10
18:18:28 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
[..]
18:21:49 sys kernel: ata4: issue flush cmd 0xea
18:21:49 sys kernel: ata3: issue flush cmd 0xea
18:21:49 sys kernel: ata3: cmd 0xea active but stat 0x10
18:21:49 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:49 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:49 sys kernel: ata4: issue flush cmd 0xea
18:21:49 sys kernel: ata4: cmd 0xea active but stat 0x0
18:21:49 sys kernel: ata3: issue flush cmd 0xea
18:21:49 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:49 sys kernel: ata4: cmd 0xea active but stat 0x0
18:21:49 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:49 sys kernel: ata4: issue flush cmd 0xea
18:21:49 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:49 sys kernel: ata4: issue flush cmd 0xea
18:21:49 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:49 sys kernel: ata3: issue flush cmd 0xea
18:21:49 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:49 sys kernel: ata3: issue flush cmd 0xea
18:21:49 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:50 sys kernel: ata4: issue flush cmd 0xea
18:21:50 sys kernel: ata3: issue flush cmd 0xea
18:21:50 sys kernel: ata3: cmd 0xea active but stat 0x10
18:21:50 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:21:50 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
[..]
18:58:54 sys kernel: ata4: issue flush cmd 0xea
18:58:54 sys kernel: ata3: issue flush cmd 0xea
18:58:54 sys kernel: ata3: cmd 0xea active but stat 0x10
18:58:54 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:58:54 sys kernel: ata3: cmd 0xea active but stat 0x10
18:58:54 sys kernel: ata4: issue flush cmd 0xea
18:58:54 sys kernel: ata3: cmd 0xea active but stat 0x10
18:58:54 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:58:54 sys kernel: ata4: issue flush cmd 0xea
18:58:54 sys kernel: ata3: cmd 0xea active but stat 0x10
18:58:54 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:58:54 sys kernel: ata3: cmd 0xea active but stat 0x10
18:58:54 sys kernel: ata4: issue flush cmd 0xea
18:58:54 sys kernel: ata3: cmd 0xea active but stat 0x10
18:58:54 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:58:55 sys kernel: ata3: cmd 0xea active but stat 0x10
18:58:57 sys kernel: ata3: cmd 0xea active but stat 0x10
18:59:02 sys kernel: ata3: cmd 0xea active but stat 0x10
18:59:09 sys kernel: ata3: cmd 0xea active but stat 0x10
18:59:16 sys kernel: ata3: cmd 0xea active but stat 0x10
18:59:23 sys kernel: ata3: cmd 0xea active but stat 0x10
18:59:24 sys kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
18:59:24 sys kernel: ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 out
18:59:24 sys kernel: res 40/00:00:00:50:28/00:00:00:00:00/00 Emask 0x4 (timeout)
18:59:24 sys kernel: ata3: soft resetting port
18:59:24 sys kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
18:59:24 sys kernel: ata3.00: configured for UDMA/133
18:59:24 sys kernel: ata3: EH complete
18:59:24 sys kernel: ata3: issue flush cmd 0xea
18:59:24 sys kernel: SCSI device sda: 488395055 512-byte hdwr sectors (250058 MB)
18:59:24 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:24 sys kernel: ata3: issue flush cmd 0xea
18:59:24 sys kernel: sda: Write Protect is off
18:59:24 sys kernel: sda: Mode Sense: 00 3a 00 00
18:59:24 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:24 sys kernel: ata3: issue flush cmd 0xea
18:59:24 sys kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
18:59:24 sys kernel: ata3: cmd 0xea active but stat 0x10
18:59:24 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:24 sys kernel: ata4: issue flush cmd 0xea
18:59:24 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:24 sys kernel: ata4: issue flush cmd 0xea
18:59:24 sys kernel: ata4: cmd 0xea active but stat 0x0
18:59:24 sys kernel: ata4: cmd 0xea active but stat 0x0
18:59:24 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:24 sys kernel: ata3: issue flush cmd 0xea
18:59:24 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:24 sys kernel: ata3: issue flush cmd 0xea
18:59:24 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:25 sys kernel: ata4: issue flush cmd 0xea
18:59:25 sys kernel: ata4: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:25 sys kernel: ata4: issue flush cmd 0xea
18:59:25 sys kernel: ata4: cmd 0xea active but stat 0x0
18:59:25 sys kernel: ata3: issue flush cmd 0xea
18:59:25 sys kernel: ata3: cmd 0xea active, stat = 0x1, handled = 0x1
18:59:25 sys kernel: ata4: cmd 0xea active but stat 0x0
18:59:25 sys kernel: ata4: cmd 0xea active but stat 0x0
18:59:25 sys kernel: ata3: issue flush cmd 0xea
--Boundary-00=_nRmsFZItxm7lRC2--
