Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSGNQuF>; Sun, 14 Jul 2002 12:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSGNQuE>; Sun, 14 Jul 2002 12:50:04 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:39193 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316912AbSGNQuD>; Sun, 14 Jul 2002 12:50:03 -0400
Date: Sun, 14 Jul 2002 18:52:54 +0200
From: Kurt Garloff <garloff@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Joerg Schilling <schilling@fokus.gmd.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714165254.GC26336@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	Joerg Schilling <schilling@fokus.gmd.de>,
	linux-kernel@vger.kernel.org
References: <200207141324.g6EDOvUe019079@burner.fokus.gmd.de> <Pine.NEB.4.44.0207141629440.4981-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0207141629440.4981-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2002 at 04:35:02PM +0200, Adrian Bunk wrote:
> On Sun, 14 Jul 2002, Joerg Schilling wrote:
> >...
> > If a CD-ROM does not support ATAPI, you are not able to
> >
> > -	open/close/lock the door.
>=20
> Look at drivers/cdrom/mcdx.c, a driver for proprietary (the device is
> connected via an ISA card to the computer) single and double speed Mitsumi
> CD-ROM drives. This driver supports to open the door although the drive
> definitely doesn't support ATAPI...

=2E..nor is it an IDE(ATA) device which this discussion is about.

BTW, I consider this discussion ridiculous and I wonder whether I=E4m the o=
nly
one:
J=F6rg, HPA and some others want to stick to the current SCSI high-level
drivers and offer more flexible transport (and to a certain extent
command) layer below. Other people are scared of some of the uglinesses of
today's SCSI code and want to offer general high-level driver (that they do
not call SCSI) with some flexible command and tranport layer below.

It's more a question of how you name it then of technical details.
And maybe in how far you allow current software (which is tailored well to
deal with our current SCSI code) to work with the future solution.

A good portion of the current SCSI midlayer code would be eliminated or
changed anyway, no matter how you call it

Given the love of Linus for the SCSI code, I would suggest not to name it
SCSI any more, but rather generic block code. I also matches reality
somewhat better.

But what we need to do then is to offer a generic interface (similar to sg)
to send down commands to the devices. Otherwise, we'd break scanners,
CD-Writers, ... which currently rely on this interface. And as we don't want
to have kernel drivers for all those, there's no alternative.=20
(And it should be sg like, otherwise we put a lot of load on application
developers such as J=F6rg, which I would call bad policy.)

Device management software will certainly also want to speak to the devices
via some exposed low-level interface, BTW. Maybe we can expose enough
information via driverfs to solve the naming stuff reasonably, i.e. allow
naming by topology, device and content, but still some things will and
should not be done in kernel space.

sg does most of this for 'real' and 'fake' (ATAPI,usb-storage,sbp2) nowadays
pretty well and we should not just scratch that because another idea looks
very sexy.

Groetjes,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9MaxlxmLh6hyYd04RAmXMAKDaeZmwdPDM8jHRDDrEWVg0fnsN4gCgrR85
PTYP+FPeaYditsmO7ATCmWQ=
=uMMy
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
