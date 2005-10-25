Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbVJYDu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVJYDu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 23:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVJYDu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 23:50:56 -0400
Received: from mail13.bluewin.ch ([195.186.18.62]:58777 "EHLO
	mail13.bluewin.ch") by vger.kernel.org with ESMTP id S1751426AbVJYDu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 23:50:56 -0400
Date: Mon, 24 Oct 2005 23:39:39 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] semaphore: Remove __MUTEX_INITIALIZER()
Message-ID: <20051025033939.GA8549@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__MUTEX_INITIALIZER() has no users, and equates to the more commonly used
DECLARE_MUTEX(), thus making it pretty much redundant. Remove it for good.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 include/asm-alpha/semaphore.h     |    3 ---
 include/asm-arm/semaphore.h       |    2 --
 include/asm-arm26/semaphore.h     |    3 ---
 include/asm-cris/semaphore.h      |    3 ---
 include/asm-frv/semaphore.h       |    3 ---
 include/asm-h8300/semaphore.h     |    3 ---
 include/asm-i386/semaphore.h      |    3 ---
 include/asm-ia64/semaphore.h      |    2 --
 include/asm-m32r/semaphore.h      |    3 ---
 include/asm-m68k/semaphore.h      |    3 ---
 include/asm-m68knommu/semaphore.h |    3 ---
 include/asm-mips/semaphore.h      |    3 ---
 include/asm-parisc/semaphore.h    |    3 ---
 include/asm-ppc/semaphore.h       |    3 ---
 include/asm-ppc64/semaphore.h     |    3 ---
 include/asm-s390/semaphore.h      |    3 ---
 include/asm-sh/semaphore.h        |    3 ---
 include/asm-sh64/semaphore.h      |    3 ---
 include/asm-sparc/semaphore.h     |    3 ---
 include/asm-sparc64/semaphore.h   |    3 ---
 include/asm-v850/semaphore.h      |    3 ---
 include/asm-x86_64/semaphore.h    |    3 ---
 include/asm-xtensa/semaphore.h    |    3 ---
 23 files changed, 0 insertions(+), 67 deletions(-)

d037647d1b61724fdc824bb68f3c4ee388b56b01
diff --git a/include/asm-alpha/semaphore.h b/include/asm-alpha/semaphore.h
--- a/include/asm-alpha/semaphore.h
+++ b/include/asm-alpha/semaphore.h
@@ -26,9 +26,6 @@ struct semaphore {
   	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }
 
-#define __MUTEX_INITIALIZER(name)			\
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)		\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-arm/semaphore.h b/include/asm-arm/semaphore.h
--- a/include/asm-arm/semaphore.h
+++ b/include/asm-arm/semaphore.h
@@ -24,8 +24,6 @@ struct semaphore {
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }
 
-#define __MUTEX_INITIALIZER(name) __SEMAPHORE_INIT(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INIT(name,count)
 
diff --git a/include/asm-arm26/semaphore.h b/include/asm-arm26/semaphore.h
--- a/include/asm-arm26/semaphore.h
+++ b/include/asm-arm26/semaphore.h
@@ -25,9 +25,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INIT(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INIT(name,count)
 
diff --git a/include/asm-cris/semaphore.h b/include/asm-cris/semaphore.h
--- a/include/asm-cris/semaphore.h
+++ b/include/asm-cris/semaphore.h
@@ -33,9 +33,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)    \
 }
 
-#define __MUTEX_INITIALIZER(name) \
-        __SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
         struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-frv/semaphore.h b/include/asm-frv/semaphore.h
--- a/include/asm-frv/semaphore.h
+++ b/include/asm-frv/semaphore.h
@@ -47,9 +47,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name,count) \
 { count, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __SEM_DEBUG_INIT(name) }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-h8300/semaphore.h b/include/asm-h8300/semaphore.h
--- a/include/asm-h8300/semaphore.h
+++ b/include/asm-h8300/semaphore.h
@@ -35,9 +35,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-i386/semaphore.h b/include/asm-i386/semaphore.h
--- a/include/asm-i386/semaphore.h
+++ b/include/asm-i386/semaphore.h
@@ -55,9 +55,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-ia64/semaphore.h b/include/asm-ia64/semaphore.h
--- a/include/asm-ia64/semaphore.h
+++ b/include/asm-ia64/semaphore.h
@@ -24,8 +24,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name)	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)					\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name, count)
 
diff --git a/include/asm-m32r/semaphore.h b/include/asm-m32r/semaphore.h
--- a/include/asm-m32r/semaphore.h
+++ b/include/asm-m32r/semaphore.h
@@ -32,9 +32,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-m68k/semaphore.h b/include/asm-m68k/semaphore.h
--- a/include/asm-m68k/semaphore.h
+++ b/include/asm-m68k/semaphore.h
@@ -36,9 +36,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-m68knommu/semaphore.h b/include/asm-m68knommu/semaphore.h
--- a/include/asm-m68knommu/semaphore.h
+++ b/include/asm-m68knommu/semaphore.h
@@ -35,9 +35,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-mips/semaphore.h b/include/asm-mips/semaphore.h
--- a/include/asm-mips/semaphore.h
+++ b/include/asm-mips/semaphore.h
@@ -45,9 +45,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-parisc/semaphore.h b/include/asm-parisc/semaphore.h
--- a/include/asm-parisc/semaphore.h
+++ b/include/asm-parisc/semaphore.h
@@ -49,9 +49,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-ppc/semaphore.h b/include/asm-ppc/semaphore.h
--- a/include/asm-ppc/semaphore.h
+++ b/include/asm-ppc/semaphore.h
@@ -37,9 +37,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-ppc64/semaphore.h b/include/asm-ppc64/semaphore.h
--- a/include/asm-ppc64/semaphore.h
+++ b/include/asm-ppc64/semaphore.h
@@ -31,9 +31,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-s390/semaphore.h b/include/asm-s390/semaphore.h
--- a/include/asm-s390/semaphore.h
+++ b/include/asm-s390/semaphore.h
@@ -29,9 +29,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name,count) \
 	{ ATOMIC_INIT(count), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-sh/semaphore.h b/include/asm-sh/semaphore.h
--- a/include/asm-sh/semaphore.h
+++ b/include/asm-sh/semaphore.h
@@ -33,9 +33,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-sh64/semaphore.h b/include/asm-sh64/semaphore.h
--- a/include/asm-sh64/semaphore.h
+++ b/include/asm-sh64/semaphore.h
@@ -40,9 +40,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-sparc/semaphore.h b/include/asm-sparc/semaphore.h
--- a/include/asm-sparc/semaphore.h
+++ b/include/asm-sparc/semaphore.h
@@ -22,9 +22,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-sparc64/semaphore.h b/include/asm-sparc64/semaphore.h
--- a/include/asm-sparc64/semaphore.h
+++ b/include/asm-sparc64/semaphore.h
@@ -22,9 +22,6 @@ struct semaphore {
 	{ ATOMIC_INIT(count), \
 	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-v850/semaphore.h b/include/asm-v850/semaphore.h
--- a/include/asm-v850/semaphore.h
+++ b/include/asm-v850/semaphore.h
@@ -18,9 +18,6 @@ struct semaphore {
 	{ ATOMIC_INIT (count), 0,					      \
 	  __WAIT_QUEUE_HEAD_INITIALIZER ((name).wait) }
 
-#define __MUTEX_INITIALIZER(name)					      \
-	__SEMAPHORE_INITIALIZER (name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INITIALIZER (name,count)
 
diff --git a/include/asm-x86_64/semaphore.h b/include/asm-x86_64/semaphore.h
--- a/include/asm-x86_64/semaphore.h
+++ b/include/asm-x86_64/semaphore.h
@@ -56,9 +56,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
diff --git a/include/asm-xtensa/semaphore.h b/include/asm-xtensa/semaphore.h
--- a/include/asm-xtensa/semaphore.h
+++ b/include/asm-xtensa/semaphore.h
@@ -29,9 +29,6 @@ struct semaphore {
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __MUTEX_INITIALIZER(name) 					\
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) 			\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
