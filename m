Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268915AbUJQAvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbUJQAvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUJQAvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:51:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19137 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268915AbUJQAvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:51:40 -0400
Message-ID: <4171C20D.1000105@pobox.com>
Date: Sat, 16 Oct 2004 20:51:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org>
In-Reply-To: <20041016171458.4511ad8b.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050200020401070504080300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200020401070504080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>>I'd be suspecting the vmscan.c change, but we allegedly fixed that later on.
>>
>> > Can you try reverting it?  (Can't reproduce the problem here)
>>
>>
>> Verified -- reverting the vmscan.c changeset (attached) fixed my hang.
> 
> 
> Can we get a sysrq-M dump from that machine please?

alas, for the 'hang' case, my during-initscripts console is going to 
strange place.  here's sysrq-m from 2.6.9-rc3-bk4 with the mm/vmscan.c 
patch reverted (the its-fixed version).

	Jeff



--------------050200020401070504080300
Content-Type: text/plain;
 name="dmesg.nohang.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.nohang.txt"

Bootdata ok (command line is ro root=/dev/sda2 nogui)
Linux version 2.6.9-rc3-bk4-test1 (jgarzik@bum.yyz.us) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #2 Sat Oct 16 19:31:35 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e2000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                                       ) @ 0x00000000000fa3f0
ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT 0x00000097) @ 0x000000001fff0000
ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 0x00000097) @ 0x000000001fff0030
ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 0x00000097) @ 0x000000001fff00c0
ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 0x0100000d) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ d0000000 size 256 MB
Built 1 zonelists
Kernel command line: ro root=/dev/sda2 nogui console=tty0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2000.136 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 510660k/524224k available (2458k kernel code, 12808k reserved, 974k data, 148k init)
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 1
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 1
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 1
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 1
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
libata version 1.02 loaded.
sata_promise version 1.00
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 177
ata1: SATA max UDMA/133 cmd 0xFFFFFF000000E200 ctl 0xFFFFFF000000E238 bmdma 0x0 irq 177
ata2: SATA max UDMA/133 cmd 0xFFFFFF000000E280 ctl 0xFFFFFF000000E2B8 bmdma 0x0 irq 177
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: dev 0 cfg 49:2f00 82:3469 83:7f21 84:4003 85:3469 86:3e01 87:4003 88:203f
ata2: dev 0 ATA, max UDMA/100, 234375000 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_promise
  Vendor: ATA       Model: WDC WD1200JD-75F  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
sata_via(0000:00:0f.0): routed to hard irq line 10
ata3: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xCC00 irq 185
ata4: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xCC08 irq 185
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:407f
ata3: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234375000 512-byte hdwr sectors (120000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 193
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: irq 193, pci mem ffffff0000010d00
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 193
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 193, io base 000000000000b800
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 193
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 193, io base 000000000000bc00
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 193
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 193, io base 000000000000c000
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 193
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: irq 193, io base 000000000000c400
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 26
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
BIOS EDD facility v0.16 2004-Jun-25, 4 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
EXT3 FS on sda2, internal journal
Adding 2048276k swap on /dev/sda3.  Priority:-1 extents:1
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        2264kB (0kB HighMem)
Active:31606 inactive:78376 dirty:12 writeback:0 unstable:0 free:566 slab:16353 mapped:31544 pagetables:121
DMA free:80kB min:20kB low:40kB high:60kB active:0kB inactive:0kB present:16384kB
protections[]: 0 0 0
Normal free:2184kB min:700kB low:1400kB high:2100kB active:126424kB inactive:313504kB present:507840kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 10*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 80kB
Normal: 8*4kB 31*8kB 11*16kB 10*32kB 4*64kB 1*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 2184kB
HighMem: empty
Swap cache: add 1976, delete 1938, find 120/152, race 0+0
Free swap:       2041740kB
131056 pages of RAM
3391 reserved pages
79434 pages shared
38 pages swap cached
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
Disabled Privacy Extensions on device ffffffff803f8100(lo)
r8169 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 169
r8169: NAPI enabled
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xffffff0000012f00, 00:0c:76:51:67:7c, IRQ 169
ip_tables: (C) 2000-2002 Netfilter core team
r8169: eth0: link up
ip_tables: (C) 2000-2002 Netfilter core team

--------------050200020401070504080300--
