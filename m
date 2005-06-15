Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVFPCeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVFPCeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 22:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVFPCeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 22:34:19 -0400
Received: from mxsf26.cluster1.charter.net ([209.225.28.226]:43161 "EHLO
	mxsf26.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261526AbVFPCdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 22:33:22 -0400
X-IronPort-AV: i="3.93,202,1115006400"; 
   d="txt'?scan'208"; a="1185777164:sNHT35184608"
From: Jacob Martin <martin@cs.uga.edu>
Reply-To: martin@cs.uga.edu
Organization: University of Georgia
To: Andi Kleen <ak@muc.de>
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Date: Wed, 15 Jun 2005 18:33:12 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200506071836.12076.martin@cs.uga.edu> <200506131953.16958.martin@cs.uga.edu> <20050615195144.GA40993@muc.de>
In-Reply-To: <20050615195144.GA40993@muc.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oyKsCNZzObnjoB1"
Message-Id: <200506151833.12315.martin@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_oyKsCNZzObnjoB1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 15 June 2005 03:51 pm, Andi Kleen wrote:
> On Mon, Jun 13, 2005 at 07:53:16PM +0000, Jacob Martin wrote:
> > On Monday 13 June 2005 10:06 am, Andi Kleen wrote:
> > > On Sun, Jun 12, 2005 at 03:29:50PM -0400, Jacob Martin wrote:
> > > > Hardware memhole mapping never seems to work, or causes lockups right
> > > > away.  I need to test it further though.
> > > >
> > > > I have discovered that with the following features enabled:
> > > >
> > > > 1.  Software memhole mapping
> > > > 2.  Continuous,
> > > >
> > > > linux sees the entire 4GB of memory.  However, when things start
> > > > getting requested from the upper half, there are Oopses generated. 
> > > > Attached are two Oopses that occurred under the test scenario
> > > > described.
> > >
> > > What happens when you boot with numa=off or with numa=noacpi ?
> >
> > You got it!  It seems to be working just fine without it compiled into
> > the kernel.
>
> Not compiled what in the kernel? I just wanted you to boot
> the kernel with these options.
>
> > > The system seems to believe it has memory in an area not covered
> > > by mem_map.
> >
> > I think you hit it right on the head.
> >
> > I enabled NUMA because I had anticipated upgrading later.  So I guess if
> > you don't actually have NUMA set up hardware-wise, and enable this
> > module, then you will have problems.
>
> No, it should work fine in theory.
>
> > Maybe a simple update to the kernel "K8 NUMA support" Processor feature's
> > help section should be made to note this?  Or, is there something that
> > could be fixed somewhere.  I wouldn't mind helping, it was baffling me
> > for two weeks.
>
> It is something that must be either fixed or workarounded (if it's a bug
> in your BIOS, which is quite possible)
>
> Can you send me the full dmesg from a numa boot again?


Attached are the full dmesg's with numa and without.  Also, I attached the 
OOPS from memeat that I received when booting with NUMA enabled.  memeat runs 
fine when numa is off.

Don't hesitate to ask me to help further.

Best,
Jacob Martin

--Boundary-00=_oyKsCNZzObnjoB1
Content-Type: text/plain;
  charset="iso-8859-1";
  name="NUMAENABLED_dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="NUMAENABLED_dmesg.txt"

Bootdata ok (command line is root=/dev/sda3 )
Linux version 2.6.12-rc6 (root@optimator) (gcc version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #1 SMP Wed Jun 15 16:56:01 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000094800 (usable)
 BIOS-e820: 0000000000094800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff20000 (usable)
 BIOS-e820: 000000007ff20000 - 000000007ff2d000 (ACPI data)
 BIOS-e820: 000000007ff2d000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f78b0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000007ff28836
ACPI: FADT (v001 NVIDIA CK8S     0x06040000 PTL_ 0x000f4240) @ 0x000000007ff2cdd6
ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 0x000000007ff2ce4a
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x000000007ff2cf12
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000007ff2cf62
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x000000007ff2cfd8
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000017fffffff
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000017fffffff
On node 0 totalpages: 1572863
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1568767 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xd0000000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xd0000000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xd0001000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xd0001000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Checking aperture...
CPU 0: aperture @ 0 size 2048 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
Putting aperture at 80000000-83ffffff
Built 1 zonelists
Kernel command line: root=/dev/sda3 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2009.294 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 4088624k/6291456k available (2906k kernel code, 0k reserved, 1576k data, 200k init)
Calibrating delay loop... 3981.31 BogoMIPS (lpj=1990656)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Using local APIC timer interrupts.
Detected 12.558 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff81017ffb5f58
Initializing CPU#1
Calibrating delay loop... 4014.08 BogoMIPS (lpj=2007040)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
Dual Core AMD Opteron(tm) Processor 270 stepping 02
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 498 cycles)
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
 domain 0: span 1
  groups: 1
  domain 1: span 3
   groups: 1 2
   domain 2: span 3
    groups: 3
CPU1 attaching sched-domain:
 domain 0: span 2
  groups: 2
  domain 1: span 3
   groups: 2 1
   domain 2: span 3
    groups: 3
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Root Bridge [PCI2] (0000:08)
PCI: Probing PCI hardware (bus 08)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PB._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 80000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Simple Boot Flag at 0x36 set to 0x1
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: MSI quirk detected. MSI disabled.
Allocate Port Service[pcie00]
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LMAC] -> GSI 23 (level, high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:0a.0 to 64
eth0: forcedeth.c: subsystem: 010f1:2895 bound to 0000:00:0a.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: no response (status = 0x98), resetting drive
hda: , ATAPI cdrom or floppy?, assuming FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
libata version 1.11 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x1440 ctl 0x1436 bmdma 0x1410 irq 185
ata2: SATA max UDMA/133 cmd 0x1438 ctl 0x1432 bmdma 0x1418 irq 185
ata1: no device found (phy stat 00000000)
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 21 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x1458 ctl 0x144E bmdma 0x1420 irq 193
ata4: SATA max UDMA/133 cmd 0x1450 ctl 0x144A bmdma 0x1428 irq 193
ata3: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:407f
ata3: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:407f
ata4: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata4: dev 0 configured for UDMA/133
scsi3 : sata_nv
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 27.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi3, channel 0, id 0, lun 0,  type 0
Fusion MPT base driver 3.01.20
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.20
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 20 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: nVidia Corporation CK804 USB Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 201, io mem 0xb0001000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 23 (level, high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation CK804 USB Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 177, io mem 0xb0000000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-4: new low speed USB device using ohci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:02.0-4
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 344 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.6 loaded successfully
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PCI0 COM1 PS2K PS2M USB0 USB2 MAC0 P2P0 G0PA G0PB 
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
Adding 506036k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
smsc47b397: found SMSC LPC47B397-NC (base address 0x0480, revision 1)

--Boundary-00=_oyKsCNZzObnjoB1
Content-Type: text/plain;
  charset="iso-8859-1";
  name="NUMADISABLED_dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="NUMADISABLED_dmesg.txt"

Bootdata ok (command line is root=/dev/sda3 numa=off)
Linux version 2.6.12-rc6 (root@optimator) (gcc version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #1 SMP Wed Jun 15 16:56:01 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000094800 (usable)
 BIOS-e820: 0000000000094800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff20000 (usable)
 BIOS-e820: 000000007ff20000 - 000000007ff2d000 (ACPI data)
 BIOS-e820: 000000007ff2d000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f78b0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x000000007ff28836
ACPI: FADT (v001 NVIDIA CK8S     0x06040000 PTL_ 0x000f4240) @ 0x000000007ff2cdd6
ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 0x000000007ff2ce4a
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x000000007ff2cf12
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x000000007ff2cf62
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x000000007ff2cfd8
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
NUMA turned off
Faking a node at 0000000000000000-0000000180000000
Bootmem setup node 0 0000000000000000-0000000180000000
On node 0 totalpages: 1572864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1568768 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xd0000000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xd0000000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xd0001000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xd0001000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Checking aperture...
CPU 0: aperture @ 0 size 2048 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
Putting aperture at 80000000-83ffffff
Built 1 zonelists
Kernel command line: root=/dev/sda3 numa=off
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2009.287 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 4088880k/6291456k available (2906k kernel code, 0k reserved, 1576k data, 200k init)
Calibrating delay loop... 3981.31 BogoMIPS (lpj=1990656)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Using local APIC timer interrupts.
Detected 12.558 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff8100070f3f58
Initializing CPU#1
Calibrating delay loop... 4014.08 BogoMIPS (lpj=2007040)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
Dual Core AMD Opteron(tm) Processor 270 stepping 02
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 498 cycles)
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
 domain 0: span 1
  groups: 1
  domain 1: span 3
   groups: 1 2
   domain 2: span 3
    groups: 3
CPU1 attaching sched-domain:
 domain 0: span 2
  groups: 2
  domain 1: span 3
   groups: 2 1
   domain 2: span 3
    groups: 3
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Root Bridge [PCI2] (0000:08)
PCI: Probing PCI hardware (bus 08)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PB._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 80000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Simple Boot Flag at 0x36 set to 0x1
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: MSI quirk detected. MSI disabled.
Allocate Port Service[pcie00]
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LMAC] -> GSI 23 (level, high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:0a.0 to 64
eth0: forcedeth.c: subsystem: 010f1:2895 bound to 0000:00:0a.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: no response (status = 0x98), resetting drive
hda: , ATAPI cdrom or floppy?, assuming FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
libata version 1.11 loaded.
sata_nv version 0.6
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x1440 ctl 0x1436 bmdma 0x1410 irq 185
ata2: SATA max UDMA/133 cmd 0x1438 ctl 0x1432 bmdma 0x1418 irq 185
ata1: no device found (phy stat 00000000)
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 21 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x1458 ctl 0x144E bmdma 0x1420 irq 193
ata4: SATA max UDMA/133 cmd 0x1450 ctl 0x144A bmdma 0x1428 irq 193
ata3: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:407f
ata3: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:407f
ata4: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata4: dev 0 configured for UDMA/133
scsi3 : sata_nv
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 27.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi3, channel 0, id 0, lun 0,  type 0
Fusion MPT base driver 3.01.20
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.20
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 20 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: nVidia Corporation CK804 USB Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 201, io mem 0xb0001000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 23 (level, high) -> IRQ 177
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation CK804 USB Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 177, io mem 0xb0000000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-4: new low speed USB device using ohci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:02.0-4
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 344 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.6 loaded successfully
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PCI0 COM1 PS2K PS2M USB0 USB2 MAC0 P2P0 G0PA G0PB 
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: AT Translated Set 2 keyboard on isa0060/serio0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding 506036k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
smsc47b397: found SMSC LPC47B397-NC (base address 0x0480, revision 1)
nvidia: disagrees about version of symbol struct_module
nvidia: disagrees about version of symbol struct_module

--Boundary-00=_oyKsCNZzObnjoB1
Content-Type: text/plain;
  charset="iso-8859-1";
  name="NUMAENABLED_oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="NUMAENABLED_oops.txt"

Jun 15 18:19:05 optimator Unable to handle kernel paging request at 0000000000001cb0 RIP: 
Jun 15 18:19:05 optimator <ffffffff8016665a>{pte_alloc_map+170}
Jun 15 18:19:05 optimator PGD 17e909067 PUD 17d7c3067 PMD 0 
Jun 15 18:19:05 optimator Oops: 0000 [1] SMP 
Jun 15 18:19:05 optimator CPU 1 
Jun 15 18:19:05 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core
Jun 15 18:19:05 optimator Pid: 6346, comm: a.out Not tainted 2.6.12-rc6
Jun 15 18:19:05 optimator RIP: 0010:[<ffffffff8016665a>] <ffffffff8016665a>{pte_alloc_map+170}
Jun 15 18:19:05 optimator RSP: 0000:ffff81017ea6ddb8  EFLAGS: 00010293
Jun 15 18:19:05 optimator RAX: ffffffff7fffffff RBX: 00002aab20000000 RCX: 0000000000000018
Jun 15 18:19:05 optimator RDX: ffff810107c03000 RSI: 0000000000000000 RDI: ffff81000000f440
Jun 15 18:19:05 optimator RBP: ffff810128302800 R08: ffff81000000f000 R09: 0000000000000000
Jun 15 18:19:05 optimator R10: 00000000000807ac R11: 0000000000000000 R12: 0000000000000000
Jun 15 18:19:05 optimator R13: ffff81017ecef6c0 R14: ffff81017ecef728 R15: ffff810128302800
Jun 15 18:19:05 optimator FS:  00002aaaaade7ae0(0000) GS:ffffffff805ba300(0000) knlGS:0000000000000000
Jun 15 18:19:05 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun 15 18:19:05 optimator CR2: 0000000000001cb0 CR3: 000000017d7c1000 CR4: 00000000000006e0
Jun 15 18:19:05 optimator Process a.out (pid: 6346, threadinfo ffff81017ea6c000, task ffff81017e94a880)
Jun 15 18:19:05 optimator Stack: ffff81017d7c12a8 00002aab20000000 ffff81017e177710 ffff81017ecef6c0 
Jun 15 18:19:05 optimator 0000000000000001 ffffffff801691e5 00002aaaaade7ae0 ffff81017ecef728 
Jun 15 18:19:05 optimator 0000000000000000 0000000000000000 
Jun 15 18:19:05 optimator Call Trace:<ffffffff801691e5>{handle_mm_fault+293} <ffffffff80120f79>{do_page_fault+1081}
Jun 15 18:19:05 optimator <ffffffff80286971>{tty_write+577} <ffffffff8028c3b0>{write_chan+0}
Jun 15 18:19:05 optimator <ffffffff801a9c4e>{dnotify_parent+46} <ffffffff8017ad0e>{vfs_write+238}
Jun 15 18:19:05 optimator <ffffffff8010f485>{error_exit+0} 
Jun 15 18:19:05 optimator 
Jun 15 18:19:05 optimator Code: 48 8b 8e b0 1c 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66 
Jun 15 18:19:05 optimator RIP <ffffffff8016665a>{pte_alloc_map+170} RSP <ffff81017ea6ddb8>
Jun 15 18:19:05 optimator CR2: 0000000000001cb0
Jun 15 18:19:31 optimator su(pam_unix)[6348]: session opened for user root by martin(uid=1000)
Jun 15 18:20:01 optimator cron[6356]: (root) CMD (test -x /usr/sbin/run-crons && /usr/sbin/run-crons )

--Boundary-00=_oyKsCNZzObnjoB1--
