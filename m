Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267775AbTGIK0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbTGIK0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:26:42 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:30960 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S268168AbTGIKXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:23:42 -0400
Subject: kconf: .so linking
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NfxND+D+M/43qHalxjFo"
Organization: Red Hat, Inc.
Message-Id: <1057747092.6494.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 09 Jul 2003 12:38:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NfxND+D+M/43qHalxjFo
Content-Type: multipart/mixed; boundary="=-DHFYkwvqlaTQOV/xCMAr"


--=-DHFYkwvqlaTQOV/xCMAr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

in the 2.5.74 kconfig makefile, the scripts/kconfig/conf binary is built
such that it requires a scripts/kconfig/libkconfig.so relative to the
current working directory. Several tools (like rpm and prelink) really
really don't like this, and in addition it's just untidy.

The attached patch fixes this by linking the .so file into the conf
binary with an "origine" path which means "same directory as the
binary". This keeps the tools happy and works better as a side effect.

Greetings,
   Arjan van de Ven

--=-DHFYkwvqlaTQOV/xCMAr
Content-Description: 
Content-Disposition: inline; filename=kconfig.patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- linux-2.5.74/scripts/kconfig/Makefile.org	2003-07-02 22:57:42.000000000=
 +0200
+++ linux-2.5.74/scripts/kconfig/Makefile	2003-07-09 12:20:49.019013406 +02=
00
@@ -15,7 +15,7 @@
 libkconfig-objs :=3D zconf.tab.o
=20
 host-progs	:=3D conf mconf qconf gconf
-conf-objs	:=3D conf.o  libkconfig.so
+conf-objs	:=3D conf.o
 mconf-objs	:=3D mconf.o libkconfig.so
=20
 ifeq ($(MAKECMDGOALS),$(obj)/qconf)
@@ -34,13 +34,15 @@
 HOSTCFLAGS_lex.zconf.o	:=3D -I$(src)
 HOSTCFLAGS_zconf.tab.o	:=3D -I$(src)
=20
+HOSTLOADLIBES_conf	=3D -Wl,-rpath,\$$ORIGIN -Lscripts/kconfig -lkconfig
+
 HOSTLOADLIBES_qconf	=3D -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) =
-ldl
 HOSTCXXFLAGS_qconf.o	=3D -I$(QTDIR)/include=20
=20
 HOSTLOADLIBES_gconf	=3D `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --li=
bs`
 HOSTCFLAGS_gconf.o	=3D `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cfl=
ags`
=20
-$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.t=
ab.h
+$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.t=
ab.h $(obj)/libkconfig.so
=20
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
=20

--=-DHFYkwvqlaTQOV/xCMAr--

--=-NfxND+D+M/43qHalxjFo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/C/CUxULwo51rQBIRAo6CAJ98GVfT/bVsj1Kky5liChtbu2r4wwCeNKEG
mLksIEKaphYg9tqxPPq5b9A=
=0X1w
-----END PGP SIGNATURE-----

--=-NfxND+D+M/43qHalxjFo--
