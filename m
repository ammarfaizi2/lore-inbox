Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWCANeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWCANeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWCANeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:34:09 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:57868 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1750787AbWCANeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:34:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Wed, 1 Mar 2006 13:34:02 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393C104@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY9K1lKWRhlPpaVSZKLMhc2XdbbQgACBXnA
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>, "Andi Kleen" <ak@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>, "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with revised patch that does:

                printk("sg%d: dma=%llx, dma_len=%u/%u, pfn=%lu\n", i,
(unsigned long long) sg->dma_address, sg->dma_length, sg->offset,
page_to_pfn(sg->page));
        }

dmesg says:


Bootdata ok (command line is root=/dev/hda1 ro )
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
Kernel command line: root=/dev/hda1 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2202.918 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x5c39000 - 0x9c39000
Memory: 4045192k/5242880k available (1703k kernel code, 148148k
reserved, 738k data, 148k init)
Calibrating delay using timer specific routine.. 4412.88 BogoMIPS
(lpj=2206443)
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
audit(1141219505.378:1): initialized
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
bounce: queue ffff81013f97ad18, setting pfn 1310720, max_low 1310720
q=ffff81013f97ad18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97aa88, setting pfn 1310720, max_low 1310720
q=ffff81013f97aa88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a7f8, setting pfn 1310720, max_low 1310720
q=ffff81013f97a7f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a568, setting pfn 1310720, max_low 1310720
q=ffff81013f97a568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a2d8, setting pfn 1310720, max_low 1310720
q=ffff81013f97a2d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a048, setting pfn 1310720, max_low 1310720
q=ffff81013f97a048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980d18, setting pfn 1310720, max_low 1310720
q=ffff81013f980d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980a88, setting pfn 1310720, max_low 1310720
q=ffff81013f980a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9807f8, setting pfn 1310720, max_low 1310720
q=ffff81013f9807f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980568, setting pfn 1310720, max_low 1310720
q=ffff81013f980568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9802d8, setting pfn 1310720, max_low 1310720
q=ffff81013f9802d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980048, setting pfn 1310720, max_low 1310720
q=ffff81013f980048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa40d18, setting pfn 1310720, max_low 1310720
q=ffff81013fa40d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa40a88, setting pfn 1310720, max_low 1310720
q=ffff81013fa40a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa407f8, setting pfn 1310720, max_low 1310720
q=ffff81013fa407f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa40568, setting pfn 1310720, max_low 1310720
q=ffff81013fa40568, dma_addr=140000000, bounce pfn 1310720
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
input: AT Translated Set 2 keyboard as /class/input/input0
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
hda: HDS722525VLAT80, ATA DISK drive
hdb: Maxtor 6Y200P0, ATA DISK drive
bounce: queue ffff81013fa402d8, setting pfn 1310720, max_low 1310720
q=ffff81013fa402d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa402d8, setting pfn 1048575, max_low 1310720
q=ffff81013fa402d8, dma_addr=ffffffff, bounce pfn 1048575
bounce: queue ffff81013fa40048, setting pfn 1310720, max_low 1310720
q=ffff81013fa40048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa40048, setting pfn 1048575, max_low 1310720
q=ffff81013fa40048, dma_addr=ffffffff, bounce pfn 1048575
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
bounce: queue ffff81013f53fd18, setting pfn 1310720, max_low 1310720
q=ffff81013f53fd18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f53fd18, setting pfn 1310720, max_low 1310720
q=ffff81013f53fd18, dma_addr=140000000, bounce pfn 1310720
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
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
SCSI subsystem initialized
USB Universal Host Controller Interface driver v2.3
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 2
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 18, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 19
e100: eth0: e100_probe: addr 0xfac00000, irq 19, MAC addr
00:D0:B7:BF:92:C8
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 20
skge 1.2 addr 0xfa900000 irq 20 chip Yukon-Lite rev 7
skge eth1: addr 00:11:2f:a7:fb:ef
libata version 1.20 loaded.
input: PC Speaker as /class/input/input1
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 2
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 18, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
bounce: queue ffff81013f53fa88, setting pfn 1310720, max_low 1310720
q=ffff81013f53fa88, dma_addr=140000000, bounce pfn 1310720
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 17
ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 17
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 2
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 18, io base 0x0000e000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
sata_promise 0000:00:08.0: version 1.03
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 19
ata3: SATA max UDMA/133 cmd 0xFFFFC20000006200 ctl 0xFFFFC20000006238
bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xFFFFC20000006280 ctl 0xFFFFC200000062B8
bmdma 0x0 irq 19
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 2
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 18, io base 0x0000e400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 2
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 18, io mem 0xfae00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
ata1: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4003 85:3069 86:3c01 87:4003
88:203f
ata1: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
bounce: queue ffff81013f53f7f8, setting pfn 1310720, max_low 1310720
q=ffff81013f53f7f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f53f7f8, setting pfn 1048575, max_low 1310720
q=ffff81013f53f7f8, dma_addr=ffffffff, bounce pfn 1048575
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:11.5 to 64
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
sd 0:0:0:0: Attached scsi disk sda
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
ide dma table, 255 entries, bounce pfn 1310720
sg0: dma=81c8800, dma_len=4096/0, pfn=1296369
sg1: dma=81c9800, dma_len=4096/0, pfn=1292696
sg2: dma=81ca800, dma_len=4096/0, pfn=1296278
sg3: dma=81cb800, dma_len=4096/0, pfn=1296092
sg4: dma=81cc800, dma_len=4096/0, pfn=1296090
sg5: dma=81cd800, dma_len=4096/0, pfn=1296088
sg6: dma=81ce800, dma_len=4096/0, pfn=1296086
sg7: dma=81cf800, dma_len=4096/0, pfn=1296083
sg8: dma=81d0800, dma_len=4096/0, pfn=1296081
sg9: dma=81d1800, dma_len=4096/0, pfn=1292712
sg10: dma=81d2800, dma_len=4096/0, pfn=1297008
sg11: dma=81d3800, dma_len=4096/0, pfn=1297063
sg12: dma=81d4800, dma_len=4096/0, pfn=1297146
sg13: dma=81d5800, dma_len=4096/0, pfn=1297193
sg14: dma=81d6800, dma_len=4096/0, pfn=1297198
sg15: dma=81d7800, dma_len=4096/0, pfn=1296363
sg16: dma=81d8800, dma_len=4096/0, pfn=1304021
sg17: dma=81d9800, dma_len=4096/0, pfn=1303030
sg18: dma=81da800, dma_len=4096/0, pfn=1302151
sg19: dma=81db800, dma_len=4096/0, pfn=1303979
sg20: dma=81dc800, dma_len=4096/0, pfn=1306158
sg21: dma=81dd800, dma_len=4096/0, pfn=1304015
sg22: dma=81de800, dma_len=4096/0, pfn=1304957
sg23: dma=81df800, dma_len=4096/0, pfn=1304001
sg24: dma=81e0800, dma_len=4096/0, pfn=1292710
sg25: dma=81e1800, dma_len=4096/0, pfn=1304035
sg26: dma=81e2800, dma_len=4096/0, pfn=1303025
sg27: dma=81e3800, dma_len=4096/0, pfn=1304019
sg28: dma=81e4800, dma_len=4096/0, pfn=1302256
sg29: dma=81e5800, dma_len=4096/0, pfn=1304738
sg30: dma=81e6800, dma_len=4096/0, pfn=1302998
sg31: dma=81e7800, dma_len=4096/0, pfn=1304148
sg32: dma=81e8800, dma_len=4096/0, pfn=1304126
sg33: dma=81e9800, dma_len=4096/0, pfn=1303079
sg34: dma=81ea800, dma_len=4096/0, pfn=1302996
sg35: dma=81eb800, dma_len=4096/0, pfn=1296243
sg36: dma=81ec800, dma_len=4096/0, pfn=1306396
sg37: dma=81ed800, dma_len=4096/0, pfn=1306474
sg38: dma=81ee800, dma_len=4096/0, pfn=1295929
sg39: dma=81ef800, dma_len=4096/0, pfn=1296156
sg40: dma=81f0800, dma_len=4096/0, pfn=1049000
sg41: dma=81f1800, dma_len=4096/0, pfn=1306293
sg42: dma=81f2800, dma_len=4096/0, pfn=1306289
sg43: dma=81f3800, dma_len=4096/0, pfn=1306368
sg44: dma=81f4800, dma_len=4096/0, pfn=1306326
sg45: dma=81f5800, dma_len=4096/0, pfn=1306388
sg46: dma=81f6800, dma_len=4096/0, pfn=1306265
sg47: dma=81f7800, dma_len=4096/0, pfn=1308137
sg48: dma=81f9000, dma_len=4096/0, pfn=1306294
sg49: dma=81fa000, dma_len=4096/0, pfn=1306130
sg50: dma=81fb000, dma_len=4096/0, pfn=1306422
sg51: dma=81fc000, dma_len=4096/0, pfn=1306151
sg52: dma=81fd000, dma_len=4096/0, pfn=1306262
sg53: dma=81fe000, dma_len=4096/0, pfn=1306617
sg54: dma=81ff000, dma_len=4096/0, pfn=1306492
sg55: dma=8200000, dma_len=4096/0, pfn=1305974
sg56: dma=8201000, dma_len=4096/0, pfn=1306509
sg57: dma=8202000, dma_len=4096/0, pfn=1306162
sg58: dma=8203000, dma_len=4096/0, pfn=1306281
sg59: dma=8204000, dma_len=4096/0, pfn=1306485
sg60: dma=8205000, dma_len=4096/0, pfn=1306024
sg61: dma=8206000, dma_len=4096/0, pfn=1307943
sg62: dma=8207000, dma_len=4096/0, pfn=1092022
sg63: dma=8208000, dma_len=4096/0, pfn=1092024
sg64: dma=8209000, dma_len=4096/0, pfn=1305950
sg65: dma=820a800, dma_len=4096/0, pfn=1295655
sg66: dma=820b800, dma_len=4096/0, pfn=1295788
sg67: dma=820c800, dma_len=4096/0, pfn=1296106
sg68: dma=820d800, dma_len=4096/0, pfn=1296102
sg69: dma=820e800, dma_len=4096/0, pfn=1296126
sg70: dma=820f800, dma_len=4096/0, pfn=1296041
sg71: dma=8210800, dma_len=4096/0, pfn=1296099
sg72: dma=8211800, dma_len=4096/0, pfn=1296076
sg73: dma=8212800, dma_len=4096/0, pfn=1296069
sg74: dma=8213800, dma_len=4096/0, pfn=1296066
sg75: dma=8214800, dma_len=4096/0, pfn=1296064
sg76: dma=8215800, dma_len=4096/0, pfn=1296049
sg77: dma=8216800, dma_len=4096/0, pfn=1296045
sg78: dma=8217800, dma_len=4096/0, pfn=1295926
sg79: dma=8218800, dma_len=4096/0, pfn=1306031
sg80: dma=8219800, dma_len=4096/0, pfn=1305911
sg81: dma=821a800, dma_len=4096/0, pfn=1306239
sg82: dma=821b800, dma_len=4096/0, pfn=1306117
sg83: dma=821c800, dma_len=4096/0, pfn=1307944
sg84: dma=821d800, dma_len=4096/0, pfn=1306097
sg85: dma=821e800, dma_len=4096/0, pfn=1306225
sg86: dma=821f800, dma_len=4096/0, pfn=1306220
sg87: dma=8220800, dma_len=4096/0, pfn=1306244
sg88: dma=8221800, dma_len=4096/0, pfn=1306186
sg89: dma=8222800, dma_len=4096/0, pfn=1306109
sg90: dma=8223800, dma_len=4096/0, pfn=1306210
sg91: dma=8224800, dma_len=4096/0, pfn=1306227
sg92: dma=8225800, dma_len=4096/0, pfn=1306049
sg93: dma=8226800, dma_len=4096/0, pfn=1306250
sg94: dma=8227800, dma_len=4096/0, pfn=1306249
sg95: dma=8228800, dma_len=4096/0, pfn=1306061
sg96: dma=8229800, dma_len=4096/0, pfn=1306080
sg97: dma=822a800, dma_len=4096/0, pfn=1306046
sg98: dma=822b800, dma_len=4096/0, pfn=1306207
sg99: dma=822c800, dma_len=4096/0, pfn=1295699
sg100: dma=822d800, dma_len=4096/0, pfn=1301756
sg101: dma=822e800, dma_len=4096/0, pfn=1301005
sg102: dma=822f800, dma_len=4096/0, pfn=1301059
sg103: dma=8230800, dma_len=4096/0, pfn=1299674
sg104: dma=8231800, dma_len=4096/0, pfn=1298741
sg105: dma=8232800, dma_len=4096/0, pfn=1297470
sg106: dma=8233800, dma_len=4096/0, pfn=1297855
sg107: dma=8234800, dma_len=4096/0, pfn=1297742
sg108: dma=8235800, dma_len=4096/0, pfn=1297728
sg109: dma=8236800, dma_len=4096/0, pfn=1303749
sg110: dma=8237800, dma_len=4096/0, pfn=1303866
sg111: dma=8239000, dma_len=4096/0, pfn=1302678
sg112: dma=823a000, dma_len=4096/0, pfn=1303323
sg113: dma=823b000, dma_len=4096/0, pfn=1299255
sg114: dma=823c000, dma_len=4096/0, pfn=1299252
sg115: dma=823d000, dma_len=4096/0, pfn=1298794
sg116: dma=823e000, dma_len=4096/0, pfn=1297988
sg117: dma=823f000, dma_len=4096/0, pfn=1297829
sg118: dma=8240000, dma_len=4096/0, pfn=1297460
sg119: dma=8241000, dma_len=4096/0, pfn=1297420
sg120: dma=8242000, dma_len=4096/0, pfn=1297654
sg121: dma=8243000, dma_len=4096/0, pfn=1301800
sg122: dma=8244000, dma_len=4096/0, pfn=1305171
sg123: dma=8245000, dma_len=4096/0, pfn=1303818
sg124: dma=8246000, dma_len=4096/0, pfn=1305201
sg125: dma=8247000, dma_len=4096/0, pfn=1298803
sg126: dma=8248000, dma_len=4096/0, pfn=1297746
sg127: dma=8249000, dma_len=4096/0, pfn=1297955
sg128: dma=824a000, dma_len=4096/0, pfn=1297510
sg129: dma=824b000, dma_len=4096/0, pfn=1297605
sg130: dma=824c000, dma_len=4096/0, pfn=1297414
sg131: dma=824d000, dma_len=4096/0, pfn=1297413
sg132: dma=824e000, dma_len=4096/0, pfn=1299048
sg133: dma=824f000, dma_len=4096/0, pfn=1299046
sg134: dma=8250000, dma_len=4096/0, pfn=1295697
sg135: dma=8251000, dma_len=4096/0, pfn=1295660
sg136: dma=8252000, dma_len=4096/0, pfn=1295714
sg137: dma=8253000, dma_len=4096/0, pfn=1295630
sg138: dma=8254000, dma_len=4096/0, pfn=1295628
sg139: dma=8255000, dma_len=4096/0, pfn=1295601
sg140: dma=8256000, dma_len=4096/0, pfn=1295590
sg141: dma=8257000, dma_len=4096/0, pfn=1295627
sg142: dma=8258000, dma_len=4096/0, pfn=1295498
sg143: dma=8259000, dma_len=4096/0, pfn=1295472
sg144: dma=825a000, dma_len=4096/0, pfn=1295437
sg145: dma=825b000, dma_len=4096/0, pfn=1295430
sg146: dma=825c000, dma_len=4096/0, pfn=1295413
sg147: dma=825d000, dma_len=4096/0, pfn=1299813
sg148: dma=825e000, dma_len=4096/0, pfn=1303770
sg149: dma=825f000, dma_len=4096/0, pfn=1300498
sg150: dma=8260000, dma_len=4096/0, pfn=1298184
sg151: dma=8261000, dma_len=4096/0, pfn=1309734
sg152: dma=8262000, dma_len=4096/0, pfn=1297857
sg153: dma=8263000, dma_len=4096/0, pfn=1302887
sg154: dma=8264000, dma_len=4096/0, pfn=1297520
sg155: dma=8265000, dma_len=4096/0, pfn=1298978
sg156: dma=8266000, dma_len=4096/0, pfn=1297431
sg157: dma=8267000, dma_len=4096/0, pfn=1298597
sg158: dma=8268000, dma_len=4096/0, pfn=1298997
sg159: dma=8269000, dma_len=4096/0, pfn=1298984
sg160: dma=826a000, dma_len=4096/0, pfn=1298832
sg161: dma=826b000, dma_len=4096/0, pfn=1308002
sg162: dma=826c000, dma_len=4096/0, pfn=1309552
sg163: dma=826d000, dma_len=4096/0, pfn=1307906
sg164: dma=826e000, dma_len=4096/0, pfn=1308001
sg165: dma=826f000, dma_len=8192/0, pfn=1309559
sg166: dma=8271000, dma_len=4096/0, pfn=1307941
sg167: dma=8272000, dma_len=4096/0, pfn=1307936
sg168: dma=8273000, dma_len=4096/0, pfn=1307935
sg169: dma=8274000, dma_len=4096/0, pfn=1307932
sg170: dma=8275000, dma_len=4096/0, pfn=1307982
sg171: dma=8276000, dma_len=4096/0, pfn=1307985
sg172: dma=8277000, dma_len=4096/0, pfn=1307999
sg173: dma=8278000, dma_len=4096/0, pfn=1297616
sg174: dma=8279000, dma_len=4096/0, pfn=1307993
sg175: dma=827a000, dma_len=4096/0, pfn=1307920
sg176: dma=827b000, dma_len=4096/0, pfn=1297609
sg177: dma=827c000, dma_len=4096/0, pfn=1297546
sg178: dma=827d000, dma_len=4096/0, pfn=1297443
sg179: dma=827e000, dma_len=4096/0, pfn=1297434
sg180: dma=827f000, dma_len=4096/0, pfn=1297429
sg181: dma=8280000, dma_len=4096/0, pfn=1297517
sg182: dma=8281000, dma_len=4096/0, pfn=1297454
sg183: dma=8282000, dma_len=4096/0, pfn=1299366
sg184: dma=8283000, dma_len=4096/0, pfn=1298890
sg185: dma=8284000, dma_len=4096/0, pfn=1299087
sg186: dma=8285000, dma_len=4096/0, pfn=1299536
sg187: dma=8286000, dma_len=4096/0, pfn=1053055
sg188: dma=8287000, dma_len=4096/0, pfn=1303002
sg189: dma=8288000, dma_len=4096/0, pfn=1301953
sg190: dma=8289000, dma_len=4096/0, pfn=1305063
sg191: dma=828a000, dma_len=4096/0, pfn=1306067
sg192: dma=828b000, dma_len=4096/0, pfn=1306001
sg193: dma=828c000, dma_len=4096/0, pfn=1300866
sg194: dma=828d000, dma_len=4096/0, pfn=1304415
sg195: dma=828e000, dma_len=4096/0, pfn=1302426
sg196: dma=828f000, dma_len=4096/0, pfn=1306090
sg197: dma=8290000, dma_len=4096/0, pfn=1300504
sg198: dma=8291000, dma_len=4096/0, pfn=1301579
sg199: dma=8292000, dma_len=4096/0, pfn=1305087
sg200: dma=8293000, dma_len=4096/0, pfn=1303295
sg201: dma=8294800, dma_len=4096/0, pfn=1300662
sg202: dma=8295800, dma_len=4096/0, pfn=1305119
sg203: dma=8296800, dma_len=4096/0, pfn=1303824
sg204: dma=8297800, dma_len=4096/0, pfn=1301163
sg205: dma=8298800, dma_len=4096/0, pfn=1051200
sg206: dma=8299800, dma_len=4096/0, pfn=1302977
sg207: dma=829a800, dma_len=4096/0, pfn=1299597
sg208: dma=829b800, dma_len=4096/0, pfn=1299592
sg209: dma=829c800, dma_len=4096/0, pfn=1299588
sg210: dma=829d800, dma_len=4096/0, pfn=1299624
sg211: dma=829e800, dma_len=4096/0, pfn=1299622
sg212: dma=829f800, dma_len=4096/0, pfn=1299621
sg213: dma=82a0800, dma_len=4096/0, pfn=1299619
sg214: dma=82a1800, dma_len=4096/0, pfn=1299553
sg215: dma=82a2800, dma_len=4096/0, pfn=1299551
sg216: dma=82a3800, dma_len=4096/0, pfn=1299549
sg217: dma=82a4800, dma_len=4096/0, pfn=1299603
sg218: dma=82a5800, dma_len=4096/0, pfn=1299600
sg219: dma=82a6800, dma_len=4096/0, pfn=1299542
sg220: dma=82a7800, dma_len=4096/0, pfn=1299540
sg221: dma=82a8800, dma_len=4096/0, pfn=1299568
sg222: dma=82a9800, dma_len=4096/0, pfn=1299567
sg223: dma=82aa800, dma_len=4096/0, pfn=1299559
sg224: dma=82ab800, dma_len=4096/0, pfn=1299557
sg225: dma=82ac800, dma_len=4096/0, pfn=1299555
sg226: dma=82ad800, dma_len=4096/0, pfn=1299533
sg227: dma=82ae800, dma_len=4096/0, pfn=1299530
sg228: dma=82af800, dma_len=4096/0, pfn=1299529
sg229: dma=82b0800, dma_len=4096/0, pfn=1299506
sg230: dma=82b1800, dma_len=4096/0, pfn=1301402
sg231: dma=82b2800, dma_len=4096/0, pfn=1301400
sg232: dma=82b3800, dma_len=4096/0, pfn=1301399
sg233: dma=82b4800, dma_len=4096/0, pfn=1299483
sg234: dma=82b5800, dma_len=4096/0, pfn=1301199
sg235: dma=82b6800, dma_len=4096/0, pfn=1301195
sg236: dma=82b7800, dma_len=4096/0, pfn=1301192
sg237: dma=82b9000, dma_len=4096/0, pfn=1301185
sg238: dma=82ba000, dma_len=4096/0, pfn=1301183
sg239: dma=82bb000, dma_len=4096/0, pfn=1301181
sg240: dma=82bc000, dma_len=4096/0, pfn=1301179
sg241: dma=82bd000, dma_len=4096/0, pfn=1301170
sg242: dma=82be000, dma_len=4096/0, pfn=1301166
sg243: dma=82bf000, dma_len=4096/0, pfn=1301164
sg244: dma=82c0000, dma_len=4096/0, pfn=1301357
sg245: dma=82c1000, dma_len=4096/0, pfn=1301354
sg246: dma=82c2000, dma_len=4096/0, pfn=1301340
sg247: dma=82c3000, dma_len=4096/0, pfn=1301124
sg248: dma=82c4000, dma_len=4096/0, pfn=1301122
sg249: dma=82c5000, dma_len=4096/0, pfn=1301115
sg250: dma=82c6000, dma_len=4096/0, pfn=1301200
sg251: dma=82c7000, dma_len=4096/0, pfn=1301494
sg252: dma=82c8000, dma_len=4096/0, pfn=1301157
sg253: dma=82c9000, dma_len=4096/0, pfn=1301152
sg254: dma=82ca000, dma_len=4096/0, pfn=1301149
hda: DMA table too small
ide dma table, 256 entries, bounce pfn 1310720
sg0: dma=5eb9800, dma_len=4096/0, pfn=1301146
sg1: dma=5eba800, dma_len=4096/0, pfn=1301144
sg2: dma=5ebb800, dma_len=4096/0, pfn=1301142
sg3: dma=5ebc800, dma_len=4096/0, pfn=1050242
sg4: dma=5ebd800, dma_len=4096/0, pfn=1076172
sg5: dma=5ebe800, dma_len=4096/0, pfn=1166945
sg6: dma=5ebf800, dma_len=4096/0, pfn=1053986
sg7: dma=5ec0800, dma_len=4096/0, pfn=1076177
sg8: dma=5ec1800, dma_len=4096/0, pfn=1076160
sg9: dma=5ec2800, dma_len=4096/0, pfn=1050254
sg10: dma=5ec3800, dma_len=4096/0, pfn=1162365
sg11: dma=5ec4800, dma_len=4096/0, pfn=1187516
sg12: dma=5ec5800, dma_len=4096/0, pfn=1164204
sg13: dma=5ec6800, dma_len=4096/0, pfn=1187223
sg14: dma=5ec7800, dma_len=4096/0, pfn=1303806
sg15: dma=5ec8800, dma_len=4096/0, pfn=1301784
sg16: dma=5ec9800, dma_len=4096/0, pfn=1303498
sg17: dma=5eca800, dma_len=4096/0, pfn=1302341
sg18: dma=5ecb800, dma_len=4096/0, pfn=1302365
sg19: dma=5ecc800, dma_len=4096/0, pfn=1304767
sg20: dma=5ecd800, dma_len=4096/0, pfn=1304761
sg21: dma=5ece800, dma_len=4096/0, pfn=1304693
sg22: dma=5ecf800, dma_len=4096/0, pfn=1304652
sg23: dma=5ed0800, dma_len=4096/0, pfn=1302210
sg24: dma=5ed1800, dma_len=4096/0, pfn=1305430
sg25: dma=5ed2800, dma_len=4096/0, pfn=1305429
sg26: dma=5ed3800, dma_len=4096/0, pfn=1306135
sg27: dma=5ed4800, dma_len=4096/0, pfn=1306166
sg28: dma=5ed5800, dma_len=4096/0, pfn=1306172
sg29: dma=5ed6800, dma_len=4096/0, pfn=1306298
sg30: dma=5ed7800, dma_len=4096/0, pfn=1306269
sg31: dma=5ed8800, dma_len=4096/0, pfn=1306153
sg32: dma=5ed9800, dma_len=4096/0, pfn=1309539
sg33: dma=5eda800, dma_len=4096/0, pfn=1308279
sg34: dma=5edb800, dma_len=4096/0, pfn=1308277
sg35: dma=5edc800, dma_len=4096/0, pfn=1308271
sg36: dma=5edd800, dma_len=4096/0, pfn=1308269
sg37: dma=5ede800, dma_len=4096/0, pfn=1305665
sg38: dma=5edf800, dma_len=4096/0, pfn=1305651
sg39: dma=5ee0800, dma_len=4096/0, pfn=1305642
sg40: dma=5ee1800, dma_len=4096/0, pfn=1306319
sg41: dma=5ee2800, dma_len=4096/0, pfn=1306316
sg42: dma=5ee3800, dma_len=4096/0, pfn=1309525
sg43: dma=5ee4800, dma_len=4096/0, pfn=1308249
sg44: dma=5ee5800, dma_len=4096/0, pfn=1307949
sg45: dma=5ee6800, dma_len=4096/0, pfn=1308552
sg46: dma=5ee7800, dma_len=4096/0, pfn=1308306
sg47: dma=5ee8800, dma_len=4096/0, pfn=1308305
sg48: dma=5ee9800, dma_len=4096/0, pfn=1306228
sg49: dma=5eea800, dma_len=4096/0, pfn=1306214
sg50: dma=5eeb800, dma_len=4096/0, pfn=1163699
sg51: dma=5eec800, dma_len=4096/0, pfn=1065378
sg52: dma=5eed800, dma_len=4096/0, pfn=1165443
sg53: dma=5eee800, dma_len=4096/0, pfn=1167113
sg54: dma=5eef800, dma_len=4096/0, pfn=1167071
sg55: dma=5ef0800, dma_len=4096/0, pfn=1167029
sg56: dma=5ef1800, dma_len=4096/0, pfn=1166987
sg57: dma=5ef2800, dma_len=4096/0, pfn=1166903
sg58: dma=5ef3800, dma_len=4096/0, pfn=1167156
sg59: dma=5ef4800, dma_len=4096/0, pfn=1163909
sg60: dma=5ef5800, dma_len=4096/0, pfn=1180298
sg61: dma=5ef6800, dma_len=4096/0, pfn=1167323
sg62: dma=5ef7800, dma_len=4096/0, pfn=1167281
sg63: dma=5ef9000, dma_len=4096/0, pfn=1167239
sg64: dma=5efa000, dma_len=4096/0, pfn=1167197
sg65: dma=5efb000, dma_len=4096/0, pfn=1166241
sg66: dma=5efc000, dma_len=4096/0, pfn=1166073
sg67: dma=5efd000, dma_len=4096/0, pfn=1166032
sg68: dma=5efe000, dma_len=4096/0, pfn=1165989
sg69: dma=5eff000, dma_len=4096/0, pfn=1165947
sg70: dma=5f00000, dma_len=4096/0, pfn=1165905
sg71: dma=5f01000, dma_len=4096/0, pfn=1165863
sg72: dma=5f02000, dma_len=4096/0, pfn=1166115
sg73: dma=5f03000, dma_len=4096/0, pfn=1165611
sg74: dma=5f04000, dma_len=4096/0, pfn=1165779
sg75: dma=5f05000, dma_len=4096/0, pfn=1165527
sg76: dma=5f06000, dma_len=4096/0, pfn=1165401
sg77: dma=5f07000, dma_len=4096/0, pfn=1165359
sg78: dma=5f08000, dma_len=4096/0, pfn=1165317
sg79: dma=5f09000, dma_len=4096/0, pfn=1165075
sg80: dma=5f0a000, dma_len=4096/0, pfn=1164739
sg81: dma=5f0b000, dma_len=4096/0, pfn=1164697
sg82: dma=5f0c000, dma_len=4096/0, pfn=1163489
sg83: dma=5f0d000, dma_len=4096/0, pfn=1163447
sg84: dma=5f0e000, dma_len=4096/0, pfn=1053983
sg85: dma=5f0f000, dma_len=4096/0, pfn=1163405
sg86: dma=5f10000, dma_len=4096/0, pfn=1163321
sg87: dma=5f11000, dma_len=4096/0, pfn=1163279
sg88: dma=5f12000, dma_len=4096/0, pfn=1165285
sg89: dma=5f13000, dma_len=4096/0, pfn=1165243
sg90: dma=5f14000, dma_len=4096/0, pfn=1165201
sg91: dma=5f15000, dma_len=4096/0, pfn=1165159
sg92: dma=5f16000, dma_len=4096/0, pfn=1165117
sg93: dma=5f17000, dma_len=4096/0, pfn=1163363
sg94: dma=5f18000, dma_len=4096/0, pfn=1165033
sg95: dma=5f19000, dma_len=4096/0, pfn=1164991
sg96: dma=5f1a000, dma_len=4096/0, pfn=1053992
sg97: dma=5f1b000, dma_len=4096/0, pfn=1053990
sg98: dma=5f1c000, dma_len=4096/0, pfn=1053989
sg99: dma=5f1d000, dma_len=4096/0, pfn=1163867
sg100: dma=5f1e800, dma_len=4096/0, pfn=1163825
sg101: dma=5f1f800, dma_len=4096/0, pfn=1163784
sg102: dma=5f20800, dma_len=4096/0, pfn=1163742
sg103: dma=5f21800, dma_len=4096/0, pfn=1163657
sg104: dma=5f22800, dma_len=4096/0, pfn=1055857
sg105: dma=5f23800, dma_len=4096/0, pfn=1163615
sg106: dma=5f24800, dma_len=4096/0, pfn=1060720
sg107: dma=5f25800, dma_len=4096/0, pfn=1055849
sg108: dma=5f26800, dma_len=4096/0, pfn=1192414
sg109: dma=5f27800, dma_len=4096/0, pfn=1076188
sg110: dma=5f28800, dma_len=4096/0, pfn=1063537
sg111: dma=5f29800, dma_len=4096/0, pfn=1051198
sg112: dma=5f2a800, dma_len=4096/0, pfn=1179509
sg113: dma=5f2b800, dma_len=4096/0, pfn=1179551
sg114: dma=5f2c800, dma_len=4096/0, pfn=1179593
sg115: dma=5f2d800, dma_len=4096/0, pfn=1179635
sg116: dma=5f2e800, dma_len=4096/0, pfn=1177630
sg117: dma=5f2f800, dma_len=4096/0, pfn=1177672
sg118: dma=5f30800, dma_len=4096/0, pfn=1177713
sg119: dma=5f31800, dma_len=4096/0, pfn=1177755
sg120: dma=5f32800, dma_len=4096/0, pfn=1177797
sg121: dma=5f33800, dma_len=4096/0, pfn=1177839
sg122: dma=5f34800, dma_len=4096/0, pfn=1177881
sg123: dma=5f35800, dma_len=4096/0, pfn=1177923
sg124: dma=5f36800, dma_len=4096/0, pfn=1177965
sg125: dma=5f37800, dma_len=4096/0, pfn=1178007
sg126: dma=5f39000, dma_len=4096/0, pfn=1178879
sg127: dma=5f3a000, dma_len=4096/0, pfn=1178921
sg128: dma=5f3b000, dma_len=4096/0, pfn=1178963
sg129: dma=5f3c000, dma_len=4096/0, pfn=1179005
sg130: dma=5f3d000, dma_len=4096/0, pfn=1179047
sg131: dma=5f3e000, dma_len=4096/0, pfn=1179089
sg132: dma=5f3f000, dma_len=4096/0, pfn=1179131
sg133: dma=5f40000, dma_len=4096/0, pfn=1125733
sg134: dma=5f41000, dma_len=4096/0, pfn=1073305
sg135: dma=5f42000, dma_len=4096/0, pfn=1126002
sg136: dma=5f43000, dma_len=4096/0, pfn=1051194
sg137: dma=5f44000, dma_len=4096/0, pfn=1076158
sg138: dma=5f45000, dma_len=4096/0, pfn=1052126
sg139: dma=5f46000, dma_len=4096/0, pfn=1052142
sg140: dma=5f47000, dma_len=4096/0, pfn=1052114
sg141: dma=5f48000, dma_len=4096/0, pfn=1053074
sg142: dma=5f49000, dma_len=4096/0, pfn=1165821
sg143: dma=5f4a000, dma_len=4096/0, pfn=1165570
sg144: dma=5f4b000, dma_len=4096/0, pfn=1163573
sg145: dma=5f4c000, dma_len=4096/0, pfn=1182545
sg146: dma=5f4d000, dma_len=4096/0, pfn=1179216
sg147: dma=5f4e000, dma_len=4096/0, pfn=1179667
sg148: dma=5f4f000, dma_len=4096/0, pfn=1179709
sg149: dma=5f50000, dma_len=4096/0, pfn=1179751
sg150: dma=5f51000, dma_len=4096/0, pfn=1179793
sg151: dma=5f52000, dma_len=4096/0, pfn=1179836
sg152: dma=5f53000, dma_len=4096/0, pfn=1179878
sg153: dma=5f54000, dma_len=4096/0, pfn=1179920
sg154: dma=5f55000, dma_len=4096/0, pfn=1179961
sg155: dma=5f56000, dma_len=4096/0, pfn=1181295
sg156: dma=5f57000, dma_len=4096/0, pfn=1181337
sg157: dma=5f58000, dma_len=4096/0, pfn=1181379
sg158: dma=5f59000, dma_len=4096/0, pfn=1181422
sg159: dma=5f5a000, dma_len=4096/0, pfn=1182713
sg160: dma=5f5b000, dma_len=4096/0, pfn=1180707
sg161: dma=5f5c000, dma_len=4096/0, pfn=1180749
sg162: dma=5f5d000, dma_len=4096/0, pfn=1180791
sg163: dma=5f5e000, dma_len=4096/0, pfn=1180833
sg164: dma=5f5f000, dma_len=4096/0, pfn=1180875
sg165: dma=5f60000, dma_len=4096/0, pfn=1180917
sg166: dma=5f61000, dma_len=4096/0, pfn=1180959
sg167: dma=5f62000, dma_len=4096/0, pfn=1181001
sg168: dma=5f63000, dma_len=4096/0, pfn=1181043
sg169: dma=5f64000, dma_len=4096/0, pfn=1181084
sg170: dma=5f65000, dma_len=4096/0, pfn=1181169
sg171: dma=5f66000, dma_len=4096/0, pfn=1181211
sg172: dma=5f67000, dma_len=4096/0, pfn=1181253
sg173: dma=5f68000, dma_len=4096/0, pfn=1182041
sg174: dma=5f69000, dma_len=4096/0, pfn=1182125
sg175: dma=5f6a000, dma_len=4096/0, pfn=1182167
sg176: dma=5f6b000, dma_len=4096/0, pfn=1182208
sg177: dma=5f6c000, dma_len=4096/0, pfn=1182251
sg178: dma=5f6d000, dma_len=4096/0, pfn=1183417
sg179: dma=5f6e000, dma_len=4096/0, pfn=1183459
sg180: dma=5f6f000, dma_len=4096/0, pfn=1183501
sg181: dma=5f70000, dma_len=4096/0, pfn=1183543
sg182: dma=5f71000, dma_len=4096/0, pfn=1183585
sg183: dma=5f72000, dma_len=4096/0, pfn=1183627
sg184: dma=5f73000, dma_len=4096/0, pfn=1183669
sg185: dma=5f74000, dma_len=4096/0, pfn=1183711
sg186: dma=5f75000, dma_len=4096/0, pfn=1181705
sg187: dma=5f76000, dma_len=4096/0, pfn=1181746
sg188: dma=5f77000, dma_len=4096/0, pfn=1181788
sg189: dma=5f78000, dma_len=4096/0, pfn=1181831
sg190: dma=5f79000, dma_len=4096/0, pfn=1184751
sg191: dma=5f7a000, dma_len=4096/0, pfn=1182745
sg192: dma=5f7b000, dma_len=4096/0, pfn=1182787
sg193: dma=5f7c000, dma_len=4096/0, pfn=1182829
sg194: dma=5f7d000, dma_len=4096/0, pfn=1182870
sg195: dma=5f7e000, dma_len=4096/0, pfn=1182912
sg196: dma=5f7f000, dma_len=4096/0, pfn=1182954
sg197: dma=5f80000, dma_len=4096/0, pfn=1182996
sg198: dma=5f81000, dma_len=4096/0, pfn=1183039
sg199: dma=5f82000, dma_len=4096/0, pfn=1183123
sg200: dma=5f83000, dma_len=4096/0, pfn=1183165
sg201: dma=5f84000, dma_len=4096/0, pfn=1183207
sg202: dma=5f85000, dma_len=4096/0, pfn=1183249
sg203: dma=5f86000, dma_len=4096/0, pfn=1183291
sg204: dma=5f87000, dma_len=4096/0, pfn=1184540
sg205: dma=5f88000, dma_len=4096/0, pfn=1184583
sg206: dma=5f89000, dma_len=4096/0, pfn=1184625
sg207: dma=5f8a000, dma_len=4096/0, pfn=1184709
sg208: dma=5f8b000, dma_len=4096/0, pfn=1183911
sg209: dma=5f8c000, dma_len=4096/0, pfn=1183953
sg210: dma=5f8d000, dma_len=4096/0, pfn=1183994
sg211: dma=5f8e000, dma_len=4096/0, pfn=1184078
sg212: dma=5f8f000, dma_len=4096/0, pfn=1184121
sg213: dma=5f90000, dma_len=4096/0, pfn=1184163
sg214: dma=5f91000, dma_len=4096/0, pfn=1184205
sg215: dma=5f92000, dma_len=4096/0, pfn=1184247
sg216: dma=5f93000, dma_len=4096/0, pfn=1184289
sg217: dma=5f94000, dma_len=4096/0, pfn=1184331
sg218: dma=5f95000, dma_len=4096/0, pfn=1184373
sg219: dma=5f96000, dma_len=4096/0, pfn=1184415
sg220: dma=5f97000, dma_len=4096/0, pfn=1184456
sg221: dma=5f98000, dma_len=4096/0, pfn=1184498
sg222: dma=5f99000, dma_len=4096/0, pfn=1286724
sg223: dma=5f9a000, dma_len=4096/0, pfn=1306057
sg224: dma=5f9b000, dma_len=4096/0, pfn=1185622
sg225: dma=5f9c000, dma_len=4096/0, pfn=1185664
sg226: dma=5f9d000, dma_len=4096/0, pfn=1185706
sg227: dma=5f9e000, dma_len=4096/0, pfn=1185748
sg228: dma=5f9f000, dma_len=4096/0, pfn=1185791
sg229: dma=5fa0000, dma_len=4096/0, pfn=1183785
sg230: dma=5fa1000, dma_len=4096/0, pfn=1183827
sg231: dma=5fa2000, dma_len=4096/0, pfn=1183869
sg232: dma=5fa3000, dma_len=4096/0, pfn=1051207
sg233: dma=5fa4000, dma_len=4096/0, pfn=1051203
sg234: dma=5fa5000, dma_len=4096/0, pfn=1076162
sg235: dma=5fa6000, dma_len=4096/0, pfn=1051193
sg236: dma=5fa7000, dma_len=4096/0, pfn=1173889
sg237: dma=5fa8000, dma_len=4096/0, pfn=1099379
sg238: dma=5fa9000, dma_len=4096/0, pfn=1163993
sg239: dma=5faa000, dma_len=4096/0, pfn=1176011
sg240: dma=5fab000, dma_len=4096/0, pfn=1178385
sg241: dma=5fac000, dma_len=4096/0, pfn=1180507
sg242: dma=5fad000, dma_len=4096/0, pfn=1059777
sg243: dma=5fae000, dma_len=4096/0, pfn=1061654
sg244: dma=5faf000, dma_len=4096/0, pfn=1056810
sg245: dma=5fb0000, dma_len=4096/0, pfn=1056781
sg246: dma=5fb1000, dma_len=4096/0, pfn=1059789
sg247: dma=5fb2000, dma_len=4096/0, pfn=1056775
sg248: dma=5fb3000, dma_len=4096/0, pfn=1075857
sg249: dma=5fb4000, dma_len=4096/0, pfn=1060733
sg250: dma=5fb5000, dma_len=4096/0, pfn=1075865
sg251: dma=5fb6000, dma_len=4096/0, pfn=1060734
sg252: dma=5fb7000, dma_len=4096/0, pfn=1075860
sg253: dma=5fb8000, dma_len=4096/0, pfn=1059763
sg254: dma=5fb9000, dma_len=4096/0, pfn=1174141
sg255: dma=5fba000, dma_len=4096/0, pfn=1174183
hda: DMA table too small
ide dma table, 256 entries, bounce pfn 1310720
sg0: dma=7512800, dma_len=4096/0, pfn=1091699
sg1: dma=7513800, dma_len=4096/0, pfn=1091675
sg2: dma=7514800, dma_len=4096/0, pfn=1110989
sg3: dma=7515800, dma_len=4096/0, pfn=1094723
sg4: dma=7516800, dma_len=4096/0, pfn=1128625
sg5: dma=7517800, dma_len=4096/0, pfn=1074769
sg6: dma=7518800, dma_len=4096/0, pfn=1061548
sg7: dma=7519800, dma_len=4096/0, pfn=1139995
sg8: dma=751a800, dma_len=4096/0, pfn=1091152
sg9: dma=751b800, dma_len=4096/0, pfn=1093315
sg10: dma=751c800, dma_len=4096/0, pfn=1086382
sg11: dma=751d800, dma_len=4096/0, pfn=1161577
sg12: dma=751e800, dma_len=4096/0, pfn=1162533
sg13: dma=751f800, dma_len=4096/0, pfn=1164161
sg14: dma=7520800, dma_len=4096/0, pfn=1125619
sg15: dma=7521800, dma_len=4096/0, pfn=1075073
sg16: dma=7522800, dma_len=4096/0, pfn=1074842
sg17: dma=7523800, dma_len=4096/0, pfn=1074880
sg18: dma=7524800, dma_len=4096/0, pfn=1135167
sg19: dma=7525800, dma_len=4096/0, pfn=1154790
sg20: dma=7526800, dma_len=4096/0, pfn=1164732
sg21: dma=7527800, dma_len=4096/0, pfn=1094056
sg22: dma=7528800, dma_len=4096/0, pfn=1168951
sg23: dma=7529800, dma_len=4096/0, pfn=1053264
sg24: dma=752a800, dma_len=4096/0, pfn=1049613
sg25: dma=752b800, dma_len=4096/0, pfn=1133339
sg26: dma=752c800, dma_len=4096/0, pfn=1132213
sg27: dma=752d800, dma_len=4096/0, pfn=1127468
sg28: dma=752e800, dma_len=4096/0, pfn=1127678
sg29: dma=752f800, dma_len=4096/0, pfn=1127803
sg30: dma=7530800, dma_len=4096/0, pfn=1143981
sg31: dma=7531800, dma_len=4096/0, pfn=1143026
sg32: dma=7532800, dma_len=4096/0, pfn=1142028
sg33: dma=7533800, dma_len=4096/0, pfn=1140117
sg34: dma=7534800, dma_len=4096/0, pfn=1137910
sg35: dma=7535800, dma_len=4096/0, pfn=1072277
sg36: dma=7536800, dma_len=4096/0, pfn=1129800
sg37: dma=7537800, dma_len=4096/0, pfn=1143864
sg38: dma=7539000, dma_len=4096/0, pfn=1136460
sg39: dma=753a000, dma_len=4096/0, pfn=1138666
sg40: dma=753b000, dma_len=4096/0, pfn=1135042
sg41: dma=753c000, dma_len=4096/0, pfn=1129631
sg42: dma=753d000, dma_len=4096/0, pfn=1129547
sg43: dma=753e000, dma_len=4096/0, pfn=1163576
sg44: dma=753f000, dma_len=4096/0, pfn=1109168
sg45: dma=7540000, dma_len=4096/0, pfn=1124431
sg46: dma=7541000, dma_len=4096/0, pfn=1127569
sg47: dma=7542000, dma_len=4096/0, pfn=1127728
sg48: dma=7543000, dma_len=4096/0, pfn=1124079
sg49: dma=7544000, dma_len=4096/0, pfn=1183318
sg50: dma=7545000, dma_len=4096/0, pfn=1166001
sg51: dma=7546000, dma_len=4096/0, pfn=1166019
sg52: dma=7547000, dma_len=4096/0, pfn=1166000
sg53: dma=7548000, dma_len=4096/0, pfn=1161066
sg54: dma=7549000, dma_len=4096/0, pfn=1065267
sg55: dma=754a000, dma_len=4096/0, pfn=1161488
sg56: dma=754b000, dma_len=4096/0, pfn=1160949
sg57: dma=754c000, dma_len=4096/0, pfn=1158399
sg58: dma=754d000, dma_len=4096/0, pfn=1139304
sg59: dma=754e000, dma_len=4096/0, pfn=1210905
sg60: dma=754f000, dma_len=4096/0, pfn=1061814
sg61: dma=7550000, dma_len=4096/0, pfn=1124273
sg62: dma=7551000, dma_len=4096/0, pfn=1139293
sg63: dma=7552000, dma_len=4096/0, pfn=1253082
sg64: dma=7553000, dma_len=4096/0, pfn=1120775
sg65: dma=7554000, dma_len=4096/0, pfn=1295660
sg66: dma=7555000, dma_len=4096/0, pfn=1278386
sg67: dma=7556000, dma_len=4096/0, pfn=1195092
sg68: dma=7557000, dma_len=4096/0, pfn=1180605
sg69: dma=7558000, dma_len=4096/0, pfn=1295714
sg70: dma=7559000, dma_len=4096/0, pfn=1303818
sg71: dma=755a000, dma_len=4096/0, pfn=1301800
sg72: dma=755b000, dma_len=4096/0, pfn=1305171
sg73: dma=755c000, dma_len=4096/0, pfn=1297654
sg74: dma=755d000, dma_len=4096/0, pfn=1295697
sg75: dma=755e000, dma_len=4096/0, pfn=1085326
sg76: dma=755f000, dma_len=4096/0, pfn=1210199
sg77: dma=7560000, dma_len=4096/0, pfn=1253083
sg78: dma=7561000, dma_len=4096/0, pfn=1075475
sg79: dma=7562000, dma_len=4096/0, pfn=1077515
sg80: dma=7563000, dma_len=4096/0, pfn=1077566
sg81: dma=7564000, dma_len=4096/0, pfn=1064739
sg82: dma=7565000, dma_len=4096/0, pfn=1064552
sg83: dma=7566000, dma_len=4096/0, pfn=1139305
sg84: dma=7567000, dma_len=4096/0, pfn=1139308
sg85: dma=7568000, dma_len=4096/0, pfn=1139063
sg86: dma=7569000, dma_len=4096/0, pfn=1124894
sg87: dma=756a000, dma_len=4096/0, pfn=1163500
sg88: dma=756b000, dma_len=4096/0, pfn=1151353
sg89: dma=756c000, dma_len=4096/0, pfn=1238691
sg90: dma=756d000, dma_len=4096/0, pfn=1064586
sg91: dma=756e000, dma_len=4096/0, pfn=1302882
sg92: dma=756f000, dma_len=4096/0, pfn=1305872
sg93: dma=7570000, dma_len=4096/0, pfn=1302818
sg94: dma=7571000, dma_len=4096/0, pfn=1306451
sg95: dma=7572000, dma_len=4096/0, pfn=1303196
sg96: dma=7573000, dma_len=4096/0, pfn=1300495
sg97: dma=7574000, dma_len=4096/0, pfn=1300505
sg98: dma=7575000, dma_len=4096/0, pfn=1301942
sg99: dma=7576000, dma_len=4096/0, pfn=1302371
sg100: dma=7577000, dma_len=4096/0, pfn=1302423
sg101: dma=7578000, dma_len=4096/0, pfn=1302943
sg102: dma=7579000, dma_len=4096/0, pfn=1227562
sg103: dma=757a000, dma_len=4096/0, pfn=1226351
sg104: dma=757b000, dma_len=4096/0, pfn=1302150
sg105: dma=757c000, dma_len=4096/0, pfn=1302146
sg106: dma=757d000, dma_len=4096/0, pfn=1302145
sg107: dma=757e000, dma_len=4096/0, pfn=1303473
sg108: dma=757f000, dma_len=4096/0, pfn=1302360
sg109: dma=7580000, dma_len=4096/0, pfn=1303481
sg110: dma=7581000, dma_len=4096/0, pfn=1303485
sg111: dma=7582000, dma_len=4096/0, pfn=1302000
sg112: dma=7583000, dma_len=4096/0, pfn=1302285
sg113: dma=7584000, dma_len=4096/0, pfn=1302605
sg114: dma=7585000, dma_len=4096/0, pfn=1302602
sg115: dma=7586000, dma_len=4096/0, pfn=1288276
sg116: dma=7587000, dma_len=4096/0, pfn=1199147
sg117: dma=7588000, dma_len=4096/0, pfn=1291163
sg118: dma=7589000, dma_len=4096/0, pfn=1225828
sg119: dma=758a000, dma_len=4096/0, pfn=1192479
sg120: dma=758b000, dma_len=4096/0, pfn=1302022
sg121: dma=758c000, dma_len=4096/0, pfn=1302096
sg122: dma=758d000, dma_len=4096/0, pfn=1302682
sg123: dma=758e000, dma_len=4096/0, pfn=1302600
sg124: dma=758f000, dma_len=4096/0, pfn=1302263
sg125: dma=7590000, dma_len=4096/0, pfn=1302626
sg126: dma=7591000, dma_len=4096/0, pfn=1303065
sg127: dma=7592000, dma_len=4096/0, pfn=1302639
sg128: dma=7593000, dma_len=4096/0, pfn=1302831
sg129: dma=7594000, dma_len=4096/0, pfn=1302391
sg130: dma=7595000, dma_len=4096/0, pfn=1186671
sg131: dma=7596000, dma_len=4096/0, pfn=1302107
sg132: dma=7597000, dma_len=4096/0, pfn=1302266
sg133: dma=7598000, dma_len=4096/0, pfn=1303514
sg134: dma=7599000, dma_len=4096/0, pfn=1074456
sg135: dma=759a000, dma_len=4096/0, pfn=1074454
sg136: dma=759b000, dma_len=4096/0, pfn=1077932
sg137: dma=759c000, dma_len=4096/0, pfn=1138151
sg138: dma=759d000, dma_len=4096/0, pfn=1309818
sg139: dma=759e000, dma_len=4096/0, pfn=1301073
sg140: dma=759f000, dma_len=4096/0, pfn=1300993
sg141: dma=75a0000, dma_len=4096/0, pfn=1309780
sg142: dma=75a1000, dma_len=4096/0, pfn=1301040
sg143: dma=75a2000, dma_len=4096/0, pfn=1301007
sg144: dma=75a3000, dma_len=4096/0, pfn=1130805
sg145: dma=75a4000, dma_len=4096/0, pfn=1285725
sg146: dma=75a5000, dma_len=4096/0, pfn=1075164
sg147: dma=75a6000, dma_len=4096/0, pfn=1074291
sg148: dma=75a7000, dma_len=4096/0, pfn=1176495
sg149: dma=75a8000, dma_len=4096/0, pfn=1152240
sg150: dma=75a9000, dma_len=4096/0, pfn=1066291
sg151: dma=75aa000, dma_len=4096/0, pfn=1078137
sg152: dma=75ab000, dma_len=4096/0, pfn=1300894
sg153: dma=75ac000, dma_len=4096/0, pfn=1300984
sg154: dma=75ad000, dma_len=4096/0, pfn=1306470
sg155: dma=75ae000, dma_len=4096/0, pfn=1306473
sg156: dma=75af000, dma_len=4096/0, pfn=1306438
sg157: dma=75b0000, dma_len=4096/0, pfn=1306454
sg158: dma=75b1000, dma_len=4096/0, pfn=1300991
sg159: dma=75b2000, dma_len=4096/0, pfn=1300996
sg160: dma=75b3000, dma_len=4096/0, pfn=1303940
sg161: dma=75b4000, dma_len=4096/0, pfn=1300980
sg162: dma=75b5000, dma_len=4096/0, pfn=1304592
sg163: dma=75b6000, dma_len=4096/0, pfn=1304657
sg164: dma=75b7000, dma_len=4096/0, pfn=1300865
sg165: dma=75b8000, dma_len=4096/0, pfn=1300868
sg166: dma=75b9000, dma_len=4096/0, pfn=1300850
sg167: dma=75ba000, dma_len=4096/0, pfn=1300902
sg168: dma=75bb000, dma_len=4096/0, pfn=1300913
sg169: dma=75bc000, dma_len=4096/0, pfn=1301045
sg170: dma=75bd000, dma_len=4096/0, pfn=1301048
sg171: dma=75be000, dma_len=4096/0, pfn=1301050
sg172: dma=75bf000, dma_len=4096/0, pfn=1305977
sg173: dma=75c0000, dma_len=4096/0, pfn=1303937
sg174: dma=75c1000, dma_len=4096/0, pfn=1301063
sg175: dma=75c2000, dma_len=4096/0, pfn=1301002
sg176: dma=75c3000, dma_len=4096/0, pfn=1300858
sg177: dma=75c4000, dma_len=4096/0, pfn=1301066
sg178: dma=75c5000, dma_len=4096/0, pfn=1301090
sg179: dma=75c6000, dma_len=4096/0, pfn=1301109
sg180: dma=75c7800, dma_len=4096/0, pfn=1301052
sg181: dma=75c8800, dma_len=4096/0, pfn=1050889
sg182: dma=75ca000, dma_len=4096/0, pfn=1058758
sg183: dma=75cb000, dma_len=4096/0, pfn=1300834
sg184: dma=75cc800, dma_len=4096/0, pfn=1175943
sg185: dma=75cd800, dma_len=4096/0, pfn=1059784
sg186: dma=75ce800, dma_len=4096/0, pfn=1178155
sg187: dma=75cf800, dma_len=4096/0, pfn=1301057
sg188: dma=75d0800, dma_len=4096/0, pfn=1301070
sg189: dma=75d1800, dma_len=4096/0, pfn=1302404
sg190: dma=75d2800, dma_len=4096/0, pfn=1306152
sg191: dma=75d3800, dma_len=4096/0, pfn=1300845
sg192: dma=75d4800, dma_len=4096/0, pfn=1050243
sg193: dma=75d5800, dma_len=4096/0, pfn=1303880
sg194: dma=75d6800, dma_len=4096/0, pfn=1306171
sg195: dma=75d7800, dma_len=4096/0, pfn=1306275
sg196: dma=75d8800, dma_len=4096/0, pfn=1306174
sg197: dma=75d9800, dma_len=4096/0, pfn=1306138
sg198: dma=75da800, dma_len=4096/0, pfn=1306463
sg199: dma=75db800, dma_len=4096/0, pfn=1306469
sg200: dma=75dc800, dma_len=4096/0, pfn=1301416
sg201: dma=75dd800, dma_len=4096/0, pfn=1301418
sg202: dma=75de800, dma_len=4096/0, pfn=1299028
sg203: dma=75df800, dma_len=4096/0, pfn=1309563
sg204: dma=75e0800, dma_len=4096/0, pfn=1299036
sg205: dma=75e1800, dma_len=4096/0, pfn=1299006
sg206: dma=75e2800, dma_len=4096/0, pfn=1298996
sg207: dma=75e3800, dma_len=4096/0, pfn=1299020
sg208: dma=75e4800, dma_len=4096/0, pfn=1299003
sg209: dma=75e5800, dma_len=4096/0, pfn=1053054
sg210: dma=75e6800, dma_len=4096/0, pfn=1050924
sg211: dma=75e7800, dma_len=4096/0, pfn=1059515
sg212: dma=75e8800, dma_len=4096/0, pfn=1051608
sg213: dma=75e9800, dma_len=4096/0, pfn=1064691
sg214: dma=75ea800, dma_len=4096/0, pfn=1050926
sg215: dma=75eb800, dma_len=4096/0, pfn=1105646
sg216: dma=75ec800, dma_len=4096/0, pfn=1199955
sg217: dma=75ed800, dma_len=4096/0, pfn=1060378
sg218: dma=75ee800, dma_len=4096/0, pfn=1143091
sg219: dma=75ef800, dma_len=4096/0, pfn=1062717
sg220: dma=75f0800, dma_len=4096/0, pfn=1050862
sg221: dma=75f1800, dma_len=4096/0, pfn=1306215
sg222: dma=75f2800, dma_len=4096/0, pfn=1306195
sg223: dma=75f3800, dma_len=4096/0, pfn=1306229
sg224: dma=75f4800, dma_len=4096/0, pfn=1050973
sg225: dma=75f5800, dma_len=4096/0, pfn=1050976
sg226: dma=75f6800, dma_len=4096/0, pfn=1061237
sg227: dma=75f7800, dma_len=4096/0, pfn=1198723
sg228: dma=75f9000, dma_len=4096/0, pfn=1301414
sg229: dma=75fa000, dma_len=4096/0, pfn=1061761
sg230: dma=75fb000, dma_len=4096/0, pfn=1062342
sg231: dma=75fc000, dma_len=4096/0, pfn=1050811
sg232: dma=75fd000, dma_len=4096/0, pfn=1050847
sg233: dma=75fe000, dma_len=4096/0, pfn=1050859
sg234: dma=75ff000, dma_len=4096/0, pfn=1050658
sg235: dma=7600000, dma_len=4096/0, pfn=1166357
sg236: dma=7601000, dma_len=4096/0, pfn=1050760
sg237: dma=7602000, dma_len=4096/0, pfn=1050771
sg238: dma=7603000, dma_len=4096/0, pfn=1051400
sg239: dma=7604000, dma_len=4096/0, pfn=1050702
sg240: dma=7605000, dma_len=4096/0, pfn=1078142
sg241: dma=7606000, dma_len=4096/0, pfn=1109123
sg242: dma=7607000, dma_len=4096/0, pfn=1059322
sg243: dma=7608000, dma_len=4096/0, pfn=1058840
sg244: dma=7609000, dma_len=4096/0, pfn=1050954
sg245: dma=760a000, dma_len=4096/0, pfn=1050931
sg246: dma=760b000, dma_len=4096/0, pfn=1051398
sg247: dma=760c000, dma_len=4096/0, pfn=1051387
sg248: dma=760d000, dma_len=4096/0, pfn=1050908
sg249: dma=760e000, dma_len=4096/0, pfn=1050802
sg250: dma=760f000, dma_len=4096/0, pfn=1050816
sg251: dma=4021f000, dma_len=4096/0, pfn=262687
sg252: dma=3fa4f000, dma_len=4096/0, pfn=260687
sg253: dma=41727000, dma_len=4096/0, pfn=268071
sg254: dma=41e55000, dma_len=4096/0, pfn=269909
sg255: dma=40043000, dma_len=4096/0, pfn=262211


-- 
Andy, BlueArc Engineering
