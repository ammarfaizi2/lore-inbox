Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUAFREU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUAFREU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:04:20 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:41677 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264527AbUAFREP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:04:15 -0500
Date: Tue, 6 Jan 2004 17:04:14 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
Message-ID: <20040106170414.GF17606@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
	linux-kernel@vger.kernel.org
References: <20040106135634.A5825@beton.cybernet.src> <20040106132533.GD17606@carfax.org.uk> <20040106174714.B6567@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Content-Disposition: inline
In-Reply-To: <20040106174714.B6567@beton.cybernet.src>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2004 at 05:47:14PM +0100, Karel Kulhav=FD wrote:
> On Tue, Jan 06, 2004 at 01:25:33PM +0000, Hugo Mills wrote:
> >    The AAR-1210SA has a BIOS which turns off interrupts unexpectedly.
> > Jeff Garzik released a patch[1] earlier today that addresses this
> > problem in the libata driver.
> >=20
> >    Hugo.
> >=20
> > [1] http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107338181210727&=
w=3D2
>=20
> Tried that patch however no remedy. Interesting is maybe the information =
the
> controller reports on hde. The patch includes something with interrupts
> of IDE0 and IDE1.
>=20
> Tried to "extrapolate" the stuff in sata_sil.c logically (sorry for not k=
nowing
> what's going on here) with bitmasks 1<<25, 1<<26 and adding them to the f=
ew
> lines that reenable the interrupts, but this also didn't work.
>=20
> In fact, it doesn't even get into the workaround code at the moment the s=
ystem
> freezes temporarily.
>=20
> I managed (after long wait) to get the system boot up and captured the
> dmesg:

[snip]
> ### THIS IS MY COMMENT Entering __devinit siimage_init_one
> Adaptec AAR-1210SA: IDE controller at PCI slot 0000:03:02.0
> PCI: Found IRQ 7 for device 0000:03:02.0
> PCI: Sharing IRQ 7 with 0000:00:1f.3
> Adaptec AAR-1210SA: chipset revision 2
> Adaptec AAR-1210SA: 100% native mode on irq 7
>     ide2: MMIO-DMA at 0xf8848c00-0xf8848c07, BIOS settings: hde:pio, hdf:=
pio
>     ide3: MMIO-DMA at 0xf8848c08-0xf8848c0f, BIOS settings: hdg:pio, hdh:=
pio
> hde: Maxtor 7Y250M0, ATA DISK drive
> ide2 at 0xf8848c80-0xf8848c87,0xf8848c8a on irq 7
> hdg: Maxtor 7Y250M0, ATA DISK drive
> ide3 at 0xf8848cc0-0xf8848cc7,0xf8848cca on irq 7
> hde: max request size: 7KiB
> ### Here the first freeze occurs
> hde: lost interrupt
> ### Another freeze
> hde: lost interrupt
> ### Another freeze... etc.
> hde: lost interrupt
> hde: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=3D30515/255/63
> hde: lost interrupt
> hde: lost interrupt
>  /dev/ide/host2/bus0/target0/lun0:<4>hde: dma_timer_expiry: dma status =
=3D=3D 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
[snip]

   It looks like you're using the wrong driver here. Jeff's patch is
for libata, which is an implementation of SATA drivers in the SCSI
layer. You'll find the libata driver options under the SCSI menu in
the kernel config. Try disabling the pure IDE layer driver (in
"ATA/ATAPI/MFM/RLL support"), and go to the "SCSI low-level drivers"
menu, and enable "Serial ATA (SATA) support".

CONFIG_SCSI_SATA=3Dy
CONFIG_SCSI_SATA_SIL=3Dy

   Hugo.

--=20
=3D=3D=3D Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk=
 =3D=3D=3D
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- You can get more with a kind word and a 2"x4" than you can ---   =20
                         with just a kind word.                         =20

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+uqNssJ7whwzWGARAmITAKCC1mheBV1CkvlnYqhkSP1HN+YRBACeKyZ6
Slmw0nIlmBTW9RtfhZBeZmA=
=LqqB
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
