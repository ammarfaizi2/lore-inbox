Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVAZOlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVAZOlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVAZOlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:41:35 -0500
Received: from dea.vocord.ru ([217.67.177.50]:16283 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262314AbVAZOlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:41:08 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <d120d50005012605323111927a@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda>
	 <20050125142356.GA20206@infradead.org> <1106666690.5257.97.camel@uganda>
	 <20050125224247.GA29849@infradead.org> <1106728267.5257.116.camel@uganda>
	 <d120d50005012605323111927a@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IeQb2rGxiXc5Wj/h7YLh"
Organization: MIPT
Date: Wed, 26 Jan 2005 17:44:51 +0300
Message-Id: <1106750691.5257.151.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 14:39:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IeQb2rGxiXc5Wj/h7YLh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 08:32 -0500, Dmitry Torokhov wrote:
> On Wed, 26 Jan 2005 11:31:07 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
> > On Tue, 2005-01-25 at 22:42 +0000, Christoph Hellwig wrote:
> > > > Yes, and it is better than removing module whose structures are in =
use.
> > > > SuperIO core is asynchronous in it's nature, one can use logical de=
vice
> > > > through superio core and remove it's module on other CPU, above loo=
p
> > > > will
> > > > wait untill all reference counters are dropped.
> > >
> > > General rule is: increment module reference count while the hardware
> > > is actually in use, and let device structures be allocated by the
> > > bus core so drivers can be freed with them still allocated.  That's
> > > how the driver model and thus about every other subsystem works.
> >=20
> > It is not general rule - network stack does not have such mechanism,
> > which is
> > very good, I doubt each block device module increment it's module
> > reference
> > when it catch a request...
> > It is internal structure that has reference counter, not module itself,
> > and this
> > structure may be in use, when module is unloaded, thus unloading must
> > wait,
> > untill all it's structures are freed.
> >=20
>=20
> No, it does not necessarily has to wait. You can unload driver at any
> time if you care to mark all its devices as "dead" and you have
> generic release function in a separate module that does not get
> unloaded until last registered device has been destroyed. Look for
> example at serio code. I think USB is about the same.
>=20

It is only because those structures can live outside the driver.
Like skb can live without even any network driver loaded.
Above case is similar, but structure is binded to the module, and can
be=20
requested outside the world.

Consider as example network stack:
netdev_wait_allrefs() waits until all references are gone, it is
called =20
when device has NETREG_UNREGISTERING state.

Very clean example is virtual devices here(tunnels, vlan) - it is
exactly the same
as logical/superio devices in superio core.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-IeQb2rGxiXc5Wj/h7YLh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB96zjIKTPhE+8wY0RAgXWAKCJAHLrAmbqavut0fN52gchO03AdwCghLvk
kwnbNEtIKnx43A08achNQ6k=
=PNbk
-----END PGP SIGNATURE-----

--=-IeQb2rGxiXc5Wj/h7YLh--

