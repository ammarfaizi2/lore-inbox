Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVCPEww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVCPEww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVCPEww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:52:52 -0500
Received: from dea.vocord.ru ([217.67.177.50]:687 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262242AbVCPEws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:52:48 -0500
Subject: Re: [11/many] acrypto: crypto_main.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <42370C51.4060607@osdl.org>
References: <11102278541439@2ka.mipt.ru>  <42370C51.4060607@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ckyjvCmldo65UejVWKqu"
Organization: MIPT
Date: Wed, 16 Mar 2005 07:58:16 +0300
Message-Id: <1110949096.30729.61.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 16 Mar 2005 07:51:27 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ckyjvCmldo65UejVWKqu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-15 at 08:24 -0800, Randy.Dunlap wrote:
> Evgeniy Polyakov wrote:
> > --- /tmp/empty/crypto_main.c	1970-01-01 03:00:00.000000000 +0300
> > +++ ./acrypto/crypto_main.c	2005-03-07 20:35:36.000000000 +0300
> > @@ -0,0 +1,374 @@
> > +/*
> > + * 	crypto_main.c
> > + *
> > + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > + *=20
> > + */
>=20
> > +struct crypto_session *crypto_session_alloc(struct crypto_session_init=
ializer *ci, struct crypto_data *d)
> > +{
> > +	struct crypto_session *s;
> > +
> > +	s =3D crypto_session_create(ci, d);
> > +	if (!s)
> > +		return NULL;
> > +
> > +	crypto_session_add(s);
> > +
> > +	return s;
> > +}
> > +
> > +
>=20
> > +EXPORT_SYMBOL(crypto_session_alloc);
> Why is this one not _GPL ??  It calls _create() and _add().

It is not allowed to control _create() and _add() methods, only call
them "atomically"
(without gap between functions where new route can be created).
So I export only that one functin as non-GPL-only for anyone
who wants to use asynchronous crypto in simple mode.
More powerfull control requires GPL.

> > +EXPORT_SYMBOL_GPL(crypto_session_create);
> > +EXPORT_SYMBOL_GPL(crypto_session_add);
> > +EXPORT_SYMBOL_GPL(crypto_session_dequeue_route);
>=20
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-ckyjvCmldo65UejVWKqu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCN7zoIKTPhE+8wY0RAhQ/AKCDr0/snv6CD4AKfqgadvDW2d4pbwCfa/Pf
tt7OjhK3IfhofpxKgnTVab8=
=QwDF
-----END PGP SIGNATURE-----

--=-ckyjvCmldo65UejVWKqu--

