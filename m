Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFTRke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFTRke (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVFTRkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:40:33 -0400
Received: from mx.laposte.net ([80.245.62.11]:35875 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261241AbVFTRkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:40:04 -0400
Subject: Tuner module is too verbose
From: "Damien \"tuX\" THEBAULT" <damien.thebault@laposte.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4DsTxmC0epLamkX0om1C"
Date: Mon, 20 Jun 2005 19:39:52 +0200
Message-Id: <1119289192.22634.24.camel@tux.rezid.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4DsTxmC0epLamkX0om1C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I upgraded from my previous kernel (2.6.10-mm1) to 2.6.12-mm1 today.

I have a problem with the "tuner" module : it is printing too many
messages into the syslog :

"tuner 2-0060: Cmd VIDIOCSCHAN accepted to TV"
or
"tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio"

(about 26 messages per second, but only when watching TV)

I looked into the module's source code and I was able to disable those
messages with a little modification (patch included).
(maybe the same modification is needed when CONFIG_TUNER_MULTI_I2C is
defined)

I don't know if this is the good way to do this, but I didn't find any
other way to solve my problem...

PS : I'm not subscribed to the list so please CC me.

--- ./drivers/media/video/tuner-core.old.c	2005-06-20 18:53:12.864742688
+0200
+++ ./drivers/media/video/tuner-core.c	2005-06-20 19:24:42.382492328
+0200
@@ -201,7 +201,7 @@
=20
 #ifdef CONFIG_TUNER_MULTI_I2C
 #define CHECK_ADDR(tp,cmd,tun)	if (client->addr!=3Dtp) { \
-			  return 0; } else \
+			  return 0; } else if (tuner_debug!=3D0) \
 			  tuner_info ("Cmd %s accepted to "tun"\n",cmd);
 #define CHECK_MODE(cmd)	if (t->mode =3D=3D V4L2_TUNER_RADIO) { \
 		 	CHECK_ADDR(radio_tuner,cmd,"radio") } else \

--=20
Damien Thebault
public keys on http://pgp.mit.edu

--=-4DsTxmC0epLamkX0om1C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCtv9oVHEaRMFauK8RAnhCAJ9ipDuwZgHfiQ+tk8Ef9MKQvLlf8QCfXzTv
Xv4XNe/lieIMUJtOAcgGFbE=
=5DY1
-----END PGP SIGNATURE-----

--=-4DsTxmC0epLamkX0om1C--

