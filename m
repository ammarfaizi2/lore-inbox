Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWISDpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWISDpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 23:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWISDpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 23:45:54 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16580 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751937AbWISDpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 23:45:53 -0400
Date: Mon, 18 Sep 2006 21:43:23 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: 2.6.18-rc6-mm2 ACPI and MCFG errors
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com
Message-id: <450F675B.1060807@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_OVz4bUeEY+EjE+jY5A70IA)"
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_OVz4bUeEY+EjE+jY5A70IA)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

I'm seeing some ACPI errors from 2.6.18-rc6-mm2 that I didn't see in 
2.6.17-based kernels. This is on an Asus A8N-SLI Deluxe with the latest 
BIOS. Not sure what exactly these are indicating, but they don't seem good:

ACPI Error (evregion-0317): No handler for Region [BRCR] 
(ffff81007df8e960) [PCI_Config] [20060707]
ACPI Error (exfldio-0290): Region PCI_Config(2) has no handler [20060707]
ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.MBIO._CRS] (Node ffff81007df96d50), AE_NOT_EXIST
ACPI Error (uteval-0212): Method execution failed [\_SB_.PCI0.MBIO._CRS] 
(Node ffff81007df96d50), AE_NOT_EXIST

As well I am also seeing this:

PCI: BIOS Bug: MCFG area at e0000000 not reserved in ACPI

In 2.6.17 it would seem to use MCFG without complaint or problem. It 
seems the check was changed to checking whether it is reserved in the 
e820 tables to checking whether it is reserved in ACPI. On this system 
it appears it is reserved in e820 tables but not in ACPI. Maybe it could 
check if it was reserved in either one?

Full dmesg is attached.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


--Boundary_(ID_OVz4bUeEY+EjE+jY5A70IA)
Content-type: text/plain; name=dmesg-2.6.18-rc6-mm2.txt
Content-transfer-encoding: 8BIT
Content-disposition: inline; filename=dmesg-2.6.18-rc6-mm2.txt

Linux version 2.6.18-rc6-mm2 (rob@newcastle.ss.shawcable.net) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Mon Sep 18 20:49:52 CST 2006
Command line: ro root=/dev/VolGroup00/LogVol00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 524272) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7c80
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fff9900
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fff9b40
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9c40
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: Node 0 PXM 0 0-a0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
SRAT: Node 0 PXM 0 0-80000000
Entering add_active_range(0, 0, 159) 1 entries of 3200 used
Entering add_active_range(0, 256, 524272) 1 entries of 3200 used
NUMA: Using 63 for the hash shift.
Bootmem setup node 0 0000000000000000-000000007fff0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524272
On node 0 totalpages: 524175
  DMA zone: 64 pages used for memmap
  DMA zone: 1768 pages reserved
  DMA zone: 2167 pages, LIFO batch:0
  DMA32 zone: 8127 pages used for memmap
  DMA32 zone: 512049 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 67520 bytes of per cpu data
Built 1 zonelists.  Total pages: 514216
Kernel command line: ro root=/dev/VolGroup00/LogVol00
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ 620000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 2051544k/2097088k available (2264k kernel code, 45156k reserved, 1604k data, 336k init)
Calibrating delay using timer specific routine.. 4425.42 BogoMIPS (lpj=8850859)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12564633
Detected 12.564 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4422.95 BogoMIPS (lpj=8845910)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 537 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2211.371 MHz processor.
migration_cost=201
checking if image is initramfs... it is
Freeing initrd memory: 1897k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
PM: Adding info for No Bus:virtual
PM: Adding info for No Bus:vtconsole
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
ACPI Error (evregion-0317): No handler for Region [BRCR] (ffff81007df8e960) [PCI_Config] [20060707]
ACPI Error (exfldio-0290): Region PCI_Config(2) has no handler [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.MBIO._CRS] (Node ffff81007df96d50), AE_NOT_EXIST
ACPI Error (uteval-0212): Method execution failed [\_SB_.PCI0.MBIO._CRS] (Node ffff81007df96d50), AE_NOT_EXIST
PCI: BIOS Bug: MCFG area at e0000000 not reserved in ACPI
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:01.1
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:06.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:08.0
PM: Adding info for pci:0000:00:09.0
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0c.0
PM: Adding info for pci:0000:00:0d.0
PM: Adding info for pci:0000:00:0e.0
PM: Adding info for pci:0000:00:18.0
PM: Adding info for pci:0000:00:18.1
PM: Adding info for pci:0000:00:18.2
PM: Adding info for pci:0000:00:18.3
PM: Adding info for pci:0000:05:07.0
PM: Adding info for pci:0000:05:0b.0
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
pnp: PnP ACPI: found 10 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: a000-afff
  MEM window: d0000000-d00fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: c0000000-c7ffffff
  PREFETCH window: b8000000-bfffffff
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: c8000000-cfffffff
  PREFETCH window: b0000000-b7ffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
PM: Adding info for No Bus:misc
PM: Adding info for No Bus:mcelog
PM: Adding info for No Bus:msr
PM: Adding info for No Bus:msr0
PM: Adding info for No Bus:msr1
PM: Adding info for No Bus:cpuid
PM: Adding info for No Bus:cpu0
PM: Adding info for No Bus:cpu1
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1158613263.596:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Found HT MSI mapping on 0000:00:0b.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Found HT MSI mapping on 0000:00:0c.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Found HT MSI mapping on 0000:00:0d.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PM: Adding info for pci_express:0000:00:0b.0:pcie00
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PM: Adding info for pci_express:0000:00:0c.0:pcie00
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PM: Adding info for pci_express:0000:00:0d.0:pcie00
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
PM: Adding info for pci_express:0000:00:0e.0:pcie00
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
PM: Adding info for No Bus:vc
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
PM: Adding info for No Bus:hpet
PM: Adding info for No Bus:nvram
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 336k freed
Write protecting the kernel read-only data: 443k
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
SCSI subsystem initialized
libata version 2.00 loaded.
sata_nv 0000:00:07.0: version 2.0
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 23
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 23
scsi0 : sata_nv
PM: Adding info for No Bus:host0
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 1
ata1.00: configured for UDMA/133
scsi1 : sata_nv
PM: Adding info for No Bus:host1
ata2: SATA link down (SStatus 0 SControl 300)
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 22
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 22
scsi2 : sata_nv
PM: Adding info for No Bus:host2
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 1
ata3.00: configured for UDMA/133
scsi3 : sata_nv
PM: Adding info for No Bus:host3
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 1
ata4.00: configured for UDMA/133
PM: Adding info for No Bus:target2:0:0
scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
PM: Adding info for scsi:2:0:0:0
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 2:0:0:0: Attached scsi disk sdb
PM: Adding info for No Bus:target3:0:0
scsi 3:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
PM: Adding info for scsi:3:0:0:0
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >
sd 3:0:0:0: Attached scsi disk sdc
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1158613266.752:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats
security:  58 classes, 43474 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1158613266.976:3): policy loaded auid=4294967295
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
input: PC Speaker as /class/input/input0
PM: Adding info for No Bus:i2c-0
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
PM: Adding info for No Bus:i2c-1
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
EDAC MC: Ver: 2.0.1 Sep 18 2006
eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
EDAC MC0: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:18.2
pata_amd 0000:00:06.0: version 0.2.2
PCI: Setting latency timer of device 0000:00:06.0 to 64
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi4 : pata_amd
PM: Adding info for No Bus:host4
ata5.00: ATAPI, max UDMA/66
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
ata5.00: configured for UDMA/66
scsi5 : pata_amd
PM: Adding info for No Bus:host5
ieee1394: Initialized config rom entry `ip1394'
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 3:0:0:0: Attached scsi generic sg2 type 0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ata6.00: ATAPI, max UDMA/33
ata6.00: configured for UDMA/33
PM: Adding info for No Bus:target4:0:0
scsi 4:0:0:0: CD-ROM            LITE-ON  DVDRW SHM-165H6S HS0E PQ: 0 ANSI: 5
PM: Adding info for scsi:4:0:0:0
scsi 4:0:0:0: Attached scsi generic sg3 type 5
PM: Adding info for No Bus:target5:0:0
scsi 5:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S09 PQ: 0 ANSI: 5
PM: Adding info for scsi:5:0:0:0
scsi 5:0:0:0: Attached scsi generic sg4 type 5
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 20, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc6-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.1
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 23, io mem 0xd0103000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc6-mm2 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
ice1724: No matching model found for ID 0x581404a6
ice1724: Invalid EEPROM version 1
PM: Adding info for ac97:0-0:VT1616i
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d0004000-d00047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ohci1394: fw-host0: Running dma failed because Node ID is not valid
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 40x/52x writer cd/rw xa/form2 cdda tray
sr 5:0:0:0: Attached scsi CD-ROM sr1
lp: driver loaded but no devices found
usb 1-8: new high speed USB device using ehci_hcd and address 6
usb 1-8: new device found, idVendor=05e3, idProduct=0605
usb 1-8: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-8: Product: USB2.0 Hub
PM: Adding info for usb:1-8
PM: Adding info for No Bus:usbdev1.6_ep00
usb 1-8: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-8:1.0
hub 1-8:1.0: USB hub found
hub 1-8:1.0: 4 ports detected
PM: Adding info for No Bus:usbdev1.6_ep81
PM: Adding info for No Bus:usbdev1.6
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
bay: Unknown symbol is_dock_device
bay: Unknown symbol register_hotplug_dock_device
bay: Unknown symbol unregister_hotplug_dock_device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
usb 1-9: new high speed USB device using ehci_hcd and address 7
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
usb 1-9: new device found, idVendor=07cc, idProduct=0301
usb 1-9: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-9: Product: Winter Ver1.3   
usb 1-9: Manufacturer:         Ltd
usb 1-9: SerialNumber: 972394281841
PM: Adding info for usb:1-9
PM: Adding info for No Bus:usbdev1.7_ep00
usb 1-9: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-9:1.0
PM: Adding info for No Bus:usbdev1.7_ep81
PM: Adding info for No Bus:usbdev1.7_ep02
PM: Adding info for No Bus:usbdev1.7
PM: Adding info for ieee1394:0012c9fffe37d629
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0012c9fffe37d629]
PM: Adding info for ieee1394:0011d80000007098
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[0011d80000007098]
PM: Adding info for ieee1394:0012c9fffe37d629-0
PM: Adding info for ieee1394:0012c9fffe37d629-1
PM: Adding info for ieee1394:0011d80000007098-0
Initializing USB Mass Storage driver...
ieee1394: raw1394: /dev/raw1394 device initialized
audit(1158634874.814:4): avc:  denied  { getattr } for  pid=1672 comm="pam_console_app" name="raw1394" dev=tmpfs ino=6004 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255 tcontext=system_u:object_r:device_t:s0 tclass=chr_file
usb 2-1: new low speed USB device using ohci_hcd and address 2
usb 2-1: new device found, idVendor=051d, idProduct=0002
usb 2-1: new device strings: Mfr=3, Product=1, SerialNumber=2
usb 2-1: Product: Back-UPS BR  800 FW:9.o2 .D USB FW:o2 
usb 2-1: Manufacturer: American Power Conversion
usb 2-1: SerialNumber: QB0419230426  
PM: Adding info for usb:2-1
PM: Adding info for No Bus:usbdev2.2_ep00
usb 2-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-1:1.0
PM: Adding info for No Bus:hiddev0
hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS BR  800 FW:9.o2 .D USB FW:o2 ] on usb-0000:00:02.0-1
PM: Adding info for No Bus:usbdev2.2_ep81
PM: Adding info for No Bus:usbdev2.2
EXT3 FS on dm-0, internal journal
usb 2-2: new full speed USB device using ohci_hcd and address 3
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sdc3, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
usb 2-2: new device found, idVendor=0451, idProduct=1446
usb 2-2: new device strings: Mfr=0, Product=0, SerialNumber=0
PM: Adding info for usb:2-2
PM: Adding info for No Bus:usbdev2.3_ep00
usb 2-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-2:1.0
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
NTFS driver 2.1.27 [Flags: R/W MODULE].
PM: Adding info for No Bus:usbdev2.3_ep81
PM: Adding info for No Bus:usbdev2.3
NTFS volume version 3.1.
SELinux: initialized (dev sdb1, type ntfs), uses genfs_contexts
NTFS volume version 3.1.
SELinux: initialized (dev sdc1, type ntfs), uses genfs_contexts
SELinux: initialized (dev sdc2, type vfat), uses genfs_contexts
usb 2-4: new low speed USB device using ohci_hcd and address 4
usb 2-4: new device found, idVendor=045e, idProduct=008c
usb 2-4: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-4: Product: Microsoft Wireless Optical Mouse® 1.0A
usb 2-4: Manufacturer: Microsoft
PM: Adding info for usb:2-4
PM: Adding info for No Bus:usbdev2.4_ep00
usb 2-4: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-4:1.0
input: Microsoft Microsoft Wireless Optical Mouse® 1.0A as /class/input/input1
input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Mouse® 1.0A] on usb-0000:00:02.0-4
PM: Adding info for No Bus:usbdev2.4_ep81
PM: Adding info for No Bus:usbdev2.4
audit(1158634876.538:5): avc:  denied  { getattr } for  pid=1824 comm="pam_console_app" name="raw1394" dev=tmpfs ino=6004 scontext=system_u:system_r:pam_console_t:s0 tcontext=system_u:object_r:device_t:s0 tclass=chr_file
usb 2-7: new low speed USB device using ohci_hcd and address 5
usb 2-7: new device found, idVendor=046d, idProduct=c20a
usb 2-7: new device strings: Mfr=4, Product=32, SerialNumber=0
usb 2-7: Product: WingMan RumblePad
usb 2-7: Manufacturer: Logitech Inc.
PM: Adding info for usb:2-7
PM: Adding info for No Bus:usbdev2.5_ep00
usb 2-7: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-7:1.0
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
PM: Adding info for No Bus:i2c-9191
drivers/usb/input/hid-core.c: timeout initializing reports
input: Logitech Inc. WingMan RumblePad as /class/input/input2
input: USB HID v1.10 Joystick [Logitech Inc. WingMan RumblePad] on usb-0000:00:02.0-7
PM: Adding info for No Bus:usbdev2.5_ep81
PM: Adding info for No Bus:usbdev2.5_ep01
PM: Adding info for No Bus:usbdev2.5
usb 1-8.4: new full speed USB device using ehci_hcd and address 8
usb 1-8.4: new device found, idVendor=046d, idProduct=092c
usb 1-8.4: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-8.4: Product: Camera
usb 1-8.4: Manufacturer:         
PM: Adding info for usb:1-8.4
PM: Adding info for No Bus:usbdev1.8_ep00
usb 1-8.4: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-8.4:1.0
PM: Adding info for No Bus:usbdev1.8_ep81
PM: Adding info for No Bus:usbdev1.8
scsi6 : SCSI emulation for USB Mass Storage devices
PM: Adding info for No Bus:host6
usb-storage: device found at 7
usb-storage: waiting for device to settle before scanning
usb 2-2.1: new low speed USB device using ohci_hcd and address 6
it87: Found IT8712F chip at 0x290, revision 7
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
PM: Adding info for i2c:9191-0290
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
usb 2-2.1: new device found, idVendor=045e, idProduct=002b
usb 2-2.1: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 2-2.1: Product: Microsoft Internet Keyboard Pro
PM: Adding info for usb:2-2.1
PM: Adding info for No Bus:usbdev2.6_ep00
usb 2-2.1: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-2.1:1.0
input: Microsoft Internet Keyboard Pro as /class/input/input3
input: USB HID v1.10 Keyboard [Microsoft Internet Keyboard Pro] on usb-0000:00:02.0-2.1
PM: Adding info for No Bus:usbdev2.6_ep81
PM: Adding info for usb:2-2.1:1.1
input: Microsoft Internet Keyboard Pro as /class/input/input4
input: USB HID v1.10 Device [Microsoft Internet Keyboard Pro] on usb-0000:00:02.0-2.1
PM: Adding info for No Bus:usbdev2.6_ep82
PM: Adding info for No Bus:usbdev2.6
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
PM: Adding info for No Bus:target6:0:0
scsi 6:0:0:0: Direct-Access     USB2.0   CardReader CF RW 0.0> PQ: 0 ANSI: 0
PM: Adding info for scsi:6:0:0:0
sd 6:0:0:0: Attached scsi removable disk sdd
sd 6:0:0:0: Attached scsi generic sg5 type 0
scsi 6:0:0:1: Direct-Access     USB2.0   CardReader Combo 0.0> PQ: 0 ANSI: 0
PM: Adding info for scsi:6:0:0:1
sd 6:0:0:1: Attached scsi removable disk sde
sd 6:0:0:1: Attached scsi generic sg6 type 0
PM: Adding info for No Bus:target6:0:1
PM: Removing info for No Bus:target6:0:1
PM: Adding info for No Bus:target6:0:2
PM: Removing info for No Bus:target6:0:2
PM: Adding info for No Bus:target6:0:3
PM: Removing info for No Bus:target6:0:3
PM: Adding info for No Bus:target6:0:4
PM: Removing info for No Bus:target6:0:4
PM: Adding info for No Bus:target6:0:5
PM: Removing info for No Bus:target6:0:5
PM: Adding info for No Bus:target6:0:6
PM: Removing info for No Bus:target6:0:6
PM: Adding info for No Bus:target6:0:7
PM: Removing info for No Bus:target6:0:7
usb-storage: device scan complete
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7

--Boundary_(ID_OVz4bUeEY+EjE+jY5A70IA)--
