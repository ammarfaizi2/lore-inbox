Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbULAIt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbULAIt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbULAIt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:49:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:32153 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261334AbULAItR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:49:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Grover <andy.grover@gmail.com>
Subject: Re: "extern inline" purge? was: Re: [PATCH] fix "extern inline"
Date: Wed, 1 Dec 2004 09:43:36 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <m2y8hapakk.wl%ysato@users.sourceforge.jp> <c0a09e5c04113017333c85c7e2@mail.gmail.com>
In-Reply-To: <c0a09e5c04113017333c85c7e2@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200412010943.36834.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_4QYrB5fiBYdE+kq";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_4QYrB5fiBYdE+kq
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Middeweken 01 Dezember 2004 02:33, Andrew Grover wrote:
> On Wed, 10 Nov 2004 13:55:23 +0900, Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > -extern __inline__ int generic_fls(int x)
> > +static __inline__ int generic_fls(int x)
>=20
> Along the lines of this patch, can I ask... if a patch were created to
> replace all instances of "extern inline" with "static inline" would
> that be a good thing or a waste of time? I found a 3 year old thread
> (Jul 27 2001, "Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1") where it sounded
> like a good thing to do, but obviously there are some still around.

If anyone uses extern inline in the way that it is intended, i.e.
provide an inline function in a header and an out-of-line version
of the same function in some C file, that breaks.

It would be pointless to use extern inline this way now, since we define=20
inline to mean always_inline in the kernel, but gcc will give you a=20
compile error when it sees the same function defined both as 'static
inline' and as 'extern'. The correct fix is to convert 'extern inline'
to 'static inline' and at the same time remove any external definitions
of the same function.

Another point that has been mentioned before is that forcing inline
to always_inline is not really a good idea. My personal preference
would be to convert all uses of 'extern inline' that are meant as
'this breaks if it is not inline' to something like 'static=20
__always_inline' instead of plain 'static inline'. Then maybe some
day the annotations get good enough to leave the decision
to the compiler for the regular case.

	Arnd <><



--Boundary-02=_4QYrB5fiBYdE+kq
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBrYQ45t5GS2LDRf4RAldLAJ9GGiKfsGWcDOo63z12ma4enGd+pwCgmNW6
/nIqJqgKVF63i/70FthfcUc=
=Z/MF
-----END PGP SIGNATURE-----

--Boundary-02=_4QYrB5fiBYdE+kq--
