Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTENMWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTENMWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:22:41 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:59870 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S261970AbTENMWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:22:39 -0400
Date: Wed, 14 May 2003 15:35:24 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PAG support only
Message-ID: <20030514123524.GK20083@actcom.co.il>
References: <20030514045744.GQ11374@actcom.co.il> <19000.1052906076@warthog.warthog>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <19000.1052906076@warthog.warthog>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2003 at 10:54:36AM +0100, David Howells wrote:
>=20
> Muli Ben-Yehuda wrote:
>=20
> > > + * VFS session authentication token cache
> > ...
> >
> > If you know the type of the data, why keep it all in one binary blob,
> > instead of a struct? cache effects?=20
>=20
> No. We _don't_ know the type of the data. A filesystem entrusts us with a
> token to keep in the PAG on its behalf. However, since this is meant to b=
e a
> generic mechanism, it's entirely dependent on the fs as to what's in
> the blob.=20

But you do know the type of the data in the blob... it's char* fsname,
const void* key and const void* data, according to your code.=20

You do

void* blob =3D kmalloc(fsname size + key size + data size)

memcpy(blob, fsname, fsname size)
memcpy(blob + fsname offset, key, key size)
mempcy(blob + fsname offset + key offset, data, data size)

I suggest

struct fsblob {=20
       const char* fsname;=20
       const void* key;=20
       size_t keysize;=20
       const void* data;=20
       size_t datasize;=20
};=20

struct fsblob b;=20

b->fsname =3D kmalloc(fsname size)
memcpy(b->fsname, fsname, fsname size)

etc.=20

Your method loses on additional complexity, and wins on
speed. However, unless it's really, really speed sensitive code, I
would go for KISS any day.

> > Nothing in this patch appears to be using it. You aren't taking a
> > reference to the token here, what's protecting it from disappearing
> > after the return and before the caller gets a chance to do something
> > with it?
>=20
> Thanks. Fixed.

My pleasure.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wjgMKRs727/VN8sRAsVSAJoDC0JFKTEXYk/uJ440GgKVz7EsrQCgmUfy
Hdcrhusf1zb7M5HLmB/uROs=
=Z90Y
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
