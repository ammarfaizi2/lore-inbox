Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbTCSUrl>; Wed, 19 Mar 2003 15:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbTCSUrl>; Wed, 19 Mar 2003 15:47:41 -0500
Received: from 210-55-152-172.dialup.xtra.co.nz ([210.55.152.172]:260 "EHLO
	riven.neverborn.ORG") by vger.kernel.org with ESMTP
	id <S263149AbTCSUqr>; Wed, 19 Mar 2003 15:46:47 -0500
Date: Fri, 21 Mar 2003 20:57:34 +1200
From: "leon j. breedt" <ljb@neverborn.org>
To: John Bradford <john@grabjohn.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ASUS P4PE IDE problems in 2.4.21-pre5
Message-ID: <20030321085734.GA3094@riven.neverborn.ORG>
References: <20030320110303.GA8759@riven.neverborn.ORG> <200303190901.h2J91vov000316@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <200303190901.h2J91vov000316@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2003 at 09:01:57AM +0000, John Bradford wrote:
> Alan - I've cc'ed you in on this, because I think it might point to a
> more subtle disk/controller interaction/bug.  Feel free to ignore if
> it's not :-).
Hi Alan, its the Intel ICH4 chipset, I've tried it on 2.4.21-pre5-ac3 too,
to make sure its not something funny in the 2.4.21-pre5-gss kernel, same
problem occurred.

I've attached the lspci -vv output, and the /proc/ide/hda/settings file.

> No, you should get the same results.
On further investigation, I do get valid results on /dev/hdb, but i can't
get /dev/hda (the WDC WD800JB-00CRA1) to give me sane test results. i've di=
sabled
S.M.A.R.T. in the BIOS, done a cold boot, and not poked at the drive at all
with smartctl before running hdparm, and i still get the invalid results:

/dev/hda:
 Timing buffer-cache reads:   -3008 MB in  0.00 seconds =3D  -inf kB/sec
 Timing buffered disk reads:  -1504 MB in  0.00 seconds =3D  -inf kB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.

/dev/hdb:
 Timing buffer-cache reads:   128 MB in  0.27 seconds =3D474.07 MB/sec
 Timing buffered disk reads:  64 MB in  1.40 seconds =3D 45.71 MB/sec

I can't feel a noticable difference in speed for hda though.

leon.

--=20
in the beginning, was the code.


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=settings

name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                9729            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
init_speed              69              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: ee000000-ef5fffff
	Prefetchable memory behind bridge: ef700000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at d000 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at ed800000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: ec000000-ed7fffff
	Prefetchable memory behind bridge: ef600000-ef6fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4600] (rev a3) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2890
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at ef800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at ef7e0000 [disabled] [size=128K]
	Capabilities: <available only to root>

02:05.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 Gigabit Ethernet (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a9
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ed000000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at ef6f0000 [disabled] [size=64K]
	Capabilities: <available only to root>

02:0e.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs: Unknown device 1002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=64]
	Capabilities: <available only to root>

02:0e.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
	Subsystem: Creative Labs: Unknown device 0060
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at b400 [size=8]
	Capabilities: <available only to root>

02:0e.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at ec800000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>


--zYM0uCDKw75PZbzx--

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+etP+RWcl5mzp4f4RAtxMAJwPal7wskHcdY1WV4D0hhm/i8N42gCfUItX
NOI5VXCZ5G2FRVJ2bsZvshA=
=zcOb
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
