Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVBFRDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVBFRDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVBFRDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:03:53 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:52106 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261212AbVBFRDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:03:49 -0500
Date: Sun, 6 Feb 2005 19:03:47 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add as-option to top-level Makefile
Message-ID: <20050206170347.GB27853@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Sam Ravnborg <sam@ravnborg.org>, Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

cc-option can presently not be used for checking as flags. It seems like
MIPS ran into this already and added their own as-option (which at this
point seems to be completely unused on MIPS, so perhaps it's worth
removing entirely from there).

This patch moves the definition to the top-level Makefile so that others
can make use of it (sh wants this with newer binutils that allow for ISA
tuning, for instance).

Additionally, it may make more sense to move the -Wa$(comma) stuff into
as-option directly so it doesn't get repeated all over the place (though
it seems unlikely that there will be enough users that actually care
about this).

=3D=3D=3D=3D=3D Makefile 1.563 vs edited =3D=3D=3D=3D=3D
--- 1.563/Makefile	2005-02-03 03:50:51 +02:00
+++ edited/Makefile	2005-02-06 18:50:49 +02:00
@@ -279,6 +279,13 @@
 # cc support functions to be used (only) in arch/$(ARCH)/Makefile
 # See documentation in Documentation/kbuild/makefiles.txt
=20
+# as-option
+# Usage: cflags-y +=3D $(call as-option, -Wa$(comma)-isa=3Dfoo,)
+
+as-option =3D $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
+	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
+	     else echo "$(2)"; fi ;)
+
 # cc-option
 # Usage: cflags-y +=3D $(call gcc-option, -march=3Dwinchip-c6, -march=3Di5=
86)
=20
=3D=3D=3D=3D=3D arch/mips/Makefile 1.28 vs edited =3D=3D=3D=3D=3D
--- 1.28/arch/mips/Makefile	2005-01-31 08:33:43 +02:00
+++ edited/arch/mips/Makefile	2005-02-06 18:49:20 +02:00
@@ -12,10 +12,6 @@
 # for "archclean" cleaning up for this architecture.
 #
=20
-as-option =3D $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
-	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
-	     else echo "$(2)"; fi ;)
-
 cflags-y :=3D
=20
 #

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD4DBQFCBk3z1K+teJFxZ9wRAkIJAJ9CNK4b7WJlVk+xsbDN7uFBLFLzSwCYxpe2
a8kGpN6ulVxJby38Xbvlqw==
=REKX
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
