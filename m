Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUBWAdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUBWAdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:33:18 -0500
Received: from viefep14-int.chello.at ([213.46.255.13]:51756 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S261292AbUBWAdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:33:10 -0500
Date: Mon, 23 Feb 2004 01:35:04 +0100
To: Christophe Saout <christophe@saout.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040223003504.GA15110@ghanima.endorphin.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20040219170228.GA10483@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.4i
From: Fruhwirth Clemens <clemens-dated-1078360505.b6b1@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2004 at 06:02:32PM +0100, Christophe Saout wrote:
> since some people keep complaining that the IV generation mechanisms
> supplied in cryptoloop (and now dm-crypt) are insecure, which they
> somewhat are, I just hacked a small digest based IV generation mechanism.
>=20
> It simply hashes the sector number and the key and uses it as IV.
>=20
> You can specify the encryption mode as "cipher-digest" like aes-md5 or
> serpent-sha1 or some other combination.

I actually would prefer that cipher algorithm and cipher mode are seperated.
It's just a matter of personal taste that I'd like to stick things where I
think they belong. So imho it would be nicer to split this string into two
seperate: one for the cipher algorithm, the other for the mode of operation,
namely, "ecb" or "cbc-<ivmode>".=20

> Consider this as a proposal, I'm not a crypto expert. Tell me if it
> contains other flaws that should be fixed.

No obvious flaws for me. I've already argued in private different IV mode,
but one more time for the public ;) : I embraced the principal of reusing
components in security systems instead of depending on a large number on
different subsystems. The only IV mode which can finally make sence for me
is the use of cipher algorithm as hash algorithm. This will keep the risk of
breakage of the system by the insecurity of one component to a minimum. A
pratical reason for using one algorithm is that just one algorithm has to be
optimized (f.e. assembler optimized or hardware offloading). I'd like to
submit a patch for this as soon as dm-crypt is merged. Andrew: any ideas if
this will happen soon?

> At least the "cryptoloop-exploit" Jari Ruusu posted doesn't work anymore.

"""exploit""".

Best Regards,
Clemens

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQFAOUq4W7sr9DEJLk4RAmBlAJ94gKnnZDiLEhVVbt2XI6owy+8McgCYhToX
11WyMjW8O8DGpyjJAK3zQw==
=hSmt
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
