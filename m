Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933010AbWJITbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbWJITbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933011AbWJITbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:31:18 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:46755 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S933010AbWJITbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:31:17 -0400
X-Originating-Ip: 72.57.81.197
Date: Mon, 9 Oct 2006 15:30:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] standardize definition of sema_init()
Message-ID: <Pine.LNX.4.64.0610091527310.27241@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed off by: Robert P. J. Day <rpjday@mindspring.com>
---
  There doesn't *appear* to be any reason for the various definitions
of sema_init() not to be in the standard form, but I'm willing to be
convinced otherwise.

diff --git a/include/asm-alpha/semaphore.h b/include/asm-alpha/semaphore.h
index 1a6295f..8c3c6dd 100644
--- a/include/asm-alpha/semaphore.h
+++ b/include/asm-alpha/semaphore.h
@@ -34,14 +34,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init(struct semaphore *sem, int val)
 {
-	/*
-	 * Logically,
-	 *   *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
-	 * except that gcc produces better initializing by parts yet.
-	 */
-
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-arm/semaphore.h b/include/asm-arm/semaphore.h
index d5dc624..7394cb1 100644
--- a/include/asm-arm/semaphore.h
+++ b/include/asm-arm/semaphore.h
@@ -32,9 +32,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init(struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX(struct semaphore *sem)
diff --git a/include/asm-arm26/semaphore.h b/include/asm-arm26/semaphore.h
index 1fda543..84ad0e3 100644
--- a/include/asm-arm26/semaphore.h
+++ b/include/asm-arm26/semaphore.h
@@ -18,7 +18,7 @@ struct semaphore {
 	wait_queue_head_t wait;
 };

-#define __SEMAPHORE_INIT(name, n)					\
+#define __SEMAPHORE_INITIALIZER(name, n)					\
 {									\
 	.count		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
@@ -33,9 +33,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init(struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX(struct semaphore *sem)
diff --git a/include/asm-avr32/semaphore.h b/include/asm-avr32/semaphore.h
index ef99ddc..7391408 100644
--- a/include/asm-avr32/semaphore.h
+++ b/include/asm-avr32/semaphore.h
@@ -40,9 +40,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-i386/semaphore.h b/include/asm-i386/semaphore.h
index 4e34a46..0945d0f 100644
--- a/include/asm-i386/semaphore.h
+++ b/include/asm-i386/semaphore.h
@@ -63,15 +63,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-m32r/semaphore.h b/include/asm-m32r/semaphore.h
index 41e45d7..d114364 100644
--- a/include/asm-m32r/semaphore.h
+++ b/include/asm-m32r/semaphore.h
@@ -39,15 +39,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-mips/semaphore.h b/include/asm-mips/semaphore.h
index 3d6aa7c..cba043a 100644
--- a/include/asm-mips/semaphore.h
+++ b/include/asm-mips/semaphore.h
@@ -53,8 +53,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-powerpc/semaphore.h b/include/asm-powerpc/semaphore.h
index 57369d2..ca3ea7d 100644
--- a/include/asm-powerpc/semaphore.h
+++ b/include/asm-powerpc/semaphore.h
@@ -39,8 +39,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-s390/semaphore.h b/include/asm-s390/semaphore.h
index dbce058..ad8c949 100644
--- a/include/asm-s390/semaphore.h
+++ b/include/asm-s390/semaphore.h
@@ -37,8 +37,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sh/semaphore.h b/include/asm-sh/semaphore.h
index 489f784..209103d 100644
--- a/include/asm-sh/semaphore.h
+++ b/include/asm-sh/semaphore.h
@@ -41,15 +41,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sh64/semaphore.h b/include/asm-sh64/semaphore.h
index 4695264..b2f3f57 100644
--- a/include/asm-sh64/semaphore.h
+++ b/include/asm-sh64/semaphore.h
@@ -48,15 +48,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sparc/semaphore.h b/include/asm-sparc/semaphore.h
index f74ba31..79d4121 100644
--- a/include/asm-sparc/semaphore.h
+++ b/include/asm-sparc/semaphore.h
@@ -30,9 +30,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic24_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sparc64/semaphore.h b/include/asm-sparc64/semaphore.h
index 093dcc6..8a7c201 100644
--- a/include/asm-sparc64/semaphore.h
+++ b/include/asm-sparc64/semaphore.h
@@ -30,8 +30,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-x86_64/semaphore.h b/include/asm-x86_64/semaphore.h
index 1194888..504a3ac 100644
--- a/include/asm-x86_64/semaphore.h
+++ b/include/asm-x86_64/semaphore.h
@@ -64,15 +64,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-xtensa/semaphore.h b/include/asm-xtensa/semaphore.h
index f10c348..017d892 100644
--- a/include/asm-xtensa/semaphore.h
+++ b/include/asm-xtensa/semaphore.h
@@ -37,9 +37,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)


