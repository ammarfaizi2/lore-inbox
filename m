Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSLBJN6>; Mon, 2 Dec 2002 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSLBJN6>; Mon, 2 Dec 2002 04:13:58 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:6298 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261689AbSLBJN5>; Mon, 2 Dec 2002 04:13:57 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: (No subject)
Date: Mon, 2 Dec 2002 10:21:27 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: "Nadav Rotem" <nadav256@hotmail.com>
MIME-Version: 1.0
Message-Id: <200212021019.50666.m.c.p@wolk-project.de>
X-PRIORITY: 2 (High)
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RBJHMHCXJPAKBAODO45H"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_RBJHMHCXJPAKBAODO45H
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Nadav,

first: a subject would be nice ;)

> I am having some problems with recent kernels. The SIS DRI module since=
=20
> 2.4.18 through 2.4.20 will not compile ^H ^H ^H Link properly. The Erro=
r I=20
> get is undefined reference to sis_free() and sis_malloc(). I believe it=
 has=20
> to do with the dependencies or make file linking with a missing .o file=
=2E
> The problem occures whenever I try to compile the module into the kerne=
l (=20
> [*] sis ).
> when I try to compile it as a module it fails when I go through "make=20
> modules_install" with the same error.
that problem is known for a long time now and has been often discussed bu=
t=20
never got a fix into mainstream. Use this.

The patch does 2 simple things.

1. If you select SiS DRI statically it selects SiS Framebuffer also stati=
cally
2. Same as above for module.

ciao, Marc


--------------Boundary-00=_RBJHMHCXJPAKBAODO45H
Content-Type: text/x-diff;
  charset="us-ascii";
  name="032_xfree-drm-4.2.0-03.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="032_xfree-drm-4.2.0-03.patch"

# Patch from: me

diff -Nur linux-2.4.18-wolk-3.3-fullkernel-org/drivers/char/drm/Config.in linux-2.4.18-wolk-3.3-fullkernel/drivers/char/drm/Config.in
--- linux-2.4.18-wolk-3.3-fullkernel-org/drivers/char/drm/Config.in	Mon Feb 25 20:37:57 2002
+++ linux-2.4.18-wolk-3.3-fullkernel/drivers/char/drm/Config.in	Tue Apr 23 19:22:31 2002
@@ -13,3 +13,10 @@
 dep_tristate '  Intel 830M' CONFIG_DRM_I830 $CONFIG_AGP
 dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
 dep_tristate '  SiS' CONFIG_DRM_SIS $CONFIG_AGP
+
+    if [ "$CONFIG_DRM_SIS" = "y" ]; then
+	define_bool CONFIG_FB_SIS y
+    fi
+    if [ "$CONFIG_DRM_SIS" = "m" ]; then
+	define_bool CONFIG_FB_SIS m
+    fi

--------------Boundary-00=_RBJHMHCXJPAKBAODO45H--

