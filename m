Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUFORcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUFORcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUFORcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:32:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:42462 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265781AbUFORcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:32:11 -0400
Date: Tue, 15 Jun 2004 19:32:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Helge Hafting vs. make menuconfig help
Message-ID: <20040615173210.GM20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src> <20040615144127.GG20632@lug-owl.de> <20040615172129.F6843@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tlWXjsxnRAhnxm2X"
Content-Disposition: inline
In-Reply-To: <20040615172129.F6843@beton.cybernet.src>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tlWXjsxnRAhnxm2X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 17:21:29 +0000, Karel Kulhav=FD <clock@twibright.com>
wrote in message <20040615172129.F6843@beton.cybernet.src>:
> > >=20
> > > Is it correct what <Help> for CONFIG_INPUT in 2.4.25 says or no?
> >=20
> > At least, it's not really wrong. You need CONFIG_INPUT to be able to do
> > something with the HID stuff. However, to have an uniform interface, you
>=20
> Does HID means always USB?

No, but USB HID devices (mouse, keyboard, ...) always implies HID.

> However when disabling CONFIG_INPUT, the keyboard still works. Is a keybo=
ard
> considered a HID or nor?

In 2.4.x, the transition from "old-style" input drivers to new-style
(Input API) was never finished. Instead, Input API was introduced, and
HID devices reported their input to Input API, while old drivers still
used all their old ways to deliver their input.

This is why a keyboard still works without CONFIG_INPUT in 2.4.x, but it
won't any longer work in 2.6.x, because the old path for submitting
input was thrown away.

> > may also use the CONFIG_INPUT stuff to access your "normal" (AT / PS/2
> > style) keyboard.
> >=20
> > In 2.6.x, that's cleaned up a bit. (Nearly?) all keyboards now push
> > their key strokes into the CONFIG_INPUT API, so you really want to have
> > CONFIG_INPUT (as long as this isn't some kind of embedded system).
>=20
> Isn't there some graphical chart (preferrably made in sodipodi ;-) ) that
> describes how data are flowing inside the kernel? I have problems visuali=
zing
> this.

2.4.x:
	- USB keyboards/mice/... are "HID" devices, using the USB HID
	  protocol, delivering their data to the Input APU
	  (CONFIG_INPUT).
	- Legacy drivers (PS/2 keyboard and the like) had their own data
	  path and directly put their input into the virtual console
	  subsystem.

2.6.x:
	- USB keyboards/mice/... are "HID" devices, using the USB HID
	  protocol, delivering their data to the Input APU
	  (CONFIG_INPUT).
	- All legacy drivers are converted to also use the new Input API
	  subsystem; direct delivery of input was removed from the code
	  base.

So in 2.4.x, you've got two APIs for drivers to dispatch their input
(new drivers using the USB HID protocol already stuff their data into
Input API, old drivers still each use a direct way). In 2.6.x, the
direct ways were thrown away, and only the Input API is remaining.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--tlWXjsxnRAhnxm2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzzKaHb1edYOZ4bsRAoQmAJ9n7x+CkJl/8y9EW5U18gLD2Y8GvQCeLfFW
hDJL976mjJ0ehWezC8J/hO8=
=+ivc
-----END PGP SIGNATURE-----

--tlWXjsxnRAhnxm2X--
