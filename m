Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVDZHKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVDZHKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVDZHKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:10:25 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:7368 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261366AbVDZHJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:09:51 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Greg KH <gregkh@suse.de>
Cc: dtor_core@ameritech.net, sensors@stimpy.netroedge.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050426070003.GE5889@suse.de>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d50005042107314cbacdea@mail.gmail.com>
	 <1114420131.8527.52.camel@uganda>
	 <d120d50005042509326241a302@mail.gmail.com>
	 <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
	 <d120d500050425132250916bcb@mail.gmail.com>
	 <1114497816.8527.66.camel@uganda>  <20050426070003.GE5889@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-20NmltUugReXvmQmyNWP"
Organization: MIPT
Date: Tue, 26 Apr 2005 11:17:06 +0400
Message-Id: <1114499826.8527.97.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 26 Apr 2005 11:09:36 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-20NmltUugReXvmQmyNWP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-26 at 00:00 -0700, Greg KH wrote:
> On Tue, Apr 26, 2005 at 10:43:36AM +0400, Evgeniy Polyakov wrote:
> > On Mon, 2005-04-25 at 15:22 -0500, Dmitry Torokhov wrote:
> > > On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > While thinking about locking schema
> > > > with respect to sysfs files I recalled,
> > > > why I implemented such a logic -
> > > > now one can _always_ remove _any_ module
> > > > [corresponding object is removed from accessible
> > > > pathes and waits untill all exsting users are gone],
> > > > which is very good - I really like it in networking model,
> > > > while with whole device driver model
> > > > if we will read device's file very quickly
> > > > in several threads we may end up not unloading it at all.
> > >=20
> > > I am sorrry, that is complete bull*. sysfs also allows removing
> > > modules at an arbitrary time (and usually without annoying "waiting
> > > for refcount" at that)... You just seem to not understand how driver
> > > code works, thus the need of inventing your own schema.
> >=20
> > Ok, let's try again - now with explanation,=20
> > since it looks like you did not even try to understand what I said.
> > If you will remove objects from ->remove() callback
> > you may end up with rmmod being stuck.
>=20
> Yes, and that is acceptable.  networking implemented their own locking
> method to allow unloading of their drivers in such a manner.  No other
> subsystem is going to do that kind of implementation, so Dmitry is
> correct here.

w1 does it too :)
It's locking was lurked in network code.
And it _is_ design note to be able to remove objects in any time.
Ok, I can not say, that it is exactly like networking,=20
since there is waiting in rmmod path, it is very similar to virtual
devices
like vlan.

> thanks,
>=20
> greg k-h
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-20NmltUugReXvmQmyNWP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCberyIKTPhE+8wY0RAhL0AKCYpLql9pFZQPhgM+ye02gG6x+WGQCeKEVw
j1xU6KJmH+AsgMPDHyajv5g=
=sd+/
-----END PGP SIGNATURE-----

--=-20NmltUugReXvmQmyNWP--

