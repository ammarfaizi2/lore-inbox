Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSKRIYB>; Mon, 18 Nov 2002 03:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSKRIYB>; Mon, 18 Nov 2002 03:24:01 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:14721
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S261661AbSKRIX7>; Mon, 18 Nov 2002 03:23:59 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD8657E.7020203@redhat.com>
References: <Pine.LNX.4.44.0211171938250.8451-100000@home.transmeta.com> 
	<3DD8657E.7020203@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-fEqkSyDls3szuijykhzm"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 09:30:52 +0100
Message-Id: <1037608252.1774.49.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fEqkSyDls3szuijykhzm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> I don't walk the thread descriptors.  I don't write into them.  I move
> entire double-linked lists with a dozen or so instructions.  Regardless
> of how many threads were active in the parent.
However this would cause a lot of copy-on-write faults on thread stacks
when other thread resume execution.

How about adding a MAP_DONTCOPY flag to mmap, using it for the thread
stacks and then adding yet another flag and pointer to the clone
syscall, pointing to a userspace array of addresses and flags, allowing
to specify whether vmas should be copied, ignored (or maybe shared, as a
future extension) so that userspace could specify that the current
thread stack should be copied anyway?


--=-fEqkSyDls3szuijykhzm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92KU8djkty3ft5+cRAvZfAKCUpHBHbMCBHgmjYETJgZW/1LjPHwCggZ8M
OAPFJoMDIDiFdoW3wOc9SF0=
=mWrE
-----END PGP SIGNATURE-----

--=-fEqkSyDls3szuijykhzm--
