Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136284AbRDVVJU>; Sun, 22 Apr 2001 17:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136289AbRDVVJL>; Sun, 22 Apr 2001 17:09:11 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:65294 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S136284AbRDVVJA>; Sun, 22 Apr 2001 17:09:00 -0400
Date: Sun, 22 Apr 2001 23:09:30 +0200
From: Waldemar Brodkorb <waldemar.brodkorb@web.de>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Pcmcia-Updates for Xircomcards?
Message-ID: <20010422230930.A11882@web.de>
Reply-To: Waldemar Brodkorb <waldemar.brodkorb@web.de>
Mail-Followup-To: David Hinds <dahinds@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Operating-System: Linux 2.4.3 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: multipart/mixed; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David Hinds, Hello Kernelhackers,

sorry that I also directly contact you.=20
But I'am very confused, at the moment.

My Hardware:=20
Toshiba Satellite Pro 4280=20
PCMCIA: Xircom RBEM56G-100=20

When I use SuSE 7.1 and Kernel 2.4.2 (SuSE) the card=20
is recognized and network works, also configured via DHCP.
(tulib_cb,serial_cb , perhaps from pcmcia-cs )

But now I want to use Kernel 2.4.3-ac12, because of the=20
new module, which I've heard/read is better than the old drivers.

O.K., here what I done:
build yenta_socket,xircom_cb,serial_cs,pcmcia_core,..

Modified /etc/pcmcia/config:
device "xircom_cb"
  class "network" module "cb_enabler", "xircom_cb"

card "Xircom CBEM56G-100 CardBus 10/100 Ethernet + 56K Modem"
  manfid 0x0105, 0x0103
  bind "xircom_cb" to 0, "serial_cs" to 1

Linus said serial_cs is for both, old serial_cb & serial_cs.

But when I start the notebook with the same /etc/init.d/pcmcia
I get this:
Apr 22 21:34:36 T50179768G kernel: PCI: Enabling device 14:00.1
(0000 -> 0003)
Apr 22 21:34:36 T50179768G cardmgr[206]: initializing socket 0
Apr 22 21:34:36 T50179768G cardmgr[206]: socket 0: Xircom
CBEM56G-100 CardBus 10
/100 Ethernet + 56K Modem
Apr 22 21:34:36 T50179768G cardmgr[206]: executing: 'modprobe
cb_enabler'
Apr 22 21:34:36 T50179768G cardmgr[206]: executing: 'modprobe
xircom_cb'
Apr 22 21:34:36 T50179768G kernel: PCI: Setting latency timer of
device 14:00.0
to 64
Apr 22 21:34:36 T50179768G kernel: eth0: Xircom cardbus revision 3
at irq 11
Apr 22 21:34:36 T50179768G cardmgr[206]: executing: 'modprobe
serial_cs'
Apr 22 21:34:36 T50179768G kernel: Serial driver version 5.05a
(2001-03-20) with
 MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
 Apr 22 21:34:36 T50179768G kernel: ttyS00 at 0x03f8 (irq =3D 4) is a
 16550A
 Apr 22 21:34:36 T50179768G cardmgr[206]: executing: './network
 start xircom_cb'
 Apr 22 21:34:36 T50179768G kernel: serial_cs: ParseTuple: No more
 items
 Apr 22 21:34:36 T50179768G cardmgr[206]: + xircom_cb: error
 fetching interface i
 nformation: Device not found
 Apr 22 21:34:37 T50179768G cardmgr[206]: + /sbin/ifconfig xircom_cb
 up
 Apr 22 21:34:37 T50179768G cardmgr[206]: + xircom_cb: unknown
 interface: No such
  device
  Apr 22 21:34:37 T50179768G dhcpcd[1115]: dhcpStart: ioctl
  SIOCGIFHWADDR: No such
   device
   Apr 22 21:34:37 T50179768G cardmgr[206]: + /sbin/dhcpcd
   xircom_cb >/dev/null 2>
   &1
   Apr 22 21:34:37 T50179768G cardmgr[206]: executing: './serial
   start xircom_cb'
   Apr 22 21:34:37 T50179768G cardmgr[206]: + expr: syntax error
   Apr 22 21:34:37 T50179768G cardmgr[206]: + ./MAKEDEV xircom_cb
   Apr 22 21:34:37 T50179768G cardmgr[206]: + ./serial: ./MAKEDEV:
   No such file or
   directory
   Apr 22 21:34:37 T50179768G cardmgr[206]: + /dev/xircom_cb: No
   such file or direc
   tory


It is possible I missed something essential?

More information added below.

Would it a good idea to split pcmcia-cs package?
One for use with kernel 2.4, without client-modules
and one for kernel 2.2.x with all modules?=20
Because of the different names and modules ?

-------------------------
pcmcia-cs 3.1.22 & 3.1.25 (same problem, cardmgr have the same
version number)

What to do?

thanks for any hints or help.

bye
Waldemar=20

--=20
* A good website for linuxsoftware:    |      (o_      *
*       http://www.freshmeat.net       |      //\      *
*           Linux rulez!    ;-)        |      V_/_     *
* GnuPG-Key: 0xBE21BD90 | Tux: #155220 | ICQ: 64035650 *



--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="lspci.asc"

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, medium devsel, latency 64
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: f0000000-f7ffffff

00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at fff0 [size=16]

00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at ff80 [size=32]

00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Flags: medium devsel, IRQ 9

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
	Subsystem: Toshiba America Info Systems Internal V.90 Modem
	Flags: bus master, medium devsel, latency 0, IRQ 3
	Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
	I/O ports at 02f8 [size=8]
	I/O ports at 1c00 [size=256]
	Capabilities: [f8] Power Management version 2

00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
	Subsystem: Toshiba America Info Systems FIR Port Type-DO
	Flags: bus master, slow devsel, latency 64, IRQ 11
	I/O ports at ff60 [size=32]
	Capabilities: [80] Power Management version 2

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, slow devsel, latency 168, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, slow devsel, latency 168, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00002000-000020ff
	16-bit legacy interface ports at 0001

00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at efff8000 (32-bit, non-prefetchable) [size=32K]
	I/O ports at ff00 [size=64]
	I/O ports at fefc [size=4]
	Capabilities: [50] Power Management version 1

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-/IX (rev 11) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
	Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
	Capabilities: [80] AGP version 1.0

14:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
	Subsystem: Xircom Cardbus Ethernet 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 1000 [size=128]
	Memory at 10800000 (32-bit, non-prefetchable) [size=2K]
	Memory at 10800800 (32-bit, non-prefetchable) [size=2K]
	Expansion ROM at 10400000 [size=16K]
	Capabilities: [dc] Power Management version 1

14:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
	Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
	Flags: medium devsel, IRQ 11
	I/O ports at 1080 [size=8]
	Memory at 10801000 (32-bit, non-prefetchable) [size=2K]
	Memory at 10801800 (32-bit, non-prefetchable) [size=2K]
	Expansion ROM at 10404000 [size=16K]
	Capabilities: [dc] Power Management version 1


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.asc"
Content-Transfer-Encoding: quoted-printable

Linux version 2.4.3-ac12 (root@hawkeye) (gcc version 2.95.4 20010319 (Debia=
n prerelease)) #4 Sun Apr 22 21:08:07 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007fe0000 (usable)
 BIOS-e820: 0000000007fe0000 - 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000007ff0000 - 0000000008000000 (reserved)
 BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
 BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
 BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 32736
zone(0): 4096 pages.
zone(1): 28640 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3DTestkernel ro root=3D304 BOOT_FILE=3D/boo=
t/vmlinuz-2.4.3-ac12
Initializing CPU#0
Detected 497.568 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 992.87 BogoMIPS
Memory: 126892k/130944k available (938k kernel code, 3664k reserved, 242k d=
ata, 64k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfee03, last bus=3D21
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:05.0
PCI: Found IRQ 11 for device 00:0b.0
PCI: The same IRQ used for device 01:00.0
PCI: Found IRQ 11 for device 00:0b.1
PCI: The same IRQ used for device 00:0c.0
  got res[10000000:10000fff] for resource 0 of PCI device 1179:0617
  got res[10001000:10001fff] for resource 0 of PCI device 1179:0617
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 84266kB/28088kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller on PCI bus 00 dev 29
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
hda: TOSHIBA MK6014MAP, ATA DISK drive
hdc: CD-224E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 11733120 sectors (6007 MB), CHS=3D730/255/63
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
Real Time Clock Driver v1.10d
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
fatfs: bogus cluster size
fatfs: bogus cluster size
reiserfs: checking transaction log (device 03:04) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 64k freed
Adding Swap: 265064k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:0b.0
PCI: The same IRQ used for device 01:00.0
PCI: Found IRQ 11 for device 00:0b.1
PCI: The same IRQ used for device 00:0c.0
Yenta IRQ list 04b0, PCI irq11
Socket status: 30000020
Yenta IRQ list 04b0, PCI irq11
Socket status: 30000007
cs: cb_alloc(bus 20): vendor 0x115d, device 0x0003
  got res[1000:107f] for resource 0 of PCI device 115d:0003
  got res[10800000:108007ff] for resource 1 of PCI device 115d:0003
  got res[10800800:10800fff] for resource 2 of PCI device 115d:0003
  got res[10400000:10403fff] for resource 6 of PCI device 115d:0003
PCI: Enabling device 14:00.0 (0000 -> 0003)
  got res[1080:1087] for resource 0 of PCI device 115d:0103
  got res[10801000:108017ff] for resource 1 of PCI device 115d:0103
  got res[10801800:10801fff] for resource 2 of PCI device 115d:0103
  got res[10404000:10407fff] for resource 6 of PCI device 115d:0103
PCI: Enabling device 14:00.1 (0000 -> 0003)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x330-0x337 0x378-0x37f 0x3f8-0x=
3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
PCI: Setting latency timer of device 14:00.0 to 64
eth0: Xircom cardbus revision 3 at irq 11=20
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
serial_cs: ParseTuple: No more items
usb-uhci.c: $Revision: 1.251 $ time 21:10:52 Apr 22 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:05.2
usb-uhci.c: USB UHCI at I/O 0xff80, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=3D0x10 cfgB=3D0x4b
0x378: ECP settings irq=3D7 dma=3D3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).

--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="lsmod.asc"
Content-Transfer-Encoding: quoted-printable

Module                  Size  Used by
serial_cs               4416   0  (unused)
serial                 43264   0  [serial_cs]
xircom_cb               4944   0  (unused)
cb_enabler              2368   0  (unused)
parport_pc             18512   1  (autoclean)
lp                      4880   0  (autoclean)
parport                24320   1  (autoclean) [parport_pc lp]
mousedev                3808   0  (unused)
hid                    11536   0  (unused)
input                   3200   0  [mousedev hid]
usb-uhci               21552   0  (unused)
ds                      6384   2  [serial_cs cb_enabler]
yenta_socket            8272   2=20
pcmcia_core            38080   0  [serial_cs cb_enabler ds yenta_socket]
usbcore                46224   1  (autoclean) [hid usb-uhci]

--pQhZXvAqiZgbeUkD--

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE640iKAxev2L4hvZARAjhEAJ4lg1zImc+cuCyw58vK5Lv7Nzq9ogCePKPy
Ah7ZqIU/MKdpwDzbtZ5XQ0I=
=35BJ
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
