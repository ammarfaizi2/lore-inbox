Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbRLQKAR>; Mon, 17 Dec 2001 05:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285077AbRLQKAI>; Mon, 17 Dec 2001 05:00:08 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:46866 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S285073AbRLQJ7v>;
	Mon, 17 Dec 2001 04:59:51 -0500
Date: Tue, 18 Dec 2001 13:03:33 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] __ISAPNP__ breakage in serial.c (2.5.1)
Message-ID: <20011218130333.A199@pazke.ipt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
User-Agent: Mutt/1.0.1i
X-Uname: Linux pazke 2.5.1-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

in serial driver __ISAPNP__ conditional symbol is used before=20
isapnp.h file is included. Quick and dirty fix attached.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serial-isapnp
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/char/serial.c /linux/driv=
ers/char/serial.c
--- /linux.vanilla/drivers/char/serial.c	Mon Dec 17 17:44:31 2001
+++ /linux/drivers/char/serial.c	Tue Dec 18 00:13:01 2001
@@ -122,11 +122,6 @@
 #define ENABLE_SERIAL_ACPI
 #endif
=20
-#ifdef __ISAPNP__
-#ifndef ENABLE_SERIAL_PNP
-#define ENABLE_SERIAL_PNP
-#endif
-#endif
=20
 /* Set of debugging defines */
=20
@@ -211,9 +206,14 @@
 #ifdef ENABLE_SERIAL_PCI
 #include <linux/pci.h>
 #endif
-#ifdef ENABLE_SERIAL_PNP
+
 #include <linux/isapnp.h>
+#ifdef __ISAPNP__
+#ifndef ENABLE_SERIAL_PNP
+#define ENABLE_SERIAL_PNP
+#endif
 #endif
+
 #ifdef CONFIG_MAGIC_SYSRQ
 #include <linux/sysrq.h>
 #endif

--x+6KMIRAuhnl3hBn--

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8HxR1Bm4rlNOo3YgRAl4LAJ9FcBXy5uti6nQLkYxO8kx3qgWRZgCfRrag
tW3Evu7OExUnB/tEKEQB5ow=
=06LF
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
