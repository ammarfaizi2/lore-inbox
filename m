Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTJERHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbTJERHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:07:24 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:33673 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263172AbTJERHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:07:19 -0400
Date: Sun, 5 Oct 2003 18:07:16 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SiI3112 DMA? (2.6.0-test6)
Message-ID: <20031005170716.GG9052@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1065347429.1441.17.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <1065347429.1441.17.camel@paragon.slim>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 05, 2003 at 11:50:29AM +0200, Jurgen Kramer wrote:
> I am currently running 2.6.0-test6 on an old PII which has a SiI3112
> SATA PCI card in one of its PCI slots. It seems that the SiI3112 is not
> using DMA so now it is even running slower then the onboard PIIX4 IDE
> controller.
>=20
> Is DMA supported on the Si3112? DMA is not being enabled by the SiI3112
> card's BIOS (this is a cheap PCI card):
>=20
> SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0b.0
> SiI3112 Serial ATA: chipset revision 2
> SiI3112 Serial ATA: 100% native mode on irq 11
>     ide2: MMIO-DMA at 0xd8807000-0xd8807007, BIOS settings: hde:pio,
> hdf:pio
>     ide3: MMIO-DMA at 0xd8807008-0xd880700f, BIOS settings: hdg:pio,
> hdh:pio
> hde: ST3120026AS, ATA DISK drive
> ide2 at 0xd8807080-0xd8807087,0xd880708a on irq 11

   I get this, too, on 2.4.22-ac2, and I've had someone else tell me
about the same issue with their card (don't know what kernel he's
running).

   This is on the SIIG 2-channel PCI card (SA-SIG212). If I copy
anything large (a couple of hundred megabytes of data) to the disk,
then the data rate to the disk drops slowly (on what appears to be an
exponential decay), and then drops to zero for about 7-10 seconds,
followed by a complete system lock-up for 1-2 seconds when the
transfer rate goes through the roof, followed by another 7-10 seconds
of no transfer and another lock-up, and so on. (I'm using gkrellm to
get this data throughput information).

   Filesystem is ReiserFS, FWIW. More details below.

   Hugo.

=46rom dmesg:

[snip]
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SiI3112 Serial ATA: IDE controller at PCI slot 00:0d.0
PCI: Found IRQ 12 for device 00:0d.0
PCI: Sharing IRQ 12 with 00:09.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
ALI15X3: IDE controller at PCI slot 00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:pio, hdh:pio
hda: ST3120026AS, ATA DISK drive
blk: queue c0325d60, I/O limit 4095Mb (mask 0xffffffff)
[snip]

vlad:~# cat /proc/ide/siimage=20

Controller: 0
SiI3112 Chipset.
MMIO Base 0xd5800000
MMIO-DMA Base 0xd5800000
MMIO-DMA Base 0xd5800008

vlad:~# hdparm /dev/ide/host0/bus0/target0/lun0/disc=20

/dev/ide/host0/bus0/target0/lun0/disc:
 multcount    =3D 16 (on)
 IO_support   =3D  1 (32-bit)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  1 (on)
 keepsettings =3D  1 (on)
 readonly     =3D  0 (off)
 readahead    =3D  8 (on)
 geometry     =3D 14593/255/63, sectors =3D 234441648, start =3D 0

(This was after hdparm -X70 -d1 -c1 -K1)

vlad:~# hdparm -I /dev/ide/host0/bus0/target0/lun0/disc=20

/dev/ide/host0/bus0/target0/lun0/disc:

ATA device, with non-removable media
        Model Number:       ST3120026AS                            =20
        Serial Number:      3JT059GT           =20
        Firmware Revision:  3.05   =20
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 2=20
        Supported: 6 5 4 3=20
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  234441648
        LBA48  user addressable sectors:  234441648
        device size with M =3D 1024*1024:      114473 MBytes
        device size with M =3D 1000*1000:      120034 MBytes (120 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard
        R/W multiple sector transfer: Max =3D 16  Current =3D 16
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=
=20
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4=20
             Cycle time: no flow control=3D240ns  IORDY flow control=3D120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command=20
           *    Device Configuration Overlay feature set=20
           *    48-bit Address feature set=20
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test=20
           *    SMART error logging=20
Security:=20
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct

vlad:~# hdparm -i /dev/ide/host0/bus0/target0/lun0/disc=20

/dev/ide/host0/bus0/target0/lun0/disc:

 Model=3DST3120026AS, FwRev=3D3.05, SerialNo=3D3JT059GT
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D4
 BuffType=3Dunknown, BuffSize=3D8192kB, MaxMultSect=3D16, MultSect=3D16
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D234441648
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4=20
 DMA modes:  mdma0 mdma1 mdma2=20
 UDMA modes: udma0 udma1 udma2=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:=20

 * signifies the current active mode

--=20
=3D=3D=3D Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk=
 =3D=3D=3D
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
                  --- Be pure. Be vigilant. Behave. ---                 =20

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/gE/EssJ7whwzWGARApUYAJ9o69lugaD9mcEN6Pk7FyP3VOND7gCfeI5L
jnoIXEhLJ3NlHQubpX5VNrA=
=OTXf
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
