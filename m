Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVCEHRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVCEHRg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 02:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVCEHRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 02:17:36 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19319 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262651AbVCEHRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 02:17:25 -0500
Date: Sat, 05 Mar 2005 00:16:21 -0700
From: Jeremy Nickurak <atrus@rifetech.com>
Subject: Re: Logitech MX1000 Horizontal Scrolling
In-reply-to: <3wDJ2-1jb-29@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
Cc: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>,
       Vojtech Pavlik <vojtech@suse.cz>
Message-id: <20050305071621.GA9097@agaeris.rifetech.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=sm4nu43k4a2Rpi4c;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
References: <3jlKa-2o0-29@gated-at.bofh.it> <3tQt7-cV-21@gated-at.bofh.it>
 <3uhWj-6Tp-27@gated-at.bofh.it> <3wDJ2-1jb-29@gated-at.bofh.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2005 at 08:50:12AM +0100, Jeremy Nickurak wrote:
> On ven, 2005-02-04 at 20:54 +0100, Vojtech Pavlik wrote:
> > Please try if 2.6.11-rc3 is any better.
>=20
> Oddly, my horizontal scroll worked fine as extra buttons under 2.6.10.
> 2.6.11-rc3 causes the scroll wheel to appear under X.org 6.8.1 with the
> evdev driver as two seperate mouse buttons being pressed simultaneously.

The breakage introduced in 2.6.11-rc3 is still observed in 2.6.11. If in fa=
ct my configuration is wrong, I'd love to know how and why, as the configur=
ation I'm using worked fine (with the exception of http://bugzilla.kernel.o=
rg/show_bug.cgi?id=3D1786 ) under 2.6.10:

> Section "InputDevice"
>    Identifier  "Mouse0"
>    Driver      "mouse"
>    Option      "CorePointer"
>    Option      "Protocol" "evdev"
>    Option        "Dev Phys" "usb-0000:00:07.2-2.1/input0"
>    Option "Device" "/dev/input/event-mx1000"
>    Option      "Buttons" "12"
>    Option        "ZAxisMapping" "11 12"
>    Option      "Resolution" "800"
> EndSection

With an Xmodmap rule:

> pointer =3D 1 2 3 8 9 10 11 12 6 7 4 5

This is to make sure that the scroll wheel shows up as 4/5 as expected,
and that the horizontal scroll shows up as 6/7, which most software
interprets as the left/right scroll buttons.

Xev says that the horizontal scrollers produce:

Scroll Left:

> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935139, (88,104), root:(89,150),
>     state 0x10, button 6, same_screen YES

> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935155, (88,104), root:(89,150),
>     state 0x10, button 5, same_screen YES

> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935155, (88,104), root:(89,150),
>     state 0x1010, button 5, same_screen YES

> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935267, (88,104), root:(89,150),
>     state 0x10, button 6, same_screen YES

And right:

> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935915, (88,104), root:(89,150),
>     state 0x10, button 7, same_screen YES

> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935931, (88,104), root:(89,150),
>     state 0x10, button 4, same_screen YES

> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935931, (88,104), root:(89,150),
>     state 0x810, button 4, same_screen YES

> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334936027, (88,104), root:(89,150),
>     state 0x10, button 7, same_screen YES=20


Various software versions below.

> atrus@agaeris:~$ xdpyinfo | grep 'X.Org version'
> X.Org version: 6.8.1.902
> atrus@agaeris:~$ uname -a
> Linux agaeris 2.6.11-rc3 #1 Thu Feb 10 23:17:14 MST 2005 i686
> GNU/Linux



--=20
Jeremy Nickurak -=3D Email/Jabber: atrus@rifetech.com =3D-
Remember, when you buy major label CD's, you're paying
companies to sue families and independant music. Learn
more now at downhillbattle.org.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCKVzFtjFmtbiy5uYRAp5mAJ4lefoQqJtJdeJENf1jWKECu19xcQCfZith
AvnyYlC7XUSm9K6PDAdk4DM=
=WvJk
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
