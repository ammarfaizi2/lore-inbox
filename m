Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbVIOWUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbVIOWUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbVIOWUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:20:14 -0400
Received: from xenotime.net ([66.160.160.81]:3464 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965290AbVIOWUK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:20:10 -0400
Date: Thu, 15 Sep 2005 15:20:03 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: linux-kernel@vger.kernel.org
Subject: soft lockup disease (2.6.14-rc1, x86_64)
Message-ID: <Pine.LNX.4.58.0509151441430.1800@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



(somewhat like http://bugzilla.kernel.org/show_bug.cgi?id=5159 )
but not IO/Storage related AFAICT, and not xseries.

It always includes ext3 in the backtrace (from what I have noticed).
[The serial console output appears a bit garbled.]

Are there patches for this or is it an outstanding issue?


2.6.14-rc1, during bootup (before login) or when I try to
'startx', I usually get either dead silence or a soft lockup:


[   43.538797] BUG: soft lockup detected on CPU#0!5 Intel Corporation4: Host added: ID:BUS[0-00:1023
[   43.544450] CPU 0:np: PnP ACPI init7105
[   43.547526] Modules linked in:19.899318] pnp: PnP ACPI: found 1
[   43.551648] Pid: 1181, comm: klogd Not tainted 2.6.14-rc1 #103871] Generic PHY: Registered new driver.681353] Uniform Multi
[   43.558418] RIP: 0010:[<ffffffff801b0e7b>] <subsystem ini

IA-32 Microcode Update Driver: v1
[   1

[   43.582387] RDX: ffff81007d614a90 RSI: ffff81007ef9e280 RDI: 0000000000002011Qde: No new microcode data for CPU0
post a r

[   43.590712] RBP: ffff81007efa9000 R08: 000000000000001d R09: ffff81007efa9000-32 M
[   23.7178
[   19.939655] pnp: 00:05: ioport range 0x500-0x53f has been r

[   43.599045] R10: 00000000000001c8 R11: 0000000000000000 R12: 00000000000001c89.945969] pnp: 00:05: ioport range 0x400-0x47f could not be reservedistered prot

[   43.607366] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000000:05: ioport range 0x680-0x6ff has been reserved
[   24.473861] h

md: md0 switche
[   19.979559]   IO window: 1000-1fff] L

[   43.640253]... checking i
[   43.640253] Call Trace:<ffffffff801b0f00>{bitmap_search_next_usable_block+69}
[
[   19.987302]   PREFETCH window: disabled.00000] Bootdata ok (

[   43.649916]        <ffffffff801b1299>{ext3_try_to_allocate+365} <ffffffff801b
[   25.41959
[   19.995048]   IO window: disabled. -> GSI 19 (level, l
1d0f>{ext3_try_to_allocate_with_rsv+771}ndow: 90400000-904fffff
[   43.661858]        <ffffffff8017cbe5>{__bread+11} <ffffdow: disabled.
[   20.026017
[   43.691860]        <ffffffff8016204c>{kmem_cache_alloc+142} <ffffffff801b692fM window: 90600000-906fffff 0 ATA, max UDMA/133, 312581808 sectors: lba48
[   20
xt3_get_block+0}
[   43.732770]        <ffffffff8017bdbb>{block_prepare_write+32} <ffffffff801b59
8c>{ext3_prepare_write+150}
[   43.743638]        <ffffffff803a862f>{_write_unlock_irq+9} <ffffffff8015a6c2>
{generic_file_buffered_write+709}
[   43.755058]        <ffffffff80160127>{make_ahead_window+137} <ffffffff8019105
7>{update_atime+68}
[   43.765249]        <ffffffff8013aabe>{current_fs_time+63} <ffffffff8015b0f2>{
do_generic_mapping_read+1353}
[   43.776348]        <ffffffff8015be43>{__generic_file_aio_write_nolock+792}
[   43.784588]        <ffffffff8015e89d>{__alloc_pages+254} <ffffffff8015c165>{g
eneric_file_aio_write+125}
[   43.795460]        <ffffffff801b2d5c>{ext3_file_write+28} <ffffffff80178adb>{
do_sync_write+223}
[   43.805618]        <ffffffff8016a2e9>{__handle_mm_fault+395} <ffffffff801f63a
b>{__up_read+139}
[   43.815682]        <ffffffff803a903c>{do_page_fault+1064} <ffffffff80149e94>{
autoremove_wake_function+0}
[   43.826642]        <ffffffff803a85ae>{_spin_unlock+9} <ffffffff80178fa7>{vfs_
write+178}
[   43.836102]        <ffffffff801794b3>{sys_write+69} <ffffffff8010e8f2>{system
_call+126}
[   43.845574]


-- 

Full boot log:


þÄ[    0.000000] Linux version 2.6.14-rc1 (rddunlap@vortex) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #1 SMP Thu Sep 15 13:49:51 PDT 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fe65000 (usable)
[    0.000000]  BIOS-e820: 000000007fe65000 - 000000007fee9000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fee9000 - 000000007feed000 (usable)
[    0.000000]  BIOS-e820: 000000007feed000 - 000000007feff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007feff000 - 000000007ff00000 (usable)
[    0.000000] ACPI: RSDP (v000 INTEL                                 ) @ 0x00000000000fe020
[    0.000000] ACPI: RSDT (v001 INTEL  D945GNT  0x000005d5 MSFT 0x01000013) @ 0x000000007fefde48
[    0.000000] ACPI: FADT (v001 INTEL  D945GNT  0x000005d5 MSFT 0x01000013) @ 0x000000007fefcf10
[    0.000000] ACPI: MADT (v001 INTEL  D945GNT  0x000005d5 MSFT 0x01000013) @ 0x000000007fefce10
[    0.000000] ACPI: WDDT (v001 INTEL  D945GNT  0x000005d5 MSFT 0x01000013) @ 0x000000007fef7f90
[    0.000000] ACPI: MCFG (v001 INTEL  D945GNT  0x000005d5 MSFT 0x01000013) @ 0x000000007fef7f10
[    0.000000] ACPI: ASF! (v032 INTEL  D945GNT  0x000005d5 MSFT 0x01000013) @ 0x000000007fefcd10
[    0.000000] ACPI: SSDT (v001 INTEL     CpuPm 0x000005d5 MSFT 0x01000013) @ 0x000000007fefdc10
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu0Ist 0x000005d5 MSFT 0x01000013) @ 0x000000007fefda10
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu1Ist 0x000005d5 MSFT 0x01000013) @ 0x000000007fefd810
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu2Ist 0x000005d5 MSFT 0x01000013) @ 0x000000007fefd610
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu3Ist 0x000005d5 MSFT 0x01000013) @ 0x000000007fefd410
[    0.000000] ACPI: TCPA (v001 INTEL  TIANO    0x00000002 MSFT 0x01000013) @ 0x000000007febbe10
[    0.000000] ACPI: DSDT (v001 INTEL  D945GNT  0x000005d5 MSFT 0x01000013) @ 0x0000000000000000
[    0.000000] On node 0 totalpages: 523785
[    0.000000]   DMA zone: 3999 pages, LIFO batch:1
[    0.000000]   Normal zone: 519786 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 7ff00000:80100000)
[    0.000000] Checking aperture...
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=/dev/sda6 vga=0x317 selinux=0    resume=/dev/sda2  splash=silent console=ttyS0,115200n8 console=tty0 usb-handoff debug
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 3200.122 MHz processor.
[   19.828342] Console: colour dummy device 80x25
[   20.211150] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   20.220153] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   20.244734] Memory: 2058216k/2096128k available (2736k kernel code, 36500k reserved, 1132k data, 188k init)
[   20.334354] Calibrating delay using timer specific routine.. 6410.18 BogoMIPS (lpj=12820368)
[   20.344788] Mount-cache hash table entries: 256
[   20.349647] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   20.355033] CPU: L2 cache: 1024K
[   20.358335] using mwait in idle threads.
[   20.362364] CPU: Physical Processor ID: 0
[   20.366470] CPU: Processor Core ID: 0
[   20.370230] CPU0: Thermal monitoring enabled (TM1)
[   20.375148] mtrr: v2.0 (20020519)
[   20.431617] Using local APIC timer interrupts.
[   20.467401] Detected 12.500 MHz APIC timer.
[   20.471767] softlockup thread 0 started up.
[   20.476217] Booting processor 1/2 APIC 0x1
[   20.490820] Initializing CPU#1
[   20.570362] Calibrating delay using timer specific routine.. 6400.40 BogoMIPS (lpj=12800804)
[   20.570373] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   20.570375] CPU: L2 cache: 1024K
[   20.570378] CPU: Physical Processor ID: 0
[   20.570380] CPU: Processor Core ID: 1
[   20.570390] CPU1: Thermal monitoring enabled (TM1)
[   20.570590]               Intel(R) Pentium(R) D CPU 3.20GHz stepping 04
[   20.570597] APIC error on CPU1: 00(40)
[   20.570600] CPU 1: Syncing TSC to CPU 0.
[   20.570887] CPU 1: synchronized TSC with CPU 0 (last diff 14 cycles, maxerr 2256 cycles)
[   20.570904] Brought up 2 CPUs
[   20.570909] softlockup thread 1 started up.
[   20.634324] time.c: Using PIT/TSC based timekeeping.
[   20.639414] testing NMI watchdog ... OK.
[   20.684553] NET: Registered protocol family 16
[   20.689138] ACPI: bus type pci registered
[   20.693255] PCI: Using configuration type 1
[   20.697986] PCI: Using MMCONFIG at f0000000
[   20.708500] ACPI: Subsystem revision 20050902
[   20.720224] ACPI: Interpreter enabled
[   20.723978] ACPI: Using IOAPIC for interrupt routing
[   20.730057] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   20.734974] PCI: Probing PCI hardware (bus 00)
[   20.739571] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   20.750360] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   20.756577] Boot video device is 0000:01:00.0
[   20.761850] PCI: Transparent bridge - 0000:00:1e.0
[   20.766815] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   20.780852] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[   20.789221] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[   20.796361] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12)
[   20.803490] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[   20.810620] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[   20.817744] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[   20.826038] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[   20.834330] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
[   20.841455] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
[   20.850755] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[   20.857978] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[   20.865034] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[   20.872095] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[   20.879146] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
[   20.887795] Linux Plug and Play Support v0.97 (c) Adam Belay
[   20.893628] pnp: PnP ACPI init
[   20.900427] pnp: PnP ACPI: found 11 devices
[   20.905006] Generic PHY: Registered new driver
[   20.910540] SCSI subsystem initialized
[   20.914513] usbcore: registered new driver usbfs
[   20.919336] usbcore: registered new driver hub
[   20.924102] PCI: Using ACPI for IRQ routing
[   20.928402] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   20.937046] PCI-DMA: Disabling IOMMU.
[   20.940935] pnp: 00:05: ioport range 0x500-0x53f has been reserved
[   20.947226] pnp: 00:05: ioport range 0x400-0x47f could not be reserved
[   20.953867] pnp: 00:05: ioport range 0x680-0x6ff has been reserved
[   20.960833] PCI: Bridge: 0000:00:01.0
[   20.964597]   IO window: 2000-2fff
[   20.968087]   MEM window: 90200000-902fffff
[   20.972383]   PREFETCH window: 80000000-8fffffff
[   20.977120] PCI: Bridge: 0000:00:1c.0
[   20.980876]   IO window: 1000-1fff
[   20.984370]   MEM window: 90100000-901fffff
[   20.988660]   PREFETCH window: disabled.
[   20.992681] PCI: Bridge: 0000:00:1c.2
[   20.996438]   IO window: disabled.
[   20.999931]   MEM window: 90400000-904fffff
[   21.004220]   PREFETCH window: disabled.
[   21.008251] PCI: Bridge: 0000:00:1c.3
[   21.012000]   IO window: disabled.
[   21.015486]   MEM window: 90500000-905fffff
[   21.019779]   PREFETCH window: disabled.
[   21.023802] PCI: Bridge: 0000:00:1c.4
[   21.027556]   IO window: disabled.
[   21.031051]   MEM window: 90600000-906fffff
[   21.035351]   PREFETCH window: disabled.
[   21.039370] PCI: Bridge: 0000:00:1c.5
[   21.043129]   IO window: disabled.
[   21.046618]   MEM window: 90700000-907fffff
[   21.050910]   PREFETCH window: disabled.
[   21.054940] PCI: Bridge: 0000:00:1e.0
[   21.058702]   IO window: disabled.
[   21.062185]   MEM window: 90000000-900fffff
[   21.066481]   PREFETCH window: disabled.
[   21.070519] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   21.078111] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   21.084550] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   21.092150] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   21.098583] Losing some ticks... checking if CPU frequency changed.
[   21.105025] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   21.112628] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   21.119072] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   21.126673] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   21.133115] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
[   21.140720] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   21.147165] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
[   21.154772] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[   21.161210] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   21.168565] IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
[   21.176095] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
[   21.187647] audit: initializing netlink socket (disabled)
[   21.193212] audit(1126796617.364:1): initialized
[   21.198794] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   21.204598] pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
[   21.211027] pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
[   21.217503] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   21.225105] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   21.231551] assign_interrupt_mode Found MSI capability
[   21.236786] Allocate Port Service[pcie00]
[   21.240983] Allocate Port Service[pcie03]
[   21.245170] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   21.252778] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   21.259232] assign_interrupt_mode Found MSI capability
[   21.264460] Allocate Port Service[pcie00]
[   21.268647] Allocate Port Service[pcie02]
[   21.272830] Allocate Port Service[pcie03]
[   21.277020] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   21.284627] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   21.291079] assign_interrupt_mode Found MSI capability
[   21.296309] Allocate Port Service[pcie00]
[   21.300492] Allocate Port Service[pcie02]
[   21.304680] Allocate Port Service[pcie03]
[   21.308870] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   21.316481] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   21.322934] assign_interrupt_mode Found MSI capability
[   21.328164] Allocate Port Service[pcie00]
[   21.332345] Allocate Port Service[pcie02]
[   21.336529] Allocate Port Service[pcie03]
[   21.340714] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
[   21.348313] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   21.354769] assign_interrupt_mode Found MSI capability
[   21.359998] Allocate Port Service[pcie00]
[   21.364181] Allocate Port Service[pcie02]
[   21.368369] Allocate Port Service[pcie03]
[   21.372562] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
[   21.380168] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[   21.386621] assign_interrupt_mode Found MSI capability
[   21.391850] Allocate Port Service[pcie00]
[   21.396036] Allocate Port Service[pcie02]
[   21.400217] Allocate Port Service[pcie03]
[   21.404716] vesafb: framebuffer at 0x80000000, mapped to 0xffffc20010100000, using 3072k, total 16384k
[   21.414196] vesafb: mode is 1024x768x16, linelength=2048, pages=9
[   21.420403] vesafb: scrolling: redraw
[   21.424131] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   21.430229] vesafb: Mode is not VGA compatible
[   21.438657] Console: switching to colour frame buffer device 128x48
[   21.445113] fb0: VESA VGA frame buffer device
[   21.449616] ACPI: Power Button (FF) [PWRF]
[   21.453853] ACPI: Sleep Button (CM) [SLPB]
[   21.458202] Using specific hotkey driver
[   21.462542] ACPI: CPU0 (power states: C1[C1])
[   21.467208] ACPI: CPU1 (power states: C1[C1])
[   21.528038] lp: driver loaded but no devices found
[   21.533107] Generic RTC Driver v1.07
[   21.536998] Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
[   21.546495] Linux agpgart interface v0.101 (c) Dave Jones
[   21.552067] [drm] Initialized drm 1.0.0 20040925
[   21.556827] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   21.566052] Hangcheck: Using monotonic_clock().
[   21.571099] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   21.577464] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   21.586537] serio: i8042 AUX port at 0x60,0x64 irq 12
[   21.591808] serio: i8042 KBD port at 0x60,0x64 irq 1
[   21.596931] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   21.605126] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   21.611153] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   21.616609] parport: PnPBIOS parport detected.
[   21.621243] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
[   21.730268] lp0: using parport0 (interrupt-driven).
[   21.735919] lp0: console ready
[   21.739870] io scheduler noop registered
[   21.744603] io scheduler anticipatory registered
[   21.750045] io scheduler deadline registered
[   21.755173] io scheduler cfq registered
[   21.759921] Floppy drive(s): fd0 is 1.44M
[   21.785733] FDC 0 is a post-1991 82077
[   21.792143] loop: loaded (max 8 devices)
[   21.797020] pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
[   21.806095] Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
[   21.813061] Copyright (c) 1999-2005 Intel Corporation.
[   21.819287] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   21.827763] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   21.897972] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   21.905932] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
[   21.913113] e100: Copyright(c) 1999-2005 Intel Corporation
[   21.919870] LXT970: Registered new driver
[   21.925017] LXT971: Registered new driver
[   21.930212] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   21.937725] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   21.946988] ICH7: IDE controller at PCI slot 0000:00:1f.1
[   21.953559] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[   21.962232] ICH7: chipset revision 1
[   21.966993] ICH7: not 100% native mode: will probe irqs later
[   21.973989]     ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
[   21.982547] Probing IDE interface ide0...
[   22.726501] hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
[   23.070441] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   23.076577] Probing IDE interface ide1...
[   23.647231] hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
[   23.655907] Uniform CD-ROM driver Revision: 3.20
[   23.662990] libata version 1.12 loaded.
[   23.668317] ata_piix version 1.04
[   23.672877] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   23.681649] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   23.689316] ata1: SATA max UDMA/133 cmd 0x30C8 ctl 0x30E6 bmdma 0x30A0 irq 19
[   23.697786] ata2: SATA max UDMA/133 cmd 0x30C0 ctl 0x30E2 bmdma 0x30A8 irq 19
[   23.874643] ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
[   23.884334] ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
[   23.892430] ata1: dev 0 configured for UDMA/133
[   23.898174] scsi0 : ata_piix
[   24.068677] ATA: abnormal status 0x7F on port 0x30C7
[   24.074888] ata2: disabling port
[   24.079299] scsi1 : ata_piix
[   24.083607]   Vendor: ATA       Model: ST3160023AS       Rev: 3.00
[   24.091412]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   24.104649] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[   24.112703] SCSI device sda: drive cache: write back
[   24.119073] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[   24.127141] SCSI device sda: drive cache: write back
[   24.133401]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   24.168327] Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
[   24.176158] Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
[   24.184999] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
[   24.193826] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   24.201417] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   24.207936] ehci_hcd 0000:00:1d.7: debug port 1
[   24.213869] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   24.222592] ehci_hcd 0000:00:1d.7: irq 20, io mem 0x90304400
[   24.233451] PCI: cache line size of 128 is not supported by device 0000:00:1d.7
[   24.242066] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[   24.251538] hub 1-0:1.0: USB hub found
[   24.256561] hub 1-0:1.0: 8 ports detected
[   24.362764] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   24.372184] USB Universal Host Controller Interface driver v2.3
[   24.379579] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
[   24.388399] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   24.395974] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   24.402614] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   24.411330] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00003080
[   24.418648] hub 2-0:1.0: USB hub found
[   24.423664] hub 2-0:1.0: 2 ports detected
[   24.530840] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[   24.539608] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   24.547147] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   24.553760] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   24.562460] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
[   24.569765] hub 3-0:1.0: USB hub found
[   24.574762] hub 3-0:1.0: 2 ports detected
[   24.682874] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   24.691655] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   24.699193] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   24.705799] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   24.714495] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
[   24.721851] hub 4-0:1.0: USB hub found
[   24.726865] hub 4-0:1.0: 2 ports detected
[   24.834903] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
[   24.843683] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   24.851230] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   24.857852] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[   24.866562] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003020
[   24.873898] hub 5-0:1.0: USB hub found
[   24.878921] hub 5-0:1.0: 2 ports detected
[   24.975490] usb 2-1: new low speed USB device using uhci_hcd and address 2
[   25.398883] usb 2-2: new full speed USB device using uhci_hcd and address 3
[   25.551497] hub 2-2:1.0: USB hub found
[   25.558392] hub 2-2:1.0: 3 ports detected
[   25.690478] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-1
[   25.700603] usbcore: registered new driver usbhid
[   25.706663] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   25.714569] mice: PS/2 mouse device common for all mice
[   25.721781] input: PC Speaker
[   25.726119] i2c /dev entries driver
[   25.731384] Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Tue Aug 30 05:31:08 2005 UTC).
[   25.742645] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
[   25.751565] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   25.905293] input: AT Translated Set 2 keyboard on isa0060/serio0
[   25.913393] usb 2-2.1: new full speed USB device using uhci_hcd and address 4
[   26.029624] input: USB HID v1.10 Keyboard [Lite-On Technology USB Productivity Option Keyboard( has the hu] on usb-0000:00:1d.0-2.1
[   26.050588] input: USB HID v1.10 Device [Lite-On Technology USB Productivity Option Keyboard( has the hu] on usb-0000:00:1d.0-2.1
[   26.643743] ALSA device list:
[   26.648103]   #0: HDA Intel at 0x90300000 irq 21
[   26.654213] NET: Registered protocol family 2
[   26.703407] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   26.712624] TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
[   26.726744] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[   26.737474] TCP: Hash tables configured (established 131072 bind 65536)
[   26.745628] TCP reno registered
[   26.750400] TCP bic registered
[   26.754848] NET: Registered protocol family 1
[   26.760610] NET: Registered protocol family 17
[   26.767735] acpi-cpufreq: CPU0 - ACPI performance management activated.
[   26.776997] acpi-cpufreq: CPU1 - ACPI performance management activated.
[   26.802849] ACPI wakeup devices:
[   26.807553] SLPB  P32 UAR1 PEX0 PEX1 PEX2 PEX3 PEX4 PEX5 UHC1 UHC2 UHC3 UHC4 EHCI AC9M AZAL
[   26.817679] ACPI: (supports S0 S1 S3 S4 S5)
[   26.823399] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   26.832769] EXT3-fs: INFO: recovery required on readonly filesystem.
[   26.840591] EXT3-fs: write access will be enabled during recovery.
[   26.865380] kjournald starting.  Commit interval 5 seconds
[   26.872320] EXT3-fs: recovery complete.
[   26.877907] EXT3-fs: mounted filesystem with ordered data mode.
[   26.885386] VFS: Mounted root (ext3 filesystem) readonly.
[   26.892338] Freeing unused kernel memory: 188k freed
[   28.422869] EXT3 (no)acl options not supported
[   28.503534] EXT3 (no)acl options not supported
[   28.509563] EXT3 FS on sda6, internal journal
[   29.582676] EXT3 (no)acl options not supported
[   29.589080] kjournald starting.  Commit interval 5 seconds
[   29.595954] EXT3 FS on sda1, internal journal
[   29.601457] EXT3-fs: mounted filesystem with writeback data mode.
[   29.617623] EXT3 (no)acl options not supported
[   29.624057] kjournald starting.  Commit interval 5 seconds
[   29.630894] EXT3 FS on sda3, internal journal
[   29.636359] EXT3-fs: mounted filesystem with writeback data mode.
[   29.653560] EXT3 (no)acl options not supported
[   29.660449] kjournald starting.  Commit interval 5 seconds
[   29.667297] EXT3 FS on sda5, internal journal
[   29.672755] EXT3-fs: mounted filesystem with writeback data mode.
[   41.523533] BUG: soft lockup detected on CPU#0!
[   41.529217] CPU 0:
[   41.532301] Modules linked in:
[   41.536429] Pid: 1181, comm: klogd Not tainted 2.6.14-rc1 #1
[   41.543233] RIP: 0010:[<ffffffff801f7bf7>] <ffffffff801f7bf7>{find_next_zero_bit+63}
[   41.551034] RSP: 0018:ffff81007dee96b8  EFLAGS: 00000206
[   41.558677] RAX: 000000000000000c RBX: 00000000000001c8 RCX: 0000000000000011
[   41.567021] RDX: 0000000000000040 RSI: 000000000000203b RDI: ffff81007dcc5400
[   41.575357] RBP: 0000000000000000 R08: 0000000000000011 R09: ffff81007dcc5000
[   41.583700] R10: 00000000000001c8 R11: 0000000000000000 R12: 0000000000000000
[   41.592044] R13: 0000000000000000 R14: ffffffff80149fb1 R15: ffff81007dee9628
[   41.600391] FS:  00002aaaaadedb00(0000) GS:ffffffff8051a800(0000) knlGS:0000000000000000
[   41.609726] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   41.616647] CR2: 000055555566b000 CR3: 000000007df3f000 CR4: 00000000000006e0
[   41.624976]
[   41.624977] Call Trace:<ffffffff801f7c1d>{find_next_zero_bit+101} <ffffffff801b0f36>{bitmap_search_next_usable_block+123}
[   41.638583]        <ffffffff801b1299>{ext3_try_to_allocate+365} <ffffffff801b1d0f>{ext3_try_to_allocate_with_rsv+771}
[   41.650511]        <ffffffff8017cbe5>{__bread+11} <ffffffff801b1fd2>{ext3_new_block+528}
[   41.659895]        <ffffffff801b3ef3>{ext3_alloc_block+9} <ffffffff801b64a9>{ext3_get_block_handle+833}
[   41.670624]        <ffffffff80149fb1>{wake_up_bit+30} <ffffffff80179cf7>{init_buffer_head+28}
[   41.680477]        <ffffffff8016204c>{kmem_cache_alloc+142} <ffffffff801b692f>{ext3_get_block+0}
[   41.690602]        <ffffffff80179ef3>{alloc_buffer_head+54} <ffffffff801b69b3>{ext3_get_block+132}
[   41.700913]        <ffffffff801b692f>{ext3_get_block+0} <ffffffff8017bb34>{__block_prepare_write+321}
[   41.711491]        <ffffffff801c3181>{journal_start+141} <ffffffff801b692f>{ext3_get_block+0}
[   41.721363]        <ffffffff8017bdbb>{block_prepare_write+32} <ffffffff801b598c>{ext3_prepare_write+150}
[   41.732222]        <ffffffff803a862f>{_write_unlock_irq+9} <ffffffff8015a6c2>{generic_file_buffered_write+709}
[   41.743629]        <ffffffff80191057>{update_atime+68} <ffffffff8013aabe>{current_fs_time+63}
[   41.753553]        <ffffffff8015b0f2>{do_generic_mapping_read+1353} <ffffffff8015be43>{__generic_file_aio_write_nolock+792}
[   41.766164]        <ffffffff8015e89d>{__alloc_pages+254} <ffffffff8015c165>{generic_file_aio_write+125}
[   41.777012]        <ffffffff801b2d5c>{ext3_file_write+28} <ffffffff80178adb>{do_sync_write+223}
[   41.787166]        <ffffffff8016a2e9>{__handle_mm_fault+395} <ffffffff801f63ab>{__up_read+139}
[   41.797232]        <ffffffff803a903c>{do_page_fault+1064} <ffffffff80149e94>{autoremove_wake_function+0}
[   41.808198]        <ffffffff803a85ae>{_spin_unlock+9} <ffffffff80178fa7>{vfs_write+178}
[   41.817651]        <ffffffff801794b3>{sys_write+69} <ffffffff8010e8f2>{system_call+126}
[   41.827112]



.config:


#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.14-rc1
# Thu Sep 15 13:45:32 2005
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
# CONFIG_MK8 is not set
CONFIG_MPSC=y
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
# CONFIG_K8_NUMA is not set
# CONFIG_NUMA_EMU is not set
# CONFIG_NUMA is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=8
CONFIG_HOTPLUG_CPU=y
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""
CONFIG_SUSPEND_SMP=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_ACPI_CPUFREQ=y

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_PD6729=m
CONFIG_I82092=m
# CONFIG_TCIC is not set
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=y
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
CONFIG_PHYLIB=y
CONFIG_PHYCONTROL=y

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_LXT_PHY=y
# CONFIG_CICADA_PHY is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
CONFIG_GEN_RTC=y
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SOFT_CURSOR=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
CONFIG_SND_HDA_INTEL=y

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_PWC is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_PHIDGETKIT=m
CONFIG_USB_PHIDGETSERVO=m
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
# CONFIG_FS_POSIX_ACL is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
CONFIG_PROFILING=y
# CONFIG_OPROFILE is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_FS=y
CONFIG_FRAME_POINTER=y
# CONFIG_INIT_DEBUG is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_KPROBES is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
