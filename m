Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVDHGn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVDHGn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVDHGn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:43:58 -0400
Received: from dea.vocord.ru ([217.67.177.50]:62928 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262705AbVDHGmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:42:18 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: James Morris <jmorris@redhat.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0504080152540.24105-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0504080152540.24105-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nZRkz/jkxvDw8zFNpBOk"
Organization: MIPT
Date: Fri, 08 Apr 2005 10:48:44 +0400
Message-Id: <1112942924.28858.234.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 10:41:51 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nZRkz/jkxvDw8zFNpBOk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 01:55 -0400, James Morris wrote:
> On Fri, 8 Apr 2005, Evgeniy Polyakov wrote:
>=20
> > > > Sure, but seems I need to ask again: What is the exact reason not t=
o implement
> > > > the muticast message multiplexing/subscription part of the connecto=
r as a
> > > > generic part of netlink? That would be nice to have and useful for =
other
> > > > subsystems too as an option to the current broadcast.
> > >=20
> > > This is a good point, in general, consider generically extending Netl=
ink=20
> > > itself instead of creating these separate things.
> >=20
>=20
> > Connector requires it's own registration technique for
> > 1. hide all transport [netlink] layer from higher protocols which use
> > connector
>=20
> Why?

User should not know about low-level transport -=20
it is like socket layer -  write only data and do not care about
how it will be delivered.

> > 2. create different group appointment for the given connector's ID
> > [it was different, now new group which is eqal to idx field is appointe=
d
> > to=20
> > the new callback]
>=20
> I don't understand.

In the previous versions netlink group was assigned as incremented
counter,=20
that was not convenient, but now we have 2-way ID, which is better
from users point of view - idx is supposed to be major id, val -=20
some subsystem of that set.

> > 3. provide more generic set of ids
>=20
> What do you mean by "ids"?

Each connector message requires pair of u32 ids - idx and val.
Idx is generic system id [which is equal to the appropriate netlink
group
in current implementation], while val is id of some subsytem
inside idx.

Using only group without it's own connector's id will heavily
complex callback register/unregister notification [Jamal's suggested
feature]
for example.

>=20
> - James
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-nZRkz/jkxvDw8zFNpBOk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVilMIKTPhE+8wY0RArKEAKCQEBVWtuYDPOPT/DjFXRphpo00eACfTtBo
xgTGthRK5L8eJD/mIN1FLWQ=
=+VfP
-----END PGP SIGNATURE-----

--=-nZRkz/jkxvDw8zFNpBOk--

