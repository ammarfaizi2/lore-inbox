Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbTGCEu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTGCEu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 00:50:57 -0400
Received: from [61.95.53.28] ([61.95.53.28]:41220 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S265115AbTGCEuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 00:50:55 -0400
Date: Thu, 3 Jul 2003 15:05:15 +1000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
Subject: [PATCH] 8139too suspend fix, maybe.
Message-ID: <20030703050515.GH4359@himi.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZG+WKzXzVby2T9Ro
Content-Type: multipart/mixed; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm currently trying to get my Fujitsu Lifebook P2120 laptop to
suspend/resume successfully, and the first stumbling block I've come
across with a plain Linus bk tree is that while the 8139too driver
is up and running, the kernel thread it starts doesn't suspend. The
attatched patch fixes this; I have no idea if this is correct, but
it works.=20

Getting the radeonfb to resume is the next problem . . .

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8139too-suspend.patch"
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D drivers/net/8139too.c 1.57 vs edited =3D=3D=3D=3D=3D
--- 1.57/drivers/net/8139too.c	Thu May 29 14:03:45 2003
+++ edited/drivers/net/8139too.c	Thu Jul  3 14:46:38 2003
@@ -109,6 +109,7 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/completion.h>
+#include <linux/suspend.h>
 #include <linux/crc32.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1597,6 +1598,8 @@
 		timeout =3D next_tick;
 		do {
 			timeout =3D interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
 		} while (!signal_pending (current) && (timeout > 0));
=20
 		if (signal_pending (current)) {

--ev7mvGV+3JQuI2Eo--

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/A7mGQPlfmRRKmRwRAjPXAKDFX5lHdmEsLIqOD2K+FWmLh6+zhgCgu6pu
IihdCvllHNCndrbgrzmeK18=
=bMYH
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--
