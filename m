Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283324AbRLEHYY>; Wed, 5 Dec 2001 02:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRLEHYG>; Wed, 5 Dec 2001 02:24:06 -0500
Received: from [202.135.142.196] ([202.135.142.196]:5648 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S283295AbRLEHXv>;
	Wed, 5 Dec 2001 02:23:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: [PATCH] BUG_ON() not arch-specific.
Date: Wed, 05 Dec 2001 18:24:40 +1100
Message-Id: <E16BWQ4-00070r-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	We only need one BUG_ON implementation, surely.  Genericized
and moved to linux/kernel.h.

Cheers,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/kernel.h working-2.5.1-pre5-percpu/include/linux/kernel.h
--- linux-2.5.1-pre5/include/linux/kernel.h	Wed Dec  5 16:49:14 2001
+++ working-2.5.1-pre5-percpu/include/linux/kernel.h	Wed Dec  5 18:12:15 2001
@@ -176,4 +176,5 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-alpha/page.h working-2.5.1-pre5-percpu/include/asm-alpha/page.h
--- linux-2.5.1-pre5/include/asm-alpha/page.h	Tue Dec  4 17:17:27 2001
+++ working-2.5.1-pre5-percpu/include/asm-alpha/page.h	Wed Dec  5 18:14:34 2001
@@ -67,18 +67,6 @@
 
 #define PAGE_BUG(page)	BUG()
 
-#define BUG_ON(condition)			\
-	do {					\
-		if (unlikely((long)(condition)))\
-			BUG();			\
-	} while (0)
-
-#define BUG_ON(condition)			\
-	do {					\
-		if (unlikely((int)(condition)))	\
-			BUG();			\
-	} while (0)
-
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/asm-i386/page.h working-2.5.1-pre5-percpu/include/asm-i386/page.h
--- linux-2.5.1-pre5/include/asm-i386/page.h	Tue Dec  4 17:17:27 2001
+++ working-2.5.1-pre5-percpu/include/asm-i386/page.h	Wed Dec  5 18:06:31 2001
@@ -101,12 +101,6 @@
 	BUG(); \
 } while (0)
 
-#define BUG_ON(condition)			\
-	do {					\
-		if (unlikely((int)(condition)))	\
-			BUG();			\
-	} while (0)
-
 /* Pure 2^n version of get_order */
 static __inline__ int get_order(unsigned long size)
 {
--
Premature optmztion is rt of all evl. --DK
