Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130272AbRBVBOW>; Wed, 21 Feb 2001 20:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBVBON>; Wed, 21 Feb 2001 20:14:13 -0500
Received: from zeus.kernel.org ([209.10.41.242]:50915 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130272AbRBVBN6>;
	Wed, 21 Feb 2001 20:13:58 -0500
Date: Wed, 21 Feb 2001 17:16:53 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ext2 superblock issue on 2.4.1-ac20
Message-ID: <20010221171653.C671@turbolinux.com>
In-Reply-To: <20010221163514.A671@turbolinux.com> <E14VjyB-000391-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <E14VjyB-000391-00@the-village.bc.nu>; from Alan Cox on Thu, Feb 22, 2001 at 12:50:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2001 at 12:50:52AM +0000, Alan Cox wrote:
> > 	I just oldconfiged linux kernel with my 2.4.1 .config. When I boot the=
 new
> > 2.4.1-ac20 kernel, I get a message saying that my ext2 superblock is co=
rrup=3D
> > ted.
> > I get a message asking me to run e2fsck -b 8193 <...hdd dev..>
> > My 2.4.0-ac4 that I've been running for more than 2-3 weeks now has no =
prob=3D
> > lems
> > booting though.
> >=20
> > 	What am I doing wrong ? I would be glad to give more info.
>=20
> Sounds like a driver change broke the handling for your disks or re-order=
ed
> them.=20
>=20
> What hardware

e2fsprogs version : e2fsprogs-1.18-1

cat /proc/partitions

[psubash@psubash[ttypts/0]/tmp]$ cat /proc/partitions                      =
                                                              [05:11pm/02-2=
1-01]
major minor  #blocks  name
3     0   20044080 hda
3     1    2048256 hda1
3     2    3076447 hda2
3     3     128520 hda3
3     4   14787832 hda4

[psubash@psubash[ttypts/0]/proc]$ cat interrupts                           =
                                                              [05:14pm/02-2=
1-01]
           CPU0
  0:     448484          XT-PIC  timer
  1:      12572          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       9908          XT-PIC  eth0
  9:          0          XT-PIC  usb-uhci
 10:     222641          XT-PIC  EMU10K1
 12:      31073          XT-PIC  PS/2 Mouse
 14:     264281          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
ERR:          0

[psubash@psubash[ttypts/0]/proc]$ cat filesystems                          =
                                                              [05:15pm/02-2=
1-01]
nodev   sockfs
nodev   shm
nodev   pipefs
nodev   proc
        ext2
        iso9660
nodev   autofs
nodev   nfs
nodev   devpts


[psubash@psubash[ttypts/0]/proc]$ cat mounts                               =
                                                              [05:14pm/02-2=
1-01]
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/hda4 /home ext2 rw 0 0
/dev/hda2 /usr ext2 rw 0 0
none /dev/pts devpts rw 0 0

[psubash@psubash[ttypts/0]/proc]$ cat devices                              =
                                                              [05:15pm/02-2=
1-01]
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 14 sound
128 ptm
136 pts
162 raw
180 usb
202 cpu/msr
203 cpu/cpuid
Block devices:
  2 fd
  3 ide0
 22 ide1


cat /proc/cpuinfo

[psubash@psubash[ttypts/0]/tmp]$ cat /proc/cpuinfo                         =
                                                              [05:11pm/02-2=
1-01]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 548.743
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov =
pat pse36 mmx fxsr sse
bogomips        : 1094.45

disk info

[psubash@psubash[ttypts/0]~]$ sudo hdparm -gi /dev/hda                     =
                                                              [05:03pm/02-2=
1-01]
/dev/hda:
 geometry     =3D 2495/255/63, sectors =3D 40088160, start =3D 0
 Model=3DIBM-DPTA-372050, FwRev=3DP76OA30A, SerialNo=3DJMYJMHL1856
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D34
 BuffType=3D3(DualPortCache), BuffSize=3D1961kB, MaxMultSect=3D16, MultSect=
=3Doff
 DblWordIO=3Dno, maxPIO=3D2(fast), DMA=3Dyes, maxDMA=3D2(fast)
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes
 LBA CHS=3D1023/256/63 Remapping, LBA=3Dyes, LBAsects=3D40088160
 tDMA=3D{min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2

lspci -vvxx output

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (r=
ev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 64 set
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: <available only to root>
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev=
 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 128 set
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	Memory behind bridge: f4100000-f4ffffff
	Prefetchable memory behind bridge: fc000000-fdffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 01 20 02 03 00 04 06 00 80 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 f0 00 a0 22
20: 10 f4 f0 f4 00 fc f0 fd 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0 set
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-i=
f 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at 10c0 [size=3D16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: c1 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-=
if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1080 [size=3D32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 0=
7)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 2 min, 20 max, 64 set
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 10a0 [size=3D32]
	Capabilities: <available only to root>
00: 02 11 02 00 05 01 90 02 07 00 01 04 00 40 80 00
10: a1 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 27 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 02 14

00:0e.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 0: I/O ports at 10d0 [size=3D8]
	Capabilities: <available only to root>
00: 02 11 02 70 05 01 90 02 07 00 80 09 00 40 80 00
10: d1 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (r=
ev 30)
	Subsystem: 3Com Corporation: Unknown device 9055
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 10 min, 10 max, 80 set, cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=3D128]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: <available only to root>
00: b7 10 55 90 17 01 10 02 30 00 00 02 08 50 00 00
10: 01 10 00 00 00 00 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0a 0a

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev =
04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SDRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 16 min, 32 max, 128 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=3D32M]
	Region 1: Memory at f4100000 (32-bit, non-prefetchable) [size=3D16K]
	Region 2: Memory at f4800000 (32-bit, non-prefetchable) [size=3D8M]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: <available only to root>
00: 2b 10 25 05 07 00 90 02 04 00 00 03 08 80 00 00
10: 08 00 00 fc 00 00 10 f4 00 00 80 f4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 38 03
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20


--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | I give you the man who -- the man who --
of a GNU generation   -o)  | uh, I forgets the man who?   -- Beauregard=20
Kernel 2.4.0-ac4      /\\  | Bugleboy=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6lGiF5UrYeFg/7bURAsGkAJ91sUe7maUR1MOU3KEolHbEaF8sfACgoQf8
KQhJ7AhTbS0vq6m87S0Ej88=
=y8H/
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
