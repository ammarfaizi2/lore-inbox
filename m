Return-Path: <linux-kernel-owner+w=401wt.eu-S1030272AbXAECCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbXAECCD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbXAECCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:02:01 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:42608 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030259AbXAECB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:01:59 -0500
Date: Thu, 04 Jan 2007 19:59:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: 2.6.20-rc3-git4 oops on suspend: __drain_pages
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <459DB116.9070805@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saw this oops on 2.6.20-rc3-git4 when attempting to suspend. This only 
happened in 1 of 3 attempts.

Jan  4 19:36:43 newcastle kernel: Linux version 2.6.20-rc3-git4 (rob@newcastle.ss.shawcable.net) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Thu Jan 4 19:24:09 CST 2007
Jan  4 19:36:43 newcastle kernel: Command line: ro root=/dev/VolGroup00/LogVol00
Jan  4 19:36:43 newcastle kernel: BIOS-provided physical RAM map:
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jan  4 19:36:43 newcastle kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  4 19:36:43 newcastle kernel: end_pfn_map = 1048576
Jan  4 19:36:43 newcastle kernel: DMI 2.3 present.
Jan  4 19:36:43 newcastle kernel: SRAT: PXM 0 -> APIC 0 -> Node 0
Jan  4 19:36:43 newcastle kernel: SRAT: PXM 0 -> APIC 1 -> Node 0
Jan  4 19:36:43 newcastle kernel: SRAT: Node 0 PXM 0 0-a0000
Jan  4 19:36:44 newcastle kernel: SRAT: Node 0 PXM 0 0-80000000
Jan  4 19:36:44 newcastle kernel: Bootmem setup node 0 0000000000000000-000000007fff0000
Jan  4 19:36:44 newcastle kernel: Zone PFN ranges:
Jan  4 19:36:44 newcastle kernel:   DMA             0 ->     4096
Jan  4 19:36:44 newcastle kernel:   DMA32        4096 ->  1048576
Jan  4 19:36:44 newcastle kernel:   Normal    1048576 ->  1048576
Jan  4 19:36:44 newcastle kernel: early_node_map[2] active PFN ranges
Jan  4 19:36:44 newcastle kernel:     0:        0 ->      159
Jan  4 19:36:44 newcastle kernel:     0:      256 ->   524272
Jan  4 19:36:44 newcastle kernel: Nvidia board detected. Ignoring ACPI timer override.
Jan  4 19:36:44 newcastle kernel: If you got timer trouble try acpi_use_timer_override
Jan  4 19:36:44 newcastle kernel: ACPI: PM-Timer IO Port: 0x4008
Jan  4 19:36:44 newcastle kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  4 19:36:44 newcastle kernel: Processor #0 (Bootup-CPU)
Jan  4 19:36:44 newcastle kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  4 19:36:44 newcastle kernel: Processor #1
Jan  4 19:36:44 newcastle kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Jan  4 19:36:44 newcastle kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Jan  4 19:36:44 newcastle kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jan  4 19:36:44 newcastle kernel: IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
Jan  4 19:36:45 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan  4 19:36:45 newcastle kernel: ACPI: BIOS IRQ0 pin2 override ignored.
Jan  4 19:36:45 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jan  4 19:36:45 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
Jan  4 19:36:45 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Jan  4 19:36:45 newcastle kernel: Setting APIC routing to physical flat
Jan  4 19:36:45 newcastle kernel: Using ACPI (MADT) for SMP configuration information
Jan  4 19:36:45 newcastle kernel: Nosave address range: 000000000009f000 - 00000000000a0000
Jan  4 19:36:45 newcastle kernel: Nosave address range: 00000000000a0000 - 00000000000f0000
Jan  4 19:36:45 newcastle kernel: Nosave address range: 00000000000f0000 - 0000000000100000
Jan  4 19:36:46 newcastle kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Jan  4 19:36:46 newcastle kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
Jan  4 19:36:46 newcastle kernel: PERCPU: Allocating 67264 bytes of per cpu data
Jan  4 19:36:46 newcastle kernel: Built 1 zonelists.  Total pages: 514297
Jan  4 19:36:46 newcastle kernel: Kernel command line: ro root=/dev/VolGroup00/LogVol00
Jan  4 19:36:46 newcastle kernel: Initializing CPU#0
Jan  4 19:36:46 newcastle kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Jan  4 19:36:46 newcastle kernel: Console: colour VGA+ 80x25
Jan  4 19:36:46 newcastle kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  4 19:36:46 newcastle kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jan  4 19:36:46 newcastle kernel: Checking aperture...
Jan  4 19:36:46 newcastle kernel: CPU 0: aperture @ 630000000 size 32 MB
Jan  4 19:36:46 newcastle kernel: Aperture too small (32 MB)
Jan  4 19:36:46 newcastle kernel: No AGP bridge found
Jan  4 19:36:46 newcastle kernel: Memory: 2051468k/2097088k available (2230k kernel code, 45232k reserved, 1115k data, 336k init)
Jan  4 19:36:46 newcastle kernel: Calibrating delay using timer specific routine.. 4425.39 BogoMIPS (lpj=8850797)
Jan  4 19:36:47 newcastle kernel: Security Framework v1.0.0 initialized
Jan  4 19:36:47 newcastle kernel: SELinux:  Initializing.
Jan  4 19:36:47 newcastle kernel: SELinux:  Starting in permissive mode
Jan  4 19:36:47 newcastle kernel: selinux_register_security:  Registering secondary module capability
Jan  4 19:36:47 newcastle kernel: Capability LSM initialized as secondary
Jan  4 19:36:47 newcastle kernel: Mount-cache hash table entries: 256
Jan  4 19:36:47 newcastle kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  4 19:36:47 newcastle kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jan  4 19:36:47 newcastle kernel: CPU 0/0 -> Node 0
Jan  4 19:36:47 newcastle kernel: CPU: Physical Processor ID: 0
Jan  4 19:36:47 newcastle kernel: CPU: Processor Core ID: 0
Jan  4 19:36:47 newcastle kernel: SMP alternatives: switching to UP code
Jan  4 19:36:47 newcastle kernel: ACPI: Core revision 20060707
Jan  4 19:36:48 newcastle kernel: Using local APIC timer interrupts.
Jan  4 19:36:48 newcastle kernel: result 12564625
Jan  4 19:36:48 newcastle kernel: Detected 12.564 MHz APIC timer.
Jan  4 19:36:48 newcastle kernel: SMP alternatives: switching to SMP code
Jan  4 19:36:48 newcastle kernel: Booting processor 1/2 APIC 0x1
Jan  4 19:36:48 newcastle kernel: Initializing CPU#1
Jan  4 19:36:48 newcastle kernel: Calibrating delay using timer specific routine.. 4423.02 BogoMIPS (lpj=8846059)
Jan  4 19:36:48 newcastle kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  4 19:36:49 newcastle kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jan  4 19:36:49 newcastle kernel: CPU 1/1 -> Node 0
Jan  4 19:36:49 newcastle kernel: CPU: Physical Processor ID: 0
Jan  4 19:36:49 newcastle kernel: CPU: Processor Core ID: 1
Jan  4 19:36:49 newcastle kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
Jan  4 19:36:49 newcastle kernel: CPU 1: Syncing TSC to CPU 0.
Jan  4 19:36:49 newcastle kernel: CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 546 cycles)
Jan  4 19:36:49 newcastle kernel: Brought up 2 CPUs
Jan  4 19:36:49 newcastle kernel: testing NMI watchdog ... OK.
Jan  4 19:36:49 newcastle kernel: Disabling vsyscall due to use of PM timer
Jan  4 19:36:49 newcastle kernel: time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
Jan  4 19:36:49 newcastle kernel: time.c: Detected 2211.370 MHz processor.
Jan  4 19:36:50 newcastle kernel: migration_cost=227
Jan  4 19:36:50 newcastle kernel: NET: Registered protocol family 16
Jan  4 19:36:50 newcastle kernel: ACPI: bus type pci registered
Jan  4 19:36:50 newcastle kernel: PCI: Using MMCONFIG at e0000000
Jan  4 19:36:50 newcastle kernel: PCI: No mmconfig possible on device 00:18
Jan  4 19:36:50 newcastle kernel: ACPI: Interpreter enabled
Jan  4 19:36:50 newcastle kernel: ACPI: Using IOAPIC for interrupt routing
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan  4 19:36:51 newcastle kernel: PCI: Transparent bridge - 0000:00:09.0
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 *7 9 10 11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 *12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Jan  4 19:36:51 newcastle kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan  4 19:36:51 newcastle kernel: pnp: PnP ACPI init
Jan  4 19:36:51 newcastle kernel: pnp: PnP ACPI: found 10 devices
Jan  4 19:36:51 newcastle kernel: usbcore: registered new interface driver usbfs
Jan  4 19:36:51 newcastle kernel: usbcore: registered new interface driver hub
Jan  4 19:36:51 newcastle kernel: usbcore: registered new device driver usb
Jan  4 19:36:51 newcastle kernel: PCI: Using ACPI for IRQ routing
Jan  4 19:36:51 newcastle kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jan  4 19:36:51 newcastle kernel: pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
Jan  4 19:36:51 newcastle kernel: pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
Jan  4 19:36:51 newcastle kernel: pnp: 00:01: ioport range 0x4400-0x447f has been reserved
Jan  4 19:36:51 newcastle kernel: pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
Jan  4 19:36:51 newcastle kernel: pnp: 00:01: ioport range 0x4800-0x487f has been reserved
Jan  4 19:36:51 newcastle kernel: pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
Jan  4 19:36:51 newcastle kernel: PCI: Bridge: 0000:00:09.0
Jan  4 19:36:51 newcastle kernel:   IO window: a000-afff
Jan  4 19:36:51 newcastle kernel:   MEM window: d0000000-d1ffffff
Jan  4 19:36:51 newcastle kernel:   PREFETCH window: disabled.
Jan  4 19:36:51 newcastle kernel: PCI: Bridge: 0000:00:0b.0
Jan  4 19:36:51 newcastle kernel:   IO window: disabled.
Jan  4 19:36:51 newcastle kernel:   MEM window: disabled.
Jan  4 19:36:51 newcastle kernel:   PREFETCH window: disabled.
Jan  4 19:36:51 newcastle kernel: PCI: Bridge: 0000:00:0c.0
Jan  4 19:36:51 newcastle kernel:   IO window: disabled.
Jan  4 19:36:51 newcastle kernel:   MEM window: disabled.
Jan  4 19:36:51 newcastle kernel:   PREFETCH window: disabled.
Jan  4 19:36:51 newcastle kernel: PCI: Bridge: 0000:00:0d.0
Jan  4 19:36:51 newcastle kernel:   IO window: disabled.
Jan  4 19:36:51 newcastle kernel:   MEM window: c0000000-c7ffffff
Jan  4 19:36:51 newcastle kernel:   PREFETCH window: b8000000-bfffffff
Jan  4 19:36:51 newcastle kernel: PCI: Bridge: 0000:00:0e.0
Jan  4 19:36:51 newcastle kernel:   IO window: disabled.
Jan  4 19:36:51 newcastle kernel:   MEM window: c8000000-cfffffff
Jan  4 19:36:51 newcastle kernel:   PREFETCH window: b0000000-b7ffffff
Jan  4 19:36:51 newcastle kernel: NET: Registered protocol family 2
Jan  4 19:36:51 newcastle kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Jan  4 19:36:51 newcastle kernel: TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
Jan  4 19:36:51 newcastle kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
Jan  4 19:36:51 newcastle kernel: TCP: Hash tables configured (established 131072 bind 65536)
Jan  4 19:36:51 newcastle kernel: TCP reno registered
Jan  4 19:36:51 newcastle kernel: checking if image is initramfs... it is
Jan  4 19:36:51 newcastle kernel: Freeing initrd memory: 2299k freed
Jan  4 19:36:51 newcastle kernel: audit: initializing netlink socket (disabled)
Jan  4 19:36:51 newcastle kernel: audit(1167939343.624:1): initialized
Jan  4 19:36:51 newcastle kernel: Total HugeTLB memory allocated, 0
Jan  4 19:36:51 newcastle kernel: VFS: Disk quotas dquot_6.5.1
Jan  4 19:36:51 newcastle kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan  4 19:36:51 newcastle kernel: SELinux:  Registering netfilter hooks
Jan  4 19:36:51 newcastle kernel: io scheduler noop registered
Jan  4 19:36:51 newcastle kernel: io scheduler anticipatory registered
Jan  4 19:36:51 newcastle kernel: io scheduler deadline registered
Jan  4 19:36:51 newcastle kernel: io scheduler cfq registered (default)
Jan  4 19:36:51 newcastle kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0b.0
Jan  4 19:36:51 newcastle kernel: PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0b.0.
Jan  4 19:36:51 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0b.0
Jan  4 19:36:51 newcastle kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0c.0
Jan  4 19:36:51 newcastle kernel: PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0c.0.
Jan  4 19:36:51 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0c.0
Jan  4 19:36:51 newcastle kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0d.0
Jan  4 19:36:51 newcastle kernel: PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0d.0.
Jan  4 19:36:51 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0d.0
Jan  4 19:36:51 newcastle kernel: PCI: Found disabled HT MSI Mapping on 0000:00:0e.0
Jan  4 19:36:51 newcastle kernel: PCI: MSI quirk detected. MSI disabled on chipset 0000:00:0e.0.
Jan  4 19:36:51 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0e.0
Jan  4 19:36:51 newcastle kernel: assign_interrupt_mode Found MSI capability
Jan  4 19:36:51 newcastle kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jan  4 19:36:51 newcastle kernel: ACPI: Fan [FAN] (on)
Jan  4 19:36:51 newcastle kernel: ACPI: Thermal Zone [THRM] (40 C)
Jan  4 19:36:51 newcastle kernel: Real Time Clock Driver v1.12ac
Jan  4 19:36:51 newcastle kernel: Non-volatile memory driver v1.2
Jan  4 19:36:51 newcastle kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jan  4 19:36:51 newcastle kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Jan  4 19:36:51 newcastle kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Jan  4 19:36:51 newcastle kernel: usbcore: registered new interface driver libusual
Jan  4 19:36:51 newcastle kernel: PNP: No PS/2 controller found. Probing ports directly.
Jan  4 19:36:51 newcastle kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  4 19:36:51 newcastle kernel: mice: PS/2 mouse device common for all mice
Jan  4 19:36:51 newcastle kernel: TCP cubic registered
Jan  4 19:36:51 newcastle kernel: Initializing XFRM netlink socket
Jan  4 19:36:51 newcastle kernel: NET: Registered protocol family 1
Jan  4 19:36:51 newcastle kernel: NET: Registered protocol family 17
Jan  4 19:36:51 newcastle kernel: powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors (version 2.00.00)
Jan  4 19:36:51 newcastle kernel: powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
Jan  4 19:36:51 newcastle kernel: powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
Jan  4 19:36:51 newcastle kernel: powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
Jan  4 19:36:51 newcastle kernel: powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
Jan  4 19:36:51 newcastle kernel: ACPI: (supports S0 S1 S3 S4 S5)
Jan  4 19:36:51 newcastle kernel: Freeing unused kernel memory: 336k freed
Jan  4 19:36:51 newcastle kernel: Write protecting the kernel read-only data: 674k
Jan  4 19:36:51 newcastle kernel: USB Universal Host Controller Interface driver v3.0
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
Jan  4 19:36:51 newcastle kernel: ohci_hcd 0000:00:02.0: OHCI Host Controller
Jan  4 19:36:51 newcastle kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Jan  4 19:36:51 newcastle kernel: ohci_hcd 0000:00:02.0: irq 23, io mem 0xd2003000
Jan  4 19:36:51 newcastle kernel: usb usb1: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: hub 1-0:1.0: USB hub found
Jan  4 19:36:51 newcastle kernel: hub 1-0:1.0: 10 ports detected
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 22 (level, low) -> IRQ 22
Jan  4 19:36:51 newcastle kernel: ehci_hcd 0000:00:02.1: EHCI Host Controller
Jan  4 19:36:51 newcastle kernel: ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
Jan  4 19:36:51 newcastle kernel: ehci_hcd 0000:00:02.1: debug port 1
Jan  4 19:36:51 newcastle kernel: ehci_hcd 0000:00:02.1: irq 22, io mem 0xfeb00000
Jan  4 19:36:51 newcastle kernel: ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jan  4 19:36:51 newcastle kernel: usb usb2: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: hub 2-0:1.0: USB hub found
Jan  4 19:36:51 newcastle kernel: hub 2-0:1.0: 10 ports detected
Jan  4 19:36:51 newcastle kernel: SCSI subsystem initialized
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 21 (level, low) -> IRQ 21
Jan  4 19:36:51 newcastle kernel: sata_nv 0000:00:07.0: Using ADMA mode
Jan  4 19:36:51 newcastle kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC2000001C480 ctl 0xFFFFC2000001C4A0 bmdma 0xD800 irq 21
Jan  4 19:36:51 newcastle kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC2000001C580 ctl 0xFFFFC2000001C5A0 bmdma 0xD808 irq 21
Jan  4 19:36:51 newcastle kernel: scsi0 : sata_nv
Jan  4 19:36:51 newcastle kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 19:36:51 newcastle kernel: ata1.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
Jan  4 19:36:51 newcastle kernel: ata1.00: ata1: dev 0 multi count 1
Jan  4 19:36:51 newcastle kernel: ata1.00: configured for UDMA/133
Jan  4 19:36:51 newcastle kernel: scsi1 : sata_nv
Jan  4 19:36:51 newcastle kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 19:36:51 newcastle kernel: usb 2-2: new high speed USB device using ehci_hcd and address 3
Jan  4 19:36:51 newcastle kernel: usb 2-2: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: hub 2-2:1.0: USB hub found
Jan  4 19:36:51 newcastle kernel: hub 2-2:1.0: 4 ports detected
Jan  4 19:36:51 newcastle kernel: ata2.00: ATAPI, max UDMA/66
Jan  4 19:36:51 newcastle kernel: ata2.00: applying bridge limits
Jan  4 19:36:51 newcastle kernel: ata2.00: configured for UDMA/66
Jan  4 19:36:51 newcastle kernel: scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  4 19:36:51 newcastle kernel: ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Jan  4 19:36:51 newcastle kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Jan  4 19:36:51 newcastle kernel: sda: Write Protect is off
Jan  4 19:36:51 newcastle kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 19:36:51 newcastle kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Jan  4 19:36:51 newcastle kernel: sda: Write Protect is off
Jan  4 19:36:51 newcastle kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 19:36:51 newcastle kernel:  sda: sda1
Jan  4 19:36:51 newcastle kernel: sd 0:0:0:0: Attached scsi disk sda
Jan  4 19:36:51 newcastle kernel: scsi 1:0:0:0: CD-ROM            LITE-ON  DVDRW SHM-165H6S HS0E PQ: 0 ANSI: 5
Jan  4 19:36:51 newcastle kernel: ata2: bounce limit 0xFFFFFFFF, segment boundary 0xFFFF, hw segs 127
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 20
Jan  4 19:36:51 newcastle kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 20 (level, low) -> IRQ 20
Jan  4 19:36:51 newcastle kernel: sata_nv 0000:00:08.0: Using ADMA mode
Jan  4 19:36:51 newcastle kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC2000001E480 ctl 0xFFFFC2000001E4A0 bmdma 0xC400 irq 20
Jan  4 19:36:51 newcastle kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC2000001E580 ctl 0xFFFFC2000001E5A0 bmdma 0xC408 irq 20
Jan  4 19:36:51 newcastle kernel: scsi2 : sata_nv
Jan  4 19:36:51 newcastle kernel: ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jan  4 19:36:51 newcastle kernel: usb 2-9: new high speed USB device using ehci_hcd and address 6
Jan  4 19:36:51 newcastle kernel: ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
Jan  4 19:36:51 newcastle kernel: ata3.00: ata3: dev 0 multi count 1
Jan  4 19:36:51 newcastle kernel: ata3.00: configured for UDMA/133
Jan  4 19:36:51 newcastle kernel: scsi3 : sata_nv
Jan  4 19:36:51 newcastle kernel: usb 2-9: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: libusual: modprobe for usb-storage succeeded, but module is not present
Jan  4 19:36:51 newcastle kernel: usb 1-1: new low speed USB device using ohci_hcd and address 2
Jan  4 19:36:51 newcastle kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  4 19:36:51 newcastle kernel: ata4.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
Jan  4 19:36:51 newcastle kernel: ata4.00: ata4: dev 0 multi count 1
Jan  4 19:36:51 newcastle kernel: ata4.00: configured for UDMA/133
Jan  4 19:36:51 newcastle kernel: scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Jan  4 19:36:51 newcastle kernel: ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Jan  4 19:36:51 newcastle kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Jan  4 19:36:51 newcastle kernel: sdb: Write Protect is off
Jan  4 19:36:51 newcastle kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 19:36:51 newcastle kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Jan  4 19:36:51 newcastle kernel: sdb: Write Protect is off
Jan  4 19:36:51 newcastle kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 19:36:51 newcastle kernel:  sdb: sdb1
Jan  4 19:36:51 newcastle kernel: sd 2:0:0:0: Attached scsi disk sdb
Jan  4 19:36:51 newcastle kernel: scsi 3:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Jan  4 19:36:51 newcastle kernel: ata4: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Jan  4 19:36:51 newcastle kernel: SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
Jan  4 19:36:51 newcastle kernel: sdc: Write Protect is off
Jan  4 19:36:51 newcastle kernel: SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 19:36:51 newcastle kernel: SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
Jan  4 19:36:51 newcastle kernel: sdc: Write Protect is off
Jan  4 19:36:51 newcastle kernel: SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  4 19:36:51 newcastle kernel:  sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >
Jan  4 19:36:51 newcastle kernel: sd 3:0:0:0: Attached scsi disk sdc
Jan  4 19:36:51 newcastle kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Jan  4 19:36:51 newcastle kernel: usb 1-1: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: usb 1-3: new full speed USB device using ohci_hcd and address 3
Jan  4 19:36:51 newcastle kernel: Attempting manual resume
Jan  4 19:36:51 newcastle kernel: Disabling non-boot CPUs ...
Jan  4 19:36:51 newcastle kernel: usb 1-3: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: hub 1-3:1.0: USB hub found
Jan  4 19:36:51 newcastle kernel: hub 1-3:1.0: 4 ports detected
Jan  4 19:36:51 newcastle kernel: CPU 1 is now offline
Jan  4 19:36:51 newcastle kernel: SMP alternatives: switching to UP code
Jan  4 19:36:51 newcastle kernel: CPU1 is down
Jan  4 19:36:51 newcastle kernel: Stopping tasks ... <7>PM: Adding info for No Bus:usbdev1.3_ep81
Jan  4 19:36:51 newcastle kernel: usb 1-4: new low speed USB device using ohci_hcd and address 4
Jan  4 19:36:51 newcastle kernel: usb 1-4: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: usb 2-2.1: new full speed USB device using ehci_hcd and address 7
Jan  4 19:36:51 newcastle kernel: usb 2-2.1: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: usb 1-3.1: new low speed USB device using ohci_hcd and address 5
Jan  4 19:36:51 newcastle kernel: usb 1-3.1: configuration #1 chosen from 1 choice
Jan  4 19:36:51 newcastle kernel: done.
Jan  4 19:36:51 newcastle kernel: Shrinking memory...  -done (0 pages freed)
Jan  4 19:36:51 newcastle kernel: Freed 0 kbytes in 0.03 seconds (0.00 MB/s)
Jan  4 19:36:51 newcastle kernel: Loading image data pages (124422 pages) ...     <3>swsusp: Resume mismatch: version
Jan  4 19:36:51 newcastle kernel: Read 497688 kbytes in 0.01 seconds (49768.80 MB/s)
Jan  4 19:36:51 newcastle kernel: Restarting tasks ... done.
Jan  4 19:36:52 newcastle kernel: Enabling non-boot CPUs ...
Jan  4 19:36:52 newcastle kernel: SMP alternatives: switching to SMP code
Jan  4 19:36:52 newcastle kernel: Booting processor 1/2 APIC 0x1
Jan  4 19:36:52 newcastle kernel: Initializing CPU#1
Jan  4 19:36:52 newcastle kernel: Calibrating delay using timer specific routine.. 2010.47 BogoMIPS (lpj=4020957)
Jan  4 19:36:52 newcastle kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan  4 19:36:52 newcastle kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jan  4 19:36:52 newcastle kernel: CPU 1/1 -> Node 0
Jan  4 19:36:52 newcastle kernel: CPU: Physical Processor ID: 0
Jan  4 19:36:52 newcastle kernel: CPU: Processor Core ID: 1
Jan  4 19:36:52 newcastle kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
Jan  4 19:36:52 newcastle kernel: CPU 1: Syncing TSC to CPU 0.
Jan  4 19:36:52 newcastle kernel: CPU 1: synchronized TSC with CPU 0 (last diff -79 cycles, maxerr 506 cycles)
Jan  4 19:36:52 newcastle kernel: powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
Jan  4 19:36:52 newcastle kernel: powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
Jan  4 19:36:52 newcastle kernel: powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
Jan  4 19:36:52 newcastle kernel: powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
Jan  4 19:36:52 newcastle kernel: CPU1 is up
Jan  4 19:36:52 newcastle kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Jan  4 19:36:52 newcastle kernel: EXT3-fs: write access will be enabled during recovery.
Jan  4 19:36:52 newcastle kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 19:36:52 newcastle kernel: EXT3-fs: recovery complete.
Jan  4 19:36:52 newcastle kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 19:36:52 newcastle kernel: audit(1167939381.534:2): enforcing=1 old_enforcing=0 auid=4294967295
Jan  4 19:36:52 newcastle kernel: security:  3 users, 6 roles, 1583 types, 172 bools, 1 sens, 1024 cats
Jan  4 19:36:52 newcastle kernel: security:  59 classes, 49428 rules
Jan  4 19:36:52 newcastle kernel: security:  class dccp_socket not defined in policy
Jan  4 19:36:52 newcastle kernel: security:  permission dccp_recv in class node not defined in policy
Jan  4 19:36:52 newcastle kernel: security:  permission dccp_send in class node not defined in policy
Jan  4 19:36:52 newcastle kernel: security:  permission dccp_recv in class netif not defined in policy
Jan  4 19:36:52 newcastle kernel: security:  permission dccp_send in class netif not defined in policy
Jan  4 19:36:52 newcastle kernel: SELinux:  Completing initialization.
Jan  4 19:36:52 newcastle kernel: SELinux:  Setting up existing superblocks.
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev dm-0, type ext3), uses xattr
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev devpts, type devpts), uses transition SIDs
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev proc, type proc), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: audit(1167939381.766:3): policy loaded auid=4294967295
Jan  4 19:36:52 newcastle kernel: usbcore: registered new interface driver hiddev
Jan  4 19:36:52 newcastle kernel: input: Microsoft Microsoft Wireless Optical Mouse® 1.0A as /class/input/input0
Jan  4 19:36:52 newcastle kernel: input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Mouse® 1.0A] on usb-0000:00:02.0-1
Jan  4 19:36:52 newcastle kernel: hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS BR  800 FW:9.o2 .D USB FW:o2 ] on usb-0000:00:02.0-4
Jan  4 19:36:52 newcastle kernel: input: Microsoft Internet Keyboard Pro as /class/input/input1
Jan  4 19:36:52 newcastle kernel: input: USB HID v1.10 Keyboard [Microsoft Internet Keyboard Pro] on usb-0000:00:02.0-3.1
Jan  4 19:36:52 newcastle kernel: input: Microsoft Internet Keyboard Pro as /class/input/input2
Jan  4 19:36:52 newcastle kernel: input: USB HID v1.10 Device [Microsoft Internet Keyboard Pro] on usb-0000:00:02.0-3.1
Jan  4 19:36:52 newcastle kernel: usbcore: registered new interface driver usbhid
Jan  4 19:36:52 newcastle kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jan  4 19:36:52 newcastle kernel: forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
Jan  4 19:36:52 newcastle kernel: forcedeth: using HIGHDMA
Jan  4 19:36:52 newcastle kernel: Linux video capture interface: v2.00
Jan  4 19:36:52 newcastle kernel: input: PC Speaker as /class/input/input3
Jan  4 19:36:52 newcastle kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jan  4 19:36:52 newcastle kernel: scsi 1:0:0:0: Attached scsi generic sg1 type 5
Jan  4 19:36:52 newcastle kernel: sd 2:0:0:0: Attached scsi generic sg2 type 0
Jan  4 19:36:52 newcastle kernel: sd 3:0:0:0: Attached scsi generic sg3 type 0
Jan  4 19:36:52 newcastle kernel: eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
Jan  4 19:36:52 newcastle kernel: ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
Jan  4 19:36:52 newcastle kernel: ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
Jan  4 19:36:52 newcastle kernel: scsi4 : pata_amd
Jan  4 19:36:52 newcastle kernel: cx2388x v4l2 driver version 0.0.6 loaded
Jan  4 19:36:52 newcastle kernel: sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Jan  4 19:36:52 newcastle kernel: Uniform CD-ROM driver Revision: 3.20
Jan  4 19:36:52 newcastle kernel: ata5.00: ATAPI, max UDMA/33
Jan  4 19:36:52 newcastle kernel: ata5.00: configured for UDMA/33
Jan  4 19:36:52 newcastle kernel: scsi5 : pata_amd
Jan  4 19:36:52 newcastle kernel: ATA: abnormal status 0x7F on port 0x177
Jan  4 19:36:52 newcastle kernel: scsi 4:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S09 PQ: 0 ANSI: 5
Jan  4 19:36:52 newcastle kernel: sr1: scsi3-mmc drive: 40x/52x writer cd/rw xa/form2 cdda tray
Jan  4 19:36:52 newcastle kernel: sr 4:0:0:0: Attached scsi generic sg4 type 5
Jan  4 19:36:52 newcastle kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
Jan  4 19:36:52 newcastle kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
Jan  4 19:36:52 newcastle kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d1004000-d10047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
Jan  4 19:36:52 newcastle kernel: CORE cx88[0]: subsystem: 0000:0000, board: MSI TV-@nywhere [card=13,insmod option]
Jan  4 19:36:52 newcastle kernel: TV tuner 33 at 0x1fe, Radio tuner -1 at 0x1fe
Jan  4 19:36:52 newcastle kernel: Floppy drive(s): fd0 is 1.44M
Jan  4 19:36:52 newcastle kernel: FDC 0 is a post-1991 82077
Jan  4 19:36:52 newcastle kernel: tveeprom 2-0050: Huh, no eeprom present (err=-121)?
Jan  4 19:36:52 newcastle kernel: cx88[0]/0: found at 0000:05:08.0, rev: 3, irq: 18, latency: 32, mmio: 0xd0000000
Jan  4 19:36:52 newcastle kernel: tuner 2-0060: Chip ID is not zero. It is not a TEA5767
Jan  4 19:36:52 newcastle kernel: tuner 2-0060: chip found @ 0xc0 (cx88[0])
Jan  4 19:36:52 newcastle kernel: tuner 2-0060: microtune: companycode=4d54 part=04 rev=04
Jan  4 19:36:52 newcastle kernel: tuner 2-0060: microtune MT2032 found, OK
Jan  4 19:36:52 newcastle kernel: tuner 2-0060: microtune: companycode=4d54 part=04 rev=04
Jan  4 19:36:52 newcastle kernel: tuner 2-0060: microtune MT2032 found, OK
Jan  4 19:36:52 newcastle kernel: cx88[0]/0: registered device video0 [v4l2]
Jan  4 19:36:52 newcastle kernel: cx88[0]/0: registered device vbi0
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
Jan  4 19:36:52 newcastle kernel: ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
Jan  4 19:36:52 newcastle kernel: ice1724: No matching model found for ID 0x581404a6
Jan  4 19:36:52 newcastle kernel: ice1724: Invalid EEPROM version 1
Jan  4 19:36:52 newcastle kernel: lp: driver loaded but no devices found
Jan  4 19:36:52 newcastle kernel: input: Power Button (FF) as /class/input/input4
Jan  4 19:36:52 newcastle kernel: ACPI: Power Button (FF) [PWRF]
Jan  4 19:36:52 newcastle kernel: input: Power Button (CM) as /class/input/input5
Jan  4 19:36:52 newcastle kernel: ACPI: Power Button (CM) [PWRB]
Jan  4 19:36:52 newcastle kernel: No dock devices found.
Jan  4 19:36:52 newcastle kernel: ibm_acpi: ec object not found
Jan  4 19:36:52 newcastle kernel: md: Autodetecting RAID arrays.
Jan  4 19:36:52 newcastle kernel: md: autorun ...
Jan  4 19:36:52 newcastle kernel: md: ... autorun DONE.
Jan  4 19:36:52 newcastle kernel: EXT3 FS on dm-0, internal journal
Jan  4 19:36:52 newcastle kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 19:36:52 newcastle kernel: EXT3 FS on sdc3, internal journal
Jan  4 19:36:52 newcastle kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev sdc3, type ext3), uses xattr
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Jan  4 19:36:52 newcastle kernel: NTFS driver 2.1.27 [Flags: R/W MODULE].
Jan  4 19:36:52 newcastle kernel: NTFS volume version 3.1.
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev sdb1, type ntfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: NTFS volume version 3.1.
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev sdc1, type ntfs), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev sdc2, type vfat), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
Jan  4 19:36:52 newcastle kernel: SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
Jan  4 19:36:53 newcastle kernel: NET: Registered protocol family 10
Jan  4 19:36:53 newcastle kernel: lo: Disabled Privacy Extensions
Jan  4 19:38:16 newcastle kernel: Bluetooth: Core ver 2.11
Jan  4 19:38:16 newcastle kernel: NET: Registered protocol family 31
Jan  4 19:38:16 newcastle kernel: Bluetooth: HCI device and connection manager initialized
Jan  4 19:38:16 newcastle kernel: Bluetooth: HCI socket layer initialized
Jan  4 19:38:16 newcastle kernel: Bluetooth: L2CAP ver 2.8
Jan  4 19:38:16 newcastle kernel: Bluetooth: L2CAP socket layer initialized
Jan  4 19:38:16 newcastle kernel: Bluetooth: RFCOMM socket layer initialized
Jan  4 19:38:16 newcastle kernel: Bluetooth: RFCOMM TTY layer initialized
Jan  4 19:38:16 newcastle kernel: Bluetooth: RFCOMM ver 1.8
Jan  4 19:38:17 newcastle kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Jan  4 19:38:31 newcastle kernel: NET: Unregistered protocol family 31
Jan  4 19:38:33 newcastle kernel: Disabling non-boot CPUs ...
Jan  4 19:38:33 newcastle kernel: Breaking affinity for irq 14
Jan  4 19:38:33 newcastle kernel: Breaking affinity for irq 20
Jan  4 19:38:33 newcastle kernel: Breaking affinity for irq 23
Jan  4 19:38:33 newcastle kernel: CPU 1 is now offline
Jan  4 19:38:33 newcastle kernel: SMP alternatives: switching to UP code
Jan  4 19:38:33 newcastle kernel: Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802b43e6>] __drain_pages+0x20/0x60
Jan  4 19:38:33 newcastle kernel: PGD 62001067 PUD 61d14067 PMD 0 
Jan  4 19:38:33 newcastle kernel: Oops: 0000 [1] SMP 
Jan  4 19:38:33 newcastle kernel: CPU 0 
Jan  4 19:38:33 newcastle kernel: Modules linked in: ipv6 autofs4 cpufreq_ondemand vfat fat nls_utf8 ntfs video sbs i2c_ec dock battery asus_acpi backlight ac parport_pc lp parport snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec ac97_bus snd_ak4114 snd_seq_dummy tuner snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss floppy snd_mixer_oss snd_pcm sr_mod cdrom snd_timer snd_page_alloc snd_ak4xxx_adda cx8800 cx88xx ir_common snd_mpu401_uart i2c_algo_bit video_buf snd_rawmidi tveeprom sg snd_seq_device pcspkr i2c_nforce2 compat_ioctl32 snd btcx_risc i2c_core pata_amd videodev forcedeth k8temp hwmon v4l2_common soundcore v4l1_compat usbhid hid dm_snapshot dm_zero dm_mirror dm_mod ata_generic sata_nv libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Jan  4 19:38:33 newcastle kernel: Pid: 3525, comm: pm-hibernate Not tainted 2.6.20-rc3-git4 #1
Jan  4 19:38:33 newcastle kernel: RIP: 0010:[<ffffffff802b43e6>]  [<ffffffff802b43e6>] __drain_pages+0x20/0x60
Jan  4 19:38:33 newcastle kernel: RSP: 0018:ffff810062aa7d08  EFLAGS: 00010046
Jan  4 19:38:33 newcastle kernel: RAX: 0000000000000001 RBX: 0000000000000046 RCX: ffff81000000d300
Jan  4 19:38:33 newcastle kernel: RDX: ffff81000000c000 RSI: ffff81007f7facf0 RDI: ffff81000000cac0
Jan  4 19:38:33 newcastle kernel: RBP: 0000000000000000 R08: ffffffff00000000 R09: 0000000000000000
Jan  4 19:38:33 newcastle kernel: R10: ffff81000101a820 R11: ffffffff802ecc89 R12: ffff81000000d580
Jan  4 19:38:33 newcastle kernel: R13: 0000000000000000 R14: 0000000000000001 R15: ffff81006130e5c0
Jan  4 19:38:33 newcastle kernel: FS:  00002b8c47751e20(0000) GS:ffffffff80545000(0000) knlGS:00000000080e3830
Jan  4 19:38:33 newcastle kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jan  4 19:38:33 newcastle kernel: CR2: 0000000000000000 CR3: 000000005bced000 CR4: 00000000000006e0
Jan  4 19:38:33 newcastle kernel: Process pm-hibernate (pid: 3525, threadinfo ffff810062aa6000, task ffff810061db3080)
Jan  4 19:38:33 newcastle kernel: Stack:  0000000000000001 0000000000000001 0000000000000007 ffff81005e6fd040
Jan  4 19:38:33 newcastle kernel:  0000000000000004 ffffffff802b4438 ffffffff804ef490 ffffffff8026141c
Jan  4 19:38:33 newcastle kernel:  0000000000000001 0000000000000001 0000000000000000 ffffffff8029c7a0
Jan  4 19:38:33 newcastle kernel: Call Trace:
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802b4438>] page_alloc_cpu_notify+0x12/0x28
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8026141c>] notifier_call_chain+0x20/0x32
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8029c7a0>] _cpu_down+0x192/0x25b
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8032f12c>] __next_cpu+0x3/0x28
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8029ca67>] disable_nonboot_cpus+0x87/0x116
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a14aa>] prepare_processes+0x10/0xcc
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a1920>] pm_suspend_disk+0xb/0x170
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a04f8>] enter_state+0x52/0x1da
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a06de>] state_store+0x5e/0x79
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802f3ba5>] sysfs_write_file+0xd3/0x107
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80214b45>] vfs_write+0xce/0x177
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80215521>] sys_write+0x45/0x6e
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8025811e>] system_call+0x7e/0x83
Jan  4 19:38:33 newcastle kernel: 
Jan  4 19:38:33 newcastle kernel: 
Jan  4 19:38:33 newcastle kernel: Code: 8b 75 00 48 8d 55 10 31 c9 4c 89 e7 e8 d3 fd ff ff c7 45 00 
Jan  4 19:38:33 newcastle kernel: RIP  [<ffffffff802b43e6>] __drain_pages+0x20/0x60
Jan  4 19:38:33 newcastle kernel:  RSP <ffff810062aa7d08>
Jan  4 19:38:33 newcastle kernel: CR2: 0000000000000000
Jan  4 19:38:33 newcastle kernel:  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
Jan  4 19:38:33 newcastle kernel: in_atomic():0, irqs_disabled():1
Jan  4 19:38:33 newcastle kernel: 
Jan  4 19:38:33 newcastle kernel: Call Trace:
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80299472>] down_read+0x15/0x23
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80291566>] blocking_notifier_call_chain+0x13/0x36
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802136d2>] do_exit+0x22/0x871
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80386124>] do_unblank_screen+0x2c/0x139
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8026137c>] do_page_fault+0x72d/0x7ad
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80282ec2>] task_rq_lock+0x3d/0x6f
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80282deb>] __activate_task+0x2d/0x3f
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8025f4cd>] error_exit+0x0/0x84
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802ecc89>] proc_destroy_inode+0x0/0x10
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802b43e6>] __drain_pages+0x20/0x60
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802b4438>] page_alloc_cpu_notify+0x12/0x28
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8026141c>] notifier_call_chain+0x20/0x32
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8029c7a0>] _cpu_down+0x192/0x25b
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8032f12c>] __next_cpu+0x3/0x28
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8029ca67>] disable_nonboot_cpus+0x87/0x116
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a14aa>] prepare_processes+0x10/0xcc
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a1920>] pm_suspend_disk+0xb/0x170
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a04f8>] enter_state+0x52/0x1da
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802a06de>] state_store+0x5e/0x79
Jan  4 19:38:33 newcastle kernel:  [<ffffffff802f3ba5>] sysfs_write_file+0xd3/0x107
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80214b45>] vfs_write+0xce/0x177
Jan  4 19:38:33 newcastle kernel:  [<ffffffff80215521>] sys_write+0x45/0x6e
Jan  4 19:38:33 newcastle kernel:  [<ffffffff8025811e>] system_call+0x7e/0x83
Jan  4 19:38:33 newcastle kernel: 


-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


