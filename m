Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVF3WVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVF3WVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVF3WVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:21:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:48112 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263055AbVF3WUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:20:19 -0400
Message-ID: <42C470D9.6050905@punnoor.de>
Date: Fri, 01 Jul 2005 00:23:21 +0200
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Sebastian Pigulak <dreamin@interia.pl>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH]Re: atxp1 module not compiling; needs I2C_SENSOR
References: <20050630234709.1ad1512a@DreaM.darnet>
In-Reply-To: <20050630234709.1ad1512a@DreaM.darnet>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A8DB01977D80ADF8C6AF54D"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A8DB01977D80ADF8C6AF54D
Content-Type: multipart/mixed;
 boundary="------------070907070507030709080606"

This is a multi-part message in MIME format.
--------------070907070507030709080606
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Sebastian Pigulak schrieb:
> Hey,
>=20
> I've tried patching linux-2.6.13-RC1 with patch-2.6.13-rc1-git2 and bui=
lding atxp1(it allows Vcore voltage changing) into the kernel. Unfortunat=
ely, the kernel compilation stops with:
>=20
> LD      init/built-in.o
> LD      vmlinux
> drivers/built-in.o(.text+0x92298): In function `atxp1_detect':
> : undefined reference to `i2c_which_vrm'
> drivers/built-in.o(.text+0x921ae): In function `atxp1_attach_adapter':
> : undefined reference to `i2c_detect'
> make: *** [vmlinux] B=B3=B1d 1
> =3D=3D> ERROR: Build Failed.  Aborting...=20
>=20
> Could someone have a look at the module and possibly fix it up?

Try attached patch.  (Works fine for me then.)

Cheers,

Prakash

Signed-off-by: Prakash Punnoor <prakash@punnoor.de>

--- drivers/i2c/chips/Kconfig~	2005-06-29 11:06:01.000000000 +0200
+++ drivers/i2c/chips/Kconfig	2005-07-01 00:17:34.972426160 +0200
@@ -80,6 +80,7 @@
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Attansic ATXP1 VID
 	  controller.

--------------070907070507030709080606
Content-Type: text/plain;
 name="atxp1_needs_i2c_sensor.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atxp1_needs_i2c_sensor.diff"

--- drivers/i2c/chips/Kconfig~	2005-06-29 11:06:01.000000000 +0200
+++ drivers/i2c/chips/Kconfig	2005-07-01 00:17:34.972426160 +0200
@@ -80,6 +80,7 @@
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Attansic ATXP1 VID
 	  controller.

--------------070907070507030709080606--

--------------enig4A8DB01977D80ADF8C6AF54D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxHDZxU2n/+9+t5gRAmg3AJ95uYhaH0mnP0e61KYZDKqnvXShdQCg69oX
BE2fXXiuuW0dUa0Em+f364c=
=g8DP
-----END PGP SIGNATURE-----

--------------enig4A8DB01977D80ADF8C6AF54D--
