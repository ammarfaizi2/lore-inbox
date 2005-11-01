Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVKAQf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVKAQf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVKAQf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:35:59 -0500
Received: from 10.ctyme.com ([69.50.231.10]:42653 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1750927AbVKAQf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:35:59 -0500
Message-ID: <43679964.20109@perkel.com>
Date: Tue, 01 Nov 2005 08:35:48 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Andi Kleen <ak@suse.de>, Michael Madore <michael.madore@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: high address but no IOMMU - nForce4
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com> <p73slum38rw.fsf@verdi.suse.de> <20051030002737.GB3423@mea-ext.zmailer.org>
In-Reply-To: <20051030002737.GB3423@mea-ext.zmailer.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matti Aarnio wrote:

>Works fine with  mem=2500M,  but blows up with  mem=3G  or 
>without any override and full 4G complement in use.
>
>This board (ASUS A8N-SLI) does use NVIDIA nForce4 chipset with
>bios-option to map (hoist) "excess memory" out from first 4G to
>higher physical addresses so that it can be accessed by the
>processor.
>
>This board has no AGP at all in it, but it does have lots
>of PCIE, and a bit of PCI-X thrown in for "legacy cards". 
>Somehow that detail breaks things when the machine really
>should use bounce-buffering, or something similar -- I don't
>know if Nvidia  nForce4 chipset does have IOMMU, though...
>
>If Nvidia did omit such essential piece of hardware from
>a modern chipset, I do find it amazingly short-sighted...
>(Of course they don't yield documentation of the chips to
>public so that I can't quickly verify this detail...)
>
>  
>

I'm having the same problem I have the same ASUS motherboard running a 
dual core Athlon and 4 gigs of ram. Worked fine with the 2.6.13.2 kernel 
which I am now running but fails with 2.6.14. No DEBUG related issues 
for me. I do have a PCI VGA card in it.

Sure would like to see these X2 problems fixed. Rather not have to run 
down to the datacenter all the time. :(

Bootdata ok (command line is ro root=/dev/sda4 vga=1 notsc)
Linux version 2.6.13.2 (root@newton.ctyme.com) (gcc version 4.0.1 
20050727 (Red Hat 4.0.1-5)) #3 SMP Tue Sep 20 17:01:09 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v000 Nvidia                                ) @ 
0x00000000000f7dc0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff30c0
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 
0x00000000bfff9900
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff9a40
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x00000000bfff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000013fffffff
Using 25 for the hash shift. Max adder is 13fffffff
Using node hash shift of 25
Bootmem setup node 0 0000000000000000-000000013fffffff
On node 0 totalpages: 1048462
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 1044463 pages, LIFO batch:31
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
Kernel command line: ro root=/dev/sda4 vga=1 notsc
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2211.376 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 4038524k/5242880k available (2355k kernel code, 0k reserved, 
1171k data, 200k init)
Calibrating delay using timer specific routine.. 4427.24 BogoMIPS 
(lpj=8854484)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4422.97 BogoMIPS 
(lpj=8845948)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -82 cycles, maxerr 595 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Boot video device is 0000:05:07.0
PCI: Transparent bridge - 0000:00:09.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 *4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
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
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:09.0
  IO window: 9000-afff
  MEM window: d0000000-d1ffffff
  PREFETCH window: c0000000-cfffffff
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
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1130793066.276:1): initialized
Total HugeTLB memory allocated, 0
JFS: nTxBlock = 8192, nTxLock = 65536
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
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
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp: pci dev 0000:05:06.0 (id 10ec:8139 rev 10) is not an 8139C+ 
compatible chip
8139cp: Try the "8139too" driver instead.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide0...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 200k freed
SCSI subsystem initialized
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:05:0a.0[A] -> Link [APC4] -> GSI 19 (level, 
low) -> IRQ 16
ata1: SATA max UDMA/100 cmd 0xFFFFC20000006080 ctl 0xFFFFC2000000608A 
bmdma 0xFFFFC20000006000 irq 16
ata2: SATA max UDMA/100 cmd 0xFFFFC200000060C0 ctl 0xFFFFC200000060CA 
bmdma 0xFFFFC20000006008 irq 16
ata3: SATA max UDMA/100 cmd 0xFFFFC20000006280 ctl 0xFFFFC2000000628A 
bmdma 0xFFFFC20000006200 irq 16
ata4: SATA max UDMA/100 cmd 0xFFFFC200000062C0 ctl 0xFFFFC200000062CA 
bmdma 0xFFFFC20000006208 irq 16
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
sata_nv version 0.6
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, 
low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 17
ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 17
ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c68 86:3e01 87:4663 
88:407f
ata5: dev 0 ATA, max UDMA/133, 586114704 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata5: dev 0 configured for UDMA/133
scsi4 : sata_nv
ata6: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c68 86:3e01 87:4063 
88:407f
ata6: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata6: dev 0 configured for UDMA/133
scsi5 : sata_nv
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
 sda:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sda1 sda2 sda3 sda4
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
Attached scsi disk sda at scsi4, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdb1 sdb2 sdb3
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
Attached scsi disk sdb at scsi5, channel 0, id 0, lun 0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, 
low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC000 irq 18
ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC008 irq 18
ata7: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c68 86:3e01 87:4663 
88:407f
ata7: dev 0 ATA, max UDMA/133, 586114704 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata7: dev 0 configured for UDMA/133
scsi6 : sata_nv
ata8: no device found (phy stat 00000000)
scsi7 : sata_nv
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdc: drive cache: write back
 sdc:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdc1 sdc2 sdc3 sdc4
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
Attached scsi disk sdc at scsi6, channel 0, id 0, lun 0
md: raid1 personality registered as nr 3
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdc3 ...
md:  adding sdc3 ...
md:  adding sda3 ...
md: created md0
md: bind<sda3>
md: bind<sdc3>
md: running: <sdc3><sda3>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
floppy0: no floppy controllers found
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, 
low) -> IRQ 19
eth0: RealTek RTL8139 at 0x9000, 00:50:fc:54:8d:c5, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8139C'
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 21 (level, 
low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 20, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, 
low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 21, io mem 0xd2002000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
usb 2-4: new low speed USB device using ohci_hcd and address 2
input: USB HID v1.10 Keyboard [USB Keyboard + Mouse] on usb-0000:00:02.0-4
input: USB HID v1.10 Mouse [USB Keyboard + Mouse] on usb-0000:00:02.0-4
audit(1130821877.994:2): user pid=1152 uid=0 auid=4294967295 
msg='hwclock: op=changing system time id=0 res=success'
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
EXT3 FS on sda4, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2008116k swap on /dev/sda2.  Priority:-1 extents:1
Adding 11984480k swap on /dev/sdb2.  Priority:-2 extents:1
Adding 2008116k swap on /dev/sdc2.  Priority:-3 extents:1

