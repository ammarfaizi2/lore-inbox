Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSBZS7l>; Tue, 26 Feb 2002 13:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292701AbSBZS73>; Tue, 26 Feb 2002 13:59:29 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:52929 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S292715AbSBZS7N>; Tue, 26 Feb 2002 13:59:13 -0500
Date: Tue, 26 Feb 2002 13:59:07 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
Message-ID: <20020226185907.GG803@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226173038.GD803@ufies.org> <3C7BC897.8D607D08@zip.com.au> <20020226175819.GE803@ufies.org> <20020226181510.GF803@ufies.org> <3C7BD91C.3B758704@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
Content-Disposition: inline
In-Reply-To: <3C7BD91C.3B758704@zip.com.au>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you, I have done something similar and that solve it in my case at
least. This driver was clearly not designed for cardbus.

I am still looking for my resume/suspend problem.
Hope to find the solution soon.

Christophe

On Tue, Feb 26, 2002 at 10:51:08AM -0800, Andrew Morton wrote:
> christophe barb=E9 wrote:
> >=20
> > Ok I have found why.
> > When I resinsert the card, the driver give it a new id (this driver
> > supports multiple cards) and the option as I set it is only defined for
> > the card #0. I would expect that the driver give the same id back.
> >=20
>=20
> hrm.  OK, hotplugging and slot-positional module parameters weren't
> designed to live together.
>=20
> This should fix it for single cards.   For multiple cards, you'll
> have to make sure you eject them in reverse scan order :)
>=20
> Index: drivers/net/3c59x.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /opt/cvs/lk/drivers/net/3c59x.c,v
> retrieving revision 1.74.2.7
> diff -u -r1.74.2.7 3c59x.c
> --- drivers/net/3c59x.c	2002/02/13 21:03:03	1.74.2.7
> +++ drivers/net/3c59x.c	2002/02/26 18:49:24
> @@ -2898,6 +2898,9 @@
>  		BUG();
>  	}
> =20
> +	if (vp->card_idx =3D=3D vortex_cards_found)
> +		vortex_cards_found--;
> +
>  	vp =3D dev->priv;
> =20
>  	/* AKPM: FIXME: we should have
>=20
>=20
> -

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Imagination is more important than knowledge.
   Albert Einstein, On Science

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8e9r7j0UvHtcstB4RAiMGAJ9z7zvgcVxeTvllClDcC94pfhqZogCgnifb
yfjMJbUQUqTbY/C+mabAO2s=
=dHZR
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--
