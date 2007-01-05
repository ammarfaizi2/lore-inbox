Return-Path: <linux-kernel-owner+w=401wt.eu-S1161037AbXAEKZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbXAEKZB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbXAEKZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:25:01 -0500
Received: from www.sf-tec.de ([62.27.20.187]:57106 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161037AbXAEKZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:25:00 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Date: Fri, 5 Jan 2007 11:26:07 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de> <20070105100610.GA382@Ahmed>
In-Reply-To: <20070105100610.GA382@Ahmed>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1207833.nokOMTnfQq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701051126.13682.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1207833.nokOMTnfQq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 5. Januar 2007 11:06 schrieb Ahmed S. Darwish:
> On Fri, Jan 05, 2007 at 09:10:01AM +0100, Rolf Eike Beer wrote:
> > Ahmed S. Darwish wrote:
> > > Remove unnecessary kmalloc casts in drivers/char/tty_io.c
> > >
> > > Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> >
> >   	if (!*ltp_loc) {
> >  -		ltp =3D (struct ktermios *) kmalloc(sizeof(struct ktermios),
> >  -						 GFP_KERNEL);
> >  +		ltp =3D kmalloc(sizeof(struct ktermios), GFP_KERNEL);
> >                       ^^^^^^^
> >   		if (!ltp)
> >   			goto free_mem_out;
> >   		memset(ltp, 0, sizeof(struct ktermios));
> >                 ^^^^^^
> > kzalloc
> >
> >   		if (!*o_ltp_loc) {
> >  -			o_ltp =3D (struct ktermios *)
> >  -				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
> >  +			o_ltp =3D kmalloc(sizeof(struct ktermios), GFP_KERNEL);
> >                                 ^^^^^^^
> >   			if (!o_ltp)
> >   				goto free_mem_out;
> >   			memset(o_ltp, 0, sizeof(struct ktermios));
> >                         ^^^^^^
> > kzalloc
>
> Currently I'm dropping this patch and writing a big patch to remove all t=
he
> k[mzc]alloc castings in the 20-rc3 tree as suggested by Mr. Robert Day.

One big patch for the whole kernel will not work anyway. You have to split =
it=20
up to allow subsystems to integrate them in their own trees. With one big=20
patch you would get collisions all over the tree causing the complete patch=
=20
to get dropped. Also CC subsystem maintainers on their parts. And please se=
nd=20
the patches as replies to the first one as it cleans up readability of lkml=
 a=20
lot :)

> I think this will be better done in another patch to let every patch do o=
ne
> single thing. right ?

Yes. But I would suggest starting with the kmalloc()->kzalloc() things. Whe=
n=20
you do this conversions just remove the casts of the lines you're touching.=
=20
This will reduce the size of the complete thing avoiding two rather trivial=
=20
patches touching the same line twice.

Eike

--nextPart1207833.nokOMTnfQq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFnifFXKSJPmm5/E4RAqO9AJ9JcA5fOySuGeeumSXopCqcolcOrwCfcukn
y1Awa+15rwPU3TCqgNpqpds=
=+Gwg
-----END PGP SIGNATURE-----

--nextPart1207833.nokOMTnfQq--
