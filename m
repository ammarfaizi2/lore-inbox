Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUGFUzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUGFUzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGFUzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:55:21 -0400
Received: from dhcp160179209.columbus.rr.com ([24.160.179.209]:44043 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S264461AbUGFUyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:54:07 -0400
Date: Tue, 6 Jul 2004 16:54:04 -0400
To: Keith Owens <kaos@sgi.com>
Cc: Joseph Fannin <jhf@rivenstone.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulus@samba.org,
       benh@kernel.crashing.org, rusty@rustcorp.com.au
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data
Message-ID: <20040706205404.GA1806@samarkand.rivenstone.net>
Mail-Followup-To: Keith Owens <kaos@sgi.com>,
	Joseph Fannin <jhf@rivenstone.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	benh@kernel.crashing.org, rusty@rustcorp.com.au
References: <13859.1089099082@kao2.melbourne.sgi.com> <14454.1089099781@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <14454.1089099781@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.6+20040523i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2004 at 05:43:01PM +1000, Keith Owens wrote:
> I hate it when I spot a typo after pressing enter ...
>=20
>=20
> PPC small data area base symbols shift between kallsyms phases 1 and 2,
> which makes the kallsyms data unstable.  Exclude them from the kallsyms
> list.

   Yes, this builds okay with KALLSYMS_EXTRA_PASS off.

=20
> Signed-off-by: Keith Owens <kaos@sgi.com>
>=20
> Index: 2.6.7-mm6/scripts/kallsyms.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +++ 2.6.7-mm6/scripts/kallsyms.c	2004-07-06 17:41:29.000000000 +1000
> @@ -83,6 +83,11 @@ symbol_valid(struct sym_entry *s)
>  	    strcmp(s->sym, "kallsyms_names") =3D=3D 0)
>  		return 0;
> =20
> +	/* Exclude linker generated symbols which vary between passes */
> +	if (strcmp(s->sym, "_SDA_BASE_") =3D=3D 0 ||	/* ppc */
> +	    strcmp(s->sym, "_SDA2_BASE_") =3D=3D 0)		/* ppc */
> +		return 0;
> +
>  	return 1;
>  }
> =20
>=20

--=20
Joseph Fannin
jhf@rivenstone.net


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6xFqWv4KsgKfSVgRAkVlAJ9BJ6uh8nkAf2nQQQYsNGzhqNUZYwCgpTnX
nKklgl+3ek3CGUh1Waoq4Ik=
=VCyD
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
