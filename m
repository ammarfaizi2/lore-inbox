Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVASW0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVASW0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVASWYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:24:21 -0500
Received: from use.the.admin.shell.to.set.your.reverse.dns.for.this.ip ([80.68.90.107]:55813
	"EHLO irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261933AbVASWTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:19:01 -0500
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Dan Hollis <goemon@anime.net>,
       Venkat Manakkal <venkat@rayservers.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Paul Walker <paul@black-sun.demon.co.uk>, linux-kernel@vger.kernel.org,
       linux-crypto@nl.linux.org
In-Reply-To: <Xine.LNX.4.44.0501191623140.30540-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0501191623140.30540-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U5VIVw3S+45/uvuLz7q7"
Date: Wed, 19 Jan 2005 23:18:50 +0100
Message-Id: <1106173131.19164.15.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U5VIVw3S+45/uvuLz7q7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-19 at 16:24 -0500, James Morris wrote:=20
> On Wed, 19 Jan 2005, Fruhwirth Clemens wrote:
>=20
> > I've rewritten some CBC code to fit the facilities I introduce in my LR=
W
> > patch[1]. Here are the results for my P4@1.8GHZ:
> >=20
> > loop-aes, CBC: ~30.5mb/s
> > dm-crypt, CBC prior to my rewrite: ~23mb/s
> > dm-crypt, CBC with my LRW patch: ~27mb/s
> > dm-crypt, LRW with my LRW patch: ~27mb/s (slightly faster than CBC)
> >=20
> > As you can see my LRW patches (actually it's the generic scatterwalker
> > which is part of the LRW patch set) halves the gap to loop-aes.=20
>=20
> This looks promising.  I wonder if the generic scatterwalker solves the=20
> null encryption performance problem that was reported a little while back=
.

I've done some testing initially. The problem, at least with respect to
CBC, is that the NULL cipher's block size is 1. The CBC path isn't zero
originally and not even in my code (although I planned to do a zero copy
version).=20

However, my patch will surely bring some relieve, as my scatterwalk code
does not give up the kmapping after every block, but wait for a page to
be completely processed. So that's one kmap/kunmap instead of 4096.

P.S.: The list of recipients have grown too long and topic moved a bit.
I will remove a bunch of people if I post another follow-up. Please
check the archive if interested and not subscribed.
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-U5VIVw3S+45/uvuLz7q7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB7tzKW7sr9DEJLk4RAumlAJ9WTEVGPlpZR8h757qxz9nkqiGrYwCgjsac
4W+Q9+7EM7EPExO8yZ+yVWw=
=sGM2
-----END PGP SIGNATURE-----

--=-U5VIVw3S+45/uvuLz7q7--
