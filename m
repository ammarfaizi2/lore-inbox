Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTDHWDg (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTDHWDg (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:03:36 -0400
Received: from cpt-dial-196-30-178-16.mweb.co.za ([196.30.178.16]:47746 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S261884AbTDHWDe (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:03:34 -0400
Subject: Re: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in
	sysfs
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com
In-Reply-To: <20030407215443.GA4386@kroah.com>
References: <1049750163.4174.35.camel@nosferatu.lan>
	 <20030407215443.GA4386@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-21E8i2DWwA5Y08p3H8yC"
Organization: 
Message-Id: <1049839904.25930.46.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 09 Apr 2003 00:11:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-21E8i2DWwA5Y08p3H8yC
Content-Type: multipart/mixed; boundary="=-Vfa8XaQ7stqLJfkTHuGR"


--=-Vfa8XaQ7stqLJfkTHuGR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-04-07 at 23:54, Greg KH wrote:

> Hm, this patch looks backwards, is it?
>=20
> Also, just as a side note, can you make your patches so that they can be
> applied with "patch -p1" instead of "patch -p0" which your current ones
> are?  My tools treat -p1 patches much better :)
>=20

Ok, here is the proper one.  To recap:

I did the w83781d sysfs update as per the old spec, which was not
milli-volt.  This patch should fix it.


Regards,

--=20

Martin Schlemmer




--=-Vfa8XaQ7stqLJfkTHuGR
Content-Disposition: attachment; filename=w83781d-in_milli-volt.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=w83781d-in_milli-volt.patch; charset=ISO-8859-1

--- 1/drivers/i2c/chips/w83781d.c	2003-04-07 22:53:37.000000000 +0200
+++ 2/drivers/i2c/chips/w83781d.c	2003-04-07 22:53:34.000000000 +0200
@@ -364,7 +364,7 @@
 	 \
 	w83781d_update_client(client); \
 	 \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
 }
 show_in_reg(in);
 show_in_reg(in_min);
@@ -378,7 +378,7 @@
 	u32 val; \
 	 \
 	val =3D simple_strtoul(buf, NULL, 10); \
-	data->in_##reg[nr] =3D IN_TO_REG(val); \
+	data->in_##reg[nr] =3D (IN_TO_REG(val) / 10); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr])=
; \
 	 \
 	return count; \

--=-Vfa8XaQ7stqLJfkTHuGR--

--=-21E8i2DWwA5Y08p3H8yC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+k0kdqburzKaJYLYRAlCSAKCMQShe8xMN3egsAbwvMxGQFO3i0ACeN7WV
V3FX0RNZiLUGobyRR9P8Cm8=
=XFvY
-----END PGP SIGNATURE-----

--=-21E8i2DWwA5Y08p3H8yC--

