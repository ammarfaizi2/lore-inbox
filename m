Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVBTPEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVBTPEi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 10:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBTPEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 10:04:37 -0500
Received: from lotus.ma.gda.pl ([80.55.61.28]:58774 "EHLO lotus.ma.gda.pl")
	by vger.kernel.org with ESMTP id S261848AbVBTPDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 10:03:04 -0500
Date: Sun, 20 Feb 2005 16:06:04 +0100
From: "Adam 'dredzik' Kuczynski" <dredzik@ekg2.org>
To: linux-kernel@vger.kernel.org
Cc: dredzik@ekg2.org
Subject: GL520SM Sensor Chip driver fix
Message-ID: <20050220150604.GA658@lotus.ma.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
X-Now-Playing: [] XMMS is not running (0:00/0:00)
X-PGP-Fingerprint: 83D8 E7FD 3900 E56E EAED  B63D F08B 13EA BD96 940D
X-PGP-Id: BD96940D
X-PGP-Public-Key-At: pgp.mit.edu
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
	I've been recently trying to get my lmsensors working under
2.6.9, and i've found this:

http://seclists.org/lists/linux-kernel/2005/Feb/2856.html
http://lkml.org/lkml/2005/2/11/90

kernel patch for gl520 chip, but after applying it kernel refused to
compile. So I've fixed it using gl518sm module source code and I want to
share the results of my work with you. I hope that it will be useful.

I've tested this on my machine and it works fine.

Bye

PS: I hope i'm writting to good list.

--=20
      .$           .,_       .$   [ Adam 'dredzik' Kuczynski ]
 gP""Y:$ g. ,gP ,P" _,P gP""Y:$   [ http://dredzik.ekg2.org/ ]
 Y.  ,Y: `$,P   Y$      Y.  ,Y:   [ mailto: dredzik@ekg2.org ]
  `""  `b.`Y'    `"--    `""  `b. [ JID:  dredzik@jabber.org ]

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="gl520sm-sensor-fixed.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.9/drivers/i2c/chips/gl520sm.c.orig	2005-02-20 15:20:38.000000=
000 +0100
+++ linux-2.6.9/drivers/i2c/chips/gl520sm.c	2005-02-20 15:41:25.000000000 +=
0100
@@ -37,6 +37,9 @@
 static unsigned short normal_i2c[] =3D { 0x2c, 0x2d, I2C_CLIENT_END };
 static unsigned int normal_isa[] =3D { I2C_CLIENT_ISA_END };
=20
+static unsigned short normal_i2c_range[] =3D { I2C_CLIENT_END };
+static unsigned int normal_isa_range[] =3D { I2C_CLIENT_ISA_END };
+
 /* Insmod parameters */
 SENSORS_INSMOD_1(gl520sm);
=20
@@ -500,13 +503,25 @@
=20
 static int gl520_attach_adapter(struct i2c_adapter *adapter)
 {
- if (!(adapter->clRD_DATA))
- goto exit;
+ if (!(adapter->class & I2C_CLASS_HWMON))
+ return 0;
+ return i2c_detect(adapter, &addr_data, gl520_detect);
+}
=20
+static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+ struct i2c_client *new_client;
+ struct gl520_data *data;
+ int err =3D 0;
+=20
+ if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+ I2C_FUNC_SMBUS_WORD_DATA))
+ goto exit;
+							    =20
  /* OK. For now, we presume we have a valid client. We now create the
  client structure, even though we cannot fill it completely yet.
  But it allows us to access gl520_{read,write}_value. */
-
+=20
  if (!(data =3D kmalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
  err =3D -ENOMEM;
  goto exit;

--YiEDa0DAkWCtVeE4--

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCGKdb8IsT6r2WlA0RAgJnAJ9G74e0wVklWgskPWqKIsPynBOVvACggePs
2jPiQNnTHKxcKsTEKQ8TTEc=
=lyDE
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
