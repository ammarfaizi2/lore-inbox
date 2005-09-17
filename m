Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVIQOuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVIQOuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 10:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVIQOuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 10:50:05 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:56734 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1750959AbVIQOuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 10:50:04 -0400
Date: Sat, 17 Sep 2005 16:49:54 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Move flags for preprocessing linker scripts to rule
Message-ID: <20050917144954.GA9800@wavehammer.waldi.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move CPPFLAGS_vmlinux.lds settings into the .lds.S -> .lds rule. Any of
the remaining CPPFLAGS definitions for .lds.S preprocessing sets this
options.

Add -undef to avoid definition of any system-specific macros. This makes
the explicit undefines unnecessary.

Signed-off-by: Bastian Blank <waldi@debian.org>

---

 Makefile               |    5 -----
 scripts/Makefile.build |    2 +-
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -827,11 +827,6 @@ prepare0: archprepare FORCE
 # All the preparing..
 prepare prepare-all: prepare0
=20
-#	Leave this as default for preprocessing vmlinux.lds.S, which is now
-#	done in arch/$(ARCH)/kernel/Makefile
-
-export CPPFLAGS_vmlinux.lds +=3D -P -C -U$(ARCH)
-
 # Single targets
 # ------------------------------------------------------------------------=
---
=20
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -234,7 +234,7 @@ targets +=3D $(extra-y) $(MAKECMDGOALS) $(
 # Linker scripts preprocessor (.lds.S -> .lds)
 # ------------------------------------------------------------------------=
---
 quiet_cmd_cpp_lds_S =3D LDS     $@
-      cmd_cpp_lds_S =3D $(CPP) $(cpp_flags) -D__ASSEMBLY__ -o $@ $<
+      cmd_cpp_lds_S =3D $(CPP) -P -C -undef $(cpp_flags) -D__ASSEMBLY__ -o=
 $@ $<
=20
 %.lds: %.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)

--=20
You!  What PLANET is this!
		-- McCoy, "The City on the Edge of Forever", stardate 3134.0

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iEYEARECAAYFAkMsLRIACgkQnw66O/MvCNGtTACfeh+5EK5MX5wJpMSeSZ2XcQkt
H4MAoIYGk9Jqm4EaFKbLA1uddf6Phiro
=A2aT
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
