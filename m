Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUHJMTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUHJMTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHJMTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:19:49 -0400
Received: from maximus.kcore.de ([213.133.102.235]:12649 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S264561AbUHJMTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:19:19 -0400
From: Oliver Feiler <kiza@gmx.net>
To: Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: eth*: transmit timed out since .27 (was: linux-2.4.27 released)
Date: Tue, 10 Aug 2004 14:23:34 +0200
User-Agent: KMail/1.5
References: <200408072328.i77NSRNi031514@hera.kernel.org>
In-Reply-To: <200408072328.i77NSRNi031514@hera.kernel.org>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_O5LGB1QQlYDhX3v";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408101423.42402.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_O5LGB1QQlYDhX3v
Content-Type: multipart/mixed;
  boundary="Boundary-01=_G5LGBuocn72qil3"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_G5LGBuocn72qil3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

I've upgraded a server from .26 to .27, but ran into problems with the netw=
ork=20
cards.

The kernel throws a lot of errors into the syslog and the net devices don't=
=20
work:
Aug 10 13:39:25 spot kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 10 13:39:26 spot kernel: NETDEV WATCHDOG: eth1: transmit timed out
Aug 10 13:39:26 spot kernel: eth1: Transmit timeout, status 00000004 000002=
49=20
Aug 10 13:39:34 spot kernel: NETDEV WATCHDOG: eth1: transmit timed out
Aug 10 13:39:34 spot kernel: eth1: Transmit timeout, status 00000004 000002=
41=20
Aug 10 13:39:42 spot kernel: NETDEV WATCHDOG: eth1: transmit timed out
Aug 10 13:39:42 spot kernel: eth1: Transmit timeout, status 00000004 000002=
40=20
[...]

and:
Aug 10 13:39:25 spot kernel: eth0: Tx timed out, lost interrupt? TSR=3D0x3,=
=20
ISR=3D0x3, t=3D515.
Aug 10 13:40:25 spot kernel: eth0: Tx timed out, lost interrupt? TSR=3D0x3,=
=20
ISR=3D0x3, t=3D5015.
Aug 10 13:40:40 spot kernel: eth0: Tx timed out, lost interrupt? TSR=3D0x3,=
=20
ISR=3D0x3, t=3D1014.
[...]

The system has three network cards.
eth0: SIS900 (sis900.c)
eth1: RTL-8029 (ne2k-pci.c)
eth2: onboard VIA VT6102 Rhine-II (via-rhine.c)

eth0 and eth1 share the same interrupt

           CPU0      =20
  0:      91986          XT-PIC  timer
  1:        935          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      25109          XT-PIC  via82cxxx, usb-uhci, usb-uhci, eth0, eth1
 11:         24          XT-PIC  usb-uhci, eth2
 14:       7523          XT-PIC  ide0
 15:       7021          XT-PIC  ide1
NMI:          0=20
ERR:          0

That was not a problem in .26 however. Though it seems to be the cause of t=
he=20
problem (lost interrupt)? The hardware this is all running on is an Asrock=
=20
K7VM4 mainboard. The system is booted with "pci=3Dnoacpi" (ACPI, no APM).=20
Otherwise IRQ255 is assigned to IDE and someone told me the noacpi paramete=
r=20
would fix the board's braindead BIOS.

Either way .27 doesn't want to boot. I've attached dmesg from a running 2.4=
=2E26=20
kernel and the config used for 2.4.27.

Other postings I've found say that the transmit timeouts mean that the=20
lowlevel ethernet connection between the NICs broke. But this works fine in=
=20
earlier kernels and only eth0 and eth1 which share an interrupt are affecte=
d.=20
I'd be glad for any more suggestions on what might be causing this. :)

Thanks,
	Oliver


=2D-=20
Oliver Feiler  -  http://kiza.kcore.de/

--Boundary-01=_G5LGBuocn72qil3
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg"

Linux version 2.4.26 (root@spot) (gcc version 3.3.4) #3 Mon Jul 5 15:32:52 =
CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7f8000 (ACPI data)
 BIOS-e820: 000000000f7f8000 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa620
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x0f7f0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0f7f0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x0f7f00c0
ACPI: DSDT (v001    VIA    K7VT4 0x00001000 MSFT 0x0100000d) @ 0x00000000
Kernel command line: BOOT_IMAGE=3DLinux.old ro root=3D900 pci=3Dnoacpi
Initializing CPU#0
Detected 599.436 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1196.03 BogoMIPS
Memory: 248184k/253888k available (1668k kernel code, 5316k reserved, 578k =
data, 92k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Duron(tm)  stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
PCI: PCI BIOS revision 2.10 entry at 0xfdae1, last bus=3D1
PCI: Using configuration type 1
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI: Hardcoded IRQ 14 for device 00:11.1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10f
=46DC 0 is a post-1991 82077
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xe800, IRQ 10, 00:00:E8:5C:2D:AA.
sis900.c: v1.08.06 9/24/2002
eth1: SiS 900 Internal MII PHY transceiver found at address 1.
eth1: Using transceiver found at address 1 as default
eth1: SiS 900 PCI Fast Ethernet at 0xec00, IRQ 10, 00:c0:ca:16:4c:b6.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: Hardcoded IRQ 14 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800BB-00CAA1, ATA DISK drive
blk: queue c0371b40, I/O limit 4095Mb (mask 0xffffffff)
hdc: ST380011A, ATA DISK drive
blk: queue c0371f94, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D9729/255/63, UDMA(=
100)
hdc: attached ide-disk driver.
hdc: host protected area =3D> 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D9729/255/63, UDMA(=
100)
Partition check:
 hda: hda1 hda2 hda3
 hdc: hdc1 hdc2 hdc3
Via 686a/8233/8235 audio driver 1.9.1-ac3
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 00:11.5 to 64
ac97_codec: AC97  codec, id: CMI97 (CMedia)
AC97 codec does not have proper volume support.
via82cxxx: Codec rate locked at 48Khz
via82cxxx: board #1 at 0xD800, IRQ 10
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 15:33:03 Jul  5 2004
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 11
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
i2c-core.o: i2c core module version 2.8.3 (20040115)
i2c-dev.o: i2c /dev entries driver module version 2.8.3 (20040115)
i2c-proc.o version 2.8.3 (20040115)
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
 [events: 000005f4]
 [events: 000005f4]
md: autorun ...
md: considering hdc3 ...
md:  adding hdc3 ...
md:  adding hda3 ...
md: created md0
md: bind<hda3,1>
md: bind<hdc3,2>
md: running: <hdc3><hda3>
md: hdc3's event counter: 000005f4
md: hda3's event counter: 000005f4
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdc3 operational as mirror 1
raid1: device hda3 operational as mirror 0
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdc3 [events: 000005f5]<6>(write) hdc3's sb offset: 77858944
md: hda3 [events: 000005f5]<6>(write) hda3's sb offset: 77851776
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (1983 buckets, 15864 max) - 288 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 92k freed
Adding Swap: 240964k swap-space (priority -1)
Adding Swap: 249976k swap-space (priority -2)
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
i2c-viapro.o version 2.8.3 (20040115)
i2c-dev.o: Registered 'SMBus Via Pro adapter at 0400' as minor 0
i2c-isa.o version 2.8.3 (20040115)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
w83627hf.o version 2.8.3 (20040115)
via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth2: VIA VT6102 Rhine-II at 0xd400, 00:0b:6a:2b:48:84, IRQ 11.
eth2: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth2: Setting full-duplex based on MII #1 link partner capability of 45e1.
eth1: Media Link On 100mbps half-duplex=20
HTB init, kernel part version 3.16

--Boundary-01=_G5LGBuocn72qil3
Content-Type: application/x-gzip;
  name="config-2.4.27.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.4.27.gz"

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

--Boundary-01=_G5LGBuocn72qil3--

--Boundary-03=_O5LGB1QQlYDhX3v
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBBGL5OOpifZVYdT9IRAvSyAKCJNsbui5NWyjvEWK7ffqY8dO9vaQCfTAb1
n6kYvj5bS56NhDegB8mtr+Q=
=5+gG
-----END PGP SIGNATURE-----

--Boundary-03=_O5LGB1QQlYDhX3v--

