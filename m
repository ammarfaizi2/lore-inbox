Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVBCCex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVBCCex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVBCCex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:34:53 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:60314 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262738AbVBCCef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:34:35 -0500
Subject: Re: dm-crypt crypt_status reports key?
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de,
       Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <20050203015236.GO2493@waste.org>
References: <20050202211916.GJ2493@waste.org>
	 <1107394381.10497.16.camel@server.cs.pocnet.net>
	 <20050203015236.GO2493@waste.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-52JWul7ySlNcVT4exRu6"
Date: Thu, 03 Feb 2005 03:34:29 +0100
Message-Id: <1107398069.11826.16.camel@server.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-52JWul7ySlNcVT4exRu6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 02.02.2005, 17:52 -0800 schrieb Matt Mackall:

> > An alternativ would be to use some form of handle to point to the key
> > after it has been given to the kernel. But that would require some more
> > infrastructure.
>=20
> There's been some talk about such infrastructure already. I believe
> some pieces of it may already be in place.

Yes, you are right. I didn't follow the discussion but it actually looks
very promising. The keys in the infrastructure are reference-counted.
That's good.

The keyrings can be attached to either thread, processes, sessions or
users.=20

It seems that it's possible to have floating keys (not attached to any
keyring). So we would just need to figure out how to use these keyrings
to allow communication with userspace applications. Process keyrings
seem to have the advantage that the keyring is dropped when it exits so
that all keys that are not in use by the kernel are also dropped. A
keyring for the root user would have the problem that if the cryptsetup
application aborts in the middle you would end up with old keys lying
around forever.

The keyring API seems very flexible. You can define your own type of
keys and give them names. Well, the name is probably irrelevant here and
should be chosen randomly but it's less likely to collide with someone
else.


--=-52JWul7ySlNcVT4exRu6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAY21ZCYBcts5dM0RAjsmAJ9OrUlTjfWq043MCzWza5WVovc4dQCfW2sO
p1ieLQGrnhoCKN1Hv2atqJQ=
=qaM/
-----END PGP SIGNATURE-----

--=-52JWul7ySlNcVT4exRu6--
