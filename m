Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263904AbUEXEq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUEXEq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 00:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUEXEqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 00:46:48 -0400
Received: from nasty.thecoop.net ([216.218.255.165]:4241 "EHLO
	nasty.thecoop.net") by vger.kernel.org with ESMTP id S263895AbUEXEp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 00:45:58 -0400
Subject: Re: Problems w/ 2.6.6 on smp system...
From: Drew Bertola <drew@drewb.com>
Reply-To: drew@drewb.com
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1085298938.2760.22.camel@ws.thecoop.net>
References: <1085298938.2760.22.camel@ws.thecoop.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qNbRqUKBhcQnzQ31fz3j"
Message-Id: <1085373949.2758.12.camel@ws.thecoop.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 23 May 2004 21:45:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qNbRqUKBhcQnzQ31fz3j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry to reply to my own post, but I've found out that the "S3 and PAE
don't play nice...disabling S3" was not the cause. =20

There are some interesting lines in my dmesg output (see below) that
someone might find useful.  I've trimmed my initial post below to
include the remaining useful bits and description of the problem.

This is a general 2.6.6 issue (not an FC2 issue - although that explains
how I find myself in the realm of the 2.6 kernels).

On Sun, 2004-05-23 at 00:55, Drew Bertola wrote:
> I've installed FC2 and am experiencing problems with usb devices and
> ethernet cards (it might be everything on the pci bus).  I don't have
> this problem with their UP kernel, but I do have it with their SMP
> kernel.
>=20
> I decided to build a 2.6.6 using the FC2 i686-smp config to see if that
> would help, but I have the same problems.
>
> I notice that right after uncompressing the smp kernel, there's a
> message that says (paraphrasing from memory)
>=20
>   ACPI: S3 and PAE don't play nicely together.  Disabling S3.
>=20
> I didn't see this message when I booted the UP kernel.

Brad Fitzpatrick suggested CONFIG_HIGHMEM64G=3Dn and that did solve the
PAE / S3 fuss.  Still...

> The system is a Tyan Tiger 230T (S2507T) with dual 800MHz PIIIs.  This
> board has a Via Apollo Pro133T chipset, a VT82C694T north bridge, and a
> VT82CC686B south bridge.  lspci output is below.

1 GB ram.

> I have 2 nics installed (e100 and 8139too).  Both have the right modules
> loaded and are configured properly (including routes), but I can't ping
> out of the system nor do anything else over the network other than
> pinging the nics themselves.
>=20
> My usb hosts are detected, but nothing attached works.  My usb optical
> mouse doesn't even light up.
>=20
> All of these problems go away in UP mode.
>=20
> Any suggestions?
>=20
> Here's the output of lspci:
>=20
> $ lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133=
x] (rev c4)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro=
133x AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] =
(rev 40)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT=
823x/A/C PIPC Bus Master IDE (rev 06)
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev =
40)
> 00:09.0 USB Controller: NEC Corporation USB (rev 41)
> 00:09.1 USB Controller: NEC Corporation USB (rev 41)
> 00:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
> 00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev =
08)
> 00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (r=
ev 08)
> 00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (re=
v 02)
> 00:0c.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (re=
v 01)

Here's my dmesg from 2.6.6 boot in SMP:

Linux version 2.6.6 (root@ws.thecoop.net) (gcc version 3.3.3 20040412
(Red Hat Linux 3.3.3-7)) #2 SMP Sun May 23 14:46:56 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5660
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
Using APIC driver default
ACPI: RSDP (v000 VIA694                                    ) @
0x000f6fd0
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3040
ACPI: MADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff5700
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 799.835 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1034532k/1048512k available (1982k kernel code, 13028k reserved,
870k data, 196k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 1572.86 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0387fbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000
00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 732.10 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1597.44 BogoMIPS
CPU:     After generic identify, caps: 0387fbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000
00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3170.30 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
2-23 not connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 799.0613 MHz.
..... host bus clock speed is 133.0268 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 198k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb3e0, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
audit(1085347198.661:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xf0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800JB-00CRA1, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DVD-RW IDE1004, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=3D65535/16/63,
UDMA(100)
 hda: hda1 hda2 < hda5 > hda3 hda4
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4bios S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 196k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
NET: Registered protocol family 10
Disabled Privacy Extensions on device c037bbc0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
[drm] Initialized mga 3.1.0 20021029 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ehci_hcd 0000:00:09.2: NEC Corporation USB 2.0
ehci_hcd 0000:00:09.2: irq 10, pci mem f899e000
ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:09.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:09.0: NEC Corporation USB
ohci_hcd 0000:00:09.0: irq 5, pci mem f89a7000
ohci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:09.1: NEC Corporation USB (#2)
ohci_hcd 0000:00:09.1: irq 12, pci mem f89a9000
ohci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-3: new high speed USB device using address 2
EXT3 FS on hda1, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
cdrom: open failed.
Adding 1534196k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb 1-3: control timeout on ep0out
ehci_hcd 0000:00:09.2: Unlink after no-IRQ?  Different ACPI or APIC
settings may help.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
microcode: CPU0 already at revision 0x14 (current=3D0x14)
microcode: CPU1 already at revision 0x14 (current=3D0x14)
microcode: No suitable data for cpu 1
microcode: No suitable data for cpu 0
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: Printer, Samsung ML-1210
parport_pc: Via 686A parallel port: io=3D0x378
SCSI subsystem initialized
inserting floppy driver for 2.6.6
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xe800, 00:40:05:36:5c:6f, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
divert: allocating divert_blk for eth1
e100: eth1: e100_probe: addr 0xfa101000, irq 10, MAC addr
00:A0:C9:74:56:AE
divert: freeing divert_blk for eth0
divert: freeing divert_blk for eth1
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 2, error -110
usb 1-3: new high speed USB device using address 3
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.27
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xe800, 00:40:05:36:5c:6f, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
usb 1-3: control timeout on ep0out
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
divert: allocating divert_blk for eth1
e100: eth1: e100_probe: addr 0xfa101000, irq 10, MAC addr
00:A0:C9:74:56:AE
ip_tables: (C) 2000-2002 Netfilter core team
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
usb 1-3: control timeout on ep0out
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: Printer, Samsung ML-1210
parport_pc: Via 686A parallel port: io=3D0x378
lp0: using parport0 (polling).
lp0: console ready
usb 1-3: device not accepting address 3, error -110
usb 3-2: new low speed USB device using address 2
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 300 bytes per
conntrack
usb 3-2: control timeout on ep0out
ohci_hcd 0000:00:09.1: Unlink after no-IRQ?  Different ACPI or APIC
settings may help.
eth1: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NETDEV WATCHDOG: eth1: transmit timed out
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
NETDEV WATCHDOG: eth1: transmit timed out
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1

Thanks,
--
Drew

--=-qNbRqUKBhcQnzQ31fz3j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsX39t26h+Ap1SlURAjsHAKDKkXbCi8T2oORcs2LUu8SnOOyJUACgr7bh
jXODvkG0NzFbLwsPh4Dy1zw=
=W9bO
-----END PGP SIGNATURE-----

--=-qNbRqUKBhcQnzQ31fz3j--

