Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSLQL51>; Tue, 17 Dec 2002 06:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSLQL50>; Tue, 17 Dec 2002 06:57:26 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:35566 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S264925AbSLQL50>; Tue, 17 Dec 2002 06:57:26 -0500
Subject: Re: Multithreaded coredump patch where?
From: Arjan van de Ven <arjanv@redhat.com>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
References: <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it>
	<5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it> 
	<5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3N9DbkMCX1GXcKSOJC5F"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 13:05:16 +0100
Message-Id: <1040126717.10064.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3N9DbkMCX1GXcKSOJC5F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-12-17 at 12:05, Roberto Fichera wrote:
> At 13.21 16/12/02 -0800, mgross wrote:
>=20
> >I haven't rebased the patches I posted back in June for a while now.
> >
> >Attached is the patch I posted for the 2.4.18 vanilla kernel.  Its a bit
> >controversial, but it seems to work for a number of folks.  Let me know =
if
> >you have any troubles re-basing it.
>=20
> Only one hunk failed on include/asm-ia64/elf.h but fixed by hand.
> Why do you say a bit controversial ?

The design has theoretical (but probably in practice not trivial to
trigger) deadlocks; by design it prevents processes that are sleeping
from running, regardless whether those processes are in kernel space or
not. If they are in kernel space, they can accidentally be holding a
semaphore that something in the core dumping path will need to get (but
can't because it never will be released). There are not that many of
such semaphores (kmap semaphore is one, and filesystems can have several
internally)


--=-3N9DbkMCX1GXcKSOJC5F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9/xL8xULwo51rQBIRAvfKAJwPpOT3e2O/wW1EnaIBapeWB2DwmwCgmbCL
y6JuBTAQvgPNakc1lvI+kfE=
=07ij
-----END PGP SIGNATURE-----

--=-3N9DbkMCX1GXcKSOJC5F--
