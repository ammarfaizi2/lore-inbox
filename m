Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVAZI1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVAZI1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVAZI1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:27:50 -0500
Received: from dea.vocord.ru ([217.67.177.50]:3478 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262386AbVAZI1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:27:36 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050125224247.GA29849@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda>
	 <20050125142356.GA20206@infradead.org> <1106666690.5257.97.camel@uganda>
	 <20050125224247.GA29849@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mmz3dFB/z4HW3oqlP2xM"
Organization: MIPT
Date: Wed, 26 Jan 2005 11:31:07 +0300
Message-Id: <1106728267.5257.116.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 08:25:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mmz3dFB/z4HW3oqlP2xM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-25 at 22:42 +0000, Christoph Hellwig wrote:
> > Zeroing can be found easily - the whole structure is NULL pointer,=20
> > and will always panic if accessed(from running superio code),=20
> > but redzoning is only happen on borders,
> > and can catch writes over the boards, which is rarely in this case.
>=20
> As I mentioned the redzoning was a brainfar on my side.  Slab debug
> code memsets all code with an easily recognizable pattern (which 0 is _NO=
T_).
>=20
> So this is totally useless, please don't do it - as all major subsystems
> don't do it either.

Ok, I do not insist.

> > Each superio chip is registered with superio core without any devices.
> > Each logical device is registered with superio core without any superio
> > chip.
> >=20
> > Then core checks if some chip is found in some superio device, and
> > links=20
> > it to appropriate device.
> > So if board has several superio chips(like soekris board) and several
> > logical devices in it, then we only have 2 superio small drivers, and
> > several=20
> > logical device drivers, but not
> > number_of_superio_chips*number_of_logical_devices drivers.
>=20
> That's how just about any bus driver works so far.
>=20
> Now somewhere else in the thread I read the a single logical device
> might belong to multiple superio devices.  Which is kinda odd, but in
> that case it's indeed needed.
>=20
> So please add a big comment explaining that properperty because it
> is extemly uncommon, and make 'ptr' in the chain structure typed
> instead of void *

Ok.

> > Yes, and it is better than removing module whose structures are in use.
> > SuperIO core is asynchronous in it's nature, one can use logical device=
=20
> > through superio core and remove it's module on other CPU, above loop
> > will
> > wait untill all reference counters are dropped.
>=20
> General rule is: increment module reference count while the hardware
> is actually in use, and let device structures be allocated by the
> bus core so drivers can be freed with them still allocated.  That's
> how the driver model and thus about every other subsystem works.

It is not general rule - network stack does not have such mechanism,
which is=20
very good, I doubt each block device module increment it's module
reference
when it catch a request...
It is internal structure that has reference counter, not module itself,
and this=20
structure may be in use, when module is unloaded, thus unloading must
wait,=20
untill all it's structures are freed.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-mmz3dFB/z4HW3oqlP2xM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB91VLIKTPhE+8wY0RAqyPAJ9b88AIbKFoGXeGso740bRJYwVBBQCfRVev
HFZi1nTGVSSyOv6fwF93AM4=
=goVj
-----END PGP SIGNATURE-----

--=-mmz3dFB/z4HW3oqlP2xM--

