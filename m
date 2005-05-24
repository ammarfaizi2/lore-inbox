Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVEXNIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVEXNIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVEXNIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:08:48 -0400
Received: from lug-owl.de ([195.71.106.12]:46513 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262054AbVEXNIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:08:38 -0400
Date: Tue, 24 May 2005 15:08:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __udivdi3 and linux kernel u64 division question [x86]
Message-ID: <20050524130837.GR2417@lug-owl.de>
Mail-Followup-To: Mateusz Berezecki <mateuszb@gmail.com>,
	linux-kernel@vger.kernel.org
References: <42931E38.6030403@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VmlJMtejgecKmNHY"
Content-Disposition: inline
In-Reply-To: <42931E38.6030403@gmail.com>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VmlJMtejgecKmNHY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-24 14:29:44 +0200, Mateusz Berezecki <mateuszb@gmail.com> w=
rote:
> u64 mconst =3D somebig64bitvalue;
> u64 tmp =3D some32bitvalue;
> u64 r =3D mconst / tmp;
>=20
> I encounter compilation error and gcc reporting __udivdi3 has not been
> found!
> After firing up cscope I found that this function has never(?) been
> implemented for
> x86 architecture. How is it possible that during compilation process of
> some module
> make system tries to link with nonexisting function?
>=20
> I've also found a do_div() and it was sufficent for my purposes but Im
> still curious about
> __udivdi3. Can someone explain this issue to me?

In some cases, gcc decides that a given division is too complicated to
do it in one assembler instruction. That's especially true for things
that newer CPUs support but older lack.  In these cases, gcc emits a
function call instead of the actual division and normally, libgcc would
provide these functions.

However, it's each architecture's decision to link-in libgcc or not,
because it can open another can of worms. Alternatively, you can
implement these little functions on your own and put them somewhere in
some library file.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--VmlJMtejgecKmNHY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCkydVHb1edYOZ4bsRAruRAJ0aOUfPLfQzJGXEpte547+YcB+eVgCfQcZI
XQY8EsOeMuAmIETAcoOTvhw=
=NWJN
-----END PGP SIGNATURE-----

--VmlJMtejgecKmNHY--
