Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVLSSjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVLSSjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 13:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLSSjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 13:39:09 -0500
Received: from zlynx.org ([199.45.143.209]:63247 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S932352AbVLSSjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 13:39:08 -0500
Subject: Re: [Bug] mlockall() not working properly in 2.6.x
From: Zan Lynx <zlynx@acm.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1135014451.6051.23.camel@localhost.localdomain>
References: <20051218212123.GC4029@mjk.myfqdn.de>
	 <20051219022108.307e68b8.akpm@osdl.org>
	 <20051219114231.GA2830@mjk.myfqdn.de>  <20051219172735.GL13985@lug-owl.de>
	 <1135014451.6051.23.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6AsB6ohjnTJUO7F2hXEv"
Date: Mon, 19 Dec 2005 11:38:35 -0700
Message-Id: <1135017515.13318.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6AsB6ohjnTJUO7F2hXEv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-12-19 at 17:47 +0000, Alan Cox wrote:
> On Llu, 2005-12-19 at 18:27 +0100, Jan-Benedict Glaw wrote:
> > > > that we did this because inheriting MCL_FUTURE is standards-incorre=
ct.
> > >=20
> > > Oh! So how can I make programs unswappable with kernel 2.6.x then?
> >=20
> > That would mean that you cannot just exec() another program that will
> > also be mlockall()ed. The new program has to do that on its own...
>=20
> mlockall MCL_FUTURE applies to this image only and the 2.6 behaviour is
> correct if less useful in some ways. It would be possible to add an
> inheriting MCL_ flag that was Linux specific but then how do you control
> the depth of inheritance ? If that isn't an issue it looks the easiest.
>=20
> Another possibility would be pmlockall(pid, flag), but that looks even
> more nasty if it races an exec.

How about clearing MCL_FUTURE on fork but allow exec to inherit it?
That way a parent process could fork, mlockall in the child and exec a
memlocked child.  A regular fork,exec by a memlocked parent would not
create a memlocked child.

Seems less messy than a new flag, while keeping the benefits.
--=20
Zan Lynx <zlynx@acm.org>

--=-6AsB6ohjnTJUO7F2hXEv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDpv4pG8fHaOLTWwgRAvixAJ9Iq8tsfBIP4q4fOq0gxX+Ipl93WgCfR6In
IvQj/zGgmXSAqpggT8uTGMs=
=G+ti
-----END PGP SIGNATURE-----

--=-6AsB6ohjnTJUO7F2hXEv--

