Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161392AbWG2BRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161392AbWG2BRV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 21:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWG2BRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 21:17:21 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:1193
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751381AbWG2BRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 21:17:20 -0400
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
From: Paul Fulghum <paulkf@microgate.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <1154132126.3349.8.camel@localhost.localdomain>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <1154112276.3530.3.camel@amdx2.microgate.com>
	 <20060728144854.44c4f557.akpm@osdl.org>  <20060728233851.GA35643@muc.de>
	 <1154132126.3349.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 20:16:32 -0500
Message-Id: <1154135792.2557.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 19:15 -0500, Paul Fulghum wrote:
> I'm doing a build on my home machine now to see if it
> happens there also.

Well, the timer int 0 problem does not happen on my home machine.
However, it still crashes in early boot for a different reason.

2.6.18-rc2 works fine with same config.

In this case the error is:

No per-cpu room for modules
...
insmod:error interting '/lib/scsi_mod.ko' -1 cannot allocate memory
...
[other modules depending on scsi_mod.ko fail to load]
...
kernel panic - Attempted to kill init - d000


Woof! (said the dog because the cow said moo)

syslog from working 2.6.18-rc2 below:

Jul 28 20:01:23 localhost kernel: Linux version 2.6.18-rc2 (paulkf@localhost.localdomain) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Fri Jul 28 19:52:34 CDT 2006
Jul 28 20:01:23 localhost kernel: BIOS-provided physical RAM map:
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 00000000d0000000 - 00000000e0000000 (reserved)
Jul 28 20:01:23 localhost kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jul 28 20:01:23 localhost kernel: DMI 2.3 present.
Jul 28 20:01:24 localhost rpc.statd[1926]: Version 1.0.8-rc2 Starting
Jul 28 20:01:25 localhost kernel: Scanning NUMA topology in Northbridge 24
Jul 28 20:01:25 localhost kernel: Number of nodes 1
Jul 28 20:01:25 localhost kernel: Node 0 MemBase 0000000000000000 Limit 000000007fff0000
Jul 28 20:01:25 localhost kernel: Using node hash shift of 63
Jul 28 20:01:25 localhost kernel: Bootmem setup node 0 0000000000000000-000000007fff0000
Jul 28 20:01:25 localhost kernel: Nvidia board detected. Ignoring ACPI timer override.
Jul 28 20:01:25 localhost kernel: ACPI: PM-Timer IO Port: 0x1008
Jul 28 20:01:25 localhost kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jul 28 20:01:25 localhost kernel: Processor #0 15:11 APIC version 16
Jul 28 20:01:25 localhost kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jul 28 20:01:25 localhost kernel: Processor #1 15:11 APIC version 16
Jul 28 20:01:25 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jul 28 20:01:25 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jul 28 20:01:25 localhost kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jul 28 20:01:25 localhost kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
Jul 28 20:01:25 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul 28 20:01:25 localhost kernel: ACPI: BIOS IRQ0 pin2 override ignored.
Jul 28 20:01:25 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jul 28 20:01:25 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
Jul 28 20:01:25 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Jul 28 20:01:25 localhost kernel: Setting APIC routing to physical flat
Jul 28 20:01:25 localhost kernel: Using ACPI (MADT) for SMP configuration information
Jul 28 20:01:25 localhost kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:50000000)
Jul 28 20:01:25 localhost kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
Jul 28 20:01:25 localhost kernel: Built 1 zonelists.  Total pages: 514549
Jul 28 20:01:25 localhost kernel: Kernel command line: ro root=LABEL=/1 rhgb quiet
Jul 28 20:01:25 localhost kernel: Initializing CPU#0
Jul 28 20:01:25 localhost kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Jul 28 20:01:25 localhost kernel: Disabling vsyscall due to use of PM timer
Jul 28 20:01:25 localhost kernel: time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
Jul 28 20:01:25 localhost kernel: time.c: Detected 2010.330 MHz processor.
Jul 28 20:01:25 localhost kernel: Console: colour VGA+ 80x25
Jul 28 20:01:25 localhost kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jul 28 20:01:25 localhost kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jul 28 20:01:25 localhost kernel: Checking aperture...
Jul 28 20:01:25 localhost kernel: CPU 0: aperture @ 2ea0000000 size 32 MB
Jul 28 20:01:25 localhost kernel: Aperture too small (32 MB)
Jul 28 20:01:25 localhost kernel: No AGP bridge found
Jul 28 20:01:25 localhost kernel: Memory: 2053824k/2097088k available (2316k kernel code, 42876k reserved, 1238k data, 204k init)
Jul 28 20:01:25 localhost kernel: Calibrating delay using timer specific routine.. 4023.90 BogoMIPS (lpj=8047819)
Jul 28 20:01:25 localhost kernel: Security Framework v1.0.0 initialized
Jul 28 20:01:25 localhost kernel: SELinux:  Initializing.
Jul 28 20:01:25 localhost kernel: SELinux:  Starting in permissive mode
Jul 28 20:01:25 localhost kernel: selinux_register_security:  Registering secondary module capability
Jul 28 20:01:25 localhost kernel: Capability LSM initialized as secondary
Jul 28 20:01:25 localhost kernel: Mount-cache hash table entries: 256
Jul 28 20:01:25 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 28 20:01:25 localhost kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jul 28 20:01:25 localhost kernel: CPU 0/0 -> Node 0
Jul 28 20:01:25 localhost kernel: CPU: Physical Processor ID: 0
Jul 28 20:01:25 localhost kernel: CPU: Processor Core ID: 0
Jul 28 20:01:25 localhost kernel: SMP alternatives: switching to UP code
Jul 28 20:01:25 localhost kernel: ACPI: Core revision 20060707
Jul 28 20:01:25 localhost kernel: Using local APIC timer interrupts.
Jul 28 20:01:25 localhost kernel: result 12564579
Jul 28 20:01:25 localhost kernel: Detected 12.564 MHz APIC timer.
Jul 28 20:01:25 localhost kernel: SMP alternatives: switching to SMP code
Jul 28 20:01:25 localhost kernel: Booting processor 1/2 APIC 0x1
Jul 28 20:01:25 localhost kernel: Initializing CPU#1
Jul 28 20:01:25 localhost kernel: Calibrating delay using timer specific routine.. 4020.89 BogoMIPS (lpj=8041781)
Jul 28 20:01:25 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 28 20:01:25 localhost kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jul 28 20:01:25 localhost kernel: CPU 1/1 -> Node 0
Jul 28 20:01:25 localhost kernel: CPU: Physical Processor ID: 0
Jul 28 20:01:25 localhost kernel: CPU: Processor Core ID: 1
Jul 28 20:01:25 localhost kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 01
Jul 28 20:01:25 localhost kernel: CPU 1: Syncing TSC to CPU 0.
Jul 28 20:01:25 localhost kernel: CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 566 cycles)
Jul 28 20:01:25 localhost kernel: Brought up 2 CPUs
Jul 28 20:01:25 localhost kernel: testing NMI watchdog ... OK.
Jul 28 20:01:25 localhost kernel: migration_cost=253
Jul 28 20:01:25 localhost kernel: checking if image is initramfs... it is
Jul 28 20:01:25 localhost kernel: Freeing initrd memory: 1078k freed
Jul 28 20:01:25 localhost kernel: NET: Registered protocol family 16
Jul 28 20:01:25 localhost kernel: ACPI: bus type pci registered
Jul 28 20:01:25 localhost kernel: PCI: Using MMCONFIG at d0000000
Jul 28 20:01:25 localhost kernel: PCI: No mmconfig possible on device 0:18
Jul 28 20:01:25 localhost kernel: ACPI: Interpreter enabled
Jul 28 20:01:25 localhost kernel: ACPI: Using IOAPIC for interrupt routing
Jul 28 20:01:25 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jul 28 20:01:25 localhost kernel: PCI: Transparent bridge - 0000:00:09.0
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 *12 14 15)
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs *3 4 5 7 9 10 11 12 14 15)
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Jul 28 20:01:25 localhost kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul 28 20:01:25 localhost kernel: pnp: PnP ACPI init
Jul 28 20:01:25 localhost kernel: pnp: PnP ACPI: found 12 devices
Jul 28 20:01:25 localhost kernel: usbcore: registered new driver usbfs
Jul 28 20:01:25 localhost kernel: usbcore: registered new driver hub
Jul 28 20:01:25 localhost kernel: PCI: Using ACPI for IRQ routing
Jul 28 20:01:25 localhost kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jul 28 20:01:25 localhost kernel: PCI-DMA: Disabling IOMMU.
Jul 28 20:01:25 localhost kernel: pnp: 00:01: ioport range 0x1000-0x107f could not be reserved
Jul 28 20:01:25 localhost kernel: pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
Jul 28 20:01:25 localhost kernel: pnp: 00:01: ioport range 0x1400-0x147f has been reserved
Jul 28 20:01:25 localhost kernel: pnp: 00:01: ioport range 0x1480-0x14ff could not be reserved
Jul 28 20:01:25 localhost kernel: pnp: 00:01: ioport range 0x1800-0x187f has been reserved
Jul 28 20:01:25 localhost kernel: pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
Jul 28 20:01:25 localhost kernel: PCI: Bridge: 0000:00:09.0
Jul 28 20:01:25 localhost kernel:   IO window: disabled.
Jul 28 20:01:25 localhost kernel:   MEM window: f3000000-f30fffff
Jul 28 20:01:25 localhost kernel:   PREFETCH window: disabled.
Jul 28 20:01:25 localhost kernel: PCI: Bridge: 0000:00:0b.0
Jul 28 20:01:25 localhost kernel:   IO window: a000-afff
Jul 28 20:01:25 localhost kernel:   MEM window: disabled.
Jul 28 20:01:25 localhost kernel:   PREFETCH window: disabled.
Jul 28 20:01:25 localhost kernel: PCI: Bridge: 0000:00:0c.0
Jul 28 20:01:25 localhost kernel:   IO window: 9000-9fff
Jul 28 20:01:25 localhost kernel:   MEM window: disabled.
Jul 28 20:01:25 localhost kernel:   PREFETCH window: disabled.
Jul 28 20:01:25 localhost kernel: PCI: Bridge: 0000:00:0d.0
Jul 28 20:01:25 localhost kernel:   IO window: 8000-8fff
Jul 28 20:01:25 localhost kernel:   MEM window: disabled.
Jul 28 20:01:25 localhost kernel:   PREFETCH window: disabled.
Jul 28 20:01:25 localhost kernel: PCI: Bridge: 0000:00:0e.0
Jul 28 20:01:25 localhost kernel:   IO window: b000-bfff
Jul 28 20:01:25 localhost kernel:   MEM window: f0000000-f2ffffff
Jul 28 20:01:25 localhost kernel:   PREFETCH window: e0000000-efffffff
Jul 28 20:01:25 localhost kernel: NET: Registered protocol family 2
Jul 28 20:01:25 localhost kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Jul 28 20:01:25 localhost kernel: TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
Jul 28 20:01:25 localhost kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
Jul 28 20:01:25 localhost kernel: TCP: Hash tables configured (established 131072 bind 65536)
Jul 28 20:01:25 localhost kernel: TCP reno registered
Jul 28 20:01:25 localhost kernel: audit: initializing netlink socket (disabled)
Jul 28 20:01:25 localhost kernel: audit(1154116852.688:1): initialized
Jul 28 20:01:25 localhost kernel: Total HugeTLB memory allocated, 0
Jul 28 20:01:25 localhost kernel: VFS: Disk quotas dquot_6.5.1
Jul 28 20:01:25 localhost kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jul 28 20:01:25 localhost kernel: SELinux:  Registering netfilter hooks
Jul 28 20:01:25 localhost kernel: Initializing Cryptographic API
Jul 28 20:01:25 localhost kernel: io scheduler noop registered
Jul 28 20:01:25 localhost kernel: io scheduler anticipatory registered
Jul 28 20:01:25 localhost kernel: io scheduler deadline registered
Jul 28 20:01:25 localhost kernel: io scheduler cfq registered (default)
Jul 28 20:01:25 localhost kernel: PCI: Linking AER extended capability on 0000:00:0b.0
Jul 28 20:01:25 localhost kernel: PCI: Linking AER extended capability on 0000:00:0c.0
Jul 28 20:01:25 localhost kernel: PCI: Linking AER extended capability on 0000:00:0d.0
Jul 28 20:01:25 localhost kernel: PCI: Linking AER extended capability on 0000:00:0e.0
Jul 28 20:01:25 localhost kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Jul 28 20:01:25 localhost kernel: assign_interrupt_mode Found MSI capability
Jul 28 20:01:25 localhost kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Jul 28 20:01:25 localhost kernel: assign_interrupt_mode Found MSI capability
Jul 28 20:01:25 localhost kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Jul 28 20:01:25 localhost kernel: assign_interrupt_mode Found MSI capability
Jul 28 20:01:25 localhost kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Jul 28 20:01:25 localhost kernel: assign_interrupt_mode Found MSI capability
Jul 28 20:01:25 localhost kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jul 28 20:01:25 localhost kernel: Real Time Clock Driver v1.12ac
Jul 28 20:01:25 localhost kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jul 28 20:01:25 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Jul 28 20:01:25 localhost kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 28 20:01:25 localhost kernel: 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 28 20:01:25 localhost kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Jul 28 20:01:25 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 28 20:01:25 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 28 20:01:25 localhost kernel: NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
Jul 28 20:01:25 localhost kernel: NFORCE-CK804: chipset revision 162
Jul 28 20:01:25 localhost kernel: NFORCE-CK804: not 100% native mode: will probe irqs later
Jul 28 20:01:25 localhost kernel: NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
Jul 28 20:01:25 localhost kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Jul 28 20:01:25 localhost kernel: hda: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
Jul 28 20:01:25 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 28 20:01:25 localhost kernel: hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Jul 28 20:01:25 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Jul 28 20:01:25 localhost kernel: ide-floppy driver 0.99.newide
Jul 28 20:01:25 localhost kernel: usbcore: registered new driver libusual
Jul 28 20:01:25 localhost kernel: usbcore: registered new driver hiddev
Jul 28 20:01:25 localhost kernel: usbcore: registered new driver usbhid
Jul 28 20:01:25 localhost kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jul 28 20:01:25 localhost kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Jul 28 20:01:25 localhost kernel: PNP: PS/2 controller doesn't have AUX irq; using default 12
Jul 28 20:01:25 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 28 20:01:25 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 28 20:01:25 localhost kernel: mice: PS/2 mouse device common for all mice
Jul 28 20:01:25 localhost kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul 28 20:01:25 localhost kernel: md: bitmap version 4.39
Jul 28 20:01:25 localhost kernel: TCP bic registered
Jul 28 20:01:25 localhost kernel: Initializing IPsec netlink socket
Jul 28 20:01:25 localhost kernel: NET: Registered protocol family 1
Jul 28 20:01:25 localhost kernel: NET: Registered protocol family 17
Jul 28 20:01:25 localhost kernel: powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ processors (version 2.00.00)
Jul 28 20:01:25 localhost kernel: powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
Jul 28 20:01:25 localhost last message repeated 3 times
Jul 28 20:01:25 localhost kernel: powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8
Jul 28 20:01:25 localhost kernel: powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12
Jul 28 20:01:25 localhost kernel: ACPI: (supports S0 S1 S4 S5)
Jul 28 20:01:25 localhost kernel: Freeing unused kernel memory: 204k freed
Jul 28 20:01:25 localhost kernel: Write protecting the kernel read-only data: 464k
Jul 28 20:01:25 localhost kernel: SCSI subsystem initialized
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
Jul 28 20:01:25 localhost kernel: GSI 16 sharing vector 0xB1 and IRQ 16
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 16
Jul 28 20:01:25 localhost kernel: ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 16
Jul 28 20:01:25 localhost kernel: ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 16
Jul 28 20:01:25 localhost kernel: scsi0 : sata_nv
Jul 28 20:01:25 localhost kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Jul 28 20:01:25 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jul 28 20:01:25 localhost kernel: ata1.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
Jul 28 20:01:25 localhost kernel: ata1.00: ata1: dev 0 multi count 16
Jul 28 20:01:25 localhost kernel: ata1.00: configured for UDMA/133
Jul 28 20:01:25 localhost kernel: scsi1 : sata_nv
Jul 28 20:01:25 localhost kernel: ata2: SATA link down (SStatus 0 SControl 300)
Jul 28 20:01:25 localhost kernel:   Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
Jul 28 20:01:25 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jul 28 20:01:25 localhost kernel: SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jul 28 20:01:25 localhost kernel: sda: Write Protect is off
Jul 28 20:01:25 localhost kernel: SCSI device sda: drive cache: write back
Jul 28 20:01:25 localhost kernel: SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jul 28 20:01:25 localhost kernel: sda: Write Protect is off
Jul 28 20:01:25 localhost kernel: SCSI device sda: drive cache: write back
Jul 28 20:01:25 localhost kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
Jul 28 20:01:25 localhost kernel: sd 0:0:0:0: Attached scsi disk sda
Jul 28 20:01:25 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jul 28 20:01:25 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 28 20:01:25 localhost kernel: audit(1154116856.620:2): enforcing=1 old_enforcing=0 auid=4294967295
Jul 28 20:01:25 localhost kernel: security:  3 users, 6 roles, 1417 types, 151 bools, 1 sens, 256 cats
Jul 28 20:01:25 localhost kernel: security:  57 classes, 41080 rules
Jul 28 20:01:25 localhost kernel: SELinux:  Completing initialization.
Jul 28 20:01:25 localhost kernel: SELinux:  Setting up existing superblocks.
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev sda8, type ext3), uses xattr
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev devpts, type devpts), uses transition SIDs
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev proc, type proc), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: audit(1154116856.892:3): policy loaded auid=4294967295
Jul 28 20:01:25 localhost kernel: SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Jul 28 20:01:25 localhost kernel: audit(1154134859.998:4): avc:  denied  { audit_write } for  pid=469 comm="hwclock" capability=29 scontext=system_u:system_r:hwclock_t:s0 tcontext=system_u:system_r:hwclock_t:s0 tclass=capability
Jul 28 20:01:25 localhost kernel: input: PC Speaker as /class/input/input1
Jul 28 20:01:25 localhost kernel: forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
Jul 28 20:01:25 localhost kernel: GSI 17 sharing vector 0xB9 and IRQ 17
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 22 (level, low) -> IRQ 17
Jul 28 20:01:25 localhost kernel: forcedeth: using HIGHDMA
Jul 28 20:01:25 localhost kernel: eth0: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:0a.0
Jul 28 20:01:25 localhost kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
Jul 28 20:01:25 localhost kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x1c40
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Jul 28 20:01:25 localhost kernel: GSI 18 sharing vector 0xC1 and IRQ 18
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 21 (level, low) -> IRQ 18
Jul 28 20:01:25 localhost kernel: intel8x0_measure_ac97_clock: measured 58545 usecs
Jul 28 20:01:25 localhost kernel: intel8x0: clocking to 46966
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
Jul 28 20:01:25 localhost kernel: GSI 19 sharing vector 0xC9 and IRQ 19
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 19
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
Jul 28 20:01:25 localhost kernel: GSI 20 sharing vector 0xD1 and IRQ 20
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
Jul 28 20:01:25 localhost kernel: ehci_hcd 0000:00:02.1: EHCI Host Controller
Jul 28 20:01:25 localhost kernel: ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
Jul 28 20:01:25 localhost kernel: ehci_hcd 0000:00:02.1: debug port 1
Jul 28 20:01:25 localhost kernel: ehci_hcd 0000:00:02.1: irq 20, io mem 0xfeb00000
Jul 28 20:01:25 localhost kernel: ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jul 28 20:01:25 localhost kernel: usb usb1: configuration #1 chosen from 1 choice
Jul 28 20:01:25 localhost kernel: hub 1-0:1.0: USB hub found
Jul 28 20:01:25 localhost kernel: hub 1-0:1.0: 10 ports detected
Jul 28 20:01:25 localhost kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[f3004000-f30047ff]  Max Packet=[4096]  IR/IT contexts=[4/8]
Jul 28 20:01:25 localhost kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
Jul 28 20:01:25 localhost kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 16
Jul 28 20:01:25 localhost kernel: ohci_hcd 0000:00:02.0: OHCI Host Controller
Jul 28 20:01:25 localhost kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
Jul 28 20:01:25 localhost kernel: ohci_hcd 0000:00:02.0: irq 16, io mem 0xf3101000
Jul 28 20:01:25 localhost kernel: usb usb2: configuration #1 chosen from 1 choice
Jul 28 20:01:25 localhost kernel: hub 2-0:1.0: USB hub found
Jul 28 20:01:25 localhost kernel: hub 2-0:1.0: 10 ports detected
Jul 28 20:01:25 localhost kernel: usb 1-6: new high speed USB device using ehci_hcd and address 2
Jul 28 20:01:25 localhost kernel: usb 1-6: configuration #1 chosen from 1 choice
Jul 28 20:01:25 localhost kernel: hub 1-6:1.0: USB hub found
Jul 28 20:01:25 localhost kernel: hub 1-6:1.0: 4 ports detected
Jul 28 20:01:25 localhost kernel: ohci_hcd 0000:00:02.0: wakeup
Jul 28 20:01:25 localhost kernel: Non-volatile memory driver v1.2
Jul 28 20:01:25 localhost kernel: usb 1-6.1: new full speed USB device using ehci_hcd and address 5
Jul 28 20:01:25 localhost kernel: usb 1-6.1: configuration #1 chosen from 1 choice




