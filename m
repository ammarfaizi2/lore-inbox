Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTIEPRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbTIEPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:17:10 -0400
Received: from ns.suse.de ([195.135.220.2]:37583 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262804AbTIEPRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:17:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, <rth@redhat.com>,
       <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
References: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 05 Sep 2003 17:17:00 +0200
In-Reply-To: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org> (Linus
 Torvalds's message of "Fri, 5 Sep 2003 07:54:30 -0700 (PDT)")
Message-ID: <ho65k76z9v.fsf@byrd.suse.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 5 Sep 2003, Andi Kleen wrote:
>>=20
>> Unfortunately the kernel doesn't compile with unit-at-a-time currently,
>> it cannot tolerate the reordering of functions in relation to inline
>> assembly.
>
> What is the problem exactly? Is it the exception table getting unordered?=
=20=20
> We _could_ just sort it at boot-time (or, even better, at build time after
> the final link) instead...

The problem is that unit-at-a-time sees all functions used and finds
some static functions/variables that are not called anywhere and
therefore drops them, making a smaller binary.  Since GCC does not
look into inline assembler, anything referenced from inline assembler
only, will be treated as not used and therefore removed.

You have to options:
=2D use attribute ((used)) (implemented since GCC 3.2) to tell GCC that
  a function/variable should never be removed
=2D use -fno-unit-at-a-time.

Since unit-at-a-time has better inlining heuristics the better way is
to add the used attribute - but that takes some time.  The short-term
solution would be to add the compiler flag,

Andreas
=2D-=20
 Andreas Jaeger, aj@suse.de, http://www.suse.de/~aj
  SuSE Linux AG, Deutschherrnstr. 15-19, 90429 N=FCrnberg, Germany
   GPG fingerprint =3D 93A3 365E CE47 B889 DF7F  FED1 389A 563C C272 A126

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/WKjsOJpWPMJyoSYRAvDYAJ9Gh08lYo58vNvvPmNWplDBuepQQQCdFHX6
eif4Qp4A4yvtoL/ppzWIJvE=
=qV7v
-----END PGP SIGNATURE-----
--=-=-=--
