Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbSJAXvd>; Tue, 1 Oct 2002 19:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262956AbSJAXvd>; Tue, 1 Oct 2002 19:51:33 -0400
Received: from h24-68-71-10.vc.shawcable.net ([24.68.71.10]:5639 "EHLO
	kruhftwerk.dyndns.org") by vger.kernel.org with ESMTP
	id <S262955AbSJAXvb>; Tue, 1 Oct 2002 19:51:31 -0400
Date: Tue, 1 Oct 2002 16:56:59 -0700
From: Burton Samograd <kruhft@kruhft.dyndns.org>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bad function ptrs - is it dangerous ?
Message-ID: <20021001235659.GB12464@kruhft.dyndns.org>
Mail-Followup-To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20021001225125.GD3927@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20021001225125.GD3927@werewolf.able.es>
X-GPG-key: http://kruhftwerk.dyndns.org/kruhft.pubkey.asc
X-Operating-System: Linux kruhft.dyndns.org 2.4.19-gentoo-r9 
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2002 at 12:51:25AM +0200, J.A. Magallon wrote:
> I have a little question. Let's suppose you have this:
>=20
> int (*pf)(data *);
> int f(data*);
>=20
> so you can:
>=20
> pf =3D f;
> pf(data).
>=20
> Fine. But what happens if:
>=20
> void (*pf)(data *);
> int f(data*);
>=20
> pf =3D f; // gcc happily swallows, gcc-3.2 gives a warning.
> pf(data).
>=20
> ??
>=20
> In C calling convention, the callee kills the stack so nothing should
> happen... or it should ?
>

I think that under most calling conventions return values are put into
registers, so this shouldn't do anything other than keep the compiler from
reallocating the designated return register for a while.

Or, after a second or two of more thought, it might cause the function to t=
rash
whatever value is contained in the return register, which the compiler thou=
ght
was safe from harm.  It all depends on the calling convention and whether t=
he
caller assumes that the callee can destroy any registers or if the callee h=
as to
save and restore the registers it uses.

burton

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9mjZLLq/0KC7fYbURAoKZAKCyBoizSSsQOnFEhG3MtLm/DI2jCACgnKfa
nM7s80QEvgDlAb3pmS9nSWM=
=NIux
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
