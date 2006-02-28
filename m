Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWB1KKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWB1KKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWB1KKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:10:33 -0500
Received: from mailgate.terastack.com ([195.173.195.66]:60173 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1751004AbWB1KKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:10:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Tue, 28 Feb 2006 10:10:28 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393BFB8@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY7r5S5ApfBiVDEQHudg6EmtSydkgACf9wgACUVujA=
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Andi's patch (and Jens' printk patch), I haven't seen a OOM but I'm
now seeing lots of "hda: DMA table too small" messages in dmesg. Is that
anything to worry about? Here's the complete output:

Bootdata ok (command line is root=/dev/hda1 ro )
Linux version 2.6.15-1-amd64-k8 (Debian 2.6.15-1) (luther@debian.org)
(gcc version 4.0.3 20060212 (prerelease) (Debian 4.0.2-9)) #2 Tue Feb 28
08:54:02 GMT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffb0000 (usable)
 BIOS-e820: 00000000bffb0000 - 00000000bffc0000 (ACPI data)
 BIOS-e820: 00000000bffc0000 - 00000000bfff0000 (ACPI NVS)
 BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @
0x00000000000fa7c0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000506 MSFT 0x00000097) @
0x00000000bffb0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000506 MSFT 0x00000097) @
0x00000000bffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000506 MSFT 0x00000097) @
0x00000000bffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000506 MSFT 0x00000097) @
0x00000000bffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @
0x0000000000000000
On node 0 totalpages: 1029721
  DMA zone: 3185 pages, LIFO batch:0
  DMA32 zone: 767976 pages, LIFO batch:31
  Normal zone: 258560 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
Looks like a VIA chipset. Disabling IOMMU. Overwrite with
"iommu=allowed"
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3f780000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2202.916 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x5c39000 - 0x9c39000
Memory: 4045192k/5242880k available (1703k kernel code, 148148k
reserved, 738k data, 148k init)
Calibrating delay using timer specific routine.. 4412.91 BogoMIPS
(lpj=2206459)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) 64 Processor 3500+ stepping 00
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
blk_max_low_pfn=1310720, blk_max_pfn=1310720
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0F03
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0C01
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xec000000
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: 00:07: ioport range 0x680-0x6ff has been reserved
pnp: 00:07: ioport range 0x290-0x297 has been reserved
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: faf00000-fbffffff
  PREFETCH window: f0000000-f9ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1141120203.375:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:02' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:03' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'serial'
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: match found with the PnP device '00:0b' and the driver 'serial'
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
0000:00:09.0: ttyS2 at I/O 0xa400 (irq = 16) is a 16550A
0000:00:09.0: ttyS3 at I/O 0xa000 (irq = 16) is a 16550A
bounce: queue ffff81013fac1d18, setting pfn 1310720, max_low 1310720
q=ffff81013fac1d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fac1a88, setting pfn 1310720, max_low 1310720
q=ffff81013fac1a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fac17f8, setting pfn 1310720, max_low 1310720
q=ffff81013fac17f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fac1568, setting pfn 1310720, max_low 1310720
q=ffff81013fac1568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fac12d8, setting pfn 1310720, max_low 1310720
q=ffff81013fac12d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fac1048, setting pfn 1310720, max_low 1310720
q=ffff81013fac1048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa34d18, setting pfn 1310720, max_low 1310720
q=ffff81013fa34d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa34a88, setting pfn 1310720, max_low 1310720
q=ffff81013fa34a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa347f8, setting pfn 1310720, max_low 1310720
q=ffff81013fa347f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa34568, setting pfn 1310720, max_low 1310720
q=ffff81013fa34568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa342d8, setting pfn 1310720, max_low 1310720
q=ffff81013fa342d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa34048, setting pfn 1310720, max_low 1310720
q=ffff81013fa34048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f973d18, setting pfn 1310720, max_low 1310720
q=ffff81013f973d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f973a88, setting pfn 1310720, max_low 1310720
q=ffff81013f973a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9737f8, setting pfn 1310720, max_low 1310720
q=ffff81013f9737f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f973568, setting pfn 1310720, max_low 1310720
q=ffff81013f973568, dma_addr=140000000, bounce pfn 1310720
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 148k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: HDS722525VLAT80, ATA DISK drive
hdb: Maxtor 6Y200P0, ATA DISK drive
bounce: queue ffff81013f9732d8, setting pfn 1310720, max_low 1310720
q=ffff81013f9732d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9732d8, setting pfn 1048575, max_low 1310720
q=ffff81013f9732d8, dma_addr=ffffffff, bounce pfn 1048575
bounce: queue ffff81013f973048, setting pfn 1310720, max_low 1310720
q=ffff81013f973048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f973048, setting pfn 1048575, max_low 1310720
q=ffff81013f973048, dma_addr=ffffffff, bounce pfn 1048575
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
bounce: queue ffff81013f522d18, setting pfn 1310720, max_low 1310720
q=ffff81013f522d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f522d18, setting pfn 1310720, max_low 1310720
q=ffff81013f522d18, dma_addr=140000000, bounce pfn 1310720
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 390721968 sectors (200049 MB) w/7938KiB Cache, CHS=24321/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
hdb: max request size: 1024KiB
hdb: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63,
UDMA(133)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem initialized
libata version 1.20 loaded.
sata_promise 0000:00:08.0: version 1.03
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004200 ctl 0xFFFFC20000004238
bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004280 ctl 0xFFFFC200000042B8
bmdma 0x0 irq 18
USB Universal Host Controller Interface driver v2.3
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
skge 1.2 addr 0xfa900000 irq 19 chip Yukon-Lite rev 7
skge eth0: addr 00:11:2f:a7:fb:ef
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ata3: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 17
ata4: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 17
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
e100: eth1: e100_probe: addr 0xfac00000, irq 18, MAC addr
00:D0:B7:BF:92:C8
input: PC Speaker as /class/input/input1
bounce: queue ffff81013f522a88, setting pfn 1310720, max_low 1310720
q=ffff81013f522a88, dma_addr=140000000, bounce pfn 1310720
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ata3: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4003 85:3069 86:3c01 87:4003
88:203f
ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
bounce: queue ffff81013f5227f8, setting pfn 1310720, max_low 1310720
q=ffff81013f5227f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f5227f8, setting pfn 1048575, max_low 1310720
q=ffff81013f5227f8, dma_addr=ffffffff, bounce pfn 1048575
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 4
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 20, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 4
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 20, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 4
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 20, io base 0x0000e000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 4
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 20, io base 0x0000e400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:11.5 to 64
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 4
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 20, io mem 0xfae00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
sd 2:0:0:0: Attached scsi disk sda
Adding 1951856k swap on /dev/hda5.  Priority:-1 extents:1
across:1951856k
Adding 1951856k swap on /dev/hda6.  Priority:-2 extents:1
across:1951856k
Adding 1951856k swap on /dev/hda7.  Priority:-3 extents:1
across:1951856k
Adding 996020k swap on /dev/hdb2.  Priority:-4 extents:1 across:996020k
Adding 996020k swap on /dev/hdb3.  Priority:-5 extents:1 across:996020k
Adding 995988k swap on /dev/hdb5.  Priority:-6 extents:1 across:995988k
Adding 843372k swap on /dev/hdb6.  Priority:-7 extents:1 across:843372k
EXT3 FS on hda1, internal journal
ieee1394: Initialized config rom entry `ip1394'
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SGI XFS with ACLs, security attributes, realtime, large block/inode
numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hdb1
Ending clean XFS mount for filesystem: hdb1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
e100: intel: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
pnp: the driver 'parport_pc' has been registered
lp: driver loaded but no devices found
intel: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery
directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
mtrr: type mismatch for f0000000,8000000 old: write-back new:
write-combining
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small
hda: DMA table too small



-- 
Andy, BlueArc Engineering
