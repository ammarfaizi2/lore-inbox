Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVBPN3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVBPN3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 08:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVBPN3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 08:29:50 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:58580 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262003AbVBPN3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 08:29:38 -0500
Subject: Re: Thoughts on the "No Linux Security Modules framework" old
	claims
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Valdis.Kletnieks@vt.edu
Cc: rsbac@rsbac.org,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200502160421.j1G4Ls7l004329@turing-police.cc.vt.edu>
References: <1108507089.3826.83.camel@localhost.localdomain>
	 <200502160421.j1G4Ls7l004329@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hQMk/MVg1AVBnGq7BWK1"
Date: Wed, 16 Feb 2005 14:29:03 +0100
Message-Id: <1108560543.3826.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hQMk/MVg1AVBnGq7BWK1
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El mar, 15-02-2005 a las 23:21 -0500, Valdis.Kletnieks@vt.edu escribi=F3:
> On Tue, 15 Feb 2005 23:38:09 +0100, Lorenzo =3D?ISO-8859-1?Q?Hern=3DE1nde=
z_?=3D =3D?ISO-8859-1?Q?Garc=3DEDa-Hierro?=3D said:
>=20
> > Yes, and that's noticed from the "official" documentation.
> > But, who says that we can't place auditing facilities inside the
> > existing hooks? or even file system linking related tweaks?
>=20
> Many auditing policies require an audit event to be generated if the oper=
ation
> is rejected by *either* the DAC (as implemented by the file permissions
> and possibly ACLs) *or* the MAC (as implemented by the LSM exit).  Howeve=
r,
> in most (all?) cases, the DAC check is made *first*, and the LSM exit isn=
't
> even called if the DAC check fails.  As a result, if you try to open() a =
file
> and get -EPERM due to the file permissions, the LSM exit isn't called and
> you can't cut an audit record there.

Yes, there are many cases that apply to such scenario and context, this
may be worth to work on, but think it's main shortcoming is that it cuts
performance and adds further overlapping to the DAC checks, that should
be the first ones being called (as most times they do) and then apply
the LSM basis, so, post-processing will be only required if the DAC
checks get in override or passed, without adding too-much overhead to
the current behavior.

So, I just agree partially, but yes, maybe modifying the DAC checks
themselves and add what-ever-else helper function to handle by-default
auditing in certain operations could be interesting.

I think it could be worthy to have a roadmap in a wiki or even talk
about a one, trying to write it, so, we all could know what needs to be
improved and done, getting a higher percentage of mainline-accepted
approaches.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-hQMk/MVg1AVBnGq7BWK1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCE0qfDcEopW8rLewRAh3pAKCoWKmNHCisEmuDyJx66sJ6v0GPRACgxfWo
uVBThM/vZsAYvJezHkts/zI=
=cd7h
-----END PGP SIGNATURE-----

--=-hQMk/MVg1AVBnGq7BWK1--

