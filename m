Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSDPK1x>; Tue, 16 Apr 2002 06:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312316AbSDPK1w>; Tue, 16 Apr 2002 06:27:52 -0400
Received: from support.kovair.com ([209.66.77.36]:13747 "EHLO tbdnetworks.com.")
	by vger.kernel.org with ESMTP id <S312031AbSDPK1r>;
	Tue, 16 Apr 2002 06:27:47 -0400
Subject: Re: [PATCH] 2.5.8 IDE 36
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBBECCF.1050000@evision-ventures.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-OwLextlAwTr9bx/ti1Bb"
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 03:20:10 -0700
Message-Id: <1018952413.12635.42.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OwLextlAwTr9bx/ti1Bb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I can for sure provide a patch, testing will take a bit longer because I
currently only use 2.4.x. Give me 24h...

--nk

On Tue, 2002-04-16 at 02:20, Martin Dalecki wrote:
> Norbert Kiesel wrote:
> > On Tue, 2002-04-16 at 01:21, Martin Dalecki wrote:
> >=20
> >>Norbert Kiesel wrote:
> >>
> >>>Hi,
> >>>
> >>>while trying to understand recent kernel changes I stumbled over
> >>>the following patch to
> >>>=20
> >>>diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
> >>>--- linux-2.5.8/drivers/ide/ide.c	Tue Apr 16 06:01:07 2002
> >>>+++ linux/drivers/ide/ide.c	Tue Apr 16 05:38:37 2002
> >>>
> >>>...
> >>> while (i > 0) {
> >>>-		u32 buffer[16];
> >>>-		unsigned int wcount =3D (i > 16) ? 16 : i;
> >>>-		i -=3D wcount;
> >>>-		ata_input_data (drive, buffer, wcount);
> >>>+		u32 buffer[SECTOR_WORDS];
> >>>+		unsigned int count =3D (i > 1) ? 1 : i;
> >>>+
> >>>+		ata_read(drive, buffer, count * SECTOR_WORDS);
> >>>+		i -=3D count;
> >>> 	}
> >>> }
> >>>...
> >>>
> >>>While the old code called ata_input_read() with [0:16] as last param,
> >>>the new code calls the (renamed) ata_read() with either 0 or 16. Also,
> >>>the new code loops "i" times while the old code looped "i/16+1" times.
> >>>Was this intended or should the patch better read like:
> >>>
> >>>...
> >>> while (i > 0) {
> >>>-               u32 buffer[16];
> >>>-               unsigned int wcount =3D (i > 16) ? 16 : i;
> >>>-               i -=3D wcount;
> >>>-               ata_input_data (drive, buffer, wcount);
> >>>+               u32 buffer[SECTOR_WORDS];
> >>>+               unsigned int count =3D max(i, SECTOR_WORDS);
> >>>+
> >>>+               ata_read(drive, buffer, count);
> >>>+               i -=3D count;
> >>>        }
> >>> }
> >>>...
> >>>
> >>>so long
> >>
> >>It's fine as it is I think. Please look up at the initialization of i.
> >>I have just divded the SECTROT_WORDS (=3D=3D 16) factor out
> >>of all the places above ata_read.
> >>
> >=20
> >=20
> > You are right (assuming SECTOR_WORDS =3D=3D 16. I was looking it up in
> > 2.4.18 where SECTOR_WORDS is 512/4 =3D=3D 128).  However, the new code =
looks
> > overly complicated (at least for me, easily proven by my wrong first
> > email :-), given that count is now always =3D=3D 1.  Would the followin=
g not
> > be nicer?
> >=20
> > 	int i;
> >=20
> > 	if (drive->type !=3D ATA_DISK)
> > 		return;
> >=20
> > 	for (i =3D min(drive->mult_count, 1); i > 0; i--) {
> > 		u32 buffer[SECTOR_WORDS];
> >=20
> > 		ata_read(drive, buffer, SECTOR_WORDS);
> > 	}
> >=20
> > (This of course assumes that drive->mult_count is always non-negative)
>=20
> Yes this looks nicer. Would you mind to test it and drop me
> a patch?
>=20
--=20
Key fingerprint =3D 6C58 F18D 4747 3295 F2DB  15C1 3882 4302 F8B4 C11C

--=-OwLextlAwTr9bx/ti1Bb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8u/raOIJDAvi0wRwRAj3lAJsEBVlda+JD2MEZi8CwcICAJ/Kz7ACglFHM
GcrfnRP/8el6pMIkozogJg8=
=eBaV
-----END PGP SIGNATURE-----

--=-OwLextlAwTr9bx/ti1Bb--

