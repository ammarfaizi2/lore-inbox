Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVFJXzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVFJXzB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFJXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:54:39 -0400
Received: from iron.pdx.net ([207.149.241.18]:59864 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S261481AbVFJXul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:50:41 -0400
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
References: <20050605204645.A28422@jurassic.park.msu.ru>
	 <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
	 <20050610184815.A13999@jurassic.park.msu.ru>
	 <200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:50:31 -0700
Message-Id: <1118447431.9185.11.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been following this thread with some interest for the last couple
of days.  I am experiencing a similar(but not identical) issue with my
ASUS K8N-DL mobo.

I seem to have no ability to access the onboard ethernet, sound or USB
controller on the machine, and I see some interesting output that looks
an awful lot like the issue Mr. Koch has been investigating.  Here is
the output of "dmesg"(Search down for :DMESG) and "lspci -vvt"(Search
down for :LSPCI) for your review.

I have used the latest patch that Mr. Kokshaysky provided against
2.6.12-rc6 with todays "git4" patch.  The system always boots, but seems
to be unable to access some of the devices that are on-board.  

The on-board Broadcom adapter shows some additional information
in /var/log/messsages when I attempt to DHCP an IP address.  I have
placed that log snippet at the end of this message(Search down
for :BROAD).

In order to get on the network to glean some data off of it, I placed a
PCI ethernet card in (Intel 10/100).

:DMESG

Linux version 2.6.12-rc6-git4 (root@home-desk) (gcc version 4.0.0
20050606 (Red Hat 4.0.0-11)) #1 Fri Jun 10 14:56:42 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001c0000000 (usable)
ACPI: RSDP (v000 Nvidia                                ) @
0x00000000000f7730
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000bfff30c0
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000bfff99c0
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000bfff9900
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x0000000000000000
On node 0 totalpages: 1835008
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1830912 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
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
Allocating PCI resources starting at c0000000 (gap: c0000000:20000000)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2010.319 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 6105052k/7340032k available (2745k kernel code, 185224k
reserved, 1253k data, 192k init)
Calibrating delay loop... 3981.31 BogoMIPS (lpj=1990656)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Opteron(tm) Processor 246 stepping 0a
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace,
AE_NOT_FOUND
search_node ffff8100bffc8a40 start_node ffff8100bffc8a40 return_node
0000000000000000
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace,
AE_NOT_FOUND
search_node ffff8100bffc8940 start_node ffff8100bffc8940 return_node
0000000000000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:04:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace,
AE_NOT_FOUND
search_node ffff8100bffc8940 start_node ffff8100bffc8940 return_node
0000000000000000
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT]
(Node ffff8100bffc8900), AE_NOT_FOUND
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
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
pnp: PnP ACPI: found 15 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Cannot allocate resource region 0 of device 0000:02:00.0
PCI: Cannot allocate resource region 3 of device 0000:04:00.0
PCI: Bridge: 0000:00:09.0
  IO window: e000-efff
  MEM window: fe600000-fe8fffff
  PREFETCH window: fe900000-fe9fffff
PCI: Bridge: 0000:00:0c.0
  IO window: d000-dfff
  MEM window: fe500000-fe5fffff
  PREFETCH window: fe400000-fe4fffff
PCI: Bridge: 0000:00:0d.0
  IO window: c000-cfff
  MEM window: fe300000-fe3fffff
  PREFETCH window: fe200000-fe2fffff
PCI: Failed to allocate mem resource #3:1000000@fe000000 for
0000:04:00.0
PCI: Bridge: 0000:00:0e.0
  IO window: b000-bfff
  MEM window: fd000000-fe0fffff
  PREFETCH window: c0000000-d0ffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1118446090.517:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing
enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xfa00-0xfa07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfa08-0xfa0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
hdd: Polaroid BurnMAX48, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 448Kbytes
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
ACPI wakeup devices:
HUB0 XVR0 XVR1 XVR2 XVR3 USB0 USB2 MMAC MMCI UAR1
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 192k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
SCSI subsystem initialized
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC2] -> GSI 17 (level,
low) -> IRQ 209
ata1: SATA max UDMA/100 cmd 0xFFFFC20000002080 ctl 0xFFFFC2000000208A
bmdma 0xFFFFC20000002000 irq 209
ata2: SATA max UDMA/100 cmd 0xFFFFC200000020C0 ctl 0xFFFFC200000020CA
bmdma 0xFFFFC20000002008 irq 209
ata3: SATA max UDMA/100 cmd 0xFFFFC20000002280 ctl 0xFFFFC2000000228A
bmdma 0xFFFFC20000002200 irq 209
ata4: SATA max UDMA/100 cmd 0xFFFFC200000022C0 ctl 0xFFFFC200000022CA
bmdma 0xFFFFC20000002208 irq 209
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003
88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
tg3.c:v3.31 (June 8, 2005)
ACPI: PCI Interrupt 0000:02:00.0[A]: no GSI - using IRQ 3
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit)
10/100/1000BaseT Ethernet 00:11:d8:d3:08:05
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
eth0: dma_rwctrl[76180000]
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 217
e100: eth1: e100_probe: addr 0xfe8ff000, irq 217, MAC addr
00:03:47:96:ED:4E
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI - using IRQ 11
PCI: Setting latency timer of device 0000:00:04.0 to 64
intel8x0_measure_ac97_clock: measured 49630 usecs
intel8x0: clocking to 46864
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt 0000:00:02.1[B]: no GSI - using IRQ 5
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 5, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:02.0[A]: no GSI - using IRQ 3
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 3, io mem 0xfeaff000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 2-9: new full speed USB device using ohci_hcd and address 2
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level,
low) -> IRQ 225
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[225]
MMIO=[fe8fe000-fe8fe7ff]  Max Packet=[2048]
ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Controller is probably
using the wrong IRQ.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000277ca6]
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff804a1b80(lo)
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present


:LSPCI

-[0000:00]-+-00.0  nVidia Corporation CK804 Memory Controller
           +-01.0  nVidia Corporation CK804 ISA Bridge
           +-01.1  nVidia Corporation CK804 SMBus
           +-02.0  nVidia Corporation CK804 USB Controller
           +-02.1  nVidia Corporation CK804 USB Controller
           +-04.0  nVidia Corporation CK804 AC'97 Audio Controller
           +-06.0  nVidia Corporation CK804 IDE
           +-09.0-[0000:01]--+-06.0  Intel Corporation 82557/8/9
[Ethernet Pro 100]
           |                 +-08.0  Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link)
           |                 \-09.0  Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller
           +-0c.0-[0000:02]----00.0  Broadcom Corporation NetXtreme
BCM5751 Gigabit Ethernet PCI Express
           +-0d.0-[0000:03]--
           +-0e.0-[0000:04]----00.0  nVidia Corporation NV44 [GeForce
6200 TurboCache]
           +-18.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
           +-18.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
           +-18.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
           +-18.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
           +-19.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
           +-19.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
           +-19.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
           \-19.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control


:BROAD
Jun 10 16:41:48 home-desk NET[2720]: /sbin/dhclient-script :
updated /etc/resolv.conf
Jun 10 16:41:50 home-desk kernel: irq 225: nobody cared!
Jun 10 16:41:50 home-desk kernel:
Jun 10 16:41:50 home-desk kernel: Call Trace: <IRQ>
<ffffffff8016ccf5>{__report_bad_irq+53}
<ffffffff8016cdcc>{note_interrupt+92}
Jun 10 16:41:50 home-desk kernel:        <ffffffff8016c285>{__do_IRQ
+597} <ffffffff80111ed8>{do_IRQ+72}
Jun 10 16:41:50 home-desk kernel:
<ffffffff8010f5c3>{ret_from_intr+0}  <EOI>
<ffffffff8010d250>{default_idle+0}
Jun 10 16:41:50 home-desk kernel:        <ffffffff8010d272>{default_idle
+34} <ffffffff8010d2b1>{cpu_idle+49}
Jun 10 16:41:50 home-desk kernel:        <ffffffff805667e5>{start_kernel
+469} <ffffffff805661f4>{_sinittext+500}
Jun 10 16:41:50 home-desk kernel:
Jun 10 16:41:50 home-desk kernel: handlers:
Jun 10 16:41:50 home-desk kernel: [<ffffffff88247250>] (ohci_irq_handler
+0x0/0xc70 [ohci1394])
Jun 10 16:41:50 home-desk kernel: Disabling IRQ #225
Jun 10 16:41:53 home-desk dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 8

Sean

