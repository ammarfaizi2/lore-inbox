Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSKRIAY>; Mon, 18 Nov 2002 03:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSKRIAX>; Mon, 18 Nov 2002 03:00:23 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:7297
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S261573AbSKRIAW>; Mon, 18 Nov 2002 03:00:22 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-NLJzUcp03C6g7I4U5Gzl"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 09:07:11 +0100
Message-Id: <1037606831.1774.13.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NLJzUcp03C6g7I4U5Gzl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>  - please don't introduce a new pointer, just use the old one. There=20
>    appears to be no cases where you want to have different pointers
>    anyway.
There are: suppose that you want to implement the int cfork(int* pid)
function, which returns the pid in *pid in the parent vm, in a
multithreaded application.

The child tid pointer must be set to the current thread tid field,
because the thread structure is going to be reused.

However, that field contains the tid of the forking thread in the parent
process and must not be modified. So a different pointer is needed.

You could avoid the additional pointer by letting
child_tidptr =3D (!(flags & CLONE_VM) && current->user_tid) ?
current->user_tid : parent_tidptr;

but this forces the thread library to reuse the thread structure when
forking.


--=-NLJzUcp03C6g7I4U5Gzl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92J+vdjkty3ft5+cRAux4AJ9r4jfiWTT0cN2iK3tpAc2XrOfKJwCg0BXv
r1WAK7VtjtHlpHnTsc7ie0U=
=LsSD
-----END PGP SIGNATURE-----

--=-NLJzUcp03C6g7I4U5Gzl--
