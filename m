Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVAYQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVAYQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVAYQA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:00:27 -0500
Received: from dea.vocord.ru ([217.67.177.50]:24761 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261991AbVAYP7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:59:47 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e050125073464befe4@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda>
	 <20050125142356.GA20206@infradead.org> <1106666690.5257.97.camel@uganda>
	 <58cb370e050125073464befe4@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IAvxYqcl4YH5TBJpnMGb"
Organization: MIPT
Date: Tue, 25 Jan 2005 19:04:47 +0300
Message-Id: <1106669087.5257.100.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 25 Jan 2005 15:59:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IAvxYqcl4YH5TBJpnMGb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-25 at 16:34 +0100, Bartlomiej Zolnierkiewicz wrote:

> > There are no places like
> > lock a
> > lock b
> > unlock a
> > unlock b
> >=20
> > and if they are, then I'm completely wrong.
> >=20
> > What you see is only following:
> >=20
> > place 1:
> > lock a
> > lock b
> > unlock b
> > lock c
> > unlock c
> > unlock a
> >=20
> > place 2:
> > lock b
> > lock a
> > unlock a
> > lock c
> > unlock c
> > unlock b
>=20
> Ugh, now think about that:
>=20
> CPU0     CPU1
> place1:   place2:
> lock a      lock b
> < guess what happens here :-) >
> lock b      lock a
> ...             ...

:) he-he, such place are in add and remove routings, and they can not be
run simultaneously
in different CPUs.

And in other places they should go through the same lock(sdev or chain):
like=20
lock sdev_lock
lock chain
unclok chain=20
lock logic
unlock logic
unlock sdev_lock


lock sdev_lock
lock logic
unlock logic
lock chain
unclok chain=20
unlock sdev_lock

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-IAvxYqcl4YH5TBJpnMGb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9m4fIKTPhE+8wY0RAlbCAJ9Zqj/XWQpBz6p25Pj3qe6Bj499gACeLwHV
Z4MioWZ2P8QgpyCP/BmTvwE=
=Ymcs
-----END PGP SIGNATURE-----

--=-IAvxYqcl4YH5TBJpnMGb--

