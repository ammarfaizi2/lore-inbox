Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVAZPtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVAZPtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVAZPtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:49:35 -0500
Received: from dea.vocord.ru ([217.67.177.50]:44712 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262336AbVAZPtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:49:25 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000501260726714e8251@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <d120d5000501250811295c298e@mail.gmail.com>
	 <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
	 <200501252357.08946.dtor_core@ameritech.net>
	 <1106727902.5257.109.camel@uganda>
	 <d120d5000501260546536647e7@mail.gmail.com>
	 <1106751547.5257.162.camel@uganda>
	 <d120d5000501260726714e8251@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hrr0xZ0mK5zeRiCGdguy"
Organization: MIPT
Date: Wed, 26 Jan 2005 18:54:08 +0300
Message-Id: <1106754848.5257.189.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 15:48:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hrr0xZ0mK5zeRiCGdguy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 10:26 -0500, Dmitry Torokhov wrote:
> On Wed, 26 Jan 2005 17:59:07 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
>=20
> > Each superio chip has the same logical devices inside.
> > With your approach we will have following schema:
> >=20
> > bus:
> > superio1 - voltage, temp, gpio, rtc, wdt, acb
> > superio2 - voltage, temp, gpio, rtc, wdt, acb
> > superio3 - voltage, temp, gpio, rtc, wdt, acb
> > superio4 - voltage, temp, gpio, rtc, wdt, acb
> >=20
> > Each logical device driver (for existing superio schema)
> > is about(more than) 150 lines of code.
> > With your approach above example will be 150*6*4 +
> > 4*superio_chip_driver_size bytes
> > of the code.
>=20
> ????? Let's count again, shall we? Suppose we have:
> > superio1 - voltage, temp, gpio, rtc, wdt, acb
> > superio2 - voltage, temp, gpio, rtc, wdt, acb
> superio1 is driven by scx200 hardware, superio2 is driven by pc8736x
> or whatever. So here, you have 2 drivers to manage chips. Plus you
> have 6 superio interface drivers - gpio, acb, etc...
> It is exactly the same as your cheme size-wise.
>=20
> There is no need to many-to-many relationship. Each chip is bound to
> only one chip driver which registers several interfaces. Each
> interface is bound to only one interface driver. Interface driver is
> not chip specific, it knows how to run a specific interface (gpio,
> temp) and relies on chip driver to properly manage access to the
> hardware. Each combination of inetrface + interface driver produce one
> class_device (call it sio, serio, whatever). Class device provides
> unified view of the interface to the userspace.
>=20
> What am I missing?

Since each logical device does not know who use it, it can not be,
for example, removed optimally.
You need to run through whole superio device set to find those one that=20
has reference to logical device being removed.
And situation become much worse, when we have so called logical device
clones -=20
it is virtual logical device that emulates standard one, but inside
performs
in a different way. Clone creates inside superio device(for example such
device
can live at different address).
When you do not have ldev->sc relation, you must traverse through each
logical device=20
in each superio chip to find clones.
Thus you will need to traverse through each superio chip,=20
then through each logical device it references, just to remove one
logical device.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-hrr0xZ0mK5zeRiCGdguy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB970gIKTPhE+8wY0RAntJAJ9Nqnrt79aj+uq1jPLLYNSFliEsNwCfX4gg
R3+wwG2RIdedZR0/MqULjoI=
=UaKQ
-----END PGP SIGNATURE-----

--=-hrr0xZ0mK5zeRiCGdguy--

