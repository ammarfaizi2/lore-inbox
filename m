Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSIHWBD>; Sun, 8 Sep 2002 18:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSIHWBD>; Sun, 8 Sep 2002 18:01:03 -0400
Received: from ppp-217-133-223-68.dialup.tiscali.it ([217.133.223.68]:61164
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S315419AbSIHWBC>; Sun, 8 Sep 2002 18:01:02 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020903034607.GF29452@ravel.coda.cs.cmu.edu>
References: <1030835635.1422.39.camel@ldb>
	<15730.4100.308481.326297@charged.uio.no>
	<15730.8121.554630.859558@charged.uio.no> <1030890022.2145.52.camel@ldb>
	<15730.17171.162970.367575@charged.uio.no> <1030906488.2145.104.camel@ldb>
	<15730.27952.29723.552617@charged.uio.no> <1030916061.2145.344.camel@ldb>
	<15730.36080.987645.452664@charged.uio.no> <1030920630.1993.420.camel@ldb> 
	<20020903034607.GF29452@ravel.coda.cs.cmu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-IqWBLD7I9H87daz6IRnA"
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Sep 2002 00:04:03 +0200
Message-Id: <1031522643.3025.279.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IqWBLD7I9H87daz6IRnA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Now if this is a multithreaded application that does this in one thread
> and another thread happens to open a completely unrelated file around
> the time that the first thread drops this application's setuid
> permissions. If we don't use a copy during the open upcall, but copy it
> after the fact, we don't have the correct permissions around the time
> the file is closed.
You would copy them during the filesystem open.
My point was that in the generic vfs open there is no need to use copied
credentials so credentials copying can be restricted to network
filesystems with not-very-good designs.

> > BTW, imho a correctly designed network filesystem should have a single
> > stateful encrypted connection (or a pool of equally authenticated ones)
> > and credentials (i.e. passwords) should only be passed when the user
> > makes the first filesystem access. After that the server should do
> > authentication with the OR of all credentials received and the client
> > kernel should further decide whether it can give access to a particular
> > user.
> 
> Right, which is pretty close to what Coda does.
This is in contradiction with your statement about credentials sent
during close.
The advantage of the model I described is that, with the exception of
connection management, it works exactly like a normal filesystem with
the exception of some totally inaccessible files due to server access
denies.


--=-IqWBLD7I9H87daz6IRnA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9e8lTdjkty3ft5+cRAkiRAJ99fce/O8dXinxSzBRPHmOS1KPZVQCfZ0ce
um1mSnZ+02x6AFMQ7Rnp+Pw=
=f/xm
-----END PGP SIGNATURE-----

--=-IqWBLD7I9H87daz6IRnA--
