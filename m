Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWFQVVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWFQVVj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWFQVVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 17:21:39 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:21945 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1750919AbWFQVVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 17:21:38 -0400
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: cosmetical(?) problem with dmraid on 2.6.15
Date: Sat, 17 Jun 2006 23:21:35 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606172321.35386.christiand59@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all,

I'm using the current ubuntu 2.6.15-23-amd64-k8 kernel on a dmraid (nvidia 
fakeraid RAID0) setup and I'm seeing multiple i/o errors on boot.

[   22.837349] Buffer I/O error on device sda3, logical block 669380224

I think its caused by the kernel not recognizing the fakeraid at that early 
stage and instead trying to access the partition on /dev/sda directly which 
won't work since that partition is larger than a single disk.

[   22.790706]  sda: sda1 sda2 sda3
[   22.799932] sd 2:0:0:0: Attached scsi disk sda
[   22.799960] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   22.799971] SCSI device sdb: drive cache: write back
[   22.800001] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   22.800011] SCSI device sdb: drive cache: write back
[   22.800013]  sdb: unknown partition table
[   22.807700] sd 3:0:0:0: Attached scsi disk sdb
[   22.837349] Buffer I/O error on device sda3, logical block 669380224
[   22.837355] Buffer I/O error on device sda3, logical block 669380225
	....

However the system seems too run fine so far.

-Christian

Full dmesg output:

user@ubuntu:~$ dmesg
[    0.000000] Bootdata ok (command line is 
root=/dev/mapper/VolGroup00-LogVol00 ro quiet splash)
[    0.000000] Linux version 2.6.15-23-amd64-k8 (buildd@yellow) (gcc version 
4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP PREEMPT Tue May 23 13:51:32 UTC 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
[    0.000000]  BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
[    0.000000]  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] ACPI: RSDP (v000 Nvidia                                ) @ 
0x00000000000f7d70
[    0.000000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff3040
[    0.000000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff30c0
[    0.000000] ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 
0x000000007fff9900
[    0.000000] ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 
0x000000007fff9b00
[    0.000000] ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff9c00
[    0.000000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff9840
[    0.000000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 1 -> Node 0
[    0.000000] SRAT: Node 0 PXM 0 0-a0000
[    0.000000] SRAT: Node 0 PXM 0 0-80000000
[    0.000000] Using 63 for the hash shift.
[    0.000000] Bootmem setup node 0 0000000000000000-000000007fff0000
[    0.000000] On node 0 totalpages: 516085
[    0.000000]   DMA zone: 3020 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 513065 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages, LIFO batch:0
[    0.000000]   HighMem zone: 0 pages, LIFO batch:0
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:11 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 
80000000:60000000)
[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ 4e60000000 size 32 MB
[    0.000000] Aperture from northbridge cpu 0 too small (32 MB)
[    0.000000] No AGP bridge found
[    0.000000] SMP: Allowing 3 CPUs, 1 hotplug CPUs
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=/dev/mapper/VolGroup00-LogVol00 ro 
quiet splash
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 2651.354 MHz processor.
[   19.222482] Console: colour VGA+ 80x25
[   19.223373] Dentry cache hash table entries: 262144 (order: 9, 2097152 
bytes)
[   19.224697] Inode-cache hash table entries: 131072 (order: 8, 1048576 
bytes)
[   19.239304] Memory: 2053808k/2097088k available (2140k kernel code, 42884k 
reserved, 750k data, 180k init)
[   19.298391] Calibrating delay using timer specific routine.. 5305.99 
BogoMIPS (lpj=2652996)
[   19.298430] Security Framework v1.0.0 initialized
[   19.298434] SELinux:  Disabled at boot.
[   19.298450] Mount-cache hash table entries: 256
[   19.298524] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   19.298527] CPU: L2 Cache: 512K (64 bytes/line)
[   19.298529] CPU 0(2) -> Node 0 -> Core 0
[   19.298534] mtrr: v2.0 (20020519)
[   19.298539] SMP alternatives: switching to UP code
[   19.298729] checking if image is initramfs... it is
[   19.713000] Freeing initrd memory: 7154k freed
[   19.718561] ACPI: Looking for DSDT ... not found!
[   19.732546] Using local APIC timer interrupts.
[   19.770244] Detected 16.570 MHz APIC timer.
[   19.770330] SMP alternatives: switching to SMP code
[   19.770444] Booting processor 1/2 APIC 0x1
[   19.779413] Initializing CPU#1
[   19.839719] Calibrating delay using timer specific routine.. 5301.85 
BogoMIPS (lpj=2650929)
[   19.839724] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   19.839725] CPU: L2 Cache: 512K (64 bytes/line)
[   19.839727] CPU 1(2) -> Node 0 -> Core 1
[   19.839788] AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 01
[   19.839793] CPU 1: Syncing TSC to CPU 0.
[   19.841137] CPU 1: synchronized TSC with CPU 0 (last diff -75 cycles, 
maxerr 529 cycles)
[   19.841142] Brought up 2 CPUs
[   19.841171] Disabling vsyscall due to use of PM timer
[   19.841173] time.c: Using PM based timekeeping.
[   19.841174] testing NMI watchdog ... OK.
[   19.851420] NET: Registered protocol family 16
[   19.851440] ACPI: bus type pci registered
[   19.851665] PCI: Using configuration type 1
[   19.854407] PCI: Using MMCONFIG at e0000000
[   19.854849] ACPI: Subsystem revision 20051216
[   19.861621] ACPI: Interpreter enabled
[   19.861623] ACPI: Using IOAPIC for interrupt routing
[   19.862053] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   19.862055] PCI: Probing PCI hardware (bus 00)
[   19.865671] PCI: Transparent bridge - 0000:00:09.0
[   19.865832] Boot video device is 0000:01:00.0
[   19.865881] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   19.947202] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   19.948988] ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   19.949322] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 7 9 10 11 12 14 
15)
[   19.949651] ACPI: PCI Interrupt Link [LNK3] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   19.949983] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   19.950319] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   19.950647] ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 7 9 10 11 12 14 
15)
[   19.950984] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   19.951280] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 *12 14 
15)
[   19.951546] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   19.951811] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   19.952084] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 
15)
[   19.952356] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   19.952626] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   19.952904] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 
15)
[   19.953190] ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 
15)
[   19.953466] ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) 
*0, disabled.
[   19.953776] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[   19.954086] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[   19.954396] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   19.954702] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[   19.954939] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   19.955262] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, 
disabled.
[   19.955584] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, 
disabled.
[   19.955911] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, 
disabled.
[   19.956236] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, 
disabled.
[   19.956554] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, 
disabled.
[   19.956876] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, 
disabled.
[   19.957202] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, 
disabled.
[   19.957521] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, 
disabled.
[   19.957848] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, 
disabled.
[   19.958186] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, 
disabled.
[   19.958512] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, 
disabled.
[   19.961591] Linux Plug and Play Support v0.97 (c) Adam Belay
[   19.961599] pnp: PnP ACPI init
[   19.967433] pnp: PnP ACPI: found 15 devices
[   19.967445] PCI: Using ACPI for IRQ routing
[   19.967448] PCI: If a device doesn't work, try "pci=routeirq".  If it 
helps, post a report
[   19.967524] PCI-DMA: Disabling IOMMU.
[   19.967950] pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
[   19.967953] pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
[   19.967955] pnp: 00:00: ioport range 0x4400-0x447f has been reserved
[   19.967957] pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
[   19.967960] pnp: 00:00: ioport range 0x4800-0x487f has been reserved
[   19.967962] pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
[   19.968103] PCI: Bridge: 0000:00:09.0
[   19.968105]   IO window: a000-afff
[   19.968108]   MEM window: d3000000-d4ffffff
[   19.968110]   PREFETCH window: 88000000-880fffff
[   19.968112] PCI: Bridge: 0000:00:0b.0
[   19.968113]   IO window: disabled.
[   19.968114]   MEM window: disabled.
[   19.968116]   PREFETCH window: disabled.
[   19.968117] PCI: Bridge: 0000:00:0c.0
[   19.968118]   IO window: disabled.
[   19.968120]   MEM window: disabled.
[   19.968121]   PREFETCH window: disabled.
[   19.968123] PCI: Bridge: 0000:00:0d.0
[   19.968126]   IO window: disabled.
[   19.968128]   MEM window: disabled.
[   19.968129]   PREFETCH window: disabled.
[   19.968131] PCI: Bridge: 0000:00:0e.0
[   19.968133]   IO window: 9000-9fff
[   19.968135]   MEM window: d0000000-d2ffffff
[   19.968137]   PREFETCH window: c0000000-cfffffff
[   19.968142] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   19.968147] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   19.968150] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   19.968154] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   19.968158] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   19.968367] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak 
Exp $
[   19.968601] audit: initializing netlink socket (disabled)
[   19.968609] audit(1150577259.959:1): initialized
[   19.968726] VFS: Disk quotas dquot_6.5.1
[   19.968739] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   19.968777] Initializing Cryptographic API
[   19.968779] io scheduler noop registered
[   19.968785] io scheduler anticipatory registered
[   19.968791] io scheduler deadline registered
[   19.968806] io scheduler cfq registered
[   19.969163] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   19.969166] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   19.969178] assign_interrupt_mode Found MSI capability
[   19.969203] Allocate Port Service[pcie00]
[   19.969229] Allocate Port Service[pcie03]
[   19.969254] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   19.969256] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   19.969266] assign_interrupt_mode Found MSI capability
[   19.969278] Allocate Port Service[pcie00]
[   19.969299] Allocate Port Service[pcie03]
[   19.969321] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   19.969323] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   19.969333] assign_interrupt_mode Found MSI capability
[   19.969345] Allocate Port Service[pcie00]
[   19.969368] Allocate Port Service[pcie03]
[   19.969389] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   19.969391] pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check 
vendor BIOS
[   19.969401] assign_interrupt_mode Found MSI capability
[   19.969412] Allocate Port Service[pcie00]
[   19.969432] Allocate Port Service[pcie03]
[   19.980313] Real Time Clock Driver v1.12
[   19.980343] Linux agpgart interface v0.101 (c) Dave Jones
[   19.980420] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   19.980422] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   19.982352] serio: i8042 AUX port at 0x60,0x64 irq 12
[   19.982566] serio: i8042 KBD port at 0x60,0x64 irq 1
[   19.982570] Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ 
sharing enabled
[   19.982670] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   19.983986] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   19.984338] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 
blocksize
[   19.984374] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   19.984377] ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
[   19.984490] mice: PS/2 mouse device common for all mice
[   19.984916] NET: Registered protocol family 2
[   19.998010] IP route cache hash table entries: 65536 (order: 7, 524288 
bytes)
[   19.998323] TCP established hash table entries: 262144 (order: 10, 4194304 
bytes)
[   20.000415] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   20.000919] TCP: Hash tables configured (established 262144 bind 65536)
[   20.000921] TCP reno registered
[   20.000990] TCP bic registered
[   20.000995] NET: Registered protocol family 1
[   20.001000] NET: Registered protocol family 8
[   20.001002] NET: Registered protocol family 20
[   20.001078] ACPI wakeup devices:
[   20.001080] HUB0 XVR0 XVR1 XVR2 XVR3 USB0 USB2 MMAC MMCI UAR1
[   20.001084] ACPI: (supports S0 S1 S3 S4 S5)
[   20.001144] Freeing unused kernel memory: 180k freed
[   20.030541] vga16fb: initializing
[   20.030545] vga16fb: mapped to 0xffff8100000a0000
[   20.158161] Console: switching to colour frame buffer device 80x25
[   20.158165] fb0: VGA16 VGA frame buffer device
[   20.304976] input: AT Translated Set 2 keyboard as /class/input/input0
[   21.175689] Capability LSM initialized
[   21.217750] ACPI: Fan [FAN] (on)
[   21.220891] ACPI: Thermal Zone [THRM] (40 C)
[   21.597608] SCSI subsystem initialized
[   21.598758] ACPI: bus type scsi registered
[   21.598760] libata version 1.20 loaded.
[   21.599497] sata_nv 0000:00:07.0: version 0.8
[   21.599929] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
[   21.599933] GSI 16 sharing vector 0xD9 and IRQ 16
[   21.599937] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 
(level, low) -> IRQ 217
[   21.600072] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   21.600147] ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 
217
[   21.600164] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 
217
[   21.800980] ata1: no device found (phy stat 00000000)
[   21.800982] scsi0 : sata_nv
[   22.001854] ata2: no device found (phy stat 00000000)
[   22.001856] scsi1 : sata_nv
[   22.002276] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[   22.002280] GSI 17 sharing vector 0xE1 and IRQ 17
[   22.002283] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 
(level, low) -> IRQ 225
[   22.002394] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   22.002445] ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 
225
[   22.002460] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 
225
[   22.373711] ata3: dev 0 cfg 00:0040 49:2f00 82:746b 83:7f01 84:4023 85:7469 
86:3e01 87:4023 88:40ff 93:0000
[   22.373715] ata3: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
[   22.377219] sata_get_dev_handle: SATA dev addr=0x80000, 
handle=0xffff810037fe12c0
[   22.383347] nv_sata: Primary device added
[   22.383348] nv_sata: Primary device removed
[   22.383349] nv_sata: Secondary device added
[   22.383350] nv_sata: Secondary device removed
[   22.383353] ata3: dev 0 configured for UDMA/133
[   22.386824] sata_get_dev_handle: SATA dev addr=0x80000, 
handle=0xffff810037fe12c0
[   22.392930] scsi2 : sata_nv
[   22.747477] ata4: dev 0 cfg 00:0040 49:2f00 82:746b 83:7f01 84:4023 85:7469 
86:bc01 87:4023 88:40ff 93:0000
[   22.747480] ata4: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
[   22.750960] sata_get_dev_handle: SATA dev addr=0x80000, 
handle=0xffff810037fe12c0
[   22.772684] nv_sata: Primary device added
[   22.772685] nv_sata: Primary device removed
[   22.772686] nv_sata: Secondary device added
[   22.772688] nv_sata: Secondary device removed
[   22.772689] ata4: dev 0 configured for UDMA/133
[   22.776174] sata_get_dev_handle: SATA dev addr=0x80000, 
handle=0xffff810037fe12c0
[   22.782287] scsi3 : sata_nv
[   22.782362]   Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
[   22.782369]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   22.782422]   Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
[   22.782427]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   22.783121] NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
[   22.783136] NFORCE-CK804: chipset revision 242
[   22.783138] NFORCE-CK804: not 100% native mode: will probe irqs later
[   22.783144] NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
[   22.783151]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, 
hdb:DMA
[   22.783158]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, 
hdd:DMA
[   22.783165] Probing IDE interface ide0...
[   22.787828] Driver 'sd' needs updating - please use bus_type methods
[   22.788442] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   22.788455] SCSI device sda: drive cache: write back
[   22.790249] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   22.790702] SCSI device sda: drive cache: write back
[   22.790706]  sda: sda1 sda2 sda3
[   22.799932] sd 2:0:0:0: Attached scsi disk sda
[   22.799960] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   22.799971] SCSI device sdb: drive cache: write back
[   22.800001] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[   22.800011] SCSI device sdb: drive cache: write back
[   22.800013]  sdb: unknown partition table
[   22.807700] sd 3:0:0:0: Attached scsi disk sdb
[   22.837349] Buffer I/O error on device sda3, logical block 669380224
[   22.837355] Buffer I/O error on device sda3, logical block 669380225
[   22.837357] Buffer I/O error on device sda3, logical block 669380226
[   22.837360] Buffer I/O error on device sda3, logical block 669380227
[   22.837362] Buffer I/O error on device sda3, logical block 669380228
[   22.837364] Buffer I/O error on device sda3, logical block 669380229
[   22.837367] Buffer I/O error on device sda3, logical block 669380230
[   22.837370] Buffer I/O error on device sda3, logical block 669380231
[   22.837387] Buffer I/O error on device sda3, logical block 669380224
[   22.837399] Buffer I/O error on device sda3, logical block 669380225
[   23.302051] Probing IDE interface ide1...
[   23.973700] hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
[   24.687255] hdd: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
[   24.745646] ide1 at 0x170-0x177,0x376 on irq 15
[   24.767028] hdc: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
[   24.767034] Uniform CD-ROM driver Revision: 3.20
[   24.839319] hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, 
UDMA(33)
[   24.927897] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 
0.48.
[   24.928283] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
[   24.928287] GSI 18 sharing vector 0xE9 and IRQ 18
[   24.928291] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 21 
(level, low) -> IRQ 233
[   24.928296] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[   24.939176] ieee1394: Initialized config rom entry `ip1394'
[   24.945309] usbcore: registered new driver usbfs
[   24.945324] usbcore: registered new driver hub
[   24.945935] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
Driver (PCI)
[   24.946299] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
[   24.946303] GSI 19 sharing vector 0x32 and IRQ 19
[   24.946307] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 
(level, low) -> IRQ 50
[   24.946411] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   24.946415] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   24.958040] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus 
number 1
[   24.958050] ohci_hcd 0000:00:02.0: irq 50, io mem 0xd5004000
[   25.010893] hub 1-0:1.0: USB hub found
[   25.010899] hub 1-0:1.0: 10 ports detected
[   25.112229] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
[   25.112234] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 
(level, low) -> IRQ 217
[   25.112336] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   25.112340] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   25.112366] ehci_hcd 0000:00:02.1: debug port 1
[   25.112369] PCI: cache line size of 64 is not supported by device 
0000:00:02.1
[   25.112512] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus 
number 2
[   25.112518] ehci_hcd 0000:00:02.1: irq 217, io mem 0xfeb00000
[   25.112524] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 
Dec 2004
[   25.112700] hub 2-0:1.0: USB hub found
[   25.112705] hub 2-0:1.0: 10 ports detected
[   25.440737] eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
[   25.440803] ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
[   25.441450] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[   25.441456] GSI 20 sharing vector 0x3A and IRQ 20
[   25.441459] ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 
(level, low) -> IRQ 58
[   25.447570] usb 2-1: new high speed USB device using ehci_hcd and address 2
[   25.491763] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[58]  
MMIO=[d4008000-d40087ff]  Max Packet=[2048]
[   25.514335] Probing IDE interface ide0...
[   25.774509] usb 2-2: new high speed USB device using ehci_hcd and address 3
[   26.037911] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: 
dm-devel@redhat.com
[   26.049360] ohci_hcd 0000:00:02.0: wakeup
[   26.326164] usb 1-4: new low speed USB device using ohci_hcd and address 2
[   26.477558] usbcore: registered new driver hiddev
[   26.494195] input: HID 1241:1177 as /class/input/input1
[   26.494267] input: USB HID v1.10 Mouse [HID 1241:1177] on 
usb-0000:00:02.0-4
[   26.494275] usbcore: registered new driver usbhid
[   26.494277] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   26.748035] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d8000077be63]
[   27.057919] cdrom: open failed.
[   27.107152] SGI XFS with ACLs, security attributes, realtime, large 
block/inode numbers, no debug enabled
[   27.107340] SGI XFS Quota Management subsystem
[   27.122431] XFS mounting filesystem dm-4
[   27.184310] Starting XFS recovery on filesystem: dm-4 (logdev: internal)
[   27.470620] Ending XFS recovery on filesystem: dm-4 (logdev: internal)
[   33.705317] Losing some ticks... checking if CPU frequency changed.
[   34.305832] printk: 72 messages suppressed.
[   34.305835] Buffer I/O error on device sda3, logical block 669380224
[   34.305840] Buffer I/O error on device sda3, logical block 669380225
[   34.450288] ts: Compaq touchscreen protocol output
[   34.786121] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   34.786144] sd 3:0:0:0: Attached scsi generic sg1 type 0
[   35.900042] NET: Registered protocol family 17
[   35.990829] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
[   35.990855] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
[   36.135030] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   36.160027] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   36.160032] GSI 21 sharing vector 0x42 and IRQ 21
[   36.160036] ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 
(level, low) -> IRQ 66
[   36.160175] skge 1.3 addr 0xd4000000 irq 66 chip Yukon-Lite rev 9
[   36.160260] skge eth1: addr 00:15:f2:3f:26:5c
[   36.198485] input: PC Speaker as /class/input/input2
[   36.225979] Floppy drive(s): fd0 is 1.44M
[   36.227450] parport: PnPBIOS parport detected.
[   36.227494] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   36.241357] FDC 0 is a post-1991 82077
[   36.243940] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   36.351504] skge eth1: enabling interface
[   36.377733] nvidia: module license 'NVIDIA' taints kernel.
[   36.381030] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   36.381036] GSI 22 sharing vector 0x4A and IRQ 22
[   36.381040] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 
(level, low) -> IRQ 74
[   36.381047] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   36.381193] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8762  Mon 
May 15 13:58:14 PDT 2006
[   36.495702] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
[   36.495707] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 22 
(level, low) -> IRQ 225
[   36.495863] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   36.807612] intel8x0_measure_ac97_clock: measured 50701 usecs
[   36.807615] intel8x0: clocking to 46801
[   37.202395] it87: Found IT8712F chip at 0x290, revision 7
[   37.251644] Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 
extents:1 across:2031608k
[   37.435789] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   37.435792] md: bitmap version 4.39
[   39.064224] cdrom: open failed.
[   39.225341] XFS mounting filesystem dm-6
[   39.387801] Starting XFS recovery on filesystem: dm-6 (logdev: internal)
[   39.634277] Ending XFS recovery on filesystem: dm-6 (logdev: internal)
[   39.704440] kjournald starting.  Commit interval 5 seconds
[   39.704561] EXT3 FS on dm-2, internal journal
[   39.704565] EXT3-fs: mounted filesystem with ordered data mode.
[   39.722235] NTFS driver 2.1.25 [Flags: R/O MODULE].
[   39.778007] NTFS volume version 3.1.
[   40.140980] NET: Registered protocol family 10
[   40.141077] lo: Disabled Privacy Extensions
[   40.141381] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   40.141400] IPv6 over IPv4 tunneling driver
[   45.329350] ACPI: Power Button (FF) [PWRF]
[   45.329358] ACPI: Power Button (CM) [PWRB]
[   45.386980] ibm_acpi: ec object not found
[   45.399398] pcc_acpi: loading...
[   45.683045] powernow-k8: Found 2 AMD Athlon 64 / Opteron processors 
(version 1.50.4)
[   45.683118] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
[   45.683122] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
[   45.683124] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
[   45.683128] cpu_init done, current fid 0xc, vid 0x6
[   45.683936] powernow-k8: ph2 null fid transition 0xc
[   46.260339] lp0: using parport0 (interrupt-driven).
[   46.282539] ppdev: user-space parallel port driver
[   47.753026] printk: 80 messages suppressed.
[   47.753031] Buffer I/O error on device sda3, logical block 669380224
[   47.753035] Buffer I/O error on device sda3, logical block 669380225
[   49.727523] Bluetooth: Core ver 2.8
[   49.727527] NET: Registered protocol family 31
[   49.727529] Bluetooth: HCI device and connection manager initialized
[   49.727536] Bluetooth: HCI socket layer initialized
[   49.748617] Bluetooth: L2CAP ver 2.8
[   49.748621] Bluetooth: L2CAP socket layer initialized
[   49.757779] Bluetooth: RFCOMM socket layer initialized
[   49.757792] Bluetooth: RFCOMM TTY layer initialized
[   49.757794] Bluetooth: RFCOMM ver 1.7
[   50.470115] eth0: no IPv6 routers present
[   51.333124] i2c_adapter i2c-2: SMBus Quick command not supported, can't 
probe for chips
[   51.333467] i2c_adapter i2c-3: SMBus Quick command not supported, can't 
probe for chips
[   51.333808] i2c_adapter i2c-4: SMBus Quick command not supported, can't 
probe for chips
[  487.954085] xfs_db[11607] trap divide error rip:423920 rsp:7fffff993110 
error:0
[  528.214181] xfs_db[11641] trap divide error rip:423920 rsp:7fffffbae120 
error:0
[  539.364718] xfs_db[11653] trap divide error rip:423920 rsp:7fffffbe0d30 
error:0
