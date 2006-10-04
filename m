Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWJDAyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWJDAyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWJDAyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:54:17 -0400
Received: from ozlabs.org ([203.10.76.45]:50066 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161057AbWJDAyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:54:16 -0400
Subject: Re: [PATCH 4/5] Generic BUG for powerpc
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20061003201812.313852083@goop.org>>
References: <20061003201618.974094245@goop.org> >
	  <20061003201812.313852083@goop.org>>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uxJMfJcOOhC4dq6L/Y8e"
Date: Wed, 04 Oct 2006 10:54:03 +1000
Message-Id: <1159923244.31312.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uxJMfJcOOhC4dq6L/Y8e
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-03 at 13:16 -0700, Jeremy Fitzhardinge wrote:
> plain text document attachment (mm)
> This makes powerpc use the generic BUG machinery.  The biggest
> difference from the previous powerpc bug code is that it no longer
> reports the function name, since it is redundant with kallsyms, and
> not needed in general.
>=20
> There is an overall reduction of code, since module_32/64 duplicated seve=
ral
> functions.
>=20
> Unfortunately there's no way to tell gcc that BUG won't return, so the
> BUG macro includes a goto loop.  This will generate a real jmp
> instruction, which is never used.

I posted a patch a few weeks back to use __builtin_trap(), which gives
GCC the hint that it's not going to return.
(http://patchwork.ozlabs.org/linuxppc/patch?id=3D7047)

Unfortunately this generated some negative feedback from some of our
crackhead ... er wonderful colleagues who want to be able to step over
BUGs in some circumstances.
(http://ozlabs.org/pipermail/linuxppc-dev/2006-September/026161.html)

I think they conceeded that it could be configurable, but I wasn't sure
it was worth the trouble.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-uxJMfJcOOhC4dq6L/Y8e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFIwYrdSjSd0sB4dIRAkz3AJ0WAKX/hcLRHDne7E2SwegLZV72KQCdF7Du
KMfJFr0ogeAIZ23cCXmj1Ko=
=BG0n
-----END PGP SIGNATURE-----

--=-uxJMfJcOOhC4dq6L/Y8e--

