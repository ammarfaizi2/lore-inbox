Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUHWBr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUHWBr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 21:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUHWBr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 21:47:26 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:17566 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S266457AbUHWBrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 21:47:21 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Aug 2004 11:47:18 +1000
Subject: Adding LOCALVERSION to build
Message-ID: <20040823014718.GF23141@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: multipart/mixed; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

If you are wanting to build multiple versions of the same kernel to
test things out, it would be really handy to have a LOCALVERSION
variable that could be easily overridden.  I used to just play with
EXTRAVERSION, but that has become increasingly inappropriate and it
really would be nicer to just be able to do make O=outputdir
LOCALVERSION=aversion and have it appended so uname reports something
useful.

I just tried the attached, which works but having a dummy dependency
to make the version.h check run all the time is a bit ugly.  I can't
think of another way to indicate to make to update version.h if I
compile once with LOCALVERSION variable set from the command line, and
once without.

Anyway, is the general idea workable?

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="localversion.diff"
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D Makefile 1.513 vs edited =3D=3D=3D=3D=3D
--- 1.513/Makefile	2004-08-14 20:54:03 +10:00
+++ edited/Makefile	2004-08-23 11:40:57 +10:00
@@ -141,7 +141,12 @@
=20
 export srctree objtree VPATH TOPDIR
=20
-KERNELRELEASE=3D$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+# Take config variable for localversion unless overridden on the command l=
ine
+ifneq ($(CONFIG_LOCALVERSION),"")
+	LOCALVERSION=3D$(subst ",,$(CONFIG_LOCALVERSION))
+endif
+
+KERNELRELEASE=3D$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCAL=
VERSION)
=20
 # SUBARCH tells the usermode build what the underlying arch is.  That is s=
et
 # first, and if a usermode build is happening, the "ARCH=3Dum" on the comm=
and
@@ -722,7 +727,10 @@
 	)
 endef
=20
-include/linux/version.h: Makefile
+.localversion.tmp:=20
+#dummy, only need to update if localversion has changed
+
+include/linux/version.h: Makefile .localversion.tmp
 	$(call filechk,version.h)
=20
 # ------------------------------------------------------------------------=
---
=3D=3D=3D=3D=3D init/Kconfig 1.45 vs edited =3D=3D=3D=3D=3D
--- 1.45/init/Kconfig	2004-07-28 07:43:46 +10:00
+++ edited/init/Kconfig	2004-08-23 11:24:52 +10:00
@@ -285,6 +285,11 @@
=20
 	  If unsure, say N.
=20
+config LOCALVERSION
+	string "Local Version"
+	help
+	  Add a special extra string to identify this kernel locally.
+
 endmenu		# General setup
=20
=20

--uXxzq0nDebZQVNAZ--

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKUymWDlSU/gp6ecRAiXyAJ4+3R5uW3lNQGYu68NL4ATEQmuZSACeIxW2
IF0Bz2V5qrw4Mxmx0Gx1jc0=
=4HDp
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
