Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVFIE1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVFIE1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 00:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVFIE1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 00:27:18 -0400
Received: from relay.rost.ru ([80.254.111.11]:37612 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262258AbVFIE1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 00:27:10 -0400
Date: Thu, 9 Jun 2005 08:27:05 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <20050609042705.GA19180@pazke>
Mail-Followup-To: Andy Whitcroft <apw@shadowen.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <42A6FF41.5040109@shadowen.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <42A6FF41.5040109@shadowen.org>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 159, 06 08, 2005 at 03:22:57 +0100, Andy Whitcroft wrote:
> We've been seeing an early boot hang on IBM x-series (at least on an
> x440) with -rc6-mm1.  Finally got hold of a box to go search for this
> and it seems that backing out the three patches below fixes it.
>=20
>  515  dmi-move-acpi-boot-quirk.patch
>  516  dmi-move-acpi-sleep-quirk.patch
>  517  dmi-remove-central-blacklist.patch
>=20
> I am pretty sure it is actually the first one (thats where my bisection
> search pointed) but I had to drop the other two to back it out.  Anyhow,
> 2.6.12-rc6-mm1 boots on an x440 with these backed out.

Yeah, probably brown paper bag time... Please try the attached patch.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-stupid-dmi-bug
Content-Transfer-Encoding: quoted-printable

diff -urdpNX /usr/share/dontdiff linux-2.6.12-rc6-mm1.vanilla/arch/i386/ker=
nel/acpi/boot.c linux-2.6.12-rc6-mm1/arch/i386/kernel/acpi/boot.c
--- linux-2.6.12-rc6-mm1.vanilla/arch/i386/kernel/acpi/boot.c	2005-06-09 08=
:02:06.000000000 +0400
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/acpi/boot.c	2005-06-09 08:24:01.0=
00000000 +0400
@@ -1040,6 +1040,7 @@ static struct dmi_system_id __initdata a
 		},
 	},
 #endif
+	{ }
 };
=20
 #endif	/* __i386__ */
diff -urdpNX /usr/share/dontdiff linux-2.6.12-rc6-mm1.vanilla/arch/i386/ker=
nel/acpi/sleep.c linux-2.6.12-rc6-mm1/arch/i386/kernel/acpi/sleep.c
--- linux-2.6.12-rc6-mm1.vanilla/arch/i386/kernel/acpi/sleep.c	2005-06-09 0=
8:02:06.000000000 +0400
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/acpi/sleep.c	2005-06-09 08:24:15.=
000000000 +0400
@@ -108,6 +108,7 @@ static __initdata struct dmi_system_id a
 			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 		},
 	},
+	{ }
 };
=20
 static int __init acpisleep_dmi_init(void)

--NzB8fVQJ5HfG6fxh--

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCp8UZR2OTnxNuAyMRAmJ5AJ40d3rGwGAisC/tbV0EurR1/UIMcACeMPri
X6T3c5+uYr8QZihq6tyJltc=
=Rll1
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
