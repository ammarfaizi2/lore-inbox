Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286085AbRLHX4N>; Sat, 8 Dec 2001 18:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286087AbRLHX4D>; Sat, 8 Dec 2001 18:56:03 -0500
Received: from [144.137.80.17] ([144.137.80.17]:55177 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S286085AbRLHXz6>;
	Sat, 8 Dec 2001 18:55:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] BUG_ON() not arch-specific. 
In-Reply-To: Your message of "Wed, 05 Dec 2001 14:42:32 -0000."
             <26384.1007563352@redhat.com> 
Date: Sun, 09 Dec 2001 10:56:43 +1100
Message-Id: <E16CrKl-0006NG-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <26384.1007563352@redhat.com> you write:
> You'll need to add #include <linux/compiler.h> to linux/kernel.h if you do 
> that. Let's not make the include files any more broken than they already 
> are :)

Ack.  Linus, please apply.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.1-pre5/include/linux/kernel.h working-2.5.1-pre5-percpu/include/linux/kernel.h
--- linux-2.5.1-pre5/include/linux/kernel.h	Thu Dec  6 16:20:29 2001
+++ working-2.5.1-pre5-percpu/include/linux/kernel.h	Sun Dec  9 10:52:09 2001
@@ -11,6 +11,7 @@
 #include <linux/linkage.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
@@ -176,4 +177,5 @@
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
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
