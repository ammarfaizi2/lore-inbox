Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVBJLRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVBJLRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 06:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVBJLRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 06:17:33 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:31244 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262096AbVBJLR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 06:17:26 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       michal@logix.cz, davem@davemloft.net, adam@yggdrasil.com
In-Reply-To: <20050210023344.390fb358.akpm@osdl.org>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
	 <1107997358.7645.24.camel@ghanima> <20050209171943.05e9816e.akpm@osdl.org>
	 <1108028923.14335.44.camel@ghanima> <20050210023344.390fb358.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tVK/ZCJttGVe+pUuy9WI"
Date: Thu, 10 Feb 2005 12:17:24 +0100
Message-Id: <1108034244.14335.59.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tVK/ZCJttGVe+pUuy9WI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-10 at 02:33 -0800, Andrew Morton wrote:
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
> >
> > On Wed, 2005-02-09 at 17:19 -0800, Andrew Morton wrote:
> > > Fruhwirth Clemens <clemens@endorphin.org> wrote:
> > > Adding a few more fixmap slots wouldn't hurt anyone.  But if you want=
 an
> > > arbitrarily large number of them then no, we cannot do that.
> >=20
> > What magnitude is "few more"? 2, 10, 100?
>=20
> Not 100.  10 would seem excessive.

Out of curiosity: Where does this limitation even come from? What
prevents kmap_atomic from adding slots dynamically?

> > Is there an easy way to bring pages to lowmem? The cryptoapi is called
> > from the backlog of the networking stack, which is assigned in irq
> > context first and processed softirq context.
>=20
> Are networking frames ever allocated from highmem?  Don't think so.

Hm, alright. So I'm going take the internal of kmap_atomic into
scatterwalk.c. to test if the page is in highmem, with PageHighMem. If
it is, I'm going to kmap_atomic and mark the fixmap as used. If it's
not, I do the "mapping" on my own with page_address.

Btw folks: why are there UpperCamelCase functions in linux/page-flags.h
and you're whining about my camelcase style in gfmulseq.c? My file isn't
even intended to be included by other files, unlike this include file.

> > If context =3D=3D user, use kmap_atomic until they all used, and fall-b=
ack
> > to kmap.
>=20
> Taking multiple kmaps can deadlock due to kmap exhaustion though.

Ok, then relay on kmap_atomic, solely.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-tVK/ZCJttGVe+pUuy9WI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCC0LEbjN8iSMYtrsRAvaDAJ0eEIKo2WkrWc8jG881d3m2lQh2UwCgiEu1
CooCfTRRHTXrO41f3KKa1Wg=
=D2fy
-----END PGP SIGNATURE-----

--=-tVK/ZCJttGVe+pUuy9WI--
