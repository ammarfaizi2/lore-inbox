Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWDAWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWDAWsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWDAWsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 17:48:52 -0500
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:10770 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S1751622AbWDAWsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 17:48:52 -0500
Date: Sat, 1 Apr 2006 23:48:50 +0100
From: John Mylchreest <johnm@gentoo.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060401224849.GH16917@getafix.willow.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+RZeZVNR8VILNfK
Content-Type: multipart/mixed; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guys,

I think the subject and patch says it all. Please see the attached minor
fix which allows ppc32 (2.6.16) to build with a non-vanilla gcc.

This could also be fixed in BOOTCFLAGS but I felt this being the more
appropriate.

Regards,
John

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=utf8
Content-Disposition: attachment; filename="ppc32-2.6.16-fix.patch"
Content-Transfer-Encoding: quoted-printable

Since ppc32 has been made to use arch/powerpc it has introduced a build-time
regression where userland CFLAGS are being leaked. This is especially obvio=
us
when a user tries to "make zImage" with an SSP enabled gcc.

This patch restores sanity.

Signed-off-by: John Mylchreest <johnm@gentoo.org>


--- linux-2.6/arch/powerpc/boot/Makefile.orig	2006-04-01 23:36:39.000000000=
 +0100
+++ linux-2.6/arch/powerpc/boot/Makefile	2006-04-01 23:36:55.000000000 +0100
@@ -65,7 +65,7 @@ clean-files :=3D $(zlib) $(zlibheader) $(z
=20
=20
 quiet_cmd_bootcc =3D BOOTCC  $@
-      cmd_bootcc =3D $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $=
@ $<
+      cmd_bootcc =3D $(CROSS32CC) -D__KERNEL__ -Wp,-MD,$(depfile) $(BOOTCF=
LAGS) -c -o $@ $<
=20
 quiet_cmd_bootas =3D BOOTAS  $@
       cmd_bootas =3D $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $=
@ $<

--BEa57a89OpeoUzGD--

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFELwNRNzVYcyGvtWURAlEBAKCvTkIuAFPJTV3UxtH3onVXg0OH7QCgkIzt
VbBNsCcTSpvGXnvKMNHnfO8=
=h0UI
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
