Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTEDXSK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 19:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTEDXSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 19:18:09 -0400
Received: from cpt-dial-196-30-179-171.mweb.co.za ([196.30.179.171]:11136 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S261835AbTEDXSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 19:18:08 -0400
Subject: Re: [2.5] Update sk98lin driver
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Andrew Morton <akpm@digeo.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030504145038.5b0495b5.akpm@digeo.com>
References: <1052073847.4478.18.camel@nosferatu.lan>
	 <20030504145038.5b0495b5.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+QKCt9dOtebGVfjbRjf7"
Organization: 
Message-Id: <1052090947.4459.16.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 05 May 2003 01:29:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+QKCt9dOtebGVfjbRjf7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-04 at 23:50, Andrew Morton wrote:

> > Now the problem is that if I try to load it, I get this:
> >=20
> > -----------------------------------------
> > sk98lin: Unknown symbol __udivdi3
> > -----------------------------------------
> >=20
> > Meaning it linked with libgcc_s.so.  Any ideas why ?
> >=20
>=20
> This was the fix for the in-kernel driver, so it'll presumably
> fix the updated driver.
>=20
>=20
> diff -puN drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix drivers/net/sk9=
8lin/h/skgepnm2.h
> --- 25/drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix	Thu Mar  6 16:18:0=
7 2003
> +++ 25-akpm/drivers/net/sk98lin/h/skgepnm2.h	Thu Mar  6 16:18:07 2003
> @@ -341,7 +341,7 @@ typedef struct s_PnmiStatAddr {
>  #if SK_TICKS_PER_SEC =3D=3D 100
>  #define SK_PNMI_HUNDREDS_SEC(t)	(t)
>  #else
> -#define SK_PNMI_HUNDREDS_SEC(t)	(((t) * 100) / (SK_TICKS_PER_SEC))
> +#define SK_PNMI_HUNDREDS_SEC(t)	((((long)t) * 100) / (SK_TICKS_PER_SEC))
>  #endif
> =20
>  /*

Thanks, that fixed it =3D)


--=20

Martin Schlemmer




--=-+QKCt9dOtebGVfjbRjf7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+taJCqburzKaJYLYRAgTPAJwJX9w8+iH/yscjP475YGsW62cJ2QCgl789
EU6KHqfLXtbQEKLuLy2kQEY=
=jT2o
-----END PGP SIGNATURE-----

--=-+QKCt9dOtebGVfjbRjf7--

