Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130371AbQLRAFn>; Sun, 17 Dec 2000 19:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbQLRAFd>; Sun, 17 Dec 2000 19:05:33 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:19909 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S130371AbQLRAFU>; Sun, 17 Dec 2000 19:05:20 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 asm-alpha/system.h has a problem
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sun_Dec_17_15:34:43_2000_953)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20001217153444N.dyky@df-usa.com>
Date: Sun, 17 Dec 2000 15:34:44 -0800
From: Daiki Matsuda <dyky@df-usa.com>
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Sun_Dec_17_15:34:43_2000_953)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, all.

I encounterd the problem that 'cdrdao' is not compilable in 2.2.18 on
Alpha. And I researched a little.
So, then new code added in include/asm-alpha/system.h on 2.2.18 has a
problem in C++. The 'new' may be the reserved word in C++. And I send
its patch.

Regards
Daiki Matsuda

----Next_Part(Sun_Dec_17_15:34:43_2000_953)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="asm-alpha.system.h.patch"

--- linux/include/asm-alpha/system.h.old	Sun Dec 17 17:53:28 2000
+++ linux/include/asm-alpha/system.h	Sun Dec 17 17:54:51 2000
@@ -390,7 +390,7 @@
 #define __HAVE_ARCH_CMPXCHG 1
 
 extern __inline__ unsigned long
-__cmpxchg_u32(volatile int *m, int old, int new)
+__cmpxchg_u32(volatile int *m, int old_val, int new_val)
 {
 	unsigned long prev, cmp;
 
@@ -409,13 +409,13 @@
 	"3:	br 1b\n"
 	".previous"
 	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
-	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+	: "r"((long) old_val), "r"(new_val), "m"(*m) : "memory");
 
 	return prev;
 }
 
 extern __inline__ unsigned long
-__cmpxchg_u64(volatile long *m, unsigned long old, unsigned long new)
+__cmpxchg_u64(volatile long *m, unsigned long old_val, unsigned long new_val)
 {
 	unsigned long prev, cmp;
 
@@ -434,7 +434,7 @@
 	"3:	br 1b\n"
 	".previous"
 	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
-	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+	: "r"((long) old_val), "r"(new_val), "m"(*m) : "memory");
 
 	return prev;
 }
@@ -444,16 +444,16 @@
 extern void __cmpxchg_called_with_bad_pointer(void);
 
 static __inline__ unsigned long
-__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
+__cmpxchg(volatile void *ptr, unsigned long old_val, unsigned long new_val, int size)
 {
 	switch (size) {
 		case 4:
-			return __cmpxchg_u32(ptr, old, new);
+			return __cmpxchg_u32(ptr, old_val, new_val);
 		case 8:
-			return __cmpxchg_u64(ptr, old, new);
+			return __cmpxchg_u64(ptr, old_val, new_val);
 	}
 	__cmpxchg_called_with_bad_pointer();
-	return old;
+	return old_val;
 }
 
 #define cmpxchg(ptr,o,n)						 \

----Next_Part(Sun_Dec_17_15:34:43_2000_953)----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
