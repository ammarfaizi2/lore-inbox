Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSIAVxA>; Sun, 1 Sep 2002 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSIAVxA>; Sun, 1 Sep 2002 17:53:00 -0400
Received: from h24-71-131-249.ss.shawcable.net ([24.71.131.249]:17138 "HELO
	bruce-guenter.dyndns.org") by vger.kernel.org with SMTP
	id <S318138AbSIAVw7>; Sun, 1 Sep 2002 17:52:59 -0400
Date: Sun, 1 Sep 2002 15:57:49 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
Message-ID: <20020901155749.A8323@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020901113741.GM32122@louise.pinerecords.com> <20020901.043512.51698754.davem@redhat.com> <20020901121053.GA7325@louise.pinerecords.com> <20020901.051611.85397564.davem@redhat.com> <20020901123903.GB7325@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020901123903.GB7325@louise.pinerecords.com>; from szepe@pinerecords.com on Sun, Sep 01, 2002 at 02:39:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2002 at 02:39:03PM +0200, Tomas Szepe wrote:
> I've been playing a bit with how gcc handles the const qualifiers
> and made an interesting discovery:
>=20
> Trying to compile
>=20
> typedef int *p_int;
> void a(const p_int t) { *t =3D 0; }
> void b(const p_int t) { t =3D (int *) 0; }
> void c(const int *t) { *t =3D 0; }
> void d(const int *t) { t =3D (int *) 0; }
> void e(int const *t) { *t =3D 0; }
> void f(int const *t) { t =3D (int *) 0; }
>=20
> will give 'assignment of read-only location' warnings for
> b(), c() and e(), i.e. it's impossible to have a constant
> pointer to a non-constant value w/o using a qualified
> typedef.

If you want a constant *pointer*, use:
	void f(int* const t)
	(read "f is a function, taking parameter constant pointer to
	int, returning void)

> W/o a typedef, gcc seems unable to tell the difference
> between 'const int *' and 'int const *' altogether.

That's because there is no difference ("pointer to integer constant" vs
"pointer to constant integer").

See http://untroubled.org/articles/cdecls.txt for one of the best
references I've ever seen to understanding C type declarations.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9co1d6W+y3GmZgOgRAk0zAJkBETzNUoeK+275g0sQKBAtwMPFLQCfVvIP
hsiXdAmsXkxBCviK1ilWGyw=
=p1ZC
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
