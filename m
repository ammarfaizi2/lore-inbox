Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTJVUBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbTJVUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 16:01:54 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:776 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S263491AbTJVUBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 16:01:52 -0400
Subject: Re: [BUG][PATCH] BIOS reserved regions block iomem registration
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au, Eric Biederman <ebiederman@lnxi.com>
In-Reply-To: <1066849062.6281.190.camel@tubarao>
References: <1066849062.6281.190.camel@tubarao>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-X3nUdOrr+7/2ppvpHe+u"
Organization: Linux Networx
Message-Id: <1066852614.6281.193.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Oct 2003 13:56:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X3nUdOrr+7/2ppvpHe+u
Content-Type: multipart/mixed; boundary="=-H9p/z8X+z99E6OaUyNuc"


--=-H9p/z8X+z99E6OaUyNuc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> 1) Don't mark the BIOS reserved regions.  Some BIOSes don't mark these
> and the kernel works fine.  This is a trivial patch of removing the
> "reserved" line in setup.c:register_memory().  See
> remove_reserved.patch.

Er, the previous remove_reserved.patch wouldn't work.  This should be
more correct.

--=20
Thayne Harbaugh
Linux Networx

--=-H9p/z8X+z99E6OaUyNuc
Content-Disposition: attachment; filename=remove_reserved-2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=remove_reserved-2.patch; charset=UTF-8

--- linux-2.4.20/arch/i386/kernel/setup.c	2002-11-28 16:53:09.000000000 -07=
00
+++ linux-2.4.20-bs/arch/i386/kernel/setup.c	2003-10-22 14:25:48.000000000 =
-0600
@@ -1042,12 +1042,14 @@
 		struct resource *res;
 		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
 			continue;
+		if (e820.map[i].type =3D=3D E820_RESERVED)
+			continue;
 		res =3D alloc_bootmem_low(sizeof(struct resource));
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name =3D "System RAM"; break;
 		case E820_ACPI:	res->name =3D "ACPI Tables"; break;
 		case E820_NVS:	res->name =3D "ACPI Non-volatile Storage"; break;
-		default:	res->name =3D "reserved";
+		default:	res->name =3D "unknown";
 		}
 		res->start =3D e820.map[i].addr;
 		res->end =3D res->start + e820.map[i].size - 1;

--=-H9p/z8X+z99E6OaUyNuc--

--=-X3nUdOrr+7/2ppvpHe+u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/luEGfsBPTKE6HMkRAl4AAJ4uZ13L0wLG1AuVlGI5cqKNuKvbkwCcCdRy
ZUiiSZM9XHRaysWJv4aq/Dk=
=kL88
-----END PGP SIGNATURE-----

--=-X3nUdOrr+7/2ppvpHe+u--

