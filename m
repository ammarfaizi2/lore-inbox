Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVA3Lti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVA3Lti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVA3Lti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:49:38 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:14601 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261683AbVA3Ltd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:49:33 -0500
Subject: Re: [PATCH 04/04] Add LRW
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Fruhwirth Clemens <clemens-dated-1107431870.41eb@endorphin.org>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050130000221.GA2955@waste.org>
References: <20050124115750.GA21883@ghanima.endorphin.org>
	 <20050130000221.GA2955@waste.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iJdc2FQH73EmRjb0ohRr"
Date: Sun, 30 Jan 2005 12:49:29 +0100
Message-Id: <1107085769.13776.11.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iJdc2FQH73EmRjb0ohRr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-01-29 at 16:02 -0800, Matt Mackall wrote:
> On Mon, Jan 24, 2005 at 12:57:50PM +0100, Fruhwirth Clemens wrote:
> > This is the core of my LRW patch. Added test vectors.
> > http://grouper.ieee.org/groups/1619/email/pdf00017.pdf
>=20
> Please include a URL for the standard at the top of the LRW code and
> next to the test vectors. I had to search around a fair bit for decent
> background material, would be helpful to a couple other references as
> well.

Ack.

> > +static inline void findAlignment(u128 callersN, int value, int *align)=
 {
> > +	int i;
>=20
> Your gfmulseq code has lots of StudlyCaps and strange whitespace, eg
> this '{' should be on the next line.

In fact, it's lowerCamelCase, that's intentional. The whitespace and the
left '{' is an error.

> > +	/* Copy N, so lsr does not destroy caller's copy */
> > +	u128_alloc(N);
> > +	copy128(N,callersN);
>=20
> The usage of your u128 type is really confusing, so 'u128' is an
> especially bad name. I expect u128 to work like u64 and u32. I propose
> gf128_t.

That's ok.

> > +#define u128_alloc(VAR) u64 _ ## VAR ## _[2]; u128 VAR =3D _ ## VAR ##=
 _
>=20
> Wrap this in a struct, please. That's disgusting.

No need to be disgusted, I've seen much worse things in the kernel. I
will change it to C99 compound literals.

> > -obj-$(CONFIG_CRYPTO) +=3D api.o scatterwalk.o cipher.o digest.o compre=
ss.o \
> > +obj-$(CONFIG_CRYPTO) +=3D api.o scatterwalk.o cipher.o digest.o compre=
ss.o lrw.o gfmulseq.o \
>=20
> LRW and the GF(2**128) code is not configurable?

No, it's a cipher mode. None of the modes is configurable.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-iJdc2FQH73EmRjb0ohRr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB/MnJW7sr9DEJLk4RAtPBAKCHtG40XyOuURtvomUAVl2D0W9SewCghAPR
xVGVXHtWXIdqhbKQ/lcW4+Y=
=zpWX
-----END PGP SIGNATURE-----

--=-iJdc2FQH73EmRjb0ohRr--
