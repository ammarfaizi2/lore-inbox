Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbTFSJ0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbTFSJ0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:26:35 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:2272
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265740AbTFSJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:26:32 -0400
Date: Thu, 19 Jun 2003 02:40:30 -0700
To: akpm@digeo.com
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: [PATCH] implicit declaration of memset in 2.5.72-mm2
Message-ID: <20030619094030.GA1933@firesong>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: multipart/mixed; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

This fixes a few implicit declarations of memset in uaccess.h
in 2.5.72-mm2... It applies cleanly to 2.5.72 vanilla as well
but has no effect on the i386 clear_user when applied to the
former. Also fixes some weird tabs.

Regards
Josh

--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="memset_include_string.patch"
Content-Transfer-Encoding: quoted-printable

Only in linux-2.5.72.mod/include/: asm
diff -ur linux-2.5.72/include/asm-h8300/uaccess.h linux-2.5.72.mod/include/=
asm-h8300/uaccess.h
--- linux-2.5.72/include/asm-h8300/uaccess.h	2003-06-16 21:19:47.000000000 =
-0700
+++ linux-2.5.72.mod/include/asm-h8300/uaccess.h	2003-06-19 01:55:31.000000=
000 -0700
@@ -6,6 +6,8 @@
  */
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/string.h>
+
 #include <asm/segment.h>
=20
 #define VERIFY_READ	0
@@ -159,7 +161,7 @@
 clear_user(void *to, unsigned long n)
 {
 	memset(to, 0, n);
-    return(0);
+	return(0);
 }
=20
 #endif /* _H8300_UACCESS_H */
diff -ur linux-2.5.72/include/asm-i386/uaccess.h linux-2.5.72.mod/include/a=
sm-i386/uaccess.h
--- linux-2.5.72/include/asm-i386/uaccess.h	2003-06-19 02:31:17.000000000 -=
0700
+++ linux-2.5.72.mod/include/asm-i386/uaccess.h	2003-06-19 01:53:23.0000000=
00 -0700
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/thread_info.h>
 #include <linux/prefetch.h>
+#include <linux/string.h>
 #include <asm/page.h>
=20
 #define VERIFY_READ 0
diff -ur linux-2.5.72/include/asm-m68knommu/uaccess.h linux-2.5.72.mod/incl=
ude/asm-m68knommu/uaccess.h
--- linux-2.5.72/include/asm-m68knommu/uaccess.h	2003-06-19 02:34:53.000000=
000 -0700
+++ linux-2.5.72.mod/include/asm-m68knommu/uaccess.h	2003-06-19 01:55:06.00=
0000000 -0700
@@ -6,6 +6,8 @@
  */
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/string.h>
+
 #include <asm/segment.h>
=20
 #define VERIFY_READ	0
@@ -178,7 +180,7 @@
 clear_user(void *to, unsigned long n)
 {
 	memset(to, 0, n);
-    return(0);
+	return(0);
 }
=20
 #endif /* _M68KNOMMU_UACCESS_H */

--3lcZGd9BuhuYXNfi--

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8YUOT2bz5yevw+4RAsmxAJ4zutPYUiUOFT8QMstKvrJYV9J8AwCZAbEF
g8gBoah6yfFtKfLL7CBCG4k=
=5Taz
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
