Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVDMOOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVDMOOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVDMOOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:14:55 -0400
Received: from users.ccur.com ([208.248.32.211]:16775 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261349AbVDMOOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:14:49 -0400
Date: Wed, 13 Apr 2005 10:14:35 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: [PATCH] add EOWNERDEAD and ENOTRECOVERABLE version 2
Message-ID: <20050413141435.GA4311@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20050412152318.GA2714@tsunami.ccur.com> <20050412190138.06a2021f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412190138.06a2021f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add EOWNERDEAD and ENOTRECOVERABLE to all architectures.
This is to support the upcoming patches for robust mutexes.

We normally don't reserve parts of the name/number space
for external patches, but robust mutexes are sufficiently
popular and important to justify it in this case.

Signed-off-by: Joe Korty <joe.korty@ccur.com>


 2.6.12-rc2-jak/include/asm-alpha/errno.h   |    4 ++++
 2.6.12-rc2-jak/include/asm-generic/errno.h |    4 ++++
 2.6.12-rc2-jak/include/asm-mips/errno.h    |    4 ++++
 2.6.12-rc2-jak/include/asm-parisc/errno.h  |    4 ++++
 2.6.12-rc2-jak/include/asm-sparc/errno.h   |    4 ++++
 2.6.12-rc2-jak/include/asm-sparc64/errno.h |    4 ++++
 6 files changed, 24 insertions(+)

diff -puNa include/asm-generic/errno.h~owner.notrecoverable.errnos include/asm-generic/errno.h
--- 2.6.12-rc2/include/asm-generic/errno.h~owner.notrecoverable.errnos	2005-04-12 09:54:38.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-generic/errno.h	2005-04-13 09:58:26.000000000 -0400
@@ -102,4 +102,8 @@
 #define	EKEYREVOKED	128	/* Key has been revoked */
 #define	EKEYREJECTED	129	/* Key was rejected by service */
 
+/* for robust mutexes */
+#define	EOWNERDEAD	130	/* Owner died */
+#define	ENOTRECOVERABLE	131	/* State not recoverable */
+
 #endif
diff -puNa include/asm-alpha/errno.h~owner.notrecoverable.errnos include/asm-alpha/errno.h
--- 2.6.12-rc2/include/asm-alpha/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-alpha/errno.h	2005-04-13 09:58:41.000000000 -0400
@@ -116,4 +116,8 @@
 #define	EKEYREVOKED	134	/* Key has been revoked */
 #define	EKEYREJECTED	135	/* Key was rejected by service */
 
+/* for robust mutexes */
+#define	EOWNERDEAD	136	/* Owner died */
+#define	ENOTRECOVERABLE	137	/* State not recoverable */
+
 #endif
diff -puNa include/asm-mips/errno.h~owner.notrecoverable.errnos include/asm-mips/errno.h
--- 2.6.12-rc2/include/asm-mips/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-mips/errno.h	2005-04-13 09:59:17.000000000 -0400
@@ -115,6 +115,10 @@
 #define	EKEYREVOKED	163	/* Key has been revoked */
 #define	EKEYREJECTED	164	/* Key was rejected by service */
 
+/* for robust mutexes */
+#define	EOWNERDEAD	165	/* Owner died */
+#define	ENOTRECOVERABLE	166	/* State not recoverable */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 #ifdef __KERNEL__
diff -puNa include/asm-parisc/errno.h~owner.notrecoverable.errnos include/asm-parisc/errno.h
--- 2.6.12-rc2/include/asm-parisc/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-parisc/errno.h	2005-04-13 09:59:24.000000000 -0400
@@ -115,5 +115,9 @@
 #define ENOTSUP		252	/* Function not implemented (POSIX.4 / HPUX) */
 #define ECANCELLED	253	/* aio request was canceled before complete (POSIX.4 / HPUX) */
 
+/* for robust mutexes */
+#define EOWNERDEAD	254	/* Owner died */
+#define ENOTRECOVERABLE	255	/* State not recoverable */
+
 
 #endif
diff -puNa include/asm-sparc/errno.h~owner.notrecoverable.errnos include/asm-sparc/errno.h
--- 2.6.12-rc2/include/asm-sparc/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-sparc/errno.h	2005-04-13 09:59:28.000000000 -0400
@@ -107,4 +107,8 @@
 #define	EKEYREVOKED	130	/* Key has been revoked */
 #define	EKEYREJECTED	131	/* Key was rejected by service */
 
+/* for robust mutexes */
+#define	EOWNERDEAD	132	/* Owner died */
+#define	ENOTRECOVERABLE	133	/* State not recoverable */
+
 #endif
diff -puNa include/asm-sparc64/errno.h~owner.notrecoverable.errnos include/asm-sparc64/errno.h
--- 2.6.12-rc2/include/asm-sparc64/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-sparc64/errno.h	2005-04-13 09:59:33.000000000 -0400
@@ -107,4 +107,8 @@
 #define	EKEYREVOKED	130	/* Key has been revoked */
 #define	EKEYREJECTED	131	/* Key was rejected by service */
 
+/* for robust mutexes */
+#define	EOWNERDEAD	132	/* Owner died */
+#define	ENOTRECOVERABLE	133	/* State not recoverable */
+
 #endif /* !(_SPARC64_ERRNO_H) */

_

