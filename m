Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTL2RYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTL2RYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:24:14 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:31447 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263762AbTL2RYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:24:10 -0500
Date: Mon, 29 Dec 2003 19:24:02 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "Sirotkin, Alexander" <demiurg@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network driver that uses skb destructor
Message-ID: <20031229172402.GG13481@actcom.co.il>
References: <3FF05C27.5030706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Hr//EUsa8//ouuB"
Content-Disposition: inline
In-Reply-To: <3FF05C27.5030706@ti.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+Hr//EUsa8//ouuB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2003 at 06:53:59PM +0200, Sirotkin, Alexander wrote:

> Anybody tried to implement similar approach ?
> Any thoughts why this would (or would not) work ?

It's a nice idea in theory, but the reality is that as the code
currently stands, the upper layers 'hijack' the skb->destructor
without regards to whether it was set previously, causing your memory
to leak. See skb_set_owner_w(), skb_set_owner_r().=20

I wrote a patch to allow chaining of skb destructors, which was fairly
simple and would allow both the driver and the upper layers to set
their destructors. If there's any interet, I could probably resurrect
it.

Cheers,=20
Muli
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--+Hr//EUsa8//ouuB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8GMxKRs727/VN8sRAiyeAKCLi1FakwPt/Bm6Kqrx0MfuVNd1gQCgivpR
A5Ycg86lRoin9mnilkWSsvc=
=Sa4U
-----END PGP SIGNATURE-----

--+Hr//EUsa8//ouuB--
