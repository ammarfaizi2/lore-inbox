Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267592AbSKQUmP>; Sun, 17 Nov 2002 15:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbSKQUmP>; Sun, 17 Nov 2002 15:42:15 -0500
Received: from ppp-217-133-221-200.dialup.tiscali.it ([217.133.221.200]:23436
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267592AbSKQUmO>; Sun, 17 Nov 2002 15:42:14 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD7FD86.7000407@redhat.com>
References: <Pine.LNX.4.44.0211172212001.18431-100000@localhost.localdomain> 
	<3DD7FD86.7000407@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ZT9r2MPz6LPXviQcwJRl"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Nov 2002 21:49:03 +0100
Message-Id: <1037566143.1597.133.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZT9r2MPz6LPXviQcwJRl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> It's all encapsulated in the libpthread which is used.  No apps need to
> be recompiled so it is OK to make this incompatible change.
My point was that aesthetical reasons do not justify breaking anything
(aka forcing people to figure out what happened and spend time
recompiling).
Anyway, I'll need to recompile anyway, so I don't really care.

> I cannot see any reasonable way out if any of the put_user calls fail?
> Do you want the clone() call to fail if the parent's receiving address
> is wrong?  You'd have to go and kill the child again since it's already
> created.
>=20
> Instead let the user initialize the memory location the clone call is
> supposed to write in with zero.  if the value didn't change the
> user-level code can detect the error and handle appropriately.  So,
> ignore the put_user errors.  Maybe say so explicitly and add (void) in
> front.
I proposed to fail in put_user for the parent tid simply because the old
code did it.
I'm not completely sure whether we should fail or not, but if put_user
fails something bad is happening, so it may be better to signal the
error rather than just continuing since it can be done easily (for the
parent tid).


--=-ZT9r2MPz6LPXviQcwJRl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92AC/djkty3ft5+cRAvW0AJwL7SIk4gkBqQps8htdNFrD2SATxwCeOuYU
wgdiMGaYvGYwDxmZwV3hejo=
=WsLR
-----END PGP SIGNATURE-----

--=-ZT9r2MPz6LPXviQcwJRl--
