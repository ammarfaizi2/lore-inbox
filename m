Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUDPLsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 07:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUDPLsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 07:48:13 -0400
Received: from mail.donpac.ru ([80.254.111.2]:49823 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262322AbUDPLsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 07:48:08 -0400
Date: Fri, 16 Apr 2004 15:47:50 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-visws-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix visws in 2.6.5
Message-ID: <20040416114750.GE9410@pazke>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-visws-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nYySOmuH/HDX6pKp
Content-Type: multipart/mixed; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

this small patch fixes visws build error in 2.6.5.
Please apply.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-visws-2.6.5"
Content-Transfer-Encoding: quoted-printable

diff -urpN -X /usr/share/dontdiff linux-2.6.3.vanilla/arch/i386/mach-visws/=
mpparse.c linux-2.6.3/arch/i386/mach-visws/mpparse.c
--- linux-2.6.3.vanilla/arch/i386/mach-visws/mpparse.c	2004-01-14 23:09:49.=
000000000 +0300
+++ linux-2.6.3/arch/i386/mach-visws/mpparse.c	2004-04-15 19:44:47.00000000=
0 +0400
@@ -28,6 +28,7 @@ unsigned int boot_cpu_logical_apicid =3D -
 /* Bitmask of physically existing CPUs */
 physid_mask_t phys_cpu_present_map;
=20
+unsigned int __initdata maxcpus =3D NR_CPUS;
=20
 /*
  * The Visual Workstation is Intel MP compliant in the hardware
@@ -89,6 +90,9 @@ void __init find_smp_config(void)
 		ncpus =3D CO_CPU_MAX;
 	}
=20
+	if (ncpus > maxcpus)
+		ncpus =3D maxcpus;
+
 	smp_found_config =3D 1;
 	while (ncpus--)
 		MP_processor_info(mp++);

--kA1LkgxZ0NN7Mz3A--

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAf8fmby9O0+A2ZecRAj6lAJ9Fq5arLUafrJjYqe9cfwOVrJPKFgCg4trf
JvEvDDmrgJ7NIShjrVAlEKw=
=zZtT
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
