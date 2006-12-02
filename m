Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424243AbWLBRWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424243AbWLBRWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424245AbWLBRWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:22:15 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:63468 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S1424243AbWLBRWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:22:13 -0500
Date: Sat, 2 Dec 2006 12:22:08 -0500
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: nforce chipset + dualcore x86-64: Oops, NMI, Null pointer deref, etc
Message-ID: <20061202172208.GC20337@jukie.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

to see my history please see this thread...

http://lkml.org/lkml/2006/11/29/156

It might be sata related, but I cannot tell for sure.

In summary, I have an Opteron 170 in a Shuttle SN25P (nforce4 chipset).
I've tested the ram overnight and swapped out every component in the
system except for the HDDs.  I see these problems only with the
dual-core, and even on an older Asus nforce4 based motherboard.  

I've had a hell of a time getting 2.6.18 to stay up longer then a day.
2.6.19 is better but I am still seeing strangeness.  This morning I
noticed the following events (the complete dmesg is included below).

[36514.296462] Unable to handle kernel paging request at 00000000ff757c4f RIP: 
...
[36514.515894]  NMI Watchdog detected LOCKUP on CPU 0
...
[36519.958059] Unable to handle kernel NULL pointer dereference at 0000000000000038 RIP: 

Now the system is quite non-responsive.  I start programs, but they
don't run for a few minutes.  Existing programs seem to work ok.

Any suggestions would be appreciated... I am going to boot with noapic
for now.  From what I can tell things work better with APIC disabled.

-Bart

[    0.000000] Linux version 2.6.19-xenon64-smp.11 (bart@xenon) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #1 SMP Fri Dec 1 15:33:02 EST 2006
[    0.000000] Command line: BOOT_IMAGE=dbg-v2.6.19 ro root=900 console=ttyS0,115200n8 console=tty0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
[    0.000000]  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
[    0.000000]  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 262128) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.2 present.
[    0.000000] ACPI: RSDP (v000 XPC                                   ) @ 0x00000000000f7b90
[    0.000000] ACPI: RSDT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3040
[    0.000000] ACPI: FADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff30c0
[    0.000000] ACPI: MCFG (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff7bc0
[    0.000000] ACPI: MADT (v001 XPC    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff7b00
[    0.000000] ACPI: DSDT (v001 XPC     SN25V10 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 262128) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   262128
[    0.000000] On node 0 totalpages: 262031
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 9 pages reserved
[    0.000000]   DMA zone: 3934 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3527 pages used for memmap
[    0.000000]   DMA32 zone: 254505 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000f0000
[    0.000000] Nosave address range: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] PERCPU: Allocating 33472 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 258439
[    0.000000] Kernel command line: BOOT_IMAGE=dbg-v2.6.19 ro root=900 console=ttyS0,115200n8 console=tty0
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   24.024600] Console: colour VGA+ 80x50
[   24.300431] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   24.308206] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   24.315224] Checking aperture...
[   24.318498] CPU 0: aperture @ 4000000 size 32 MB
[   24.323155] Aperture too small (32 MB)
[   24.332082] No AGP bridge found
[   24.347182] Memory: 1026144k/1048512k available (3242k kernel code, 21592k reserved, 1408k data, 248k init)
[   24.416755] Calibrating delay using timer specific routine.. 4021.80 BogoMIPS (lpj=2010901)
[   24.425239] Security Framework v1.0.0 initialized
[   24.429984] SELinux:  Disabled at boot.
[   24.433874] Mount-cache hash table entries: 256
[   24.438583] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   24.445752] CPU: L2 Cache: 1024K (64 bytes/line)
[   24.450411] CPU: Physical Processor ID: 0
[   24.454462] CPU: Processor Core ID: 0
[   24.458186] Freeing SMP alternatives: 32k freed
[   24.462788] ACPI: Core revision 20060707
[   24.482808] Using local APIC timer interrupts.
[   24.536998] result 12564413
[   24.539832] Detected 12.564 MHz APIC timer.
[   24.544747] Booting processor 1/2 APIC 0x1
[   24.558953] Initializing CPU#1
[   24.619353] Calibrating delay using timer specific routine.. 4020.05 BogoMIPS (lpj=2010029)
[   24.619360] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   24.619362] CPU: L2 Cache: 1024K (64 bytes/line)
[   24.619364] CPU: Physical Processor ID: 0
[   24.619366] CPU: Processor Core ID: 1
[   24.619484] Dual Core AMD Opteron(tm) Processor 170    stepping 02
[   24.620357] CPU 1: Syncing TSC to CPU 0.
[   24.620659] CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 466 cycles)
[   24.620668] Brought up 2 CPUs
[   24.672904] testing NMI watchdog ... OK.
[   24.686903] Disabling vsyscall due to use of PM timer
[   24.692023] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[   24.697806] time.c: Detected 2010.303 MHz processor.
[   25.840388] migration_cost=443
[   25.843933] NET: Registered protocol family 16
[   25.848493] ACPI: bus type pci registered
[   25.855943] PCI: Using MMCONFIG at e0000000
[   25.860193] PCI: No mmconfig possible on device 00:18
[   25.872334] ACPI: Interpreter enabled
[   25.876042] ACPI: Using IOAPIC for interrupt routing
[   25.881491] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   25.886324] PCI: Probing PCI hardware (bus 00)
[   25.889907] PCI: Transparent bridge - 0000:00:09.0
[   25.894992] Boot video device is 0000:01:00.0
[   25.895058] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   25.969737] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   25.971389] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   25.980531] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   25.989690] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 *12 14 15)
[   25.997623] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 *7 9 10 11 12 14 15)
[   26.005552] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   26.014705] ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 7 9 10 11 12 14 15)
[   26.022612] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   26.031747] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[   26.039654] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   26.048792] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   26.057957] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
[   26.065862] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   26.073777] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   26.082939] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   26.090865] ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 *10 11 12 14 15)
[   26.098803] ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   26.108001] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[   26.114893] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[   26.121783] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   26.128686] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[   26.136699] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   26.143378] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
[   26.151190] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
[   26.159000] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
[   26.166806] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
[   26.174625] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
[   26.182446] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
[   26.190245] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
[   26.198042] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
[   26.205852] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
[   26.213666] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
[   26.221471] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
[   26.231535] Linux Plug and Play Support v0.97 (c) Adam Belay
[   26.237241] pnp: PnP ACPI init
[   26.245363] pnp: PnP ACPI: found 11 devices
[   26.249623] Generic PHY: Registered new driver
[   26.254216] SCSI subsystem initialized
[   26.258056] libata version 2.00 loaded.
[   26.258106] usbcore: registered new interface driver usbfs
[   26.263664] usbcore: registered new interface driver hub
[   26.269044] usbcore: registered new device driver usb
[   26.274164] PCI: Using ACPI for IRQ routing
[   26.278392] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   26.286766] NetLabel: Initializing
[   26.290212] NetLabel:  domain hash size = 128
[   26.294610] NetLabel:  protocols = UNLABELED CIPSOv4
[   26.299629] NetLabel:  unlabeled traffic allowed by default
[   26.305277] PCI-DMA: Disabling IOMMU.
[   26.309356] pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
[   26.316098] pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
[   26.322489] pnp: 00:01: ioport range 0x4400-0x447f has been reserved
[   26.328879] pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
[   26.335617] pnp: 00:01: ioport range 0x4800-0x487f has been reserved
[   26.342008] pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
[   26.348636] ieee1394: Initialized config rom entry `ip1394'
[   26.348683] PCI: Bridge: 0000:00:09.0
[   26.352392]   IO window: a000-afff
[   26.355839]   MEM window: d8100000-d81fffff
[   26.360065]   PREFETCH window: disabled.
[   26.364030] PCI: Bridge: 0000:00:0b.0
[   26.367737]   IO window: disabled.
[   26.371184]   MEM window: disabled.
[   26.374718]   PREFETCH window: disabled.
[   26.378685] PCI: Bridge: 0000:00:0c.0
[   26.382390]   IO window: disabled.
[   26.385838]   MEM window: disabled.
[   26.389371]   PREFETCH window: disabled.
[   26.393338] PCI: Bridge: 0000:00:0d.0
[   26.397044]   IO window: disabled.
[   26.400490]   MEM window: disabled.
[   26.404024]   PREFETCH window: disabled.
[   26.407993] PCI: Bridge: 0000:00:0e.0
[   26.411696]   IO window: 9000-9fff
[   26.415145]   MEM window: d8000000-d80fffff
[   26.419370]   PREFETCH window: d0000000-d7ffffff
[   26.424033] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   26.424038] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   26.424043] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   26.424047] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   26.424051] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   26.424072] NET: Registered protocol family 2
[   26.438259] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   26.445695] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   26.454682] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   26.462186] TCP: Hash tables configured (established 131072 bind 65536)
[   26.468839] TCP reno registered
[   26.472643] audit: initializing netlink socket (disabled)
[   26.478106] audit(1165005353.993:1): initialized
[   26.482957] VFS: Disk quotas dquot_6.5.1
[   26.486937] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   26.493460] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[   26.503231] SGI XFS Quota Management subsystem
[   26.507749] io scheduler noop registered
[   26.511760] io scheduler anticipatory registered (default)
[   26.517373] io scheduler deadline registered
[   26.521738] io scheduler cfq registered
[   26.539564] PCI: Linking AER extended capability on 0000:00:0b.0
[   26.545630] PCI: Found HT MSI mapping on 0000:00:0b.0 with capability disabled
[   26.552915] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   26.560082] PCI: Linking AER extended capability on 0000:00:0c.0
[   26.566128] PCI: Found HT MSI mapping on 0000:00:0c.0 with capability disabled
[   26.573413] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   26.580583] PCI: Linking AER extended capability on 0000:00:0d.0
[   26.586628] PCI: Found HT MSI mapping on 0000:00:0d.0 with capability disabled
[   26.593912] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   26.601081] PCI: Linking AER extended capability on 0000:00:0e.0
[   26.607125] PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
[   26.614410] PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
[   26.621779] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   26.621782] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   26.629333] assign_interrupt_mode Found MSI capability
[   26.634535] Allocate Port Service[0000:00:0b.0:pcie00]
[   26.634571] Allocate Port Service[0000:00:0b.0:pcie03]
[   26.634615] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   26.634618] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   26.642165] assign_interrupt_mode Found MSI capability
[   26.647353] Allocate Port Service[0000:00:0c.0:pcie00]
[   26.647383] Allocate Port Service[0000:00:0c.0:pcie03]
[   26.647426] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   26.647429] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   26.654983] assign_interrupt_mode Found MSI capability
[   26.660170] Allocate Port Service[0000:00:0d.0:pcie00]
[   26.660198] Allocate Port Service[0000:00:0d.0:pcie03]
[   26.660239] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   26.660242] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
[   26.667790] assign_interrupt_mode Found MSI capability
[   26.672979] Allocate Port Service[0000:00:0e.0:pcie00]
[   26.673013] Allocate Port Service[0000:00:0e.0:pcie03]
[   26.673096] ACPI: Power Button (FF) [PWRF]
[   26.677236] ACPI: Power Button (CM) [PWRB]
[   26.681386] ACPI: Fan [FAN] (on)
[   26.684717] Using specific hotkey driver
[   26.689314] ACPI: Thermal Zone [THRM] (40 C)
[   26.715676] DoubleTalk PC - not found
[   26.719425] Linux agpgart interface v0.101 (c) Dave Jones
[   26.724869] [drm] Initialized drm 1.0.1 20051102
[   26.729797] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   26.735588] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
[   26.744509] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[   26.750475] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   26.759494] Hangcheck: Using monotonic_clock().
[   26.764067] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   26.771977] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   26.778508] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   26.784708] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   26.792426] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
[   26.800310] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
[   26.806098] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
[   26.814936] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[   26.814942] forcedeth: using HIGHDMA
[   27.330722] eth0: forcedeth.c: subsystem: 01297:5036 bound to 0000:00:0a.0
[   27.337641] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   27.344035] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   27.352191] Probing IDE interface ide0...
[   28.145997] hda: PLEXTOR DVDR PX-716AL, ATAPI CD/DVD-ROM drive
[   28.457643] Probing IDE interface ide1...
[   28.970267] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   28.975011] sata_nv 0000:00:07.0: version 2.0
[   28.975405] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
[   28.981192] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> IRQ 22
[   28.990616] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   28.990688] ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 22
[   28.997720] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 22
[   29.004729] scsi0 : sata_nv
[   29.461888] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   29.468651] ata1.00: ATA-7, max UDMA/133, 320170943 sectors: LBA48 
[   29.474954] ata1.00: ata1: dev 0 multi count 16
[   29.480186] ata1.00: configured for UDMA/133
[   29.484517] scsi1 : sata_nv
[   29.941501] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   29.948283] ata2.00: ATA-7, max UDMA/133, 320173056 sectors: LBA48 
[   29.954585] ata2.00: ata2: dev 0 multi count 16
[   29.959843] ata2.00: configured for UDMA/133
[   29.964223] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y160M0   YAR5 PQ: 0 ANSI: 5
[   29.972452] SCSI device sda: 320170943 512-byte hdwr sectors (163928 MB)
[   29.979194] sda: Write Protect is off
[   29.982903] sda: Mode Sense: 00 3a 00 00
[   29.982913] SCSI device sda: drive cache: write back
[   29.987952] SCSI device sda: 320170943 512-byte hdwr sectors (163928 MB)
[   29.994694] sda: Write Protect is off
[   29.999599] sda: Mode Sense: 00 3a 00 00
[   29.999609] SCSI device sda: drive cache: write back
[   30.004614]  sda: sda1 sda2 sda3
[   30.067176] sd 0:0:0:0: Attached scsi disk sda
[   30.071735] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   30.077151] scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y160M0   YAR5 PQ: 0 ANSI: 5
[   30.085363] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   30.092109] sdb: Write Protect is off
[   30.095819] sdb: Mode Sense: 00 3a 00 00
[   30.095830] SCSI device sdb: drive cache: write back
[   30.100862] SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
[   30.107601] sdb: Write Protect is off
[   30.111313] sdb: Mode Sense: 00 3a 00 00
[   30.111323] SCSI device sdb: drive cache: write back
[   30.116324]  sdb: sdb1 sdb2 sdb3
[   30.158212] sd 1:0:0:0: Attached scsi disk sdb
[   30.162748] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   30.168551] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
[   30.174346] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> IRQ 21
[   30.183433] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   30.183502] ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
[   30.190541] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
[   30.197559] scsi2 : sata_nv
[   30.503075] ata3: SATA link down (SStatus 0 SControl 300)
[   30.508519] scsi3 : sata_nv
[   30.814833] ata4: SATA link down (SStatus 0 SControl 300)
[   30.820304] ieee1394: raw1394: /dev/raw1394 device initialized
[   30.826202] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   30.833203] ieee1394: sbp2: Try serialize_io=0 for better performance
[   30.839736] usbmon: debugfs is not available
[   30.844406] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
[   30.850199] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
[   30.859258] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   30.859263] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   30.864646] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
[   30.872126] ehci_hcd 0000:00:02.1: debug port 1
[   30.876700] PCI: cache line size of 64 is not supported by device 0000:00:02.1
[   30.876709] ehci_hcd 0000:00:02.1: irq 20, io mem 0xd8205000
[   30.882413] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   30.890067] usb usb1: configuration #1 chosen from 1 choice
[   30.895709] hub 1-0:1.0: USB hub found
[   30.899510] hub 1-0:1.0: 10 ports detected
[   31.004753] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   31.005118] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
[   31.010902] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
[   31.019954] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   31.019959] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   31.025324] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
[   31.032792] ohci_hcd 0000:00:02.0: irq 23, io mem 0xd8204000
[   31.091705] usb usb2: configuration #1 chosen from 1 choice
[   31.097349] hub 2-0:1.0: USB hub found
[   31.101147] hub 2-0:1.0: 10 ports detected
[   31.206599] USB Universal Host Controller Interface driver v3.0
[   31.213529] usb 1-2: new high speed USB device using ehci_hcd and address 2
[   31.339151] usb 1-2: configuration #1 chosen from 1 choice
[   31.862010] usb 1-6: new high speed USB device using ehci_hcd and address 5
[   31.998536] usb 1-6: configuration #1 chosen from 1 choice
[   32.221732] usb 2-3: new low speed USB device using ohci_hcd and address 2
[   32.374720] usb 2-3: configuration #1 chosen from 1 choice
[   32.599441] usb 2-4: new full speed USB device using ohci_hcd and address 3
[   32.750443] usb 2-4: configuration #1 chosen from 1 choice
[   32.757397] hub 2-4:1.0: USB hub found
[   32.762367] hub 2-4:1.0: 3 ports detected
[   33.064142] usb 2-4.1: new full speed USB device using ohci_hcd and address 4
[   33.168131] usb 2-4.1: configuration #1 chosen from 1 choice
[   33.185055] usbcore: registered new interface driver libusual
[   33.190888] usbcore: registered new interface driver hiddev
[   33.204123] input: Logitech Trackball as /class/input/input0
[   33.209822] input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:02.0-3
[   33.222118] input: Chicony  PFU-65 USB Keyboard as /class/input/input1
[   33.228688] input: USB HID v1.00 Keyboard [Chicony  PFU-65 USB Keyboard] on usb-0000:00:02.0-4.1
[   33.237622] usbcore: registered new interface driver usbhid
[   33.243231] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   33.249573] PNP: No PS/2 controller found. Probing ports directly.
[   33.507121] serio: i8042 KBD port at 0x60,0x64 irq 1
[   33.512214] mice: PS/2 mouse device common for all mice
[   33.517549] md: raid0 personality registered for level 0
[   33.522905] md: raid1 personality registered for level 1
[   33.528301] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[   33.536861] TCP cubic registered
[   33.540144] NET: Registered protocol family 1
[   33.847544] md: Autodetecting RAID arrays.
[   33.901666] md: autorun ...
[   33.904508] md: considering sdb3 ...
[   33.908134] md:  adding sdb3 ...
[   33.911411] md: sdb1 has different UUID to sdb3
[   33.915982] md:  adding sda3 ...
[   33.919257] md: sda1 has different UUID to sdb3
[   33.923866] md: created md1
[   33.926707] md: bind<sda3>
[   33.929467] md: bind<sdb3>
[   33.932227] md: running: <sdb3><sda3>
[   33.936145] raid1: raid set md1 active with 2 out of 2 mirrors
[   33.942053] md: considering sdb1 ...
[   33.945673] md:  adding sdb1 ...
[   33.948945] md:  adding sda1 ...
[   33.952217] md: created md0
[   33.955056] md: bind<sda1>
[   33.957818] md: bind<sdb1>
[   33.960580] md: running: <sdb1><sda1>
[   33.964489] raid1: raid set md0 active with 2 out of 2 mirrors
[   33.970395] md: ... autorun DONE.
[   33.974797] Filesystem "md0": Disabling barriers, not supported by the underlying device
[   33.983147] XFS mounting filesystem md0
[   34.107449] Ending clean XFS mount for filesystem: md0
[   34.107504] VFS: Mounted root (xfs filesystem) readonly.
[   34.112914] Freeing unused kernel memory: 248k freed
[   44.615813] lp: driver loaded but no devices found
[   44.629868] Real Time Clock Driver v1.12ac
[   44.690685] Adding 1951888k swap on /dev/sda2.  Priority:-1 extents:1 across:1951888k
[   44.707248] Adding 1951888k swap on /dev/sdb2.  Priority:-2 extents:1 across:1951888k
[   44.813289] Filesystem "md0": Disabling barriers, not supported by the underlying device
[   47.809658] Filesystem "dm-4": Disabling barriers, not supported by the underlying device
[   47.832891] XFS mounting filesystem dm-4
[   47.919943] Starting XFS recovery on filesystem: dm-4 (logdev: internal)
[   47.994080] Ending XFS recovery on filesystem: dm-4 (logdev: internal)
[   48.071295] Filesystem "dm-1": Disabling barriers, not supported by the underlying device
[   48.095571] XFS mounting filesystem dm-1
[   48.358152] Ending clean XFS mount for filesystem: dm-1
[   48.536687] kjournald starting.  Commit interval 5 seconds
[   48.542205] EXT3 FS on dm-3, internal journal
[   48.542211] EXT3-fs: mounted filesystem with ordered data mode.
[   48.589866] Filesystem "dm-0": Disabling barriers, not supported by the underlying device
[   48.612587] XFS mounting filesystem dm-0
[   48.690742] Starting XFS recovery on filesystem: dm-0 (logdev: internal)
[   48.977576] Ending XFS recovery on filesystem: dm-0 (logdev: internal)
[   49.040971] Filesystem "dm-2": Disabling barriers, not supported by the underlying device
[   49.052967] XFS mounting filesystem dm-2
[   49.237089] Ending clean XFS mount for filesystem: dm-2
[  175.572997] NET: Registered protocol family 17
[  179.085580] ibm_acpi: ec object not found
[  179.209382] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[  183.497167] Linux video capture interface: v2.00
[  185.776980] NET: Registered protocol family 10
[  185.777068] lo: Disabled Privacy Extensions
[  196.621982] eth0: no IPv6 routers present
[  314.704296] ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
[  314.704323] ALSA sound/pci/ice1712/ice1724.c:2050: using the defined eeprom..
[29370.530107] eth0: too many iterations (6) in nv_nic_irq.
[36514.296462] Unable to handle kernel paging request at 00000000ff757c4f RIP: 
[36514.301077]  [<ffffffff8103e2d3>] ide_dma_intr+0x53/0xf0
[36514.308853] PGD 3aecf067 PUD 0 
[36514.312023] Oops: 0000 [1] SMP 
[36514.315192] CPU 0 
[36514.317218] Modules linked in: snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ac97_bus snd_ak4114 snd_ak4xxx_adda snd_mpu401_uart snd_pcm_oss snd_pcm snd_page_alloc snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore binfmt_misc ipv6 videodev v4l1_compat v4l2_common container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[36514.355758] Pid: 2127, comm: Xorg Not tainted 2.6.19-xenon64-smp.11 #1
[36514.362278] RIP: 0010:[<ffffffff8103e2d3>]  [<ffffffff8103e2d3>] ide_dma_intr+0x53/0xf0
[36514.370289] RSP: 0018:ffff81003a157ed0  EFLAGS: 00010006
[36514.375591] RAX: 0000000001312d00 RBX: ffff81003a157f38 RCX: 0000000000004e20
[36514.382717] RDX: 00000000ff757baf RSI: 0000000001312d00 RDI: ffff81003e55b730
[36514.389845] RBP: ffff81003e55b730 R08: 0000000000000001 R09: 0000000000000000
[36514.396971] R10: 0000000000000001 R11: 0000000000000246 R12: ffff81003ae2c100
[36514.404092] R13: 0000000000000000 R14: 00007fffbc9562a0 R15: 00000000006a8cb0
[36514.411218] FS:  00002ab4eee5fd10(0000) GS:ffffffff8148b000(0000) knlGS:00000000f74a46c0
[36514.419299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[36514.425040] CR2: 00000000ff757c4f CR3: 000000003a56e000 CR4: 00000000000006e0
[36514.432159] Process Xorg (pid: 2127, threadinfo ffff81003a156000, task ffff81003ae2c100)
[36514.440237] Stack:  ffffffff8103488f ffff81003a157dd8 ffff81003a157de0 ffffffff81044e95
[36514.448309]  00000000006bca00 0000000000000000 0000000000000000 ffff81003a157f38
[36514.455757]  ffffffff8108e252 00000000006a8cb0 ffffffff810163a1 00000000000000f3
[36514.463015] Call Trace:
[36514.465652]  [<ffffffff8103488f>] do_setitimer+0x16f/0x4d0
[36514.471132]  [<ffffffff81044e95>] sys_rt_sigreturn+0x235/0x2f0
[36514.476961]  [<ffffffff8108e252>] sys_setitimer+0xb2/0xd0
[36514.482355]  [<ffffffff810163a1>] sys_select+0x151/0x1d0
[36514.487665]  [<ffffffff8106211e>] system_call+0x7e/0x83
[36514.492887] 
[36514.494381] 
[36514.494382] Code: 48 8b 82 a0 00 00 00 48 85 c0 74 18 48 8b 40 50 48 8b 52 40 
[36514.503440] RIP  [<ffffffff8103e2d3>] ide_dma_intr+0x53/0xf0
[36514.509104]  RSP <ffff81003a157ed0>
[36514.512587] CR2: 00000000ff757c4f
[36514.515894]  NMI Watchdog detected LOCKUP on CPU 0
[36519.731721] CPU 0 
[36519.733748] Modules linked in: snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ac97_bus snd_ak4114 snd_ak4xxx_adda snd_mpu401_uart snd_pcm_oss snd_pcm snd_page_alloc snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore binfmt_misc ipv6 videodev v4l1_compat v4l2_common container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[36519.772287] Pid: 2127, comm: Xorg Not tainted 2.6.19-xenon64-smp.11 #1
[36519.778807] RIP: 0010:[<ffffffff81067af8>]  [<ffffffff81067af8>] _spin_lock_irq+0x8/0x10
[36519.786906] RSP: 0018:ffff81003a157c70  EFLAGS: 00000086
[36519.792214] RAX: ffff81003ae2c100 RBX: ffff81003e55b940 RCX: ffff81003fd72428
[36519.799342] RDX: 0000000000000000 RSI: 0000000000000292 RDI: ffff81003c0e0d08
[36519.806468] RBP: 00000000000344f0 R08: 00000000ffffffff R09: 000000000000084f
[36519.813587] R10: 000000000000000c R11: 0000000000000006 R12: 0000000000000009
[36519.820706] R13: 0000000000000009 R14: 0000000000000000 R15: ffff81003a157e28
[36519.827825] FS:  00002ab4eee5fd10(0000) GS:ffffffff8148b000(0000) knlGS:00000000f74a46c0
[36519.835904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[36519.841638] CR2: 00000000ff757c4f CR3: 000000003a56e000 CR4: 00000000000006e0
[36519.848767] Process Xorg (pid: 2127, threadinfo ffff81003a156000, task ffff81003ae2c100)
[36519.856844] Stack:  ffffffff810a7bed 0000000000000046 ffff81003ae2c100 0000000000000001
[36519.864916]  ffffffff81015118 ffff81003a157ed0 0000000000000000 ffff81003a157e28
[36519.872363]  00ffffff8106fa54 0000000000000000 ffffffff813582a5 00000000000000f0
[36519.879621] Call Trace:
[36519.882257]  [<ffffffff810a7bed>] acct_collect+0xad/0x1a0
[36519.887651]  [<ffffffff81015118>] do_exit+0x1e8/0x8e0
[36519.892704]  [<ffffffff8106a319>] do_page_fault+0x7c9/0x8d0
[36519.898272]  [<ffffffff810cc69e>] core_sys_select+0x24e/0x2e0
[36519.904013]  [<ffffffff8106807d>] error_exit+0x0/0x84
[36519.909062]  [<ffffffff8103e2d3>] ide_dma_intr+0x53/0xf0
[36519.914370]  [<ffffffff8103488f>] do_setitimer+0x16f/0x4d0
[36519.919850]  [<ffffffff81044e95>] sys_rt_sigreturn+0x235/0x2f0
[36519.925680]  [<ffffffff8108e252>] sys_setitimer+0xb2/0xd0
[36519.931074]  [<ffffffff810163a1>] sys_select+0x151/0x1d0
[36519.936385]  [<ffffffff8106211e>] system_call+0x7e/0x83
[36519.941606] 
[36519.943100] 
[36519.943101] Code: 83 3f 00 7e f9 eb f2 c3 53 48 89 fb e8 67 74 02 00 f0 ff 0b 
[36519.952160]  <1>Fixing recursive fault but reboot is needed!
[36519.958059] Unable to handle kernel NULL pointer dereference at 0000000000000038 RIP: 
[36519.963540]  [<ffffffff8103e2d0>] ide_dma_intr+0x50/0xf0
[36519.971308] PGD 1fa02067 PUD 1a759067 PMD 0 
[36519.975620] Oops: 0000 [2] SMP 
[36519.978789] CPU 0 
[36519.980815] Modules linked in: snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ac97_bus snd_ak4114 snd_ak4xxx_adda snd_mpu401_uart snd_pcm_oss snd_pcm snd_page_alloc snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore binfmt_misc ipv6 videodev v4l1_compat v4l2_common container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[36520.019355] Pid: 5752, comm: screen Not tainted 2.6.19-xenon64-smp.11 #1
[36520.026042] RIP: 0010:[<ffffffff8103e2d0>]  [<ffffffff8103e2d0>] ide_dma_intr+0x50/0xf0
[36520.034052] RSP: 0018:ffff8100291b9ee0  EFLAGS: 00010006
[36520.039352] RAX: 0000000000000000 RBX: ffff8100291b9f48 RCX: 0000000000000000
[36520.046471] RDX: 0000000000000041 RSI: 000000037e11d600 RDI: ffff8100356721f0
[36520.053598] RBP: ffff8100356721f0 R08: 00007fff4de7df90 R09: 00007fff4de7e030
[36520.060725] R10: 0000000000000008 R11: 0000000000000206 R12: ffff810018114180
[36520.067845] R13: ffff8100291b9f28 R14: 0000000000000000 R15: 00007fff4de7e0f0
[36520.074972] FS:  00002b055d530ae0(0000) GS:ffffffff8148b000(0000) knlGS:00000000f74a46c0
[36520.083052] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[36520.088793] CR2: 0000000000000038 CR3: 000000001a753000 CR4: 00000000000006e0
[36520.095912] Process screen (pid: 5752, threadinfo ffff8100291b8000, task ffff810018114180)
[36520.104164] Stack:  ffffffff8103488f 000003e800001678 00007fff4de7dee0 00007fff4de7de40
[36520.112237]  0000000000000000 0000000000000012 00007fff4de7e4e0 00007fff4de7f938
[36520.119684]  ffffffff8108e2a5 0000000000000000 0000000000000000 0000000000000000
[36520.126942] Call Trace:
[36520.129576]  [<ffffffff8103488f>] do_setitimer+0x16f/0x4d0
[36520.135060]  [<ffffffff8108e2a5>] alarm_setitimer+0x35/0x70
[36520.140627]  [<ffffffff81092a99>] sys_alarm+0x9/0x10
[36520.145589]  [<ffffffff8106211e>] system_call+0x7e/0x83
[36520.150811] 
[36520.152306] 
[36520.152307] Code: 8b 50 38 48 8b 82 a0 00 00 00 48 85 c0 74 18 48 8b 40 50 48 
[36520.161365] RIP  [<ffffffff8103e2d0>] ide_dma_intr+0x50/0xf0
[36520.167031]  RSP <ffff8100291b9ee0>
[36520.170520] CR2: 0000000000000038
[36520.173827]  NMI Watchdog detected LOCKUP on CPU 1
[72692.470814] CPU 1 
[72692.472849] Modules linked in: snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ac97_bus snd_ak4114 snd_ak4xxx_adda snd_mpu401_uart snd_pcm_oss snd_pcm snd_page_alloc snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd soundcore binfmt_misc ipv6 videodev v4l1_compat v4l2_common container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[72692.511389] Pid: 15399, comm: ps Not tainted 2.6.19-xenon64-smp.11 #1
[72692.517823] RIP: 0010:[<ffffffff81067ada>]  [<ffffffff81067ada>] _spin_lock_irqsave+0xa/0x20
[72692.526274] RSP: 0018:ffff810008e75c20  EFLAGS: 00000082
[72692.531574] RAX: 0000000000000286 RBX: ffff81003c0e0500 RCX: ffff810008e75e67
[72692.538702] RDX: ffff810008e75fd8 RSI: ffff810008e75e70 RDI: ffff81003c0e0d08
[72692.545830] RBP: ffff81003c0e0d08 R08: 0000000000000000 R09: 0000000000000000
[72692.552956] R10: 00000000000004e2 R11: 0000000000000000 R12: ffff81003ae2c100
[72692.560076] R13: ffff810008e75e70 R14: 00000000000003ff R15: ffff810008e75f50
[72692.567203] FS:  00002b6b17dd66d0(0000) GS:ffff8100025395c0(0000) knlGS:00000000f74a46c0
[72692.575283] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[72692.581026] CR2: 00002aaaaca30000 CR3: 000000002707e000 CR4: 00000000000006e0
[72692.588152] Process ps (pid: 15399, threadinfo ffff810008e74000, task ffff810019797810)
[72692.596145] Stack:  ffffffff8109389a ffff810008e75c88 ffff81003ae2c100 ffff810015bfa000
[72692.604217]  ffff81003fd723c0 ffff8100117a3358 ffffffff8101e4ac ffff810008e75e48
[72692.611664]  00000101039fda68 ffff810008e75ca8 ffffffff81009d15 0000000000000000
[72692.618921] Call Trace:
[72692.621558]  [<ffffffff8109389a>] lock_task_sighand+0x3a/0x80
[72692.627300]  [<ffffffff8101e4ac>] do_task_stat+0xfc/0x7c0
[72692.632693]  [<ffffffff81009d15>] __link_path_walk+0xcc5/0xe20
[72692.638522]  [<ffffffff8102d9b4>] mntput_no_expire+0x24/0xb0
[72692.644177]  [<ffffffff8100e040>] link_path_walk+0x100/0x140
[72692.649835]  [<ffffffff8100c053>] do_path_lookup+0x1d3/0x210
[72692.655487]  [<ffffffff8100ee98>] generic_permission+0x78/0x110
[72692.661405]  [<ffffffff8100eb95>] __alloc_pages+0x65/0x2f0
[72692.666889]  [<ffffffff810f0543>] proc_info_read+0x73/0xf0
[72692.672366]  [<ffffffff8100abeb>] vfs_read+0xdb/0x1a0
[72692.677416]  [<ffffffff810112e3>] sys_read+0x53/0x90
[72692.682378]  [<ffffffff8106211e>] system_call+0x7e/0x83
[72692.687600] 
[72692.689094] 
[72692.689095] Code: 83 3f 00 7e f9 eb f2 c3 66 66 66 90 66 66 66 90 66 66 90 66 
[72692.698155]  

-- 
				WebSig: http://www.jukie.net/~bart/sig/
