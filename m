Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWCAOkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWCAOkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWCAOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:40:21 -0500
Received: from mailgate.terastack.com ([195.173.195.66]:1803 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S932233AbWCAOkT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:40:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Wed, 1 Mar 2006 14:40:14 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393C12B@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY9PVUwujehn96KTgCOZI02qyvelgAADOCw
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>, "Andi Kleen" <ak@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>, "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try that patch in a minute and let you know the result.

With iommu=nomerge, I believe the problem's still there:

Bootdata ok (command line is iommu=nomerge root=/dev/hda1 ro )
Linux version 2.6.15-1-amd64-k8 (Debian 2.6.15-1) (luther@debian.org)
(gcc version 4.0.3 20060212 (prerelease) (Debian 4.0.2-9)) #2 Wed Mar 1
12:31:31 GMT 2006
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
Kernel command line: iommu=nomerge root=/dev/hda1 ro 
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
(lpj=2206455)
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
agpgart: AGP aperture is 128M @ 0xe8000000
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
audit(1141223603.378:1): initialized
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
bounce: queue ffff81013f957d18, setting pfn 1310720, max_low 1310720
q=ffff81013f957d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f957a88, setting pfn 1310720, max_low 1310720
q=ffff81013f957a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9577f8, setting pfn 1310720, max_low 1310720
q=ffff81013f9577f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f957568, setting pfn 1310720, max_low 1310720
q=ffff81013f957568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9572d8, setting pfn 1310720, max_low 1310720
q=ffff81013f9572d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f957048, setting pfn 1310720, max_low 1310720
q=ffff81013f957048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f983d18, setting pfn 1310720, max_low 1310720
q=ffff81013f983d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f983a88, setting pfn 1310720, max_low 1310720
q=ffff81013f983a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9837f8, setting pfn 1310720, max_low 1310720
q=ffff81013f9837f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f983568, setting pfn 1310720, max_low 1310720
q=ffff81013f983568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9832d8, setting pfn 1310720, max_low 1310720
q=ffff81013f9832d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f983048, setting pfn 1310720, max_low 1310720
q=ffff81013f983048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f977d18, setting pfn 1310720, max_low 1310720
q=ffff81013f977d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f977a88, setting pfn 1310720, max_low 1310720
q=ffff81013f977a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9777f8, setting pfn 1310720, max_low 1310720
q=ffff81013f9777f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f977568, setting pfn 1310720, max_low 1310720
q=ffff81013f977568, dma_addr=140000000, bounce pfn 1310720
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
bounce: queue ffff81013f9772d8, setting pfn 1310720, max_low 1310720
q=ffff81013f9772d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9772d8, setting pfn 1048575, max_low 1310720
q=ffff81013f9772d8, dma_addr=ffffffff, bounce pfn 1048575
bounce: queue ffff81013f977048, setting pfn 1310720, max_low 1310720
q=ffff81013f977048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f977048, setting pfn 1048575, max_low 1310720
q=ffff81013f977048, dma_addr=ffffffff, bounce pfn 1048575
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
bounce: queue ffff81013f540d18, setting pfn 1310720, max_low 1310720
q=ffff81013f540d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f540d18, setting pfn 1310720, max_low 1310720
q=ffff81013f540d18, dma_addr=140000000, bounce pfn 1310720
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
bounce: queue ffff81013f540a88, setting pfn 1310720, max_low 1310720
q=ffff81013f540a88, dma_addr=140000000, bounce pfn 1310720
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
SCSI subsystem initialized
input: PC Speaker as /class/input/input1
libata version 1.20 loaded.
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 2
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 18, io mem 0xfae00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 2
uhci_hcd 0000:00:10.0: UHCI Host Controller
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
skge 1.2 addr 0xfa900000 irq 19 chip Yukon-Lite rev 7
skge eth0: addr 00:11:2f:a7:fb:ef
sata_promise 0000:00:08.0: version 1.03
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 20
ata1: SATA max UDMA/133 cmd 0xFFFFC20000006200 ctl 0xFFFFC20000006238
bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0xFFFFC20000006280 ctl 0xFFFFC200000062B8
bmdma 0x0 irq 20
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 18, io base 0x0000d400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 2
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 18, io base 0x0000d800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 2
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 18, io base 0x0000e000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 2
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 18, io base 0x0000e400
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 20
e100: eth1: e100_probe: addr 0xfac00000, irq 20, MAC addr
00:D0:B7:BF:92:C8
ata3: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 17
ata4: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 17
ata3: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4003 85:3069 86:3c01 87:4003
88:203f
ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
bounce: queue ffff81013f5407f8, setting pfn 1310720, max_low 1310720
q=ffff81013f5407f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f5407f8, setting pfn 1048575, max_low 1310720
q=ffff81013f5407f8, dma_addr=ffffffff, bounce pfn 1048575
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:11.5 to 64
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
ide dma table, 256 entries, bounce pfn 1310720
sg0: dma=8be5000, dma_len=4096/0, pfn=1187929
sg1: dma=8be6000, dma_len=4096/0, pfn=1136193
sg2: dma=8be7000, dma_len=4096/0, pfn=1136235
sg3: dma=8be8000, dma_len=4096/0, pfn=1136277
sg4: dma=8be9000, dma_len=4096/0, pfn=1136319
sg5: dma=8bea000, dma_len=4096/0, pfn=1136361
sg6: dma=8beb000, dma_len=4096/0, pfn=1136403
sg7: dma=8bec000, dma_len=4096/0, pfn=1136445
sg8: dma=8bed000, dma_len=4096/0, pfn=1136486
sg9: dma=8bee000, dma_len=4096/0, pfn=1136528
sg10: dma=8bef000, dma_len=4096/0, pfn=1136570
sg11: dma=8bf0000, dma_len=4096/0, pfn=1136612
sg12: dma=8bf1000, dma_len=4096/0, pfn=1134607
sg13: dma=8bf2000, dma_len=4096/0, pfn=1134649
sg14: dma=8bf3000, dma_len=4096/0, pfn=1134691
sg15: dma=8bf4000, dma_len=4096/0, pfn=1134733
sg16: dma=8bf5000, dma_len=4096/0, pfn=1134775
sg17: dma=8bf6000, dma_len=4096/0, pfn=1134817
sg18: dma=8bf7000, dma_len=4096/0, pfn=1134859
sg19: dma=8bf8000, dma_len=4096/0, pfn=1134900
sg20: dma=8bf9000, dma_len=4096/0, pfn=1134942
sg21: dma=8bfa000, dma_len=4096/0, pfn=1134984
sg22: dma=8bfb000, dma_len=4096/0, pfn=1135026
sg23: dma=8bfc000, dma_len=4096/0, pfn=1135110
sg24: dma=8bfd000, dma_len=4096/0, pfn=1135152
sg25: dma=8bfe000, dma_len=4096/0, pfn=1135194
sg26: dma=8bff000, dma_len=4096/0, pfn=1135236
sg27: dma=8c00000, dma_len=4096/0, pfn=1135278
sg28: dma=8c01000, dma_len=4096/0, pfn=1135320
sg29: dma=8c02000, dma_len=4096/0, pfn=1135361
sg30: dma=8c03000, dma_len=4096/0, pfn=1135403
sg31: dma=8c04000, dma_len=4096/0, pfn=1135445
sg32: dma=8c05000, dma_len=4096/0, pfn=1135488
sg33: dma=8c06000, dma_len=4096/0, pfn=1135530
sg34: dma=8c07000, dma_len=4096/0, pfn=1135572
sg35: dma=8c08000, dma_len=4096/0, pfn=1135614
sg36: dma=8c09000, dma_len=4096/0, pfn=1133608
sg37: dma=8c0a000, dma_len=4096/0, pfn=1133650
sg38: dma=8c0b000, dma_len=4096/0, pfn=1133692
sg39: dma=8c0c000, dma_len=4096/0, pfn=1133734
sg40: dma=8c0d000, dma_len=4096/0, pfn=1133775
sg41: dma=8c0e000, dma_len=4096/0, pfn=1133817
sg42: dma=8c0f000, dma_len=4096/0, pfn=1133859
sg43: dma=8c10000, dma_len=4096/0, pfn=1133902
sg44: dma=8c11000, dma_len=4096/0, pfn=1133944
sg45: dma=8c12000, dma_len=4096/0, pfn=1133986
sg46: dma=8c13000, dma_len=4096/0, pfn=1134028
sg47: dma=8c14000, dma_len=4096/0, pfn=1134111
sg48: dma=8c15000, dma_len=4096/0, pfn=1134153
sg49: dma=8c16000, dma_len=4096/0, pfn=1134195
sg50: dma=8c17000, dma_len=4096/0, pfn=1134236
sg51: dma=8c18000, dma_len=4096/0, pfn=1134278
sg52: dma=8c19000, dma_len=4096/0, pfn=1134320
sg53: dma=8c1a000, dma_len=4096/0, pfn=1134363
sg54: dma=8c1b000, dma_len=4096/0, pfn=1134405
sg55: dma=8c1c000, dma_len=4096/0, pfn=1134447
sg56: dma=8c1d000, dma_len=4096/0, pfn=1134489
sg57: dma=8c1e000, dma_len=4096/0, pfn=1134531
sg58: dma=8c1f000, dma_len=4096/0, pfn=1134573
sg59: dma=8c20000, dma_len=4096/0, pfn=1132567
sg60: dma=8c21000, dma_len=4096/0, pfn=1132609
sg61: dma=8c22000, dma_len=4096/0, pfn=1132650
sg62: dma=8c23000, dma_len=4096/0, pfn=1132692
sg63: dma=8c24000, dma_len=4096/0, pfn=1132734
sg64: dma=8c25000, dma_len=4096/0, pfn=1132777
sg65: dma=8c26000, dma_len=4096/0, pfn=1132819
sg66: dma=8c27000, dma_len=4096/0, pfn=1132861
sg67: dma=8c28000, dma_len=4096/0, pfn=1132903
sg68: dma=8c29000, dma_len=4096/0, pfn=1132945
sg69: dma=8c2a000, dma_len=4096/0, pfn=1132987
sg70: dma=8c2b000, dma_len=4096/0, pfn=1133029
sg71: dma=8c2c000, dma_len=4096/0, pfn=1133071
sg72: dma=8c2d000, dma_len=4096/0, pfn=1133153
sg73: dma=8c2e000, dma_len=4096/0, pfn=1133195
sg74: dma=8c2f000, dma_len=4096/0, pfn=1133237
sg75: dma=8c30000, dma_len=4096/0, pfn=1133280
sg76: dma=8c31000, dma_len=4096/0, pfn=1133322
sg77: dma=8c32000, dma_len=4096/0, pfn=1133364
sg78: dma=8c33000, dma_len=4096/0, pfn=1133406
sg79: dma=8c34000, dma_len=4096/0, pfn=1133448
sg80: dma=8c35000, dma_len=4096/0, pfn=1133490
sg81: dma=8c36000, dma_len=4096/0, pfn=1133531
sg82: dma=8c37000, dma_len=4096/0, pfn=1131525
sg83: dma=8c38000, dma_len=4096/0, pfn=1131567
sg84: dma=8c39000, dma_len=4096/0, pfn=1131609
sg85: dma=8c3a000, dma_len=4096/0, pfn=1131651
sg86: dma=8c3b000, dma_len=4096/0, pfn=1131694
sg87: dma=8c3c000, dma_len=4096/0, pfn=1131736
sg88: dma=8c3d000, dma_len=4096/0, pfn=1131778
sg89: dma=8c3e000, dma_len=4096/0, pfn=1131820
sg90: dma=8c3f000, dma_len=4096/0, pfn=1131862
sg91: dma=8c40000, dma_len=4096/0, pfn=1131904
sg92: dma=8c41000, dma_len=4096/0, pfn=1131945
sg93: dma=8c42000, dma_len=4096/0, pfn=1131987
sg94: dma=8c43000, dma_len=4096/0, pfn=1132029
sg95: dma=8c44000, dma_len=4096/0, pfn=1132071
sg96: dma=8c45000, dma_len=4096/0, pfn=1132155
sg97: dma=8c46000, dma_len=4096/0, pfn=1132197
sg98: dma=8c47000, dma_len=4096/0, pfn=1132363
sg99: dma=8c48000, dma_len=4096/0, pfn=1132405
sg100: dma=8c49000, dma_len=4096/0, pfn=1132489
sg101: dma=8c4a000, dma_len=4096/0, pfn=1132530
sg102: dma=8c4b000, dma_len=4096/0, pfn=1130524
sg103: dma=8c4c000, dma_len=4096/0, pfn=1130566
sg104: dma=8c4d000, dma_len=4096/0, pfn=1130608
sg105: dma=8c4e000, dma_len=4096/0, pfn=1130651
sg106: dma=8c4f000, dma_len=4096/0, pfn=1130693
sg107: dma=8c50000, dma_len=4096/0, pfn=1130735
sg108: dma=8c51000, dma_len=4096/0, pfn=1130777
sg109: dma=8c52000, dma_len=4096/0, pfn=1130819
sg110: dma=8c53000, dma_len=4096/0, pfn=1130861
sg111: dma=8c54000, dma_len=4096/0, pfn=1130903
sg112: dma=8c55000, dma_len=4096/0, pfn=1130944
sg113: dma=8c56000, dma_len=4096/0, pfn=1130986
sg114: dma=8c57000, dma_len=4096/0, pfn=1131028
sg115: dma=8c58000, dma_len=4096/0, pfn=1131070
sg116: dma=8c59000, dma_len=4096/0, pfn=1131113
sg117: dma=8c5a000, dma_len=4096/0, pfn=1131155
sg118: dma=8c5b000, dma_len=4096/0, pfn=1131197
sg119: dma=8c5c000, dma_len=4096/0, pfn=1131239
sg120: dma=8c5d000, dma_len=4096/0, pfn=1131322
sg121: dma=8c5e000, dma_len=4096/0, pfn=1131364
sg122: dma=8c5f000, dma_len=4096/0, pfn=1131405
sg123: dma=8c60000, dma_len=4096/0, pfn=1131447
sg124: dma=8c61000, dma_len=4096/0, pfn=1131489
sg125: dma=8c62000, dma_len=4096/0, pfn=1129484
sg126: dma=8c63000, dma_len=4096/0, pfn=1129526
sg127: dma=8c64000, dma_len=4096/0, pfn=1129568
sg128: dma=8c65000, dma_len=4096/0, pfn=1129610
sg129: dma=8c66000, dma_len=4096/0, pfn=1129652
sg130: dma=8c67000, dma_len=4096/0, pfn=1129694
sg131: dma=8c68000, dma_len=4096/0, pfn=1129736
sg132: dma=8c69000, dma_len=4096/0, pfn=1129778
sg133: dma=8c6a000, dma_len=4096/0, pfn=1129819
sg134: dma=8c6b000, dma_len=4096/0, pfn=1129861
sg135: dma=8c6c000, dma_len=4096/0, pfn=1244022
sg136: dma=8c6d000, dma_len=4096/0, pfn=1129903
sg137: dma=8c6e000, dma_len=4096/0, pfn=1129946
sg138: dma=8c6f000, dma_len=4096/0, pfn=1129988
sg139: dma=8c70000, dma_len=4096/0, pfn=1130030
sg140: dma=8c71000, dma_len=4096/0, pfn=1130072
sg141: dma=8c72000, dma_len=4096/0, pfn=1130114
sg142: dma=8c73000, dma_len=4096/0, pfn=1130156
sg143: dma=8c74000, dma_len=4096/0, pfn=1130198
sg144: dma=8c75000, dma_len=4096/0, pfn=1130240
sg145: dma=8c76000, dma_len=4096/0, pfn=1130281
sg146: dma=8c77000, dma_len=4096/0, pfn=1130364
sg147: dma=8c78000, dma_len=4096/0, pfn=1130407
sg148: dma=8c79000, dma_len=4096/0, pfn=1130449
sg149: dma=8c7a000, dma_len=4096/0, pfn=1130491
sg150: dma=8c7b000, dma_len=4096/0, pfn=1128485
sg151: dma=8c7c000, dma_len=4096/0, pfn=1128527
sg152: dma=8c7d000, dma_len=4096/0, pfn=1128569
sg153: dma=8c7e000, dma_len=4096/0, pfn=1128611
sg154: dma=8c7f000, dma_len=4096/0, pfn=1128653
sg155: dma=8c80000, dma_len=4096/0, pfn=1128694
sg156: dma=8c81000, dma_len=4096/0, pfn=1128736
sg157: dma=8c82000, dma_len=4096/0, pfn=1128778
sg158: dma=8c83000, dma_len=4096/0, pfn=1128821
sg159: dma=8c84000, dma_len=4096/0, pfn=1128863
sg160: dma=8c85000, dma_len=4096/0, pfn=1128905
sg161: dma=8c86000, dma_len=4096/0, pfn=1128947
sg162: dma=8c87000, dma_len=4096/0, pfn=1128989
sg163: dma=8c88000, dma_len=4096/0, pfn=1129031
sg164: dma=8c89000, dma_len=4096/0, pfn=1129073
sg165: dma=8c8a000, dma_len=4096/0, pfn=1129115
sg166: dma=8c8b000, dma_len=4096/0, pfn=1129156
sg167: dma=8c8c000, dma_len=4096/0, pfn=1129198
sg168: dma=8c8d000, dma_len=4096/0, pfn=1129240
sg169: dma=8c8e000, dma_len=4096/0, pfn=1129283
sg170: dma=8c8f000, dma_len=4096/0, pfn=1129366
sg171: dma=8c90800, dma_len=4096/0, pfn=1129408
sg172: dma=8c91800, dma_len=4096/0, pfn=1129450
sg173: dma=8c99800, dma_len=4096/0, pfn=1127444
sg174: dma=8c9a800, dma_len=4096/0, pfn=1127486
sg175: dma=8c9b800, dma_len=4096/0, pfn=1127527
sg176: dma=8c9c800, dma_len=4096/0, pfn=1127569
sg177: dma=8c9d800, dma_len=4096/0, pfn=1127611
sg178: dma=8c9e800, dma_len=4096/0, pfn=1127653
sg179: dma=8c9f800, dma_len=4096/0, pfn=1127695
sg180: dma=8ca0800, dma_len=4096/0, pfn=1127738
sg181: dma=8ca1800, dma_len=4096/0, pfn=1127780
sg182: dma=8ca3800, dma_len=4096/0, pfn=1127822
sg183: dma=8ca4800, dma_len=4096/0, pfn=1127864
sg184: dma=8ca5800, dma_len=4096/0, pfn=1127906
sg185: dma=8ca6800, dma_len=4096/0, pfn=1127948
sg186: dma=8ca7800, dma_len=4096/0, pfn=1127989
sg187: dma=8ca8800, dma_len=4096/0, pfn=1128031
sg188: dma=8ca9800, dma_len=4096/0, pfn=1128073
sg189: dma=8caa800, dma_len=4096/0, pfn=1128240
sg190: dma=8cab800, dma_len=4096/0, pfn=1128282
sg191: dma=8cac800, dma_len=4096/0, pfn=1128324
sg192: dma=8cad800, dma_len=4096/0, pfn=1128366
sg193: dma=8cae800, dma_len=4096/0, pfn=1128408
sg194: dma=8caf800, dma_len=4096/0, pfn=1126402
sg195: dma=8cb0800, dma_len=4096/0, pfn=1126485
sg196: dma=8cb1800, dma_len=4096/0, pfn=1126526
sg197: dma=8cb2800, dma_len=4096/0, pfn=1126568
sg198: dma=8cb3800, dma_len=4096/0, pfn=1126610
sg199: dma=8cb4800, dma_len=4096/0, pfn=1126653
sg200: dma=8cb5800, dma_len=4096/0, pfn=1126695
sg201: dma=8cb6800, dma_len=4096/0, pfn=1126737
sg202: dma=8cb7800, dma_len=4096/0, pfn=1126779
sg203: dma=8cb9000, dma_len=4096/0, pfn=1126821
sg204: dma=8cba000, dma_len=4096/0, pfn=1126863
sg205: dma=8cbb000, dma_len=4096/0, pfn=1126905
sg206: dma=8cbc000, dma_len=4096/0, pfn=1126947
sg207: dma=8cbd000, dma_len=4096/0, pfn=1126988
sg208: dma=8cbe000, dma_len=4096/0, pfn=1127030
sg209: dma=8cbf000, dma_len=4096/0, pfn=1127072
sg210: dma=8cc0000, dma_len=4096/0, pfn=1127114
sg211: dma=8cc1000, dma_len=4096/0, pfn=1127157
sg212: dma=8cc2000, dma_len=4096/0, pfn=1127199
sg213: dma=8cc3000, dma_len=4096/0, pfn=1127241
sg214: dma=8cc4000, dma_len=4096/0, pfn=1127283
sg215: dma=8cc5000, dma_len=4096/0, pfn=1127325
sg216: dma=8cc6000, dma_len=4096/0, pfn=1127367
sg217: dma=8cc7000, dma_len=4096/0, pfn=1127409
sg218: dma=8cc8000, dma_len=4096/0, pfn=1125402
sg219: dma=8cc9000, dma_len=4096/0, pfn=1125444
sg220: dma=8cca000, dma_len=4096/0, pfn=1125528
sg221: dma=8ccb000, dma_len=4096/0, pfn=1125570
sg222: dma=8ccc000, dma_len=4096/0, pfn=1125612
sg223: dma=8ccd000, dma_len=4096/0, pfn=1125654
sg224: dma=8cce000, dma_len=4096/0, pfn=1125696
sg225: dma=8ccf000, dma_len=4096/0, pfn=1125738
sg226: dma=8cd0000, dma_len=4096/0, pfn=1125780
sg227: dma=8cd1000, dma_len=4096/0, pfn=1125822
sg228: dma=8cd2000, dma_len=4096/0, pfn=1125863
sg229: dma=8cd3000, dma_len=4096/0, pfn=1125905
sg230: dma=8cd4000, dma_len=4096/0, pfn=1125948
sg231: dma=8cd5000, dma_len=4096/0, pfn=1125990
sg232: dma=8cd6000, dma_len=4096/0, pfn=1126032
sg233: dma=8cd7000, dma_len=4096/0, pfn=1126074
sg234: dma=8cd8000, dma_len=4096/0, pfn=1126116
sg235: dma=8cd9000, dma_len=4096/0, pfn=1126158
sg236: dma=8cda000, dma_len=4096/0, pfn=1126200
sg237: dma=8cdb000, dma_len=4096/0, pfn=1126242
sg238: dma=8cdc000, dma_len=4096/0, pfn=1126284
sg239: dma=8cdd000, dma_len=4096/0, pfn=1126325
sg240: dma=8cde000, dma_len=4096/0, pfn=1126367
sg241: dma=8cdf000, dma_len=4096/0, pfn=1124361
sg242: dma=8ce0000, dma_len=4096/0, pfn=1124404
sg243: dma=8ce1000, dma_len=4096/0, pfn=1124446
sg244: dma=8ce2000, dma_len=4096/0, pfn=1124529
sg245: dma=8ce3000, dma_len=4096/0, pfn=1124571
sg246: dma=8ce4000, dma_len=4096/0, pfn=1124613
sg247: dma=8ce5000, dma_len=4096/0, pfn=1124655
sg248: dma=8ce6000, dma_len=4096/0, pfn=1124697
sg249: dma=8ce7000, dma_len=4096/0, pfn=1124738
sg250: dma=8ce8000, dma_len=4096/0, pfn=1124780
sg251: dma=8ce9000, dma_len=4096/0, pfn=1124822
sg252: dma=8cea000, dma_len=4096/0, pfn=1124865
sg253: dma=8ceb000, dma_len=4096/0, pfn=1124907
sg254: dma=8cec000, dma_len=4096/0, pfn=1124949
sg255: dma=8ced000, dma_len=4096/0, pfn=1124991
hda: DMA table too small
ide dma table, 256 entries, bounce pfn 1310720
sg0: dma=8cf0000, dma_len=4096/0, pfn=1125033
sg1: dma=8cf1000, dma_len=4096/0, pfn=1125075
sg2: dma=8cf2000, dma_len=4096/0, pfn=1125117
sg3: dma=8cf3000, dma_len=4096/0, pfn=1125159
sg4: dma=8cf4000, dma_len=4096/0, pfn=1125200
sg5: dma=8cf5000, dma_len=4096/0, pfn=1125242
sg6: dma=8cf6000, dma_len=4096/0, pfn=1125284
sg7: dma=8cf7000, dma_len=4096/0, pfn=1125327
sg8: dma=8cf8000, dma_len=4096/0, pfn=1125369
sg9: dma=8cf9000, dma_len=4096/0, pfn=1123363
sg10: dma=8cfa000, dma_len=4096/0, pfn=1123405
sg11: dma=8cfb000, dma_len=4096/0, pfn=1123447
sg12: dma=8cfc000, dma_len=4096/0, pfn=1123489
sg13: dma=8cfd000, dma_len=4096/0, pfn=1123571
sg14: dma=8cfe000, dma_len=4096/0, pfn=1123613
sg15: dma=8cff000, dma_len=4096/0, pfn=1123655
sg16: dma=8d00000, dma_len=4096/0, pfn=1123697
sg17: dma=8d01000, dma_len=4096/0, pfn=1123740
sg18: dma=8d02000, dma_len=4096/0, pfn=1123782
sg19: dma=8d03000, dma_len=4096/0, pfn=1123824
sg20: dma=8d04000, dma_len=4096/0, pfn=1123866
sg21: dma=8d05000, dma_len=4096/0, pfn=1123908
sg22: dma=8d06000, dma_len=4096/0, pfn=1123950
sg23: dma=8d07000, dma_len=4096/0, pfn=1123992
sg24: dma=8d08000, dma_len=4096/0, pfn=1124033
sg25: dma=8d09000, dma_len=4096/0, pfn=1124075
sg26: dma=8d0a000, dma_len=4096/0, pfn=1124117
sg27: dma=8d0b000, dma_len=4096/0, pfn=1124159
sg28: dma=8d0c000, dma_len=4096/0, pfn=1124202
sg29: dma=8d0d000, dma_len=4096/0, pfn=1124244
sg30: dma=8d0e000, dma_len=4096/0, pfn=1124286
sg31: dma=8d0f000, dma_len=4096/0, pfn=1124328
sg32: dma=8d10000, dma_len=4096/0, pfn=1122322
sg33: dma=8d11000, dma_len=4096/0, pfn=1122364
sg34: dma=8d12000, dma_len=4096/0, pfn=1122406
sg35: dma=8d13000, dma_len=4096/0, pfn=1122447
sg36: dma=8d14000, dma_len=4096/0, pfn=1122489
sg37: dma=8d15000, dma_len=4096/0, pfn=1122572
sg38: dma=8d16000, dma_len=4096/0, pfn=1122614
sg39: dma=8d17000, dma_len=4096/0, pfn=1122657
sg40: dma=8d18000, dma_len=4096/0, pfn=1122699
sg41: dma=8d19000, dma_len=4096/0, pfn=1122741
sg42: dma=8d1a000, dma_len=4096/0, pfn=1122783
sg43: dma=8d1b000, dma_len=4096/0, pfn=1122825
sg44: dma=8d1c000, dma_len=4096/0, pfn=1122867
sg45: dma=8d1d000, dma_len=4096/0, pfn=1122908
sg46: dma=8d1e000, dma_len=4096/0, pfn=1122950
sg47: dma=8d1f000, dma_len=4096/0, pfn=1122992
sg48: dma=8d20000, dma_len=4096/0, pfn=1123034
sg49: dma=8d21000, dma_len=4096/0, pfn=1123076
sg50: dma=8d22000, dma_len=4096/0, pfn=1123119
sg51: dma=8d23000, dma_len=4096/0, pfn=1123161
sg52: dma=8d24000, dma_len=4096/0, pfn=1123203
sg53: dma=8d25000, dma_len=4096/0, pfn=1123245
sg54: dma=8d26000, dma_len=4096/0, pfn=1123287
sg55: dma=8d27000, dma_len=4096/0, pfn=1121281
sg56: dma=8d28000, dma_len=4096/0, pfn=1121322
sg57: dma=8d29000, dma_len=4096/0, pfn=1121364
sg58: dma=8d2a000, dma_len=4096/0, pfn=1121406
sg59: dma=8d2b000, dma_len=4096/0, pfn=1121448
sg60: dma=8d2c000, dma_len=4096/0, pfn=1121490
sg61: dma=8d2d000, dma_len=4096/0, pfn=1121533
sg62: dma=8d2e000, dma_len=4096/0, pfn=1121616
sg63: dma=8d2f000, dma_len=4096/0, pfn=1121658
sg64: dma=8d30000, dma_len=4096/0, pfn=1121700
sg65: dma=8d31000, dma_len=4096/0, pfn=1121742
sg66: dma=8d32000, dma_len=4096/0, pfn=1121783
sg67: dma=8d33000, dma_len=4096/0, pfn=1121825
sg68: dma=8d34000, dma_len=4096/0, pfn=1121867
sg69: dma=8d35000, dma_len=4096/0, pfn=1122049
sg70: dma=8d36000, dma_len=4096/0, pfn=1122091
sg71: dma=8d37000, dma_len=4096/0, pfn=1122133
sg72: dma=8d38000, dma_len=4096/0, pfn=1122175
sg73: dma=8d39000, dma_len=4096/0, pfn=1122217
sg74: dma=8d3a000, dma_len=4096/0, pfn=1122259
sg75: dma=8d3b000, dma_len=4096/0, pfn=1122301
sg76: dma=8d3c000, dma_len=4096/0, pfn=1120295
sg77: dma=8d3d000, dma_len=4096/0, pfn=1120336
sg78: dma=8d3e000, dma_len=4096/0, pfn=1120378
sg79: dma=8d3f000, dma_len=4096/0, pfn=1120421
sg80: dma=8d40000, dma_len=4096/0, pfn=1120463
sg81: dma=8d41000, dma_len=4096/0, pfn=1120505
sg82: dma=8d42000, dma_len=4096/0, pfn=1120547
sg83: dma=8d43000, dma_len=4096/0, pfn=1120589
sg84: dma=8d46800, dma_len=4096/0, pfn=1120631
sg85: dma=8d47800, dma_len=4096/0, pfn=1120673
sg86: dma=8d48800, dma_len=4096/0, pfn=1120715
sg87: dma=8d49800, dma_len=4096/0, pfn=1120797
sg88: dma=8d4a800, dma_len=4096/0, pfn=1120839
sg89: dma=8d4b800, dma_len=4096/0, pfn=1120881
sg90: dma=8d4c800, dma_len=4096/0, pfn=1120924
sg91: dma=8d4d800, dma_len=4096/0, pfn=1120966
sg92: dma=8d4e800, dma_len=4096/0, pfn=1121008
sg93: dma=8d4f800, dma_len=4096/0, pfn=1121050
sg94: dma=8d50800, dma_len=4096/0, pfn=1121092
sg95: dma=8d51800, dma_len=4096/0, pfn=1121134
sg96: dma=8d52800, dma_len=4096/0, pfn=1121176
sg97: dma=8d53800, dma_len=4096/0, pfn=1121218
sg98: dma=8d54800, dma_len=4096/0, pfn=1121259
sg99: dma=8d55800, dma_len=4096/0, pfn=1119253
sg100: dma=8d56800, dma_len=4096/0, pfn=1119295
sg101: dma=8d57800, dma_len=4096/0, pfn=1119338
sg102: dma=8d58800, dma_len=4096/0, pfn=1119380
sg103: dma=8d59800, dma_len=4096/0, pfn=1119422
sg104: dma=8d5a800, dma_len=4096/0, pfn=1119464
sg105: dma=8d5b800, dma_len=4096/0, pfn=1119506
sg106: dma=8d5c800, dma_len=4096/0, pfn=1119548
sg107: dma=8d5d800, dma_len=4096/0, pfn=1119590
sg108: dma=8d5e800, dma_len=4096/0, pfn=1119632
sg109: dma=8d5f800, dma_len=4096/0, pfn=1119673
sg110: dma=8d60800, dma_len=4096/0, pfn=1119715
sg111: dma=8d61800, dma_len=4096/0, pfn=1119799
sg112: dma=8d62800, dma_len=4096/0, pfn=1119841
sg113: dma=8d63800, dma_len=4096/0, pfn=1119883
sg114: dma=8d64800, dma_len=4096/0, pfn=1119925
sg115: dma=8d65800, dma_len=4096/0, pfn=1119967
sg116: dma=8d66800, dma_len=4096/0, pfn=1120009
sg117: dma=8d67800, dma_len=4096/0, pfn=1120051
sg118: dma=8d68800, dma_len=4096/0, pfn=1120092
sg119: dma=8d69800, dma_len=4096/0, pfn=1120134
sg120: dma=8d6a800, dma_len=4096/0, pfn=1120176
sg121: dma=8d6b800, dma_len=4096/0, pfn=1120218
sg122: dma=8d6c800, dma_len=4096/0, pfn=1118213
sg123: dma=8d6d800, dma_len=4096/0, pfn=1118255
sg124: dma=8d6e800, dma_len=4096/0, pfn=1118297
sg125: dma=8d6f800, dma_len=4096/0, pfn=1118339
sg126: dma=8d70800, dma_len=4096/0, pfn=1118381
sg127: dma=8d71800, dma_len=4096/0, pfn=1118423
sg128: dma=8d72800, dma_len=4096/0, pfn=1118465
sg129: dma=8d73800, dma_len=4096/0, pfn=1118506
sg130: dma=8d74800, dma_len=4096/0, pfn=1118548
sg131: dma=8d75800, dma_len=4096/0, pfn=1118590
sg132: dma=8d76800, dma_len=4096/0, pfn=1118632
sg133: dma=8d77800, dma_len=4096/0, pfn=1118675
sg134: dma=8d79000, dma_len=4096/0, pfn=1118717
sg135: dma=8d7a000, dma_len=4096/0, pfn=1118759
sg136: dma=8d7b000, dma_len=4096/0, pfn=1118842
sg137: dma=8d7c000, dma_len=4096/0, pfn=1118884
sg138: dma=8d7d000, dma_len=4096/0, pfn=1118926
sg139: dma=8d7e000, dma_len=4096/0, pfn=1118967
sg140: dma=8d7f000, dma_len=4096/0, pfn=1119009
sg141: dma=8d80000, dma_len=4096/0, pfn=1119051
sg142: dma=8d81000, dma_len=4096/0, pfn=1119093
sg143: dma=8d82000, dma_len=4096/0, pfn=1119135
sg144: dma=8d83000, dma_len=4096/0, pfn=1119178
sg145: dma=8d84000, dma_len=4096/0, pfn=1119220
sg146: dma=8d85000, dma_len=4096/0, pfn=1117214
sg147: dma=8d86000, dma_len=4096/0, pfn=1117256
sg148: dma=8d87000, dma_len=4096/0, pfn=1117298
sg149: dma=8d88000, dma_len=4096/0, pfn=1117340
sg150: dma=8d89000, dma_len=4096/0, pfn=1117381
sg151: dma=8d8a000, dma_len=4096/0, pfn=1117423
sg152: dma=8d8b000, dma_len=4096/0, pfn=1117465
sg153: dma=8d8c000, dma_len=4096/0, pfn=1117507
sg154: dma=8d8d000, dma_len=4096/0, pfn=1117549
sg155: dma=8d8e000, dma_len=4096/0, pfn=1117592
sg156: dma=8d8f000, dma_len=4096/0, pfn=1117634
sg157: dma=8d90000, dma_len=4096/0, pfn=1117676
sg158: dma=8d91000, dma_len=4096/0, pfn=1117842
sg159: dma=8d92000, dma_len=4096/0, pfn=1117884
sg160: dma=8d93000, dma_len=4096/0, pfn=1117926
sg161: dma=8d94000, dma_len=4096/0, pfn=1118008
sg162: dma=8d95000, dma_len=4096/0, pfn=1118051
sg163: dma=8d96000, dma_len=4096/0, pfn=1118093
sg164: dma=8d97000, dma_len=4096/0, pfn=1118135
sg165: dma=8d98000, dma_len=4096/0, pfn=1118177
sg166: dma=8d99000, dma_len=4096/0, pfn=1116171
sg167: dma=8d9a000, dma_len=4096/0, pfn=1116213
sg168: dma=8d9b000, dma_len=4096/0, pfn=1116255
sg169: dma=8d9c000, dma_len=4096/0, pfn=1116297
sg170: dma=8d9d000, dma_len=4096/0, pfn=1116339
sg171: dma=8d9e000, dma_len=4096/0, pfn=1116380
sg172: dma=8d9f000, dma_len=4096/0, pfn=1116422
sg173: dma=8da0000, dma_len=4096/0, pfn=1116465
sg174: dma=8da1000, dma_len=4096/0, pfn=1116507
sg175: dma=8da2000, dma_len=4096/0, pfn=1116549
sg176: dma=8da3000, dma_len=4096/0, pfn=1116591
sg177: dma=8da4000, dma_len=4096/0, pfn=1116633
sg178: dma=8da5000, dma_len=4096/0, pfn=1116675
sg179: dma=8da6000, dma_len=4096/0, pfn=1116717
sg180: dma=8da7000, dma_len=4096/0, pfn=1116759
sg181: dma=8da8000, dma_len=4096/0, pfn=1116801
sg182: dma=8da9000, dma_len=4096/0, pfn=1116842
sg183: dma=8daa000, dma_len=4096/0, pfn=1116884
sg184: dma=8dab000, dma_len=4096/0, pfn=1116927
sg185: dma=8dac000, dma_len=4096/0, pfn=1117010
sg186: dma=8dad000, dma_len=4096/0, pfn=1117052
sg187: dma=8dae000, dma_len=4096/0, pfn=1117094
sg188: dma=8daf000, dma_len=4096/0, pfn=1117136
sg189: dma=8db0000, dma_len=4096/0, pfn=1117178
sg190: dma=8db1000, dma_len=4096/0, pfn=1115172
sg191: dma=8db2000, dma_len=4096/0, pfn=1115214
sg192: dma=8db3000, dma_len=4096/0, pfn=1115255
sg193: dma=8db4000, dma_len=4096/0, pfn=1115297
sg194: dma=8db5000, dma_len=4096/0, pfn=1115340
sg195: dma=8db6000, dma_len=4096/0, pfn=1115382
sg196: dma=8db7000, dma_len=4096/0, pfn=1115424
sg197: dma=8db8000, dma_len=4096/0, pfn=1115466
sg198: dma=8db9000, dma_len=4096/0, pfn=1115508
sg199: dma=8dba000, dma_len=4096/0, pfn=1115550
sg200: dma=8dbb000, dma_len=4096/0, pfn=1115592
sg201: dma=8dbc000, dma_len=4096/0, pfn=1115634
sg202: dma=8dbd000, dma_len=4096/0, pfn=1115676
sg203: dma=8dbe000, dma_len=4096/0, pfn=1115717
sg204: dma=8dbf000, dma_len=4096/0, pfn=1115759
sg205: dma=8dc0000, dma_len=4096/0, pfn=1115801
sg206: dma=8dc1000, dma_len=4096/0, pfn=1115844
sg207: dma=8dc2000, dma_len=4096/0, pfn=1115886
sg208: dma=8dc3000, dma_len=4096/0, pfn=1115970
sg209: dma=8dc4000, dma_len=4096/0, pfn=1116053
sg210: dma=8dc5000, dma_len=4096/0, pfn=1116095
sg211: dma=8dc6000, dma_len=4096/0, pfn=1116136
sg212: dma=8dc7000, dma_len=4096/0, pfn=1114130
sg213: dma=8dc8000, dma_len=4096/0, pfn=1114172
sg214: dma=8dc9000, dma_len=4096/0, pfn=1114214
sg215: dma=8dca000, dma_len=4096/0, pfn=1114257
sg216: dma=8dcb000, dma_len=4096/0, pfn=1114299
sg217: dma=8dcc000, dma_len=4096/0, pfn=1114341
sg218: dma=8dcd000, dma_len=4096/0, pfn=1114383
sg219: dma=8dce000, dma_len=4096/0, pfn=1114425
sg220: dma=8dcf000, dma_len=4096/0, pfn=1114467
sg221: dma=8dd0000, dma_len=4096/0, pfn=1114509
sg222: dma=8dd1000, dma_len=4096/0, pfn=1114550
sg223: dma=8dd2000, dma_len=4096/0, pfn=1114592
sg224: dma=8dd3000, dma_len=4096/0, pfn=1114634
sg225: dma=8dd4000, dma_len=4096/0, pfn=1114676
sg226: dma=8dd5000, dma_len=4096/0, pfn=1114719
sg227: dma=8dd6000, dma_len=4096/0, pfn=1114761
sg228: dma=8dd7000, dma_len=4096/0, pfn=1114803
sg229: dma=8dd8000, dma_len=4096/0, pfn=1114845
sg230: dma=8dd9000, dma_len=4096/0, pfn=1114887
sg231: dma=8dda000, dma_len=4096/0, pfn=1114929
sg232: dma=8ddb000, dma_len=4096/0, pfn=1114971
sg233: dma=8ddc000, dma_len=4096/0, pfn=1115053
sg234: dma=8ddd000, dma_len=4096/0, pfn=1115095
sg235: dma=8dde000, dma_len=4096/0, pfn=1113089
sg236: dma=8ddf000, dma_len=4096/0, pfn=1113132
sg237: dma=8de0000, dma_len=4096/0, pfn=1113174
sg238: dma=8de1000, dma_len=4096/0, pfn=1113216
sg239: dma=8de2000, dma_len=4096/0, pfn=1113258
sg240: dma=8de3000, dma_len=4096/0, pfn=1113300
sg241: dma=8de4000, dma_len=4096/0, pfn=1113342
sg242: dma=8de5000, dma_len=4096/0, pfn=1113384
sg243: dma=8de6000, dma_len=4096/0, pfn=1113425
sg244: dma=8de7000, dma_len=4096/0, pfn=1113467
sg245: dma=8de8000, dma_len=4096/0, pfn=1113509
sg246: dma=8de9000, dma_len=4096/0, pfn=1113551
sg247: dma=8dea000, dma_len=4096/0, pfn=1113594
sg248: dma=8deb000, dma_len=4096/0, pfn=1113636
sg249: dma=8dec000, dma_len=4096/0, pfn=1113678
sg250: dma=8ded000, dma_len=4096/0, pfn=1113720
sg251: dma=8dee000, dma_len=4096/0, pfn=1113762
sg252: dma=8def000, dma_len=4096/0, pfn=1113846
sg253: dma=8df0000, dma_len=4096/0, pfn=1113887
sg254: dma=8df1000, dma_len=4096/0, pfn=1113929
sg255: dma=8df2000, dma_len=4096/0, pfn=1113971

-- 
Andy, BlueArc Engineering
