Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310186AbSBRHXf>; Mon, 18 Feb 2002 02:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310187AbSBRHX0>; Mon, 18 Feb 2002 02:23:26 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:24072 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S310186AbSBRHXJ>;
	Mon, 18 Feb 2002 02:23:09 -0500
Date: Mon, 18 Feb 2002 10:27:01 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz
Subject: [PATCH] ISAPNP support in ALSA (2.5.5-pre1) is broken 
Message-ID: <20020218072701.GA4598@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org, perex@suse.cz
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

ISA PnP support in 2.5.5-pre1 ALSA modules is broken.
1) it uses __ISAPNP__ without including linux/isapnp.h,
2) it uses isapnp_dev and isapnp_card sturctures which
are not declared anywhere.

Attached patch fixes these problems, without it snd-sbawe module
doesn't recognize my ISA PnP AWE64.

Best regards.
--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-alsa-isapnp
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/ad1816a/ad1816a.c=
 /linux/sound/isa/ad1816a/ad1816a.c
--- /linux.vanilla/sound/isa/ad1816a/ad1816a.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/ad1816a/ad1816a.c	Sat Feb 16 22:26:51 2002
@@ -20,6 +20,7 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/als100.c /linux/s=
ound/isa/als100.c
--- /linux.vanilla/sound/isa/als100.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/als100.c	Sat Feb 16 22:12:49 2002
@@ -22,12 +22,14 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
 #include <sound/sb.h>
+
=20
 #define chip_t sb_t
=20
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/azt2320.c /linux/=
sound/isa/azt2320.c
--- /linux.vanilla/sound/isa/azt2320.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/azt2320.c	Sat Feb 16 22:15:20 2002
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/cmi8330.c /linux/=
sound/isa/cmi8330.c
--- /linux.vanilla/sound/isa/cmi8330.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/cmi8330.c	Sat Feb 16 22:16:47 2002
@@ -45,6 +45,7 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #include <sound/ad1848.h>
 #include <sound/sb.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/cs423x/cs4236.c /=
linux/sound/isa/cs423x/cs4236.c
--- /linux.vanilla/sound/isa/cs423x/cs4236.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/cs423x/cs4236.c	Sat Feb 16 22:25:14 2002
@@ -21,6 +21,7 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #include <sound/cs4231.h>
 #include <sound/mpu401.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/dt0197h.c /linux/=
sound/isa/dt0197h.c
--- /linux.vanilla/sound/isa/dt0197h.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/dt0197h.c	Sat Feb 16 22:17:36 2002
@@ -20,6 +20,7 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/es18xx.c /linux/s=
ound/isa/es18xx.c
--- /linux.vanilla/sound/isa/es18xx.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/es18xx.c	Sat Feb 16 22:19:00 2002
@@ -68,6 +68,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/gus/interwave.c /=
linux/sound/isa/gus/interwave.c
--- /linux.vanilla/sound/isa/gus/interwave.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/gus/interwave.c	Sat Feb 16 22:23:49 2002
@@ -26,6 +26,7 @@
 #include <asm/dma.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #include <sound/gus.h>
 #include <sound/cs4231.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/opl3sa2.c /linux/=
sound/isa/opl3sa2.c
--- /linux.vanilla/sound/isa/opl3sa2.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/opl3sa2.c	Sat Feb 16 22:19:41 2002
@@ -22,6 +22,7 @@
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <linux/pm.h>
 #include <sound/core.h>
 #include <sound/cs4231.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/opti9xx/opti92x-a=
d1848.c /linux/sound/isa/opti9xx/opti92x-ad1848.c
--- /linux.vanilla/sound/isa/opti9xx/opti92x-ad1848.c	Sun Feb 17 15:16:05 2=
002
+++ /linux/sound/isa/opti9xx/opti92x-ad1848.c	Sat Feb 16 22:23:07 2002
@@ -27,6 +27,7 @@
 #include <asm/dma.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #ifdef CS4231
 #include <sound/cs4231.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/sb/es968.c /linux=
/sound/isa/sb/es968.c
--- /linux.vanilla/sound/isa/sb/es968.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/sb/es968.c	Sat Feb 16 22:21:42 2002
@@ -22,6 +22,7 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/sb/sb16.c /linux/=
sound/isa/sb/sb16.c
--- /linux.vanilla/sound/isa/sb/sb16.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/sb/sb16.c	Sat Feb 16 22:22:18 2002
@@ -22,6 +22,7 @@
 #include <sound/driver.h>
 #include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/sb16_csp.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/sound/isa/wavefront/wavefro=
nt.c /linux/sound/isa/wavefront/wavefront.c
--- /linux.vanilla/sound/isa/wavefront/wavefront.c	Sun Feb 17 15:16:05 2002
+++ /linux/sound/isa/wavefront/wavefront.c	Sat Feb 16 22:20:49 2002
@@ -21,6 +21,7 @@
=20
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/isapnp.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
diff -urN -X /usr/share/dontdiff /linux.vanilla/include/sound/core.h /linux=
/include/sound/core.h
--- /linux.vanilla/include/sound/core.h	Sun Feb 17 15:16:02 2002
+++ /linux/include/sound/core.h	Sat Feb 16 22:12:24 2002
@@ -338,4 +338,7 @@
=20
 #define SNDRV_OSS_VERSION         ((3<<16)|(8<<8)|(1<<4)|(0))	/* 3.8.1a */
=20
+#define isapnp_card pci_bus
+#define isapnp_dev pci_dev
+
 #endif /* __SOUND_CORE_H */

--y0ulUmNC+osPPQO6--

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8cKzFBm4rlNOo3YgRAjz0AJ9lEZ4BAIjYL4KdsJlcbxbalORaqwCdFaBJ
UrU3TUgSKDaHT/2AUnFj0aM=
=wFAI
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
