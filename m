Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSIILNI>; Mon, 9 Sep 2002 07:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSIILNI>; Mon, 9 Sep 2002 07:13:08 -0400
Received: from ppp-217-133-216-23.dialup.tiscali.it ([217.133.216.23]:2501
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317030AbSIILNH>; Mon, 9 Sep 2002 07:13:07 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020909062223.GA19766@ravel.coda.cs.cmu.edu>
References: <15730.8121.554630.859558@charged.uio.no>
	<1030890022.2145.52.camel@ldb> <15730.17171.162970.367575@charged.uio.no>
	<1030906488.2145.104.camel@ldb> <15730.27952.29723.552617@charged.uio.no>
	<1030916061.2145.344.camel@ldb> <15730.36080.987645.452664@charged.uio.no>
	<1030920630.1993.420.camel@ldb>
	<20020903034607.GF29452@ravel.coda.cs.cmu.edu>
	<1031522643.3025.279.camel@ldb> 
	<20020909062223.GA19766@ravel.coda.cs.cmu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-s/zgS+SVcQgdh7Su1IXc"
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Sep 2002 13:17:45 +0200
Message-Id: <1031570265.16159.130.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s/zgS+SVcQgdh7Su1IXc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-09-09 at 08:22, Jan Harkes wrote: 
> On Mon, Sep 09, 2002 at 12:04:03AM +0200, Luca Barbieri wrote:
> > > Now if this is a multithreaded application that does this in one thread
> > > and another thread happens to open a completely unrelated file around
> > > the time that the first thread drops this application's setuid
> > > permissions. If we don't use a copy during the open upcall, but copy it
> > > after the fact, we don't have the correct permissions around the time
> > > the file is closed.
> > You would copy them during the filesystem open.
> > My point was that in the generic vfs open there is no need to use copied
> > credentials so credentials copying can be restricted to network
> > filesystems with not-very-good designs.
> > 
> > > > BTW, imho a correctly designed network filesystem should have a single
> > > > stateful encrypted connection (or a pool of equally authenticated ones)
> > > > and credentials (i.e. passwords) should only be passed when the user
> > > > makes the first filesystem access. After that the server should do
> > > > authentication with the OR of all credentials received and the client
> > > > kernel should further decide whether it can give access to a particular
> > > > user.
> > > 
> > > Right, which is pretty close to what Coda does.
> > This is in contradiction with your statement about credentials sent
> > during close.
> 
> How so, Coda has a pool of authenticated connections per user. But the
> userspace cachemanager still needs to know which user performed the
> operation in order to pick the right connection to send the message.
> 
> If user A opens a file and then user B writes/closes it, should it send
> the write/close message over the authenticated connection of user B?
> Ofcourse not, so we need to store the credentials of the opener with the
> file.
My point is that all users should be authenticated on all connections.
You may have to remember which connection was used to open the file, but
it's probably much better to design the protocol so that this isn't
necessary: this would allow efficient load balancing with per-cpu or
per-nic connections.


--=-s/zgS+SVcQgdh7Su1IXc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9fINZdjkty3ft5+cRAiSaAJ94Yv033bd+qVzuRloG3tUIqHuE3QCdHx/3
mSAOSPx/iu5Az4shwoUTs2Q=
=Cx5Q
-----END PGP SIGNATURE-----

--=-s/zgS+SVcQgdh7Su1IXc--
