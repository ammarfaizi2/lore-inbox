Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSKRME6>; Mon, 18 Nov 2002 07:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbSKRME6>; Mon, 18 Nov 2002 07:04:58 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:36485
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262360AbSKRME5>; Mon, 18 Nov 2002 07:04:57 -0500
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-6b0piB+VK0x4L+s8VBYM"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 13:11:43 +0100
Message-Id: <1037621503.1774.99.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6b0piB+VK0x4L+s8VBYM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

But this way you throw away a lot of functionality, make the existence
of two pointers pointless, cause pthread_self() to change across fork
and force NPTL to copy thread state.

How about instead doing a verify_area in copy_process, putting the
child_settid address and the tid in two child registers and assigning it
in assembly in ret_from_fork?

Alternatively you could also manually call the copy-on-write handler
functions but this adds complexity for little gain.


--=-6b0piB+VK0x4L+s8VBYM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92Nj+djkty3ft5+cRAh2YAJ9lqlV0xUUgXNKmVvRKA5vGNGHMjQCg3hzm
wOMLZTxaVBuIsTkNPoSxw30=
=WIQf
-----END PGP SIGNATURE-----

--=-6b0piB+VK0x4L+s8VBYM--
