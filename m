Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWHKUbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWHKUbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWHKUbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:31:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964783AbWHKUbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:31:22 -0400
Subject: Re: 2.6.18-rc3-mm2
From: Mark Haverkamp <markh@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060811113602.04867f46.akpm@osdl.org>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <1155319901.17493.9.camel@markh3.pdx.osdl.net>
	 <20060811113602.04867f46.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-mbm9GeBfGD0hJWriGVNr"
Date: Fri, 11 Aug 2006 13:31:03 -0700
Message-Id: <1155328263.17493.20.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mbm9GeBfGD0hJWriGVNr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-08-11 at 11:36 -0700, Andrew Morton wrote:
> On Fri, 11 Aug 2006 11:11:40 -0700
> Mark Haverkamp <markh@osdl.org> wrote:
> 
> > On Sun, 2006-08-06 at 03:08 -0700, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > 
> > I am seeing problem loading modules at boot time.  My initrd tries to
> > load scsi_mod and percpu_modalloc prints this;
> > 
> > Could not allocate 16 bytes percpu data
> > 
> > This is a 2 processor x86_64 machine.  I have attached the output from
> > the serial console and the config file.
> > 
> > It is related to the mm patches.  I can boot OK from the main kernel
> > tree and the scsi trees.
> 
> Yeah, sorry - this is almost certainly due to the increase in NR_IRQS.  It
> made this, in include/linux/kernel_stat.h
> 
> 	DECLARE_PER_CPU(struct kernel_stat, kstat);
> 
> really big and we consume all the per-cpu memory.
> 
> 
> NR_IRQS is (sometimes) calculated from NR_CPUS via complex means.  Reducing
> your NR_CPUS should fix things up.

It helps.  I set NR_CPUS to 8 and got past that problem.  Now I can't
get the root to mount.

Here is some output.  I had to copy it from the VGA since this doesn't
show up on the serial output.

Creating root device
Mounting root filesystem
mount: error 6 mounting ext3
Switching to new root
ERROR opening /dev/console!!!!:2
error dup2'ing fd of 0 to 0
error dup2'ing fd of 0 to 1
error dup2'ing fd of 0 to 2
umounting old /proc
unmounting old /sys
Switchroot: mount failed: 22
Kernel Panic ....


> 
-- 
Mark Haverkamp <markh@osdl.org>

--=-mbm9GeBfGD0hJWriGVNr
Content-Disposition: attachment; filename=mm-mount-root.txt
Content-Type: text/plain; name=mm-mount-root.txt; charset=utf-8
Content-Transfer-Encoding: 8bit

Bootdata ok (command line is console=ttyS0,38400n8 console=tty1 ro root=LABEL=/ )
Linux version 2.6.18-rc3-mm2-main (markh@fuzzy.pdx.osdl.net) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #7 SMP Fri Aug 11 13:01:59 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
 BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff60000 (usable)
 BIOS-e820: 000000007ff60000 - 000000007ff72000 (ACPI data)
 BIOS-e820: 000000007ff72000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
DMI present.
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-40000000
SRAT: Node 1 PXM 1 40000000-80000000
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-000000007ff60000
ACPI: PM-Timer IO Port: 0x8008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xc0000000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xc0000000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xc0001000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xc0001000, GSI 28-31
ACPI: IOAPIC (id[0x05] address[0xc0600000] gsi_base[32])
IOAPIC[3]: apic_id 5, version 17, address 0xc0600000, GSI 32-35
ACPI: IOAPIC (id[0x06] address[0xc0601000] gsi_base[36])
IOAPIC[4]: apic_id 6, version 17, address 0xc0601000, GSI 36-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009a000 - 000000000009b000
Nosave address range: 000000000009b000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000d8000
Nosave address range: 00000000000d8000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
Built 2 zonelists.  Total pages: 514381
Kernel command line: console=ttyS0,38400n8 console=tty1 ro root=LABEL=/ 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ d0000000 size 256 MB
CPU 1: aperture @ d0000000 size 256 MB
Memory: 2052732k/2096512k available (2336k kernel code, 43372k reserved, 1547k data, 204k init)
Calibrating delay using timer specific routine.. 3992.90 BogoMIPS (lpj=7985813)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12464816
Detected 12.464 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3988.94 BogoMIPS (lpj=7977894)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 1
AMD Opteron(tm) Processor 246 stepping 08
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 1312 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 1994.368 MHz processor.
migration_cost=0,649
checking if image is initramfs... it is
Freeing initrd memory: 1458k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:06.0
PM: Adding info for pci:0000:00:07.0
Losing some ticks... checking if CPU frequency changed.
PM: Adding info for pci:0000:00:07.1
PM: Adding info for pci:0000:00:07.2
PM: Adding info for pci:0000:00:07.3
PM: Adding info for pci:0000:00:07.5
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0a.1
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0b.1
PM: Adding info for pci:0000:00:18.0
PM: Adding info for pci:0000:00:18.1
PM: Adding info for pci:0000:00:18.2
PM: Adding info for pci:0000:00:18.3
PM: Adding info for pci:0000:00:19.0
PM: Adding info for pci:0000:00:19.1
PM: Adding info for pci:0000:00:19.2
PM: Adding info for pci:0000:00:19.3
PM: Adding info for pci:0000:01:02.0
PM: Adding info for pci:0000:01:03.0
PM: Adding info for pci:0000:01:03.1
PM: Adding info for pci:0000:01:03.2
PM: Adding info for pci:0000:01:04.0
PM: Adding info for pci:0000:02:01.0
PM: Adding info for pci:0000:03:02.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.TP2P._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.G0PB._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:08)
PCI: Probing PCI hardware (bus 08)
PM: Adding info for No Bus:pci0000:08
Boot video device is 0000:09:00.0
PM: Adding info for pci:0000:08:00.0
PM: Adding info for pci:0000:08:01.0
PM: Adding info for pci:0000:08:03.0
PM: Adding info for pci:0000:08:03.1
PM: Adding info for pci:0000:08:04.0
PM: Adding info for pci:0000:08:04.1
PM: Adding info for pci:0000:09:00.0
PM: Adding info for pci:0000:09:00.1
PM: Adding info for pci:0000:0e:01.0
PM: Adding info for pci:0000:0f:0e.0
PM: Adding info for pci:0000:14:04.0
PM: Adding info for pci:0000:14:04.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.Z00J._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G1PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G1PB._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
pnp: PnP ACPI: found 13 devices
AMD768 RNG detected
PM: Adding info for No Bus:hw_random
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AMD 8151 AGP Bridge rev B2
PM: Adding info for No Bus:agpgart
agpgart: AGP aperture is 256M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0x1100-0x117f has been reserved
pnp: 00:05: ioport range 0x1180-0x11ff has been reserved
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: c0100000-c01fffff
  PREFETCH window: 88200000-882fffff
PCI: Bridge: 0000:00:0a.0
  IO window: 3000-3fff
  MEM window: c0200000-c02fffff
  PREFETCH window: 88000000-881fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: c0300000-c03fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:08:01.0
  IO window: 4000-4fff
  MEM window: c0700000-c07fffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:0e:01.0
  IO window: disabled.
  MEM window: c0800000-c09fffff
  PREFETCH window: 88300000-883fffff
PCI: Bridge: 0000:08:03.0
  IO window: disabled.
  MEM window: c0800000-c09fffff
  PREFETCH window: 88300000-883fffff
PCI: Bridge: 0000:08:04.0
  IO window: 5000-5fff
  MEM window: c0a00000-c0afffff
  PREFETCH window: 88400000-884fffff
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
PM: Adding info for No Bus:mcelog
PM: Adding info for No Bus:msr0
PM: Adding info for No Bus:msr1
PM: Adding info for No Bus:cpu0
PM: Adding info for No Bus:cpu1
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1155302161.432:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
PM: Adding info for No Bus:hpet
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: SONY DVD RW DW-U18A, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
Probing IDE interface ide0...
hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Power state transitions not supported
powernow-k8: Power state transitions not supported
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 956k
PM: Adding info for No Bus:vcs1
input: AT Translated Set 2 keyboard as /class/input/input0
PM: Adding info for No Bus:vcsa1
SCSI subsystem initialized
libata version 2.00 loaded.
sata_sil 0000:01:02.0: version 2.0
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 17 (level, low) -> IRQ 17
sata_sil 0000:01:02.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004880 ctl 0xFFFFC2000000488A bmdma 0xFFFFC20000004800 irq 17
ata2: SATA max UDMA/100 cmd 0xFFFFC200000048C0 ctl 0xFFFFC200000048CA bmdma 0xFFFFC20000004808 irq 17
scsi0 : sata_sil
PM: Adding info for No Bus:host0
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 156312576 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ata1.00: configured for UDMA/100
scsi1 : sata_sil
PM: Adding info for No Bus:host1
ata2: SATA link down (SStatus 0 SControl 310)
PM: Adding info for No Bus:target0:0:0
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt 0000:14:04.0[A] -> GSI 39 (level, low) -> IRQ 39
scsi2 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

PM: Adding info for No Bus:host2
PM: Adding info for No Bus:target2:0:0
PM: Removing info for No Bus:target2:0:0
PM: Adding info for No Bus:target2:0:1
PM: Removing info for No Bus:target2:0:1
PM: Adding info for No Bus:target2:0:2
PM: Removing info for No Bus:target2:0:2
PM: Adding info for No Bus:target2:0:3
PM: Removing info for No Bus:target2:0:3
PM: Adding info for No Bus:target2:0:4
PM: Removing info for No Bus:target2:0:4
PM: Adding info for No Bus:target2:0:5
PM: Removing info for No Bus:target2:0:5
PM: Adding info for No Bus:target2:0:6
PM: Removing info for No Bus:target2:0:6
PM: Adding info for No Bus:target2:0:8
PM: Removing info for No Bus:target2:0:8
PM: Adding info for No Bus:target2:0:9
PM: Removing info for No Bus:target2:0:9
PM: Adding info for No Bus:target2:0:10
PM: Removing info for No Bus:target2:0:10
PM: Adding info for No Bus:target2:0:11
PM: Removing info for No Bus:target2:0:11
PM: Adding info for No Bus:target2:0:12
PM: Removing info for No Bus:target2:0:12
PM: Adding info for No Bus:target2:0:13
PM: Removing info for No Bus:target2:0:13
PM: Adding info for No Bus:target2:0:14
PM: Removing info for No Bus:target2:0:14
PM: Adding info for No Bus:target2:0:15
PM: Removing info for No Bus:target2:0:15
ACPI: PCI Interrupt 0000:14:04.1[B] -> GSI 38 (level, low) -> IRQ 38
scsi3 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

PM: Adding info for No Bus:host3
PM: Adding info for No Bus:target3:0:0
PM: Removing info for No Bus:target3:0:0
PM: Adding info for No Bus:target3:0:1
PM: Removing info for No Bus:target3:0:1
PM: Adding info for No Bus:target3:0:2
PM: Removing info for No Bus:target3:0:2
PM: Adding info for No Bus:target3:0:3
PM: Removing info for No Bus:target3:0:3
PM: Adding info for No Bus:target3:0:4
PM: Removing info for No Bus:target3:0:4
PM: Adding info for No Bus:target3:0:5
PM: Removing info for No Bus:target3:0:5
PM: Adding info for No Bus:target3:0:6
PM: Removing info for No Bus:target3:0:6
PM: Adding info for No Bus:target3:0:8
PM: Removing info for No Bus:target3:0:8
PM: Adding info for No Bus:target3:0:9
PM: Removing info for No Bus:target3:0:9
PM: Adding info for No Bus:target3:0:10
PM: Removing info for No Bus:target3:0:10
PM: Adding info for No Bus:target3:0:11
PM: Removing info for No Bus:target3:0:11
PM: Adding info for No Bus:target3:0:12
PM: Removing info for No Bus:target3:0:12
PM: Adding info for No Bus:target3:0:13
PM: Removing info for No Bus:target3:0:13
PM: Adding info for No Bus:target3:0:14
PM: Removing info for No Bus:target3:0:14
PM: Adding info for No Bus:target3:0:15
PM: Removing info for No Bus:target3:0:15
Fusion MPT base driver 3.04.01
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SAS Host driver 3.04.01
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 26 (level, low) -> IRQ 26
mptbase: Initiating ioc0 bringup
ioc0: SAS1068: Capabilities={Initiator}
scsi4 : ioc0: LSISAS1068, FwRev=01060000h, Ports=1, MaxQ=511, IRQ=26
PM: Adding info for No Bus:host4
PM: Adding info for No Bus:phy-4:0
PM: Adding info for No Bus:phy-4:1
PM: Adding info for No Bus:phy-4:2
PM: Adding info for No Bus:phy-4:3
PM: Adding info for No Bus:phy-4:4
PM: Adding info for No Bus:phy-4:5
PM: Adding info for No Bus:phy-4:6
PM: Adding info for No Bus:phy-4:7
Adaptec aacraid driver (1.1-5[2409]-mh2)
ACPI: PCI Interrupt 0000:0f:0e.0[A] -> GSI 34 (level, low) -> IRQ 34
AAC0: kernel 5.1-0[9179] 
AAC0: monitor 5.1-0[9179]
AAC0: bios 5.1-0[9179]
AAC0: serial c83099
AAC0: 64bit support enabled.
AAC0: 64 Bit DAC enabled
scsi5 : aacraid
PM: Adding info for No Bus:host5
PM: Adding info for No Bus:target5:0:0
  Vendor: Adaptec   Model: Device 1          Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
PM: Adding info for scsi:5:0:0:0
SCSI device sdb: 143337472 512-byte hdwr sectors (73389 MB)
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
SCSI device sdb: 143337472 512-byte hdwr sectors (73389 MB)
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
 sdb: sdb1
sd 5:0:0:0: Attached scsi removable disk sdb
PM: Adding info for No Bus:target5:0:1
PM: Removing info for No Bus:target5:0:1
PM: Adding info for No Bus:target5:0:2
PM: Removing info for No Bus:target5:0:2
PM: Adding info for No Bus:target5:0:3
PM: Removing info for No Bus:target5:0:3
PM: Adding info for No Bus:target5:0:4
PM: Removing info for No Bus:target5:0:4
PM: Adding info for No Bus:target5:0:5
PM: Removing info for No Bus:target5:0:5
PM: Adding info for No Bus:target5:0:6
PM: Removing info for No Bus:target5:0:6
PM: Adding info for No Bus:target5:0:7
PM: Removing info for No Bus:target5:0:7
PM: Adding info for No Bus:target5:0:8
PM: Removing info for No Bus:target5:0:8
PM: Adding info for No Bus:target5:0:9
PM: Removing info for No Bus:target5:0:9
PM: Adding info for No Bus:target5:0:10
PM: Removing info for No Bus:target5:0:10
PM: Adding info for No Bus:target5:0:11
PM: Removing info for No Bus:target5:0:11
PM: Adding info for No Bus:target5:0:12
PM: Removing info for No Bus:target5:0:12
PM: Adding info for No Bus:target5:0:13
PM: Removing info for No Bus:target5:0:13
PM: Adding info for No Bus:target5:0:14
PM: Removing info for No Bus:target5:0:14
PM: Adding info for No Bus:target5:0:15
PM: Removing info for No Bus:target5:0:15
PM: Adding info for No Bus:target5:0:16
PM: Removing info for No Bus:target5:0:16
PM: Adding info for No Bus:target5:0:17
PM: Removing info for No Bus:target5:0:17
PM: Adding info for No Bus:target5:0:18
PM: Removing info for No Bus:target5:0:18
PM: Adding info for No Bus:target5:0:19
PM: Removing info for No Bus:target5:0:19
PM: Adding info for No Bus:target5:0:20
PM: Removing info for No Bus:target5:0:20
PM: Adding info for No Bus:target5:0:21
PM: Removing info for No Bus:target5:0:21
PM: Adding info for No Bus:target5:0:22
PM: Removing info for No Bus:target5:0:22
PM: Adding info for No Bus:target5:0:23
PM: Removing info for No Bus:target5:0:23
PM: Adding info for No Bus:target5:0:24
PM: Removing info for No Bus:target5:0:24
PM: Adding info for No Bus:target5:0:25
PM: Removing info for No Bus:target5:0:25
PM: Adding info for No Bus:target5:0:26
PM: Removing info for No Bus:target5:0:26
PM: Adding info for No Bus:target5:0:27
PM: Removing info for No Bus:target5:0:27
PM: Adding info for No Bus:target5:0:28
PM: Removing info for No Bus:target5:0:28
PM: Adding info for No Bus:target5:0:29
PM: Removing info for No Bus:target5:0:29
PM: Adding info for No Bus:target5:0:30
PM: Removing info for No Bus:target5:0:30
PM: Adding info for No Bus:target5:0:31
PM: Removing info for No Bus:target5:0:31
PM: Adding info for No Bus:target5:0:32
PM: Removing info for No Bus:target5:0:32
PM: Adding info for No Bus:target5:0:33
PM: Removing info for No Bus:target5:0:33
PM: Adding info for No Bus:target5:0:34
PM: Removing info for No Bus:target5:0:34
PM: Adding info for No Bus:target5:0:35
PM: Removing info for No Bus:target5:0:35
PM: Adding info for No Bus:target5:0:36
PM: Removing info for No Bus:target5:0:36
PM: Adding info for No Bus:target5:0:37
PM: Removing info for No Bus:target5:0:37
PM: Adding info for No Bus:target5:0:38
PM: Removing info for No Bus:target5:0:38
PM: Adding info for No Bus:target5:0:39
PM: Removing info for No Bus:target5:0:39
PM: Adding info for No Bus:target5:0:40
PM: Removing info for No Bus:target5:0:40
PM: Adding info for No Bus:target5:0:41
PM: Removing info for No Bus:target5:0:41
PM: Adding info for No Bus:target5:0:42
PM: Removing info for No Bus:target5:0:42
PM: Adding info for No Bus:target5:0:43
PM: Removing info for No Bus:target5:0:43
PM: Adding info for No Bus:target5:0:44
PM: Removing info for No Bus:target5:0:44
PM: Adding info for No Bus:target5:0:45
PM: Removing info for No Bus:target5:0:45
PM: Adding info for No Bus:target5:0:46
PM: Removing info for No Bus:target5:0:46
PM: Adding info for No Bus:target5:0:47
PM: Removing info for No Bus:target5:0:47
PM: Adding info for No Bus:target5:0:48
PM: Removing info for No Bus:target5:0:48
PM: Adding info for No Bus:target5:0:49
PM: Removing info for No Bus:target5:0:49
PM: Adding info for No Bus:target5:0:50
PM: Removing info for No Bus:target5:0:50
PM: Adding info for No Bus:target5:0:51
PM: Removing info for No Bus:target5:0:51
PM: Adding info for No Bus:target5:0:52
PM: Removing info for No Bus:target5:0:52
PM: Adding info for No Bus:target5:0:53
PM: Removing info for No Bus:target5:0:53
PM: Adding info for No Bus:target5:0:54
PM: Removing info for No Bus:target5:0:54
PM: Adding info for No Bus:target5:0:55
PM: Removing info for No Bus:target5:0:55
PM: Adding info for No Bus:target5:0:56
PM: Removing info for No Bus:target5:0:56
PM: Adding info for No Bus:target5:0:57
PM: Removing info for No Bus:target5:0:57
PM: Adding info for No Bus:target5:0:58
PM: Removing info for No Bus:target5:0:58
PM: Adding info for No Bus:target5:0:59
PM: Removing info for No Bus:target5:0:59
PM: Adding info for No Bus:target5:0:60
PM: Removing info for No Bus:target5:0:60
PM: Adding info for No Bus:target5:0:61
PM: Removing info for No Bus:target5:0:61
PM: Adding info for No Bus:target5:0:62
PM: Removing info for No Bus:target5:0:62
PM: Adding info for No Bus:target5:0:63
PM: Removing info for No Bus:target5:0:63
PM: Adding info for No Bus:target5:0:64
PM: Removing info for No Bus:target5:0:64
PM: Adding info for No Bus:target5:0:65
PM: Removing info for No Bus:target5:0:65
PM: Adding info for No Bus:target5:0:66
PM: Removing info for No Bus:target5:0:66
PM: Adding info for No Bus:target5:0:67
PM: Removing info for No Bus:target5:0:67
PM: Adding info for No Bus:target5:0:68
PM: Removing info for No Bus:target5:0:68
PM: Adding info for No Bus:target5:0:69
PM: Removing info for No Bus:target5:0:69
PM: Adding info for No Bus:target5:0:70
PM: Removing info for No Bus:target5:0:70
PM: Adding info for No Bus:target5:0:71
PM: Removing info for No Bus:target5:0:71
PM: Adding info for No Bus:target5:0:72
PM: Removing info for No Bus:target5:0:72
PM: Adding info for No Bus:target5:0:73
PM: Removing info for No Bus:target5:0:73
PM: Adding info for No Bus:target5:0:74
PM: Removing info for No Bus:target5:0:74
PM: Adding info for No Bus:target5:0:75
PM: Removing info for No Bus:target5:0:75
PM: Adding info for No Bus:target5:0:76
PM: Removing info for No Bus:target5:0:76
PM: Adding info for No Bus:target5:0:77
PM: Removing info for No Bus:target5:0:77
PM: Adding info for No Bus:target5:0:78
PM: Removing info for No Bus:target5:0:78
PM: Adding info for No Bus:target5:0:79
PM: Removing info for No Bus:target5:0:79
PM: Adding info for No Bus:target5:0:80
PM: Removing info for No Bus:target5:0:80
PM: Adding info for No Bus:target5:0:81
PM: Removing info for No Bus:target5:0:81
PM: Adding info for No Bus:target5:0:82
PM: Removing info for No Bus:target5:0:82
PM: Adding info for No Bus:target5:0:83
PM: Removing info for No Bus:target5:0:83
PM: Adding info for No Bus:target5:0:84
PM: Removing info for No Bus:target5:0:84
PM: Adding info for No Bus:target5:0:85
PM: Removing info for No Bus:target5:0:85
PM: Adding info for No Bus:target5:0:86
PM: Removing info for No Bus:target5:0:86
PM: Adding info for No Bus:target5:0:87
PM: Removing info for No Bus:target5:0:87
PM: Adding info for No Bus:target5:0:88
PM: Removing info for No Bus:target5:0:88
PM: Adding info for No Bus:target5:0:89
PM: Removing info for No Bus:target5:0:89
PM: Adding info for No Bus:target5:0:90
PM: Removing info for No Bus:target5:0:90
PM: Adding info for No Bus:target5:0:91
PM: Removing info for No Bus:target5:0:91
PM: Adding info for No Bus:target5:0:92
PM: Removing info for No Bus:target5:0:92
PM: Adding info for No Bus:target5:0:93
PM: Removing info for No Bus:target5:0:93
PM: Adding info for No Bus:target5:0:94
PM: Removing info for No Bus:target5:0:94
PM: Adding info for No Bus:target5:0:95
PM: Removing info for No Bus:target5:0:95
PM: Adding info for No Bus:target5:0:96
PM: Removing info for No Bus:target5:0:96
PM: Adding info for No Bus:target5:0:97
PM: Removing info for No Bus:target5:0:97
PM: Adding info for No Bus:target5:0:98
PM: Removing info for No Bus:target5:0:98
PM: Adding info for No Bus:target5:0:99
PM: Removing info for No Bus:target5:0:99
PM: Adding info for No Bus:target5:0:100
PM: Removing info for No Bus:target5:0:100
PM: Adding info for No Bus:target5:0:101
PM: Removing info for No Bus:target5:0:101
PM: Adding info for No Bus:target5:0:102
PM: Removing info for No Bus:target5:0:102
PM: Adding info for No Bus:target5:0:103
PM: Removing info for No Bus:target5:0:103
PM: Adding info for No Bus:target5:0:104
PM: Removing info for No Bus:target5:0:104
PM: Adding info for No Bus:target5:0:105
PM: Removing info for No Bus:target5:0:105
PM: Adding info for No Bus:target5:0:106
PM: Removing info for No Bus:target5:0:106
PM: Adding info for No Bus:target5:0:107
PM: Removing info for No Bus:target5:0:107
PM: Adding info for No Bus:target5:0:108
PM: Removing info for No Bus:target5:0:108
PM: Adding info for No Bus:target5:0:109
PM: Removing info for No Bus:target5:0:109
PM: Adding info for No Bus:target5:0:110
PM: Removing info for No Bus:target5:0:110
PM: Adding info for No Bus:target5:0:111
PM: Removing info for No Bus:target5:0:111
PM: Adding info for No Bus:target5:0:112
PM: Removing info for No Bus:target5:0:112
PM: Adding info for No Bus:target5:0:113
PM: Removing info for No Bus:target5:0:113
PM: Adding info for No Bus:target5:0:114
PM: Removing info for No Bus:target5:0:114
PM: Adding info for No Bus:target5:0:115
PM: Removing info for No Bus:target5:0:115
PM: Adding info for No Bus:target5:0:116
PM: Removing info for No Bus:target5:0:116
PM: Adding info for No Bus:target5:0:117
PM: Removing info for No Bus:target5:0:117
PM: Adding info for No Bus:target5:0:118
PM: Removing info for No Bus:target5:0:118
PM: Adding info for No Bus:target5:0:119
PM: Removing info for No Bus:target5:0:119
PM: Adding info for No Bus:target5:0:120
PM: Removing info for No Bus:target5:0:120
PM: Adding info for No Bus:target5:0:121
PM: Removing info for No Bus:target5:0:121
PM: Adding info for No Bus:target5:0:122
PM: Removing info for No Bus:target5:0:122
PM: Adding info for No Bus:target5:0:123
PM: Removing info for No Bus:target5:0:123
PM: Adding info for No Bus:target5:0:124
PM: Removing info for No Bus:target5:0:124
PM: Adding info for No Bus:target5:0:125
PM: Removing info for No Bus:target5:0:125
PM: Adding info for No Bus:target5:0:126
PM: Removing info for No Bus:target5:0:126
Kernel panic - not syncing: Attempted to kill init!
 

--=-mbm9GeBfGD0hJWriGVNr--

