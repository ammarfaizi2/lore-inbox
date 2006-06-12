Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWFLQ43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWFLQ43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFLQ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:56:28 -0400
Received: from threatwall.zlynx.org ([199.45.143.218]:46295 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1750918AbWFLQ42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:56:28 -0400
Subject: Re: 2.6.16-rc6-mm2
From: Zan Lynx <zlynx@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060609214024.2f7dd72c.akpm@osdl.org>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-w1rGSsf40BlKGa1ML6u+"
Date: Mon, 12 Jun 2006 10:56:23 -0600
Message-Id: <1150131383.26875.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w1rGSsf40BlKGa1ML6u+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-09 at 21:40 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/=
2.6.17-rc6-mm2/


I don't think I saw this bug caught by anyone yet.  I was getting
segmentation faults in modpost while building out of tree modules.  I'm
pretty sure the code should look like the following patch.  Otherwise,
it makes modname look like "vmlinux\tEXPORT_SYMBOL" which then fails
badly later on.

--- linux/scripts/mod/modpost.c.orig    2006-06-12 10:21:10.000000000 -0600
+++ linux/scripts/mod/modpost.c 2006-06-12 10:16:01.000000000 -0600
@@ -1290,8 +1290,10 @@ static void read_dump(const char *fname,
                        goto fail;
                *modname++ =3D '\0';
                if (!(export =3D strchr(modname, '\t')))
-                       *export++ =3D '\0';
-
+                       goto fail;
+               *export++ =3D '\0';
+               if (strchr(export, '\t'))
+                       goto fail;
                crc =3D strtoul(line, &d, 16);
                if (*symname =3D=3D '\0' || *modname =3D=3D '\0' || *d !=3D=
 '\0')
                        goto fail;

--=20
Zan Lynx <zlynx@acm.org>

--=-w1rGSsf40BlKGa1ML6u+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD4DBQBEjZy3G8fHaOLTWwgRAsKLAJ0fWGDFsX7Oe8aW1J5IkV5WiHyCMQCYzayz
8RW039UyM7ZZTNdPcbWGqw==
=fvO4
-----END PGP SIGNATURE-----

--=-w1rGSsf40BlKGa1ML6u+--

