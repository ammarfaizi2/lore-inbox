Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVJ1U1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVJ1U1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVJ1U1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:27:47 -0400
Received: from maggie.cs.pitt.edu ([130.49.220.148]:60838 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1750713AbVJ1U1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:27:46 -0400
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Bug: timer going backward on a dual core
Date: Fri, 28 Oct 2005 22:27:35 +0200
User-Agent: KMail/1.8
References: <200510282109.42054.cloud.of.andor@gmail.com> <1130527831.27168.413.camel@cog.beaverton.ibm.com>
In-Reply-To: <1130527831.27168.413.camel@cog.beaverton.ibm.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282227.36433.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We have a dual-core AMD64 with the new kernel 2.6.14 and the
> > timer goes backward...
> >
> >
> > CONFIGURATION:
> >
> > Kernel: 2.6.14
> > Distribution: Gentoo Linux 2005.0
> > Processor: Athlon 64 x2 4200+ (dual core)
> > Motherboard: Abit KN8
> > Memory: 1GB PC3200
> >
> >
> > PROBLEM:
> >
> > gettimeofday goes backward and returns values that are not monotonic,
> > giving values that are smaller than values returned before.
> >
> > The system has been tested with timer as PIT, PIT/TSC and PM and the
> > problem occurs with all the configurations.
> >
> > Here is the config file that we used for the PM configuration.
> >
> > Any suggestion ?
>
> Booting w/ idle=poll tends to work around this issue. You might check
> with your motherboard vendor for an updated BIOS that supports HPET or
> the ACPI PM timer.

We already updated the BIOS with the latest version.

Also the booting command idle=poll doesn't work.

Here is the output of dmesg, if it may be useful.

Thanks,

              Claudio

Bootdata ok (command line is root=/dev/sda3 idle=poll)
Linux version 2.6.14 (root@yellow-athlon) (gcc version 3.4.4 (Gentoo 3.4.4-r1, 
ssp-3.4.4-1.0, pie-8.7.8)) #2 SMP Fri Oct 28 15:22:35 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7800
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003fee3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003fee30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 
0x000000003fee9a40
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003fee9c80
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003fee9980
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000003fee0000
Using 20 for the hash shift. Max adder is 3fee0000 
Using node hash shift of 20
Bootmem setup node 0 0000000000000000-000000003fee0000
On node 0 totalpages: 261759
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 257760 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3ff00000:a0100000)
Built 1 zonelists
Kernel command line: root=/dev/sda3 idle=poll
using polling idle threads.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2210.222 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1026156k/1047424k available (2785k kernel code, 20880k reserved, 1231k 
data, 216k init)
Calibrating delay using timer specific routine.. 4424.98 BogoMIPS 
(lpj=8849962)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control 
Methods:...................................................................................................................................................................................................................................................................................................
Table [DSDT](id 0006) - 1027 Objects with 90 Devices 291 Methods 40 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 6 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root ffffffff8054e080
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
Using local APIC timer interrupts.
Detected 12.558 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4420.68 BogoMIPS 
(lpj=8841360)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -77 cycles, maxerr 548 cycles)
Brought up 2 CPUs
softlockup thread 1 started up.
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 
0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 1 Runtime 
GPEs in this block
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs on int 
0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime 
GPEs in this block
Completing Region/Field/Buffer/Package 
initialization:...................................................................................................
Initialized 40/40 Regions 9/9 Fields 34/34 Buffers 16/25 Packages (1042 nodes)
Executing all Device _STA and_INI 
methods:...............................................................................................
95 Devices found containing: 95 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 10 11)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 *4 5 7 10 11)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 *7 10 11)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs *3 4 5 7 10 11)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 10 11) *0, disabled.
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
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
pnp: 00:00: ioport range 0x1400-0x147f has been reserved
pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:00: ioport range 0x1800-0x187f has been reserved
pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: 7000-7fff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:0b.0
  IO window: 9000-9fff
  MEM window: fd900000-fd9fffff
  PREFETCH window: fd800000-fd8fffff
PCI: Bridge: 0000:00:0c.0
  IO window: a000-afff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fda00000-fdafffff
PCI: Bridge: 0000:00:0d.0
  IO window: 6000-6fff
  MEM window: fdf00000-fdffffff
  PREFETCH window: fdc00000-fdcfffff
PCI: Bridge: 0000:00:0e.0
  IO window: 8000-8fff
  MEM window: fa000000-fcffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
PCI: Setting latency timer of device 0000:00:0b.0 to 64
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
PCI: Setting latency timer of device 0000:00:0c.0 to 64
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
PCI: Setting latency timer of device 0000:00:0d.0 to 64
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: Address64 -------- Resource unparsed
pciehp: Address64 -------- Resource unparsed
pciehp: Address64 -------- Resource unparsed
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (off)
Using specific hotkey driver
acpi_thermal-0386 [08] thermal_get_trip_point: Invalid passive threshold
ACPI: Thermal Zone [THRM] (27 C)
Real Time Clock Driver v1.12
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 
seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.41.
acpi_bus-0200 [02] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> 
IRQ 217
PCI: Setting latency timer of device 0000:00:0a.0 to 64
eth0: forcedeth.c: subsystem: 0147b:1c05 bound to 0000:00:0a.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
acpi_bus-0200 [02] bus_set_power         : Device is not power manageable
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hdb: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hdb: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.12 loaded.
sata_nv version 0.8
acpi_bus-0200 [02] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> 
IRQ 225
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 225
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 225
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3e01 87:4023 
88:407f
ata1: dev 0 ATA, max UDMA/133, 156250000 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
  Vendor: ATA       Model: WDC WD800JD-75LS  Rev: 09.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
acpi_bus-0200 [02] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> 
IRQ 233
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xE800 irq 233
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xE808 irq 233
ata3: no device found (phy stat 00000000)
scsi2 : sata_nv
ata4: no device found (phy stat 00000000)
scsi3 : sata_nv
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usbmon: debugfs is not available
acpi_bus-0200 [02] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> 
IRQ 50
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 50, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
acpi_bus-0200 [02] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> 
IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 217, io mem 0xfe02b000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xe, vid 0x8
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Adding 2008116k swap on /dev/sda2.  Priority:-1 extents:1 across:2008116k
EXT3 FS on sda3, internal journal
eth0: no IPv6 routers present
