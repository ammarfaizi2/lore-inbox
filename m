Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUFBQ1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUFBQ1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUFBQ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:27:11 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:8578 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263324AbUFBQ0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:26:31 -0400
Subject: Re: [PATCH] 5/5: Device-mapper: dm-zero
From: Christophe Saout <christophe@saout.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1086193026.4659.3.camel@leto.cs.pocnet.net>
References: <20040602154605.GR6302@agk.surrey.redhat.com>
	 <1086192141.4659.1.camel@leto.cs.pocnet.net>
	 <20040602160905.GX28915@suse.de>
	 <1086193026.4659.3.camel@leto.cs.pocnet.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bFy3Lftz8gzaYdEHC1/z"
Date: Wed, 02 Jun 2004 18:26:11 +0200
Message-Id: <1086193571.4659.7.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bFy3Lftz8gzaYdEHC1/z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mi, den 02.06.2004 um 18:17 Uhr +0200 schrieb Christophe Saout:

> What does this & PAGE_MASK do? This looks wrong too.

Sorry, please forget this.


--- linux.orig/drivers/md/dm-zero.c  2004-06-02 18:24:38.231186664 +0200
+++ linux/drivers/ms/dm-zero.c	     2004-06-02 18:24:55.645539280 +0200
@@ -35,7 +35,8 @@
	bio_for_each_segment(bv, bio, i) {
		char *data =3D bvec_kmap_irq(bv, &flags);
		memset(data, 0, bv->bv_len);
- 		bvec_kunmap_irq(bv, &flags);
+ 		flush_dcache_page(bv->bv_page);
+ 		bvec_kunmap_irq(data, &flags);
  	}
  }
=20


--=-bFy3Lftz8gzaYdEHC1/z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvf+jZCYBcts5dM0RArt+AJ4+t/W+mmHUcSWwfDyGkgtvrA+h9QCeIGHg
blDOWUh+3iK65p8SyEYxc+I=
=Ep30
-----END PGP SIGNATURE-----

--=-bFy3Lftz8gzaYdEHC1/z--

