Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVBRJYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVBRJYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 04:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVBRJYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 04:24:05 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:26002 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261305AbVBRJX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 04:23:58 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Fri, 18 Feb 2005 10:23:41 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] obey HOSTLOADLIBES_programname for single-file compilation
Message-ID: <20050218092341.GA12271@kiste>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Single-file HOSTCC calls added the libraries from $(HOSTLOADLIBES),
but not from $(HOSTLOADLIBES_programname). Multi-file HOSTCC calls do
both.

This patch fixes that inconsistency.

Signed-Off-By: Matthias Urlichs <smurf@debian.org>

diff -Nru a/scripts/Makefile.host b/scripts/Makefile.host
--- a/scripts/Makefile.host	2005-02-18 10:19:29 +01:00
+++ b/scripts/Makefile.host	2005-02-18 10:19:29 +01:00
@@ -98,7 +98,8 @@
 # Create executable from a single .c file
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	=3D HOSTCC  $@
-      cmd_host-csingle	=3D $(HOSTCC) $(hostc_flags) $(HOST_LOADLIBES) -o $=
@ $<
+      cmd_host-csingle	=3D $(HOSTCC) $(hostc_flags) -o $@ $< \
+	  	$(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-csingle): %: %.c FORCE
 	$(call if_changed_dep,host-csingle)
=20
--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCFbQd8+hUANcKr/kRAnKyAJ9udiPuiRTs6LqoWTZ9c+U3HvmDAACgjD5+
5e15qwaf7ASAbOMum4TRzKc=
=6bZI
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
