Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVAZK4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVAZK4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 05:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVAZK4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 05:56:25 -0500
Received: from dea.vocord.ru ([217.67.177.50]:56508 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262266AbVAZK4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 05:56:09 -0500
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <ROmq5T3x.1106733327.5706070.khali@localhost>
References: <ROmq5T3x.1106733327.5706070.khali@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s8uU/yZAB0bB2KO5QBRf"
Organization: MIPT
Date: Wed, 26 Jan 2005 13:55:07 +0300
Message-Id: <1106736907.5257.134.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 10:49:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s8uU/yZAB0bB2KO5QBRf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 10:55 +0100, Jean Delvare wrote:
> Hi Evgeniy,
>=20
> > > So I suspect that this update at least was never reviewed by anyone (=
on
> > > the sensors list at least).
> >
> > I have one rule - if noone answers that it means noone objects,
> > or it is not interesting for anyone, and thus noone objects.
>=20
> Broken rule IMHO. This might be fine for your own projects, but doesn't
> work at all for the kernel. Silence might not mean that everyone agrees.
> Rather, it could mean that either people are just not interested at all,
> or they are too busy to review a whole new subsystem (or more) at the
> moment. Believe me, kernel folks are very, very busy.

Sigh.
I presented the code.
Several times in special mail list.

Only problem that it was not sent to lkml, where there are=20
too many noise and flood. That is why while digging through it several=20
years ago I decided to drop this mail list.

> > I have pc8736x logical devices in my TODO list, but they are currently
> > preempted by acrypto, but I definitely will get it very soon.
>=20
> I don't think you get me. Your personal priorities are unimportant when
> you are asking for code review and merge into the main kernel tree. What
> matters is that parts are presented correctly and added in small chunks
> and in the right order, so as to minimize the time it takes to Greg and
> others to understand, review and accept it.
>=20
> One year ago I learnt this the hard way myself. I realize how deep my
> misunderstanding of the situation was back then, and now praise Greg for
> the good lesson - however tough it was for me at that time - each time I
> now send a kernel patch the right way and get it accepted.
>=20
> So, make yourself a favor and comply with what the kernel folks expect
> from you. They won't change for you.

Mdee...

I do not understand you, what are you trying to say? Waht is wrong?
I wrote the code.
I presented it.
I presented it again.
I presented it yeat another again.

First time people answered, then - not.

I ask for inclusion. It is included, and ohh now people recall,=20
that they wanted to complain.
Ok, I want to listen what technical problems do you see?

> > > If you can provide a patch which adds your superio core driver and on=
e
> > > which modifies the pc87360 driver to take make use of it, and only th=
at,
> > > this would certainly be easier for everyone (and especially me) to
> > > review your superio code. Once this is in, incremental patches for th=
e
> > > additional features should be easier for you to generate and for the
> > > rest of us to review.
> >
> > pc87360.c can not be used with superio as is, it requires big rewrite,
> > since you implemented it as part of i2c core,
> > that is why I created parts that was not touched by your driver.
>=20
> Again, you clearly don't get it. The pc87360 driver does *not* require a
> big rewrite. Without even looking at your superio code again, I can tell
> that it is necessarily broken if every driver which accesses the superio
> address space at the moment needs a big rewrite.
>=20
> The pc87360 driver only really uses the superio for hardware
> identification and then to get a couple configuration values (such as
> subdevice I/O addresses) at startup, and then leaves it alone forever.
> If we has a dedicated superio driver, it would need to provide an
> interface to read, and eventually write, these values, as a replacement
> for the savage direct accesses we do for now. Period. Anything else
> might be nice or useful for other logical devices (such as GPIOs) but is
> not strictly necessary at first.
>=20
> I do not deny that these Super-I/O integrated sensors are not using the
> SMBus and as such do not truly belong to the i2c subsystem. It just
> happens that, for now and for historical reasons, the i2c subsystem is
> also where all hardware monitoring drivers are. That might (hopefully)
> change in the future, but this is a completely different problem. One
> thing at a time please.

Sigh.
Jean, it looks like you forget how superio is designed.
Your pc87360 driver is all in one big piese of code, superio
is splitted into absolutely separated modules - _one_ for superio chip,
and _several_ for logical devices.

I need to split your driver into at least 5 parts - pc8736x=20
initialisation(superio has it), i2c part(should be removed from superio
code),
fan logical device(separate part), voltage monitor logical device
(separate part)
and temperature monitor logical device(separate part).

They are just separate modules, it is design feature to use _the_
_same_,=20
for example, voltage monitor module with _any_ number of existent
superio chips.

> > Your driver is part of i2c core, it just not supposed to be used
> > in superio, although many hardware routings could be used.
>=20
> Again, some drivers in the i2c subsystem use ISA accesses; others need to
> poke a couple PCI configuration registers. We did not move these drivers
> to the ISA (is there even one?) or PCI subsystems. Before anything else,
> these drivers are hardware monitoring drivers, and such drivers belong -
> for now - to the i2c subsystem, until we can separate the i2c subsystem
> from the hardware monitoring function more clearly.
>=20
> So, the pc87360, it87, smsc47m1 and w83627hf drivers are not going to
> move to the "superio subsystem", nor are they going to be rewritten
> for it. Superio chips are only a new way to access the subdevices. What
> we need for them is an extension of the request_region/release_region
> mechanism, because superios introduce a two-level addressing scheme. And
> this is about it.

And that will end up having tons of duplicated code in each driver:
temp monitor in A, temp monitor in B and so on...
volt monitor in A, volt monitor in B and so on...
...

Jean, we already discussed it a bit in lm_sensors mail list AFAR...

> Thanks,
> --
> Jean Delvare
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-s8uU/yZAB0bB2KO5QBRf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB93cLIKTPhE+8wY0RAuM7AJ9oIBgO4hYw2CCcMPRjuXd0+sfzJQCdEmxS
GrEkc8tJaPPYw31Q/wr2PNA=
=DYa/
-----END PGP SIGNATURE-----

--=-s8uU/yZAB0bB2KO5QBRf--

