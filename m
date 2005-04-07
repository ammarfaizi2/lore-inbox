Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVDGIJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVDGIJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVDGIJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:09:24 -0400
Received: from dea.vocord.ru ([217.67.177.50]:17342 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262219AbVDGIHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:07:24 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112860419.28858.76.camel@uganda>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CpD5834E0LjXrpeWOc15"
Organization: MIPT
Date: Thu, 07 Apr 2005 12:13:58 +0400
Message-Id: <1112861638.28858.92.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 12:07:07 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CpD5834E0LjXrpeWOc15
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 11:53 +0400, Evgeniy Polyakov wrote:
> > > Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > > >
> > > > Hello,
> > > >=20
> > > >  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. So=
 it
> > > > seems that you removed the connector?
> > >=20
> > > Greg dropped it for some reason.  I think that's best because it need=
ed a
> > > significant amount of rework.  I'd like to see it resubitted in total=
ity so
> > > we can take another look at it.
>=20
> Hmm, what exactly do you think _must_ be changed?
> Most of your comments are addressed in 4 patches I sent to you and Greg.
> Others [mostly atomic allocation] are API extensions and will be added.
> There also not included flush on callback removal.
>=20
> > > It's a new piece of core kernel infrastructure and the barriers for t=
hat
> > > are necessarily high.
> > >=20
> > > > Will you include it again in futur
> > > > release? At the same time, will you include the fork connector?
> > >=20
> > > I could put the fork connector into -mm, but would like to be convinc=
ed
> > > that it's acceptable to and useful for all system accounting requirem=
ents,
> > > not just the one project.  That means code, please.
>=20
> SuperIO and kobject_uevent are also dropped as far as I can see.
>=20
> Acrypto is being reviewed but it also depends on it, although=20
> it takes to much time, probably will be dropped too.

I mean review process - It is low priority task for maintainers,=20
so can be preempted, no problem.

> Proper w1 notification also requires connector.

=46rom the other point of view - how can someone use the interface, if it
is
not in the kernel tree?

Main connector idea was not system accounting, but it was designed
so that it can be usefull in other places, like accounting.
The main idea was to simplify userspace control and notification
system - so people did not waste it's time learning how skb's are
allocated
and processed, how socket layer is designed and what all those
netlink_* and NLMSG* mean if they do not need it.

As you can see in kobject_uevent.c changes - it is significant amount of
code
that can be removed if connector is used without _any_ advantages for=20
not using connector.

But, of course the main word is yours, so you still may allow growing
netlink uids and socket allocation all over the place.
P.S. udev may also use it directly - for example with some notification
from ->open() syscall for /dev/something_major_minor and
that "something" does not exist  :)=20
[Ok, I know you do not like it, just an idea]

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-CpD5834E0LjXrpeWOc15
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVOvGIKTPhE+8wY0RAg0DAJwJ7k6khLJWJVhqSXpr1e9ObRmrgwCdEQu0
Hb/drw+GLqHidAjXxPXgmzU=
=jz3m
-----END PGP SIGNATURE-----

--=-CpD5834E0LjXrpeWOc15--

