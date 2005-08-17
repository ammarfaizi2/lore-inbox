Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVHQFF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVHQFF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVHQFF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:05:29 -0400
Received: from bay103-f6.bay103.hotmail.com ([65.54.174.16]:41393 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750818AbVHQFF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:05:28 -0400
Message-ID: <BAY103-F636E57020083E2347173AC4B30@phx.gbl>
X-Originating-IP: [65.54.174.207]
X-Originating-Email: [jonschindler@hotmail.com]
From: "Jon Schindler" <jonschindler@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: powernow-k8 cpufreq driver problems (fails to load on MSI k8n neo2 w/3500+)
Date: Wed, 17 Aug 2005 01:05:25 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 17 Aug 2005 05:05:27.0621 (UTC) FILETIME=[486E8750:01C5A2E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have two machines with similar specs (same motherboard and bios version), 
and one works fine with the cpufreq driver while the other machine is giving 
me the following messages below.

powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.4)
cpufreq-core: trying to register driver powernow-k8
cpufreq-core: adding CPU 0
powernow-k8: register performance failed: bad ACPI data
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
cpufreq-core: initialization failed
cpufreq-core: no CPU initialized for driver powernow-k8
cpufreq-core: unregistering CPU 0

I have done roughly 8 hours of google searching and research, have tried 
various kernel options, tried updating to the latest kernel, tried reverting 
to an earlier bios, but nothing seems to work.  At this point, I think there 
may be an issue with the kernel.  However, it doesn't make sense that the 
bios and powernow would work with a bleeding edge dual core processor, but 
not work with an older processor model on the same motherboard.  I've 
obviously run out of ideas.  If anyone has any suggestions or ideas, (or 
even better, a patch) I would really appreciate it.

Strangely enough, the machine that works with powernow has a leading edge 
athlon 4800+, while the one that is broken is running an Athlon 3500+.

Anyway, here are the details.
Machine 1: (works with powernow)
OS: Fedora Core 4 64 bit version, kernel 2.6.12.3
AMD Athlon 4800+
3GB of RAM
MSI K8N Neo2 Platinum motherboard with bios version 1.9
Nvidia Geforce 6800 GT video card (AGP)
3 hard drives, 2 SATA, 1 ATA
ATI Tv Wonder PCI
1 Plextor DVD burner

Machine 2:(fails to load powernow driver)
OS: Fedora Cord 4 32 bit version, kernel 2.6.12.4
AMD Athlon 3500+ (venice core, stepping 2)
MSI K8N Neo2 Platinum motherboard with bios version 1.9
1 GB of RAM
Trident PCI video card (it's a file/mail server)
4 SATA drives in a RAID 5 array (data drives)
2 ATA drives in a RAID 1 array (boot drive)
1 NEC DVD RW (model 3504?)

Here is the dmesg for machine 1:
Bootdata ok (command line is ro root=LABEL=/1 rhgb quiet)
Linux version 2.6.12.3 (root@localhost) (gcc version 4.0.0 20050519 (Red Hat 
4.0.0-8)) #2 SMP Thu Jul 21 03:48:06 CDT 2005
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 
0x00000000000f8f30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 
0x00000000bfff7b80
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff7ac0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
On node 0 totalpages: 786416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 782320 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
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
Allocating PCI resources starting at c0000000 (gap: c0000000:3ec00000)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
Built 1 zonelists
Kernel command line: ro root=LABEL=/1 rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2411.790 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3088432k/3145664k available (2361k kernel code, 56304k reserved, 
1585k data, 220k init)
Calibrating delay loop... 4784.12 BogoMIPS (lpj=2392064)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Using local APIC timer interrupts.
Detected 12.561 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff810004155f58
Initializing CPU#1
Calibrating delay loop... 4816.89 BogoMIPS (lpj=2408448)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
CPU 1: synchronized TSC with CPU 0 (last diff -77 cycles, maxerr 565 cycles)
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
domain 0: span 00000003
  groups: 00000001 00000002
CPU1 attaching sched-domain:
domain 0: span 00000003
  groups: 00000002 00000001
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 256M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1124235674.328:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y250P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
NFORCE3-250-SATA2: IDE controller at PCI slot 0000:00:09.0
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [APSI] -> GSI 23 (level, high) 
-> IRQ 177
NFORCE3-250-SATA2: chipset revision 162
NFORCE3-250-SATA2: BIOS didn't set cable bits correctly. Enabling 
workaround.
NFORCE3-250-SATA2: 0000:00:09.0 (rev a2) UDMA133 controller
NFORCE3-250-SATA2: 100% native mode on irq 177
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdg: WDC WD3200SD-01KNB0, ATA DISK drive
ide3 at 0x960-0x967,0xb62 on irq 177
NFORCE3-250-SATA: IDE controller at PCI slot 0000:00:0a.0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) 
-> IRQ 185
NFORCE3-250-SATA: chipset revision 162
NFORCE3-250-SATA: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250-SATA: 0000:00:0a.0 (rev a2) UDMA133 controller
NFORCE3-250-SATA: 100% native mode on irq 185
    ide4: BM-DMA at 0xb000-0xb007, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb008-0xb00f, BIOS settings: hdk:DMA, hdl:pio
Probing IDE interface ide4...
hdi: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide4 at 0x9f0-0x9f7,0xbf2 on irq 185
Probing IDE interface ide5...
hdk: WDC WD740GD-00FLA2, ATA DISK drive
ide5 at 0x970-0x977,0xb72 on irq 185
Probing IDE interface ide2...
hda: max request size: 1024KiB
hda: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, 
UDMA(133)
hda: cache flushes supported
hda: hda1 hda2
hdg: max request size: 1024KiB
hdg: 625142448 sectors (320072 MB) w/8192KiB Cache, CHS=38913/255/63
hdg: cache flushes supported
hdg: hdg1 hdg2 hdg3
hdk: max request size: 1024KiB
hdk: 145226112 sectors (74355 MB) w/8192KiB Cache, CHS=16383/255/63
hdk: cache flushes supported
hdk: hdk1
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
hdi: No disk in drive
hdi: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.40.4)
powernow-k8:    0 : fid 0x10 (2400 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0xe (2200 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0xc (1250 mV)
powernow-k8:    3 : fid 0xa (1800 MHz), vid 0xe (1200 mV)
powernow-k8:    4 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0x10, vid 0xa
ACPI wakeup devices:
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 220k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
SCSI subsystem initialized
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 21 (level, high) 
-> IRQ 193
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC5] -> GSI 16 (level, low) -> 
IRQ 201
r8169: NAPI enabled
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffc20000006000, 00:11:09:8f:4f:a4, IRQ 201
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 20 (level, high) 
-> IRQ 209
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 50646 usecs
intel8x0: clocking to 46900
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC2] -> GSI 17 (level, low) -> 
IRQ 217
bttv0: Bt878 (rev 2) at 0000:02:0a.0, irq: 217, latency: 32, mmio: 
0xfdeff000
bttv0: detected: ATI TV Wonder [card=63], PCI subsystem ID is 1002:0001
bttv0: using: ATI TV-Wonder [card=63,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: using tuner=19
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3430G-A4 +nicam +simple +simpler +radio mode=simpler
msp34xxg: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 2-0060: chip found @ 0xc0 (bt878 #0 [sw])
tuner 2-0060: type set to 19 (Temic PAL* auto (4006 FN5))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI Interrupt 0000:02:0a.1[A] -> Link [APC2] -> GSI 17 (level, low) -> 
IRQ 217
bt878(0): Bt878 (rev 2) at 02:0a.1, irq: 217, latency: 32, memory: 
0xfdefe000
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 23 (level, high) 
-> IRQ 177
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 EHCI USB 2.0 Controller
ehci_hcd 0000:00:02.2: reset hcs_params 0x102488 dbg=1 cc=2 pcc=4 !ppc 
ports=8
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 1 0
ehci_hcd 0000:00:02.2: reset hcc_params a082 caching frame 256/512/1024
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: capability 0001 at a0
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 177, io mem 0xfe02d000
ehci_hcd 0000:00:02.2: reset command 080002 (park)=0 ithresh=8 period=1024 
Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ehci_hcd 0000:00:02.2: supports USB remote wakeup
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: nVidia Corporation nForce3 EHCI USB 2.0 Controller
usb usb1: Manufacturer: Linux 2.6.12.3 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
ehci_hcd 0000:00:02.2: GetStatus port 6 status 001403 POWER sig=k  CSC 
CONNECT
hub 1-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) 
-> IRQ 185
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation CK8S USB Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 185, io mem 0xfe02f000
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: fminterval a7782edf
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000204 POTPGT=1 NPS NDP=4
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [3] 0x00000100 PPS
ohci_hcd 0000:00:02.0: supports USB remote wakeup
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: nVidia Corporation CK8S USB Controller
usb usb2: Manufacturer: Linux 2.6.12.3 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
ohci_hcd 0000:00:02.0: created debug files
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) 
-> IRQ 193
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: nVidia Corporation CK8S USB Controller (#2)
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 193, io mem 0xfe02e000
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
hub 1-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 6 low speed --> companion
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: fminterval a7782edf
ohci_hcd 0000:00:02.1: hcca frame #0003
ohci_hcd 0000:00:02.1: roothub.a 01000204 POTPGT=1 NPS NDP=4
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:02.1: roothub.portstatus [3] 0x00000100 PPS
ohci_hcd 0000:00:02.1: supports USB remote wakeup
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: nVidia Corporation CK8S USB Controller (#2)
usb usb3: Manufacturer: Linux 2.6.12.3 ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
ohci_hcd 0000:00:02.1: created debug files
ehci_hcd 0000:00:02.2: GetStatus port 6 status 003402 POWER OWNER sig=k  CSC
hub 1-0:1.0: port_wait_reset: err = -107
hub 2-0:1.0: state 5 ports 4 chg 0000 evt 0000
hub 3-0:1.0: state 5 ports 4 chg 0000 evt 0000
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010301 CSC 
LSDA PPS CCS
hub 3-0:1.0: port 3, status 0301, change 0001, 1.5 Mb/s
hub 3-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x301
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level, low) -> 
IRQ 225
PCI: Via IRQ fixup for 0000:02:0c.0, from 11 to 1
ohci_hcd 0000:00:02.0: suspend root hub
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[225]  MMIO=[fdfff000-fdfff7ff] 
  Max Packet=[2048]
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100303 PRSC 
LSDA PPS PES CCS
usb 3-3: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100303 PRSC 
LSDA PPS PES CCS
usb 3-3: skipped 1 descriptor after interface
usb 3-3: default language 0x0409
usb 3-3: new device strings: Mfr=3, Product=1, SerialNumber=2
usb 3-3: Product: Back-UPS ES 500 FW:801.e5.D USB FW:e5
usb 3-3: Manufacturer: APC
usb 3-3: SerialNumber: JB0451044605
usb 3-3: hotplug
usb 3-3: adding 3-3:1.0 (config #1, interface 0)
usb 3-3:1.0: hotplug
usbhid 3-3:1.0: usb_probe_interface
usbhid 3-3:1.0: usb_probe_interface - got id
drivers/usb/core/file.c: looking for a minor, starting at 96
hiddev96: USB HID v1.10 Device [APC Back-UPS ES 500 FW:801.e5.D USB FW:e5] 
on usb-0000:00:02.1-3
hub 3-0:1.0: state 5 ports 4 chg 0000 evt 0008
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00007aa441]
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80492340(lo)
IPv6 over IPv4 tunneling driver
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> 
IRQ 201
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7667  Fri Jun 17 
07:14:03 PDT 2005
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
hdi: No disk in drive
cdrom: open failed.
EXT3 FS on hdg1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
w83627hf 3-0290: Reading VID from GPIO5
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth0: no IPv6 routers present
/dev/vmmon[2887]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[2887]: Module vmmon: initialized
/dev/vmnet: open called by PID 2921 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth1: peer interface eth1 not found, will wait for it to come up
bridge-eth1: attached
/dev/vmnet: open called by PID 2930 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened




Here is the dmesg for machine 2:
Linux version 2.6.12.4 (root@mail) (gcc version 4.0.0 20050519 (Red Hat 
4.0.0-8)) #1 Tue Aug 16 20:21:55 CDT 2005
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f5040
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f8f30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff30c0
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7ac0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
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
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 3 cpufreq.debug=7
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0487000 soft=c0486000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2210.713 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 903160k/917504k available (2644k kernel code, 13804k reserved, 720k 
data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4374.52 BogoMIPS (lpj=2187264)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 
00000001 00000000 00000001
CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 
00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000010 00000001 
00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) 64 Processor 3500+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=0 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 1810k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb840, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:02:07.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
speedstep-lib: x86: f, model: 2f
speedstep-ich: Intel(R) SpeedStep(TM) capable processor not found
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1124235809.386:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 32M @ 0xfa000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD300BB-00AUA1, ATA DISK drive
hdd: WDC WD205BA, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hdc: max request size: 128KiB
hdc: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hdc: cache flushes not supported
hdc: hdc1 hdc2 hdc3
hdd: max request size: 128KiB
hdd: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
hdd: cache flushes not supported
hdd: hdd1 hdd2
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.4)
cpufreq-core: trying to register driver powernow-k8
cpufreq-core: adding CPU 0
powernow-k8: register performance failed: bad ACPI data
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
cpufreq-core: initialization failed
cpufreq-core: no CPU initialized for driver powernow-k8
cpufreq-core: unregistering CPU 0
ACPI wakeup devices:
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 216k freed
SCSI subsystem initialized
libata version 1.11 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [APSI] -> GSI 23 (level, high) 
-> IRQ 177
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC800 irq 177
ata2: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC808 irq 177
input: AT Translated Set 2 keyboard on isa0060/serio0
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/100
scsi0 : sata_nv
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata2: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_nv
  Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) 
-> IRQ 185
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xB000 irq 185
ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xB008 irq 185
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata3: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/100
scsi2 : sata_nv
ata4: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata4: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_nv
  Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
  Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
sdd: sdd1
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
md: raid1 personality registered as nr 3
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  6996.000 MB/sec
raid5: using function: pIII_sse (6996.000 MB/sec)
md: raid5 personality registered as nr 4
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: hdd1 has different UUID to sdd1
md: hdc2 has different UUID to sdd1
md: created md1
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 4212kB for md1
raid5: raid level 5 set md1 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
--- rd:4 wd:4 fd:0
disk 0, o:1, dev:sda1
disk 1, o:1, dev:sdb1
disk 2, o:1, dev:sdc1
disk 3, o:1, dev:sdd1
md: considering hdd1 ...
md:  adding hdd1 ...
md:  adding hdc2 ...
md: created md0
md: bind<hdc2>
md: bind<hdd1>
md: running: <hdd1><hdc2>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC5] -> GSI 16 (level, low) -> 
IRQ 193
r8169: NAPI enabled
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf88d6000, 00:11:09:d6:fe:9d, IRQ 193
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 21 (level, high) 
-> IRQ 201
PCI: Setting latency timer of device 0000:00:05.0 to 64
0000:00:05.0: Invalid Mac address detected: ff:ff:ff:ff:fe:ff
Please complain to your hardware vendor. Switching to a random MAC.
eth1: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 20 (level, high) 
-> IRQ 209
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49684 usecs
intel8x0: clocking to 46761
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 23 (level, high) 
-> IRQ 177
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 177, io mem 0xfe02d000
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) 
-> IRQ 185
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 185, io mem 0xfe02f000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) 
-> IRQ 201
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 201, io mem 0xfe02e000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level, low) -> 
IRQ 217
PCI: Via IRQ fixup for 0000:02:0c.0, from 3 to 9
usb 2-2: new low speed USB device using ohci_hcd and address 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[217]  MMIO=[fdbff000-fdbff7ff] 
  Max Packet=[2048]
hiddev96: USB HID v1.10 Device [APC Back-UPS ES 500 FW:801.e5.D USB FW:e5] 
on usb-0000:00:02.0-2
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000044b80808003]
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 786424k swap on /dev/VolGroup02/LogVol01.  Priority:-1 extents:1
r8169: eth0: link up
eth1: no link during initialization.
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0407080(lo)
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present
eth0: no IPv6 routers present


