Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTJQRop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTJQRop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:44:45 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:34073 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S263571AbTJQRol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:44:41 -0400
Subject: remove unnecessary BIOS reserved resources
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederman@lnxi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p9GkyyrpvzN8JvUdKn26"
Organization: Linux Networx
Message-Id: <1066412413.6281.12.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Oct 2003 11:40:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p9GkyyrpvzN8JvUdKn26
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

e820 BIOS reserved memory ranges can be incorrect.  Even when the ranges
are correct, once they are entered into iomem_resource with
request_resorce() the ranges prevent drivers from registering the same
ranges.

Not registering the ranges shouldn't break anything - some BIOSes don't
even report _any_ reserved ranges and the kernel works just fine.  This
patch drops registration of e820 BIOS reserved ranges.  The patch should
apply to 2.4.x and 2.6.

--- linux-2.4.20/arch/i386/kernel/setup.c	2002-11-28 16:53:09.000000000
-0700
+++ linux-2.4.20-bs/arch/i386/kernel/setup.c	2003-10-17
12:01:12.000000000 -0600
@@ -1047,7 +1047,6 @@
 		case E820_RAM:	res->name =3D "System RAM"; break;
 		case E820_ACPI:	res->name =3D "ACPI Tables"; break;
 		case E820_NVS:	res->name =3D "ACPI Non-volatile Storage"; break;
-		default:	res->name =3D "reserved";
 		}
 		res->start =3D e820.map[i].addr;
 		res->end =3D res->start + e820.map[i].size - 1;

Anyone have reasons why this shouldn't be applied?

--=20
Thayne Harbaugh
Linux Networx

--=-p9GkyyrpvzN8JvUdKn26
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/kCl9fsBPTKE6HMkRAsLIAJkBBtRjX0wBWqYbPwnSxJgdJPxcVwCfcZNT
eygV7cM6F5yINNKK1CesxKs=
=lyYI
-----END PGP SIGNATURE-----

--=-p9GkyyrpvzN8JvUdKn26--

