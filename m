Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTJNTSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTJNTSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:18:42 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:1409 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263538AbTJNTSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:18:36 -0400
Subject: Re: mouse driver bug in 2.6.0-test7?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <3F8C3A99.6020106@opensound.com>
References: <3F8C3A99.6020106@opensound.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-su2tuR/aZSiVLVc4O9a4"
Message-Id: <1066159113.12171.4.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 21:18:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-su2tuR/aZSiVLVc4O9a4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-14 at 20:04, 4Front Technologies wrote:
> Why is the PS2 mouse tracking about 2x faster in 2.6.0-test7 compared
> to 2.4.xx?. Has anybody else seen this problem?.
>=20
> If I move the mouse 1 inch horizontally left-to-right on the mouse
> pad, the cursor on the screen moves almost twice the distance on the
> screen compared to Linux 2.4.xx

It's probably mostly because Vojtech changed the samplerate from 200 to
60. Here's a patch to change it back. I've sent it to Vojtech but he's
completely ignored it so far. This patch also readds the fallback logic
that was used before his change, although it uses the new
samplerate-table.

Without this patch my mouse is awful to use.
Vojtech, please consider this patch, at least say yay or nay.

--- linux-2.6.0-test6-mm4/drivers/input/mouse/psmouse-base.c.orig	2003-10-0=
5 17:02:23.000000000 +0200
+++ linux-2.6.0-test6-mm4/drivers/input/mouse/psmouse-base.c	2003-10-05 17:=
06:55.000000000 +0200
@@ -40,7 +40,7 @@
=20
 static int psmouse_noext;
 int psmouse_resolution;
-unsigned int psmouse_rate =3D 60;
+unsigned int psmouse_rate =3D 200;
 int psmouse_smartscroll =3D PSMOUSE_LOGITECH_SMARTSCROLL;
 unsigned int psmouse_resetafter;
=20
@@ -450,6 +450,11 @@
 	int i =3D 0;
=20
 	while (rates[i] > psmouse_rate) i++;
+
+	/* set lower rate in case requested rate fails */
+	if (rates[i])
+		psmouse_command(psmouse, rates + i + 1, PSMOUSE_CMD_SETRATE);
+
 	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
 }
=20

--=20
/Martin

--=-su2tuR/aZSiVLVc4O9a4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/jEwJWm2vlfa207ERAmCEAJ9Ps7pzxy4nRD6g17y4T3YLdorFEgCggfKf
aDS+8zx7o0YZy0JG2JzmJSo=
=zvCG
-----END PGP SIGNATURE-----

--=-su2tuR/aZSiVLVc4O9a4--
