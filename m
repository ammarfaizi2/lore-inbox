Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261957AbSIYLam>; Wed, 25 Sep 2002 07:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261958AbSIYLam>; Wed, 25 Sep 2002 07:30:42 -0400
Received: from B56da.pppool.de ([213.7.86.218]:20713 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261957AbSIYLal>; Wed, 25 Sep 2002 07:30:41 -0400
Subject: Re: [PATCH] streq()
From: Daniel Egger <degger@fhm.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020924045313.0FBE52C075@lists.samba.org>
References: <20020924045313.0FBE52C075@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-e6PkmJCOM+v5mnFL0qnR"
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Sep 2002 13:27:32 +0200
Message-Id: <1032953252.18004.18.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-e6PkmJCOM+v5mnFL0qnR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2002-09-24 um 06.49 schrieb Rusty Russell:

> Embarrassing, huh?  But I just found a bug in my code cause by
> "if (strcmp(a,b))" instead of "if (!strcmp(a,b))".

> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/curr=
ent-dontdiff --minimal linux-2.5.38/include/linux/string.h working-2.5.38-s=
treq/include/linux/string.h
> --- linux-2.5.38/include/linux/string.h	2002-06-06 21:38:40.000000000 +10=
00
> +++ working-2.5.38-streq/include/linux/string.h	2002-09-24 14:43:30.00000=
0000 +1000
> @@ -15,7 +15,7 @@ extern "C" {
>  extern char * strpbrk(const char *,const char *);
>  extern char * strsep(char **,const char *);
>  extern __kernel_size_t strspn(const char *,const char *);
> -
> +#define streq(a,b) (strcmp((a),(b)) =3D=3D 0)

Considering most compares will only care for equality/non-equality and
not about the type of unequality a strcmp usually returns, wouldn't it
be more wise and faster to use an approach like memcpy for comparison
instead of that stupid compare each character approach?

Something along the lines of:
Start comparying by granules with the biggest type the architecture has
to offer which will fit into the length of the string and going down
to the size of 1 char bailing out as soon as the granules don't match.
=20
--=20
Servus,
       Daniel

--=-e6PkmJCOM+v5mnFL0qnR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9kZ2jchlzsq9KoIYRApQXAKCNP6juovUbC595aXTvJA/DssIt0wCg2+d6
FhXeubpfSnyTCkjiKGKkvIc=
=5/tt
-----END PGP SIGNATURE-----

--=-e6PkmJCOM+v5mnFL0qnR--

