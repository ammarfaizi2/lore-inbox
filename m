Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUHZOd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUHZOd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268928AbUHZOaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:30:21 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:10136 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269022AbUHZOZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:25:30 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Hans Reiser <reiser@namesys.com>, Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040826140500.GA29965@fs.tum.de>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
	 <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826001152.GB23423@mail.shareable.org>
	 <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com>
	 <20040826140500.GA29965@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ayEJYZR3115GeyJhdEGR"
Date: Thu, 26 Aug 2004 16:25:13 +0200
Message-Id: <1093530313.11694.56.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ayEJYZR3115GeyJhdEGR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 16:05 +0200 schrieb Adrian Bunk:

> > Yes, this was part of the plan, tar file-directory plugins would be cut=
e.
>=20
> Silly question:
>=20
> GNU Midnight Commander allows for ages to go into e.g. tar files, so I=20
> know the benefits of this. Additionally, in GNU Midnight Commander, this=20
> works no matter which file system I use (e.g. it works on iso9660), and=20
> it even works the same way on other OS's like e.g. Solaris and NetBSD.
>=20
> What is the technical reason why a tar plugin should be reiser4=20
> specific, instead of a generic VFS or userspace solution that would=20
> allow the same also on other fs like e.g. iso9660?

I don't think that this should be done inside the kernel. tar is a
perfectly valid userspace application.

What reiser4 can do, but the VFS can't is to insert or remove data in
the middle of a file. Adding this above the page cache would probably be
almost impossible (truncate seems already complicated enough).

But below page-cache and thus invisible from the VFS or the applications
it is extremely useful for the compression plugin. When changing some
data in the middle of the file the compressed data might grow in size.
reiser4 can handle this inside the storage layer and doesn't mess with
the rest of the filesystem.


--=-ayEJYZR3115GeyJhdEGR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLfLJZCYBcts5dM0RAsyfAJ93usHbDXqOrv2ObJ3BYvO03yWSvwCeJ15d
cXzraPHedm+u0kJwcHUVADg=
=GB1W
-----END PGP SIGNATURE-----

--=-ayEJYZR3115GeyJhdEGR--

