Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319283AbSHVDQw>; Wed, 21 Aug 2002 23:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319285AbSHVDQw>; Wed, 21 Aug 2002 23:16:52 -0400
Received: from h-64-105-137-141.SNVACAID.covad.net ([64.105.137.141]:2004 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S319283AbSHVDQq>; Wed, 21 Aug 2002 23:16:46 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 21 Aug 2002 20:20:42 -0700
Message-Id: <200208220320.UAA00740@adam.yggdrasil.com>
To: aia21@cantab.net
Subject: Re: [BUG] 2.5.31 doesn't boot - looks IDE related
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-08-13, Anton Altaparmakov wrote:

>2.5.31 dies with the last messages being:
>[snip]
>ATA/ATAPI device driver v7.0.0
>ATA: PCI bus speed 33.3MHz
>ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
>ATA: chipset rev.: 6
>ATA: non-legacy mode: IRQ probe delayed
>VP_IDE: VIA vt82c686b (rev 40) ATA UDMA100 controller on PCI 00:07.1
>    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
>hda: IC35L040AVER07-0, DISK drive
>hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive 
>hdd: Maxtor 90288D2, DISK drive 
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
><it is dead>

	I tried to reproduce your problem on two Via motherboard,
which I set up with the following configuration:

		Primary IDE:	Master: A Maxtor IDE hard disk as master.

		Secondary IDE:	Master: An ATAPI CDROM or DVD-ROM drive.
				Slave:	Another Maxtor IDE hard disk (17.2GB)

	One of the motherboards had an 866MHz CPU and did not experience
any problem.

	The other one, with a 1GHz CPU, failed to recognize the ATAPI
CDROM, but recognized both hard disks, and did not hang.  Rebooting with
the slave hard disk removed resulted in the ATAPI drive to being
recognized.  Patching from approxiamtely stock 2.5.31 to Martin's IDE 115
on the misbehaving machine CDROM did not change these behaviors.

	I have included the boot messages from stock 2.5.31 on both machines,
so that you can see chip revisions, model numbers, etc.


Console messages of the 866MHz Pentium III machine that was not affected:
Linux version 2.5.31 (root@baldur) (gcc version 3.1) #9 SMP Tue Aug 13 04:20:59 PDT 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
384MB LOWMEM available.
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.
ACPI: Unable to locate RSDP
Kernel command line: auto BOOT_IMAGE=default ro root=302 ramdisk=5000 root=/dev/ram ro
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 868.754 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1708.03 BogoMIPS
Memory: 386556k/393216k available (1003k kernel code, 6276k reserved, 279k data, 84k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.72 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 868.0457 MHz.
..... host bus clock speed is 133.0608 MHz.
cpu: 0, clocks: 133608, slice: 4048
CPU0<T0:133600,T1:129552,D:0,S:4048,C:133608>
Starting migration thread for cpu 0
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb170, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020725
tbxfroot-0305 [04] Acpi_find_root_pointer: RSDP structure not found
ACPI: System description tables not found
 tbxface-0066: *** Error: Acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
 tbxface-0116: *** Error: Acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
NET4: Frame Diverter 0.46
Starting kswapd
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Disk quotas vdquot_6.5.1
devfs: v1.20 (20020728) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Capability LSM initialized
Activating ISA DMA hang workarounds.
Detected PS/2 Mouse Port.
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
pty: 256 Unix98 ptys configured
block: 256 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 5000K size 1024 blocksize
Software Suspend has a malfunctioning SMP support. Disabled :(
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 589k freed
VFS: Mounted root (romfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 84k freed
isapnp: Scanning for PnP cards...
isapnp: Card 'Crystal Codec'
isapnp: 1 Plug & Play card detected total
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: PCI device 1106:0571, PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c596b (rev 12) ATA UDMA66 controller on PCI 00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 92720U8, DISK drive
hdc: LTN262, ATAPI CD/DVD-ROM drive
hdd: Maxtor 91728D8, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 53177040 sectors w/2048KiB Cache, CHS=52755/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: unknown partition table
 hdd: 33750864 sectors w/512KiB Cache, CHS=33483/16/63, UDMA(33)
 /dev/ide/host1/bus1/target1/lun0: unknown partition table
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.07+LK1.0.13, Nov 12, 2001  Jeff Garzik, Tjeerd Mulder)
PCI: Found IRQ 11 for device 00:10.0
divert: allocating divert_blk for eth0
eth0: NatSemi DP8381[56] at 0xd8846000, 00:a0:cc:a0:b9:34, IRQ 11.
eth0: Transceiver status 0x7869 advertising 05e1.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 322M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
agpgart: Oops, don't init more than one agpgart device.
Real Time Clock Driver v1.11
Unable to find swap-space signature
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ds: no socket drivers loaded!
unloading Kernel Card Services
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
VFS: Can't find ext2 filesystem on dev ramdisk(1,1).
SCSI subsystem driver Revision: 1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
Linux IP multicast router 0.06 plus PIM-SM
eth0: link is back. Enabling watchdog.
eth0: Setting full-duplex based on negotiated link capability.



Console messages of the 1GHz Pentium III machine that was affected:
Linux version 2.5.31 (root@baldur) (gcc version 3.1) #9 SMP Tue Aug 13 04:20:59 PDT 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fffc000 (usable)
 BIOS-e820: 000000004fffc000 - 000000004ffff000 (ACPI data)
 BIOS-e820: 000000004ffff000 - 0000000050000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f5a60
ACPI: RSDT (v001 ASUS   P3V_4X   12336.12337) @ 0x4fffc000
ACPI: FADT (v001 ASUS   P3V_4X   12336.12337) @ 0x4fffc080
ACPI: BOOT (v001 ASUS   P3V_4X   12336.12337) @ 0x4fffc040
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=default ro root=302 ramdisk=5000 root=/dev/ram ro
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1003.703 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1978.36 BogoMIPS
Memory: 905700k/917504k available (1003k kernel code, 11420k reserved, 279k data, 84k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.80 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1003.0483 MHz.
..... host bus clock speed is 133.0797 MHz.
cpu: 0, clocks: 133797, slice: 4054
CPU0<T0:133792,T1:129728,D:10,S:4054,C:133797>
Starting migration thread for cpu 0
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf0890, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020725
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..............................................................................
Table [DSDT] - 267 Objects with 36 Devices 78 Methods 16 Regions
ACPI Namespace successfully loaded at root c02a40dc
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:....................................
36 Devices found containing: 36 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:..............................................
Initialized 11/16 Regions 5/5 Fields 19/19 Buffers 11/11 Packages (267 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi'
NET4: Frame Diverter 0.46
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting kswapd
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Disk quotas vdquot_6.5.1
devfs: v1.20 (20020728) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Capability LSM initialized
Activating ISA DMA hang workarounds.
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: 256 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 5000K size 1024 blocksize
Software Suspend has a malfunctioning SMP support. Disabled :(
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 588k freed
VFS: Mounted root (romfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 84k freed
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: PCI device 1106:0571, PCI slot 00:04.1
ATA: chipset rev.: 16
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c596b (rev 23) ATA UDMA66 controller on PCI 00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 98196H8, DISK drive
hdd: Maxtor 91728D8, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 160086528 sectors w/2048KiB Cache, CHS=158816/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: unknown partition table
 hdd: 33750864 sectors w/512KiB Cache, CHS=33483/16/63, UDMA(33)
 /dev/ide/host1/bus1/target1/lun0: unknown partition table
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: 00:0a.0 PCI cache line size set incorrectly (32 bytes) by BIOS/FW, expecting 16
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #8 config 3100 status 786b advertising 01e1.
divert: allocating divert_blk for eth0
eth0: Digital DS21140 Tulip rev 34 at 0xf8858000, 00:40:05:36:F2:9F, IRQ 11.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xe4000000
agpgart: Oops, don't init more than one agpgart device.
usb.c: registered new driver usbfs
usb.c: registered new driver hub
uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
hcd-pci.c: uhci-hcd @ 00:04.2, PCI device 1106:3038
hcd-pci.c: irq 10, io base 0000d400
hcd.c: new USB bus registered, assigned bus number 1
uhci-hcd.c: detected 2 ports
hcd.c: 00:04.2 root hub device address 1
usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
Product: PCI device 1106:3038
Manufacturer: Linux 2.5.31 uhci-hcd
SerialNumber: 00:04.2
hub.c: USB hub found at 0
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7f4079c
usb.c: kusbd: /sbin/hotplug add 1
uhci-hcd.c: d400: suspend_hc
Real Time Clock Driver v1.11
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: hub 0 port 1 connection change
hub.c: hub 0 port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: hub 0 port 2 connection change
hub.c: hub 0 port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
hub.c: hub 0 port 1 enable change, status 300
hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
hub.c: hub 0 port 2 enable change, status 300
Unable to find swap-space signature
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ds: no socket drivers loaded!
unloading Kernel Card Services
VFS: Can't find ext2 filesystem on dev ramdisk(1,1).
SCSI subsystem driver Revision: 1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
Linux IP multicast router 0.06 plus PIM-SM
eth0: Setting full-duplex based on MII#8 link partner capability of 45e1.

