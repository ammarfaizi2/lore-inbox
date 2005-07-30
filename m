Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVG3Vkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVG3Vkt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVG3Vkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:40:49 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:60873 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262927AbVG3Vkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:40:47 -0400
Date: Sat, 30 Jul 2005 23:32:20 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] random : prefetch the whole pool, not 1/4 of it
Message-ID: <20050730213220.GL14975@vanheusden.com>
References: <20050407212058.GU3174@waste.org> <42E95B83.8070006@cosmosbay.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/BvujNCPFVhiGON"
Content-Disposition: inline
In-Reply-To: <42E95B83.8070006@cosmosbay.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Jul 25 14:06:23 CEST 2005
X-MSMail-Priority: High
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.9i
X-Original-Status: RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o/BvujNCPFVhiGON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Could you check this patch and apply it ?
> [RANDOM] : prefetch the whole pool, not 1/4 of it,
>            (pool contains u32 words, not bytes)
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

> --- linux-2.6.13-rc3/drivers/char/random.c	2005-07-13 06:46:46.000000000 =
+0200
> +++ linux-2.6.13-rc3-ed/drivers/char/random.c	2005-07-29 00:11:24.0000000=
00 +0200
> @@ -469,7 +469,7 @@
>  	next_w =3D *in++;
> =20
>  	spin_lock_irqsave(&r->lock, flags);
> -	prefetch_range(r->pool, wordmask);
> +	prefetch_range(r->pool, wordmask*4);

Isn't it cleaner to replace the line above with:
+	prefetch_range(r->pool, wordmask * sizeof(__u32));
as the pool contains u32 words?

>  	input_rotate =3D r->input_rotate;
>  	add_ptr =3D r->add_ptr;
> =20



Folkert van Heusden

--=20
Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
--------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE

--o/BvujNCPFVhiGON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkLr8eQ8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuHvMAoIBdMjXd
dPg1Z8nRAnkQw1Wh96v1AKCQZqaeMwJzszPvnX35EMYrBg1zKg==
=WGZm
-----END PGP SIGNATURE-----

--o/BvujNCPFVhiGON--
