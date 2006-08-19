Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWHSIlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWHSIlv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 04:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHSIlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 04:41:51 -0400
Received: from ozlabs.org ([203.10.76.45]:24001 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750876AbWHSIlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 04:41:50 -0400
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andy Gay <andy@andynet.net>
Cc: Thomas Klein <osstklei@de.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
In-Reply-To: <1155970112.7302.434.camel@tahini.andynet.net>
References: <200608181333.23031.ossthema@de.ibm.com>
	 <20060818140506.GC5201@martell.zuzino.mipt.ru>
	 <44E5DFA6.7040707@de.ibm.com>
	 <1155968305.1388.4.camel@localhost.localdomain>
	 <1155970112.7302.434.camel@tahini.andynet.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-km1jr+c+vrMYyrWp/uHS"
Date: Sat, 19 Aug 2006 18:41:27 +1000
Message-Id: <1155976887.1388.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-km1jr+c+vrMYyrWp/uHS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-08-19 at 02:48 -0400, Andy Gay wrote:
> On Sat, 2006-08-19 at 16:18 +1000, Michael Ellerman wrote:
>=20
> >=20
> > If you try to return an uninitialized value the compiler will warn you,
> > you'll then look at the code and realise you missed a case, you might
> > save yourself a bug.=20
>=20
> You *should* look at the code :)
>=20
> So should we be reporting these as bugs?

No you're better off sending patches ;)

A lot of these have started appearing recently, which I think is due to
GCC becoming more vocal. Unfortunately many of them are false positives
caused by GCC not seeming to grok that this is ok:

void foo(int *x) { *x =3D 1; }
...
int x;
foo(&x);
return x;

It's a pity because it creates noise, but still it's beside the point.

New code going into the kernel should be 100% warning free, and so if
the eHEA guys had missed an error case they'd spot the warning before
they submitted it.

Doing the initialise-to-some-value "trick" means you only spot the bug
via testing.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-km1jr+c+vrMYyrWp/uHS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE5s63dSjSd0sB4dIRAs4JAKC8Wh4R1q7mYXxSHT8QL6amzEHJOgCgh/Rj
Dp8bX8YxxoUmTyO2MgNtSbU=
=AFky
-----END PGP SIGNATURE-----

--=-km1jr+c+vrMYyrWp/uHS--

