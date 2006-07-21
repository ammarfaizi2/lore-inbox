Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWGUUm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWGUUm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 16:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWGUUm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 16:42:28 -0400
Received: from www.timetrex.com ([69.93.244.106]:41698 "EHLO
	mail.academyoflearning.ca") by vger.kernel.org with ESMTP
	id S1751171AbWGUUm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 16:42:27 -0400
Subject: Re: reiser4 status (correction)
From: Mike Benoit <ipso@snappymail.ca>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>
In-Reply-To: <44C093D2.1040703@namesys.com>
References: <44BFFCB1.4020009@namesys.com> <44C043B5.3070501@slaphack.com>
	 <44C093D2.1040703@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-psVoHvXooL/1w7w7rcoO"
Date: Fri, 21 Jul 2006 13:41:48 -0700
Message-Id: <1153514509.6659.41.camel@ipso.snappymail.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4-2mdv2007.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-psVoHvXooL/1w7w7rcoO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-21 at 02:44 -0600, Hans Reiser wrote:
> fix fsync performance (est. 1 week of time to make post-commit writes
> asynchronous, maybe 3 weeks to create fixed-reserve for write twice
> blocks, and make all fsync blocks write twice)
>=20
> write repacker (12 weeks).
>=20
> I am not sure that putting the repacker after fsync is the right choice..=
..
>=20

Tuning fsync will fix the last wart on Reiser4 as far as benchmarks are
concerned won't it? Right now Reiser4 looks excellent on the benchmarks
that don't use fsync often (mongo?), but last I recall the fsync
performance was so poor it overshadows the rest of the performance. It
would also probably be more useful to a much wider audience, especially
if Namesys decides to charge for the repacker.

ReiserV3 is used on a lot of mail and squid proxy servers that deal with
many small files, and these work loads usually call fsync often. My
guess is that ReiserV3 users are the most likely to migrate to Reiser4,
because they already know the benefits of using a "Reiser" file system.
But neglecting fsync performance will just put a sour taste in their
mouth.=20

On top of that, I don't see how a repacker would help these work loads
much as the files usually have a high churn rate. Packing them would
probably be a net loss as the files would just be deleted in 24hrs and
replaced by new ones.

Very few people will (or should) disable fsync as David suggests, I
don't see that as a solution at all, even if it is temporary.

--=20
Mike Benoit <ipso@snappymail.ca>

--=-psVoHvXooL/1w7w7rcoO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEwTwMMhKjsejwBhgRAhdOAKCjyHZNFCoXe3+35bmjs6bYcnQ2CACghynW
FIwr8lM7yuJVKqCPS5kbRbc=
=Rsaj
-----END PGP SIGNATURE-----

--=-psVoHvXooL/1w7w7rcoO--

