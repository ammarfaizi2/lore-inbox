Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263483AbUFBQRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUFBQRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUFBQRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:17:30 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:27265 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263483AbUFBQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:17:23 -0400
Subject: Re: [PATCH] 5/5: Device-mapper: dm-zero
From: Christophe Saout <christophe@saout.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040602160905.GX28915@suse.de>
References: <20040602154605.GR6302@agk.surrey.redhat.com>
	 <1086192141.4659.1.camel@leto.cs.pocnet.net>
	 <20040602160905.GX28915@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YDiCCCNJyOXbUJYg0+Qx"
Date: Wed, 02 Jun 2004 18:17:06 +0200
Message-Id: <1086193026.4659.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YDiCCCNJyOXbUJYg0+Qx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mi, den 02.06.2004 um 18:09 Uhr +0200 schrieb Jens Axboe:
> On Wed, Jun 02 2004, Christophe Saout wrote:
> > Am Mi, den 02.06.2004 um 16:46 Uhr +0100 schrieb Alasdair G Kergon:
> >=20
> > > +	bio_for_each_segment(bv, bio, i) {
> > > +		char *data =3D bvec_kmap_irq(bv, &flags);
> > > +		memset(data, 0, bv->bv_len);
> >=20
> > I just noticed, there's a
> >=20
> > 		flush_dcache_page(bv->bv_page);
> >=20
> > missing here.
> >=20
> > > +		bvec_kunmap_irq(bv, &flags);
>=20
> and even worse, passing bad argument to bvec_kunmap_irq().

Oops. Right.

> extern inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
> {
> 	unsigned long ptr =3D (unsigned long) buffer & PAGE_MASK;
>
> 	kunmap_atomic((void *) ptr, KM_BIO_SRC_IRQ);
> 	local_irq_restore(*flags);
> }

What does this & PAGE_MASK do? This looks wrong too.


--=-YDiCCCNJyOXbUJYg0+Qx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvf2CZCYBcts5dM0RAq1lAJ9BjZ5cDhmxxXQpsOcoP9GQYjnABQCfetg4
EApsvz+KUf4dIa+rPe280KA=
=XsSJ
-----END PGP SIGNATURE-----

--=-YDiCCCNJyOXbUJYg0+Qx--

