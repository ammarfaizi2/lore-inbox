Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbTDGVHz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTDGVHy (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:07:54 -0400
Received: from cpt-dial-196-30-179-42.mweb.co.za ([196.30.179.42]:43648 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263664AbTDGVHx (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:07:53 -0400
Subject: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in sysfs
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eQaywIlurV3tThY64XPo"
Organization: 
Message-Id: <1049750163.4174.35.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 07 Apr 2003 23:16:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eQaywIlurV3tThY64XPo
Content-Type: multipart/mixed; boundary="=-amCC7BocVSBTjgquXDUA"


--=-amCC7BocVSBTjgquXDUA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I did the w83781d sysfs update as per the old spec, which was not
milli-volt.  This patch should fix it.


Regards,

--=20

Martin Schlemmer



--=-amCC7BocVSBTjgquXDUA
Content-Disposition: attachment; filename=w83781d-in_milli-volt.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=w83781d-in_milli-volt.patch; charset=ISO-8859-1

--- drivers/i2c/chips/w83781d.c.orig	2003-04-07 22:53:37.000000000 +0200
+++ drivers/i2c/chips/w83781d.c	2003-04-07 22:53:34.000000000 +0200
@@ -364,7 +364,7 @@
 	 \
 	w83781d_update_client(client); \
 	 \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
+	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
 }
 show_in_reg(in);
 show_in_reg(in_min);
@@ -378,7 +378,7 @@
 	u32 val; \
 	 \
 	val =3D simple_strtoul(buf, NULL, 10); \
-	data->in_##reg[nr] =3D (IN_TO_REG(val) / 10); \
+	data->in_##reg[nr] =3D IN_TO_REG(val); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr])=
; \
 	 \
 	return count; \

--=-amCC7BocVSBTjgquXDUA--

--=-eQaywIlurV3tThY64XPo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+keqTqburzKaJYLYRAi0SAJ4t9KkzDgJJUmAWXwhZGbYwAKJ7nACeLVt2
wK7rWrSset8qmmICyj4vwcc=
=20ff
-----END PGP SIGNATURE-----

--=-eQaywIlurV3tThY64XPo--

