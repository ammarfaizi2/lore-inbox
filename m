Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317621AbSFIOzJ>; Sun, 9 Jun 2002 10:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSFIOzI>; Sun, 9 Jun 2002 10:55:08 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:3576 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317621AbSFIOzH>; Sun, 9 Jun 2002 10:55:07 -0400
Date: Sun, 9 Jun 2002 16:55:08 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5.21] compilation fix
Message-ID: <Pine.GSO.4.05.10206091653110.16366-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seems the include file cleanup was a little bit over-optimized :)

this simple patch should fix the problem:

diff -Nru a/include/linux/bio.h b/include/linux/bio.h
--- a/include/linux/bio.h       Sun Jun  9 21:54:07 2002
+++ b/include/linux/bio.h       Sun Jun  9 21:54:07 2002
@@ -23,6 +23,7 @@
 #include <linux/kdev_t.h>
 /* Platforms may set this to teach the BIO layer about IOMMU hardware. */
 #include <asm/io.h>
+#include <asm/atomic.h>
 #ifndef BIO_VMERGE_BOUNDARY
 #define BIO_VMERGE_BOUNDARY    0
 #endif
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c     Sun Jun  9 21:54:07 2002
+++ b/kernel/fork.c     Sun Jun  9 21:54:07 2002
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
+#include <linux/sched.h>
 #include <linux/namespace.h>
 #include <linux/personality.h>
 #include <linux/file.h>


	tm
-- 
in some way i do, and in some way i don't.

