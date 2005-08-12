Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVHLR4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVHLR4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVHLRyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:53 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:57482 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1750779AbVHLRyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:20 -0400
Subject: [patch 11/39] remap_file_pages protection support: add MAP_NOINHERIT flag
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:31:55 +0200
Message-Id: <20050812173156.315A624E7DA@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add the MAP_NOINHERIT flag to arch headers, for use with remap-file-pages.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-i386/mman.h   |    1 +
 linux-2.6.git-paolo/include/asm-ia64/mman.h   |    1 +
 linux-2.6.git-paolo/include/asm-ppc/mman.h    |    1 +
 linux-2.6.git-paolo/include/asm-ppc64/mman.h  |    1 +
 linux-2.6.git-paolo/include/asm-s390/mman.h   |    1 +
 linux-2.6.git-paolo/include/asm-x86_64/mman.h |    1 +
 6 files changed, 6 insertions(+)

diff -puN include/asm-i386/mman.h~rfp-map-noinherit include/asm-i386/mman.h
--- linux-2.6.git/include/asm-i386/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-ia64/mman.h~rfp-map-noinherit include/asm-ia64/mman.h
--- linux-2.6.git/include/asm-ia64/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ia64/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-ppc64/mman.h~rfp-map-noinherit include/asm-ppc64/mman.h
--- linux-2.6.git/include/asm-ppc64/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc64/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -38,6 +38,7 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MADV_NORMAL	0x0		/* default page-in behavior */
 #define MADV_RANDOM	0x1		/* page-in minimum required */
diff -puN include/asm-ppc/mman.h~rfp-map-noinherit include/asm-ppc/mman.h
--- linux-2.6.git/include/asm-ppc/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -23,6 +23,7 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-s390/mman.h~rfp-map-noinherit include/asm-s390/mman.h
--- linux-2.6.git/include/asm-s390/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-s390/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -puN include/asm-x86_64/mman.h~rfp-map-noinherit include/asm-x86_64/mman.h
--- linux-2.6.git/include/asm-x86_64/mman.h~rfp-map-noinherit	2005-08-11 12:06:40.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-x86_64/mman.h	2005-08-11 12:06:40.000000000 +0200
@@ -23,6 +23,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of the underlying vma*/
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
_
