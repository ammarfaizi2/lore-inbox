Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268011AbTBRVBa>; Tue, 18 Feb 2003 16:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268013AbTBRVBa>; Tue, 18 Feb 2003 16:01:30 -0500
Received: from mx.laposte.net ([213.30.181.11]:57552 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id <S268011AbTBRVB3>;
	Tue, 18 Feb 2003 16:01:29 -0500
Subject: Re: [2.5] EHCI HID keyboard not unloaded at reboot time ?
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
In-Reply-To: <20030216212801.GA2546@elf.ucw.cz>
References: <1045324980.1767.28.camel@rousalka>
	 <20030216212801.GA2546@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4bfaXpMCEm8MV+VSMxLJ"
Organization: 
Message-Id: <1045602674.2091.8.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 18 Feb 2003 22:11:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4bfaXpMCEm8MV+VSMxLJ
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le dim 16/02/2003 =E0 22:28, Pavel Machek a =E9crit :
> Hi!
>=20
> > 	This is a question related to :
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D9
> >=20
> > 	Basically I have a usb keyboard plugged on an external USB2 hub. Using
> > a monolithic ehci/hid kernel I can get it to work in 2.5. It's also use=
d
> > in usb1 mode by the bios and the bootloader.
> >=20
> > 	However when I shut down or reboot from 2.5, I loose keyboard support
> > in the bios/bootloader/linux 2.4 (used to loose it in linux 2.5 also bu=
t
> > recent ehci enhancements enable 2.5 to recover it). Nothing short of a
> > PSU stop (neither reset nor stop button works) will recover it.
>=20
> Well, if reset does not work, it looks like hw bug ;-). OTOH this
> might be quite easy to workaround in sw. What happens if you unplug
> and replug the keyboard?

Hey, thanks for the reply.

Turns out I was right about the diagnostic. 2.5 *did* *not* *unload*
*ehci*. So after the reboot all usb1-aware systems (bios, linux 2.4,
etc) found usb components that expected usb2 commands. David Brownell
send me a patch that forced ehci unload at shutdown (via a reboot
notifier) and all's been well since. So it was a real 2.5 bug.

Sure the hardware could have moped up usb remains better, but since
other evil OSes cleanup their usb stack correctly, I guess they didn't
bother (plus I suspect it would have made boot times a bit longer).

Anyway, closing one of the first ten bugzilla bugs at last one feels
very good:)

--=20
Nicolas Mailhot

--=-4bfaXpMCEm8MV+VSMxLJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+UqFyI2bVKDsp8g0RAuckAJ0TJKN0T+h8Fd2m3HseDHf5HRuEJgCfWDSM
gIHyDmTzgGvs2Rh/J/iWMuI=
=/hpR
-----END PGP SIGNATURE-----

--=-4bfaXpMCEm8MV+VSMxLJ--

