Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWIKTNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWIKTNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWIKTNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:13:08 -0400
Received: from [84.77.237.53] ([84.77.237.53]:38025 "EHLO
	dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S964945AbWIKTNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:13:05 -0400
Date: Mon, 11 Sep 2006 21:13:04 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sensors on Asus M2N SLI Deluxe
Message-ID: <20060911191303.GA27441@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200609110927.k8B9RJfH019016@mersenne.math.TU-Berlin.DE> <200609111234.25413.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <200609111234.25413.prakash@punnoor.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday, 11 September 2006, at 12:34:25 +0200,
Prakash Punnoor wrote:

> Take a look into lm_sensors ml. Some patches have been posted, which work=
 well=20
> for me with 2.6.18rc. (I have a slightly different mobo, but I guess the =
same=20
> it87 derivative is used on yours.) The will probably go into 2.6.19, IIRC.
>=20
If the sensor chip is an IT8716F one, the attached patch will do the
trikc ( patch based on kernel 2.6.18-rc4). It seems that IT8716F are
mostly like the well-known IT8712F. See:
http://www.lm-sensors.org/changeset/4083

Just for the record, gkrellm sees the sensors just fine, but (for
example) ksensors or even lm-sensors 2.10.0 don't. mbmon works fine
though. Multipliers and offsets are probably mobo-dependent (GIGABYTE
GA-M55Plus-S3G Socket AM2 here).

Hope it helps.

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.17.9-slh-up-1)


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="it8716_sensor.diff"
Content-Transfer-Encoding: quoted-printable

--- 2.6.18-rc47it87.c	2006-06-18 03:49:35.000000000 +0200
+++ 2.6.18-rc4-modified/it87.c	2006-08-20 18:17:43.000000000 +0200
@@ -50,7 +50,7 @@
 static unsigned short isa_address;
=20
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_2(it87, it8712);
+I2C_CLIENT_INSMOD_3(it87, it8712, it8716);
=20
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -100,6 +100,7 @@
 }
=20
 #define IT8712F_DEVID 0x8712
+#define IT8716F_DEVID 0x8716
 #define IT8705F_DEVID 0x8705
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
@@ -720,6 +721,7 @@
 	superio_enter();
 	chip_type =3D superio_inw(DEVID);
 	if (chip_type !=3D IT8712F_DEVID
+	 && chip_type !=3D IT8716F_DEVID
 	 && chip_type !=3D IT8705F_DEVID)
 	 	goto exit;
=20
@@ -801,6 +803,8 @@
 			kind =3D it87;
 			if ((is_isa) && (chip_type =3D=3D IT8712F_DEVID))
 				kind =3D it8712;
+			else if ((is_isa) && (chip_type =3D=3D IT8716F_DEVID))
+				kind =3D it8716;
 		}
 		else {
 			if (kind =3D=3D 0)
@@ -817,6 +821,8 @@
 		name =3D "it87";
 	} else if (kind =3D=3D it8712) {
 		name =3D "it8712";
+	} else if (kind =3D=3D it8716) {
+		name =3D "it8716";
 	}
=20
 	/* Fill in the remaining client fields and put it into the global list */
@@ -1193,7 +1199,7 @@
=20
=20
 MODULE_AUTHOR("Chris Gauthron <chrisg@0-in.com>");
-MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
+MODULE_DESCRIPTION("IT8705F, IT8712F, IT8716F, Sis950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup valu=
e");
 module_param(fix_pwm_polarity, bool, 0);

--sdtB3X0nJg68CQEu--

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBbU/ao1/w/yPYI0RAqQHAJ40idwhItxs71lyjoX8DxJJzwcYCQCfWOzF
0SVrD+LRn7Si29juKM6ViFY=
=90ar
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
