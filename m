Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135372AbQLOAoI>; Thu, 14 Dec 2000 19:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135400AbQLOAn6>; Thu, 14 Dec 2000 19:43:58 -0500
Received: from ns.snowman.net ([63.80.4.34]:267 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S135372AbQLOAny>;
	Thu, 14 Dec 2000 19:43:54 -0500
Date: Thu, 14 Dec 2000 19:10:18 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
Message-ID: <20001214191018.Q26953@ns>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netfilter <netfilter@us5.samba.org>
In-Reply-To: <20001214184544.O26953@ns> <Pine.LNX.4.10.10012141552180.12695-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M2XkPJ45YXpBrBm3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012141552180.12695-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 14, 2000 at 03:56:08PM -0800
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 8:28am  up 89 days, 12:22,  4 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M2XkPJ45YXpBrBm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Linus Torvalds (torvalds@transmeta.com) wrote:
>=20
>=20
> On Thu, 14 Dec 2000, Stephen Frost wrote:
> >=20
> > 	Any idea if these issues would cause a general slow-down of a
> > machine?  For no apparent reason after 5 days running 2.4.0test12
> > everything going through my firewall (set up using iptables) I got about
> > 100ms time added on to pings and traceroutes.
>=20
> Probably not related to that particular bug - the netfilter issue has
> apparently been around forever, and it was just some changes in IP
> fragmentation that just made it show up as an oops.=20
>=20
> A 100ms delay sounds like some interrupt shut up or similar (and then
> timer handling makes it limp along).

	Hmm, it's happening on all interfaces.  No oops or anything in
the logs/dmesg.  I can check console when I get home, but I doubt there's
anything of interest.  All cards are 3com 3c905's.

	Does this info help any?

=3D=3D=3D# cat /proc/interrupts
           CPU0       CPU1      =20
  0:   29170703   23315160    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:     258815     247131    IO-APIC-edge  serial
  4:        101        120    IO-APIC-edge  serial
  5:    1748096    1692143   IO-APIC-level  usb-uhci, eth0
  8:          1          0    IO-APIC-edge  rtc
 10:    1199227    1146776   IO-APIC-level  eth2
 12:    2367239    2389531   IO-APIC-level  eth1
 14:     210804     193050    IO-APIC-edge  ide0
 15:       7052       6391    IO-APIC-edge  ide1
NMI:   52509191   52509191=20
LOC:   52472090   52472489=20
ERR:          0
=3D=3D=3D# sleep 10
=3D=3D=3D# cat /proc/interrupts
           CPU0       CPU1      =20
  0:   29171536   23315741    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:     258818     247134    IO-APIC-edge  serial
  4:        101        120    IO-APIC-edge  serial
  5:    1748295    1692372   IO-APIC-level  usb-uhci, eth0
  8:          1          0    IO-APIC-edge  rtc
 10:    1199230    1146777   IO-APIC-level  eth2
 12:    2367244    2389534   IO-APIC-level  eth1
 14:     210833     193050    IO-APIC-edge  ide0
 15:       7052       6391    IO-APIC-edge  ide1
NMI:   52510605   52510605=20
LOC:   52473504   52473902=20
ERR:          0
=3D=3D=3D#=20

Boot log:
--------
Linux version 2.4.0-test12 (root@whitegryphon) (gcc version 2.95.2 20000220=
 (Debian GNU/Linux)) #1 SMP Wed Dec 6 01:53:29 EST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000fefd000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000002000 @ 000000000fffd000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f6e80
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
Bus #0 is PCI  =20
Bus #1 is ISA  =20
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 1, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 1, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 1, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 1, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 1, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 1, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 1, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 1, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 1, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 1, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 1, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 1, IRQ 0b, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 1, IRQ 0a, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 1, IRQ 0c, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 1, IRQ 05, APIC ID 2, APIC INT 13
Lint: type 3, pol 1, trig 1, bus 1, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 1, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D301 BOOT_FILE=3D/vml=
inuz console=3Dtty0 console=3DttyS0
Initializing CPU#0
Detected 300.688 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 599.65 BogoMIPS
Memory: 255312k/262132k available (1468k kernel code, 6436k reserved, 96k d=
ata, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 00
per-CPU timeslice cutoff: 365.75 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 1000000
Getting ID: e000000
Getting LVT0: 8700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Initializing CPU#1
Waiting for send to finish...
CPU#1 (phys ID: 0) waiting for CALLOUT
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 601.29 BogoMIPS
Stack at about cfff3fbc
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
OK.
CPU1: Intel Celeron (Mendocino) stepping 00
CPU has booted.
Before bogomips.
Total of 2 processors activated (1200.95 BogoMIPS).
Before bogocount - setting activated=3D1.
Boot done.
ENABLING IO-APIC IRQs
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
=2E.TIMER: vector=3D49 pin1=3D2 pin2=3D0
activating NMI Watchdog ... done.
testing the IO APIC.......................

=2E................................... done.
calibrating APIC timer ...
=2E.... CPU clock speed is 300.7153 MHz.
=2E.... host bus clock speed is 66.8254 MHz.
cpu: 0, clocks: 668254, slice: 222751
CPU0<T0:668240,T1:445488,D:1,S:222751,C:668254>
cpu: 1, clocks: 668254, slice: 222751
CPU1<T0:668240,T1:222736,D:2,S:222751,C:668254>
checking TSC synchronization across CPUs: passed.
Setting commenced=3D1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC24300L, ATA DISK drive
hdc: FUJITSU M1638TAU, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=3D524/255/63, (U)DMA
hdc: 5023680 sectors (2572 MB) w/128KiB Cache, CHS=3D4983/16/63, DMA
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdc: [PTBL] [622/128/63] hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
early initialization of device teql0 is deferred
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PC=
I enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10d
3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.co=
m/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905 Boomerang 100baseTx at 0xd000,  00:60:97:7f:65:89, IRQ=
 5
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
eth1: 3Com PCI 3c905 Boomerang 100baseTx at 0xb800,  00:60:97:80:75:bb, IRQ=
 12
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
eth2: 3Com PCI 3c905B Cyclone 100baseTx at 0xb400,  00:10:5a:01:f6:ec, IRQ =
10
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus]
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xd400, IRQ 5
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2047 buckets, 16376 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 128516k swap-space (priority -1)
eth0: first available media type: MII
eth1: first available media type: MII
eth2: using NWAY autonegotiation
--------

		Stephen

--M2XkPJ45YXpBrBm3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OWFqrzgMPqB3kigRAjWqAJ9lVhsQlBDooAcropZhuLAViIBoUACfXTnh
tVnjtTV0U7ONhlLJd6ZlMEY=
=UesH
-----END PGP SIGNATURE-----

--M2XkPJ45YXpBrBm3--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
