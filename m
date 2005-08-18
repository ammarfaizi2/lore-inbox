Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVHRAOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVHRAOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVHRAOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:14:40 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:49263 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751387AbVHRAOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=qEgztLeFzU47Oe16SvLTG+uep47qFF9e+djq8PDoObuIhuFmSPfsAUnjMZpMhbNAXGcwkWoJJpKRD8si5ZfTEQEC6ZM6TNUr34PRNJyMc7evWr2lPlYTlkSGIbltt+14mun360ELMWIpVtACcChR/7FcSNLKZBOE5zQubStpMeQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] rename locking functions - do the rename
Date: Thu, 18 Aug 2005 02:07:14 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508180207.14574.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames sema_init to init_sema, init_MUTEX to init_mutex and
init_MUTEX_LOCKED to init_mutex_locked  and at the same time creates 3 
(deprecated) wrapper functions with the old names.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/asm-alpha/semaphore.h     |   31 ++++++++++++++++++++++++++-----
 include/asm-arm/semaphore.h       |   31 ++++++++++++++++++++++++++-----
 include/asm-arm26/semaphore.h     |   31 ++++++++++++++++++++++++++-----
 include/asm-cris/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-frv/semaphore.h       |   31 ++++++++++++++++++++++++++-----
 include/asm-h8300/semaphore.h     |   31 ++++++++++++++++++++++++++-----
 include/asm-i386/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-ia64/semaphore.h      |   34 ++++++++++++++++++++++++++--------
 include/asm-m32r/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-m68k/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-m68knommu/semaphore.h |   31 ++++++++++++++++++++++++++-----
 include/asm-mips/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-parisc/semaphore.h    |   31 ++++++++++++++++++++++++++-----
 include/asm-ppc/semaphore.h       |   31 ++++++++++++++++++++++++++-----
 include/asm-ppc64/semaphore.h     |   31 ++++++++++++++++++++++++++-----
 include/asm-s390/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-sh/semaphore.h        |   31 ++++++++++++++++++++++++++-----
 include/asm-sh64/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-sparc/semaphore.h     |   31 ++++++++++++++++++++++++++-----
 include/asm-sparc64/semaphore.h   |   31 ++++++++++++++++++++++++++-----
 include/asm-v850/semaphore.h      |   31 ++++++++++++++++++++++++++-----
 include/asm-x86_64/semaphore.h    |   31 ++++++++++++++++++++++++++-----
 include/asm-xtensa/semaphore.h    |   31 ++++++++++++++++++++++++++-----
 23 files changed, 598 insertions(+), 118 deletions(-)

diff -upr linux-2.6.13-rc6-git9-orig/include/asm-alpha/semaphore.h linux-2.6.13-rc6-git9/include/asm-alpha/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-alpha/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-alpha/semaphore.h	2005-08-18 00:35:35.000000000 +0200
@@ -35,7 +35,7 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init(struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	/*
 	 * Logically, 
@@ -47,14 +47,35 @@ static inline void sema_init(struct sema
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void down(struct semaphore *);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-arm/semaphore.h linux-2.6.13-rc6-git9/include/asm-arm/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-arm/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-arm/semaphore.h	2005-08-18 00:36:21.000000000 +0200
@@ -32,21 +32,42 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init(struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX(struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED(struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 static inline int sema_count(struct semaphore *sem)
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-arm26/semaphore.h linux-2.6.13-rc6-git9/include/asm-arm26/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-arm26/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-arm26/semaphore.h	2005-08-18 00:37:08.000000000 +0200
@@ -34,21 +34,42 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init(struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX(struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED(struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 /*
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-cris/semaphore.h linux-2.6.13-rc6-git9/include/asm-cris/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-cris/semaphore.h	2005-08-17 21:52:03.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-cris/semaphore.h	2005-08-18 00:37:40.000000000 +0200
@@ -42,19 +42,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init(struct semaphore *sem, int val)
+extern inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }
 
-extern inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-        sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-extern inline void init_MUTEX_LOCKED (struct semaphore *sem)
+extern inline void init_mutex(struct semaphore *sem)
 {
-        sema_init(sem, 0);
+        init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+extern inline void init_mutex_locked(struct semaphore *sem)
+{
+        init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void __down(struct semaphore * sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-frv/semaphore.h linux-2.6.13-rc6-git9/include/asm-frv/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-frv/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-frv/semaphore.h	2005-08-17 23:54:33.000000000 +0200
@@ -56,19 +56,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER(*sem, val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void __down(struct semaphore *sem, unsigned long flags);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-h8300/semaphore.h linux-2.6.13-rc6-git9/include/asm-h8300/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-h8300/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-h8300/semaphore.h	2005-08-18 00:05:34.000000000 +0200
@@ -44,19 +44,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER(*sem, val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 asmlinkage void __down_failed(void /* special register calling convention */);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-i386/semaphore.h linux-2.6.13-rc6-git9/include/asm-i386/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-i386/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-i386/semaphore.h	2005-08-18 00:06:59.000000000 +0200
@@ -64,7 +64,7 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 /*
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
@@ -77,14 +77,35 @@ static inline void sema_init (struct sem
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 fastcall void __down_failed(void /* special register calling convention */);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-ia64/semaphore.h linux-2.6.13-rc6-git9/include/asm-ia64/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-ia64/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-ia64/semaphore.h	2005-08-18 00:09:14.000000000 +0200
@@ -32,22 +32,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
-static inline void
-sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER(*sem, val);
 }
 
-static inline void
-init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void
-init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
+{
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_mutex_locked(sem);
 }
 
 extern void __down (struct semaphore * sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-m32r/semaphore.h linux-2.6.13-rc6-git9/include/asm-m32r/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-m32r/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-m32r/semaphore.h	2005-08-18 00:11:40.000000000 +0200
@@ -41,7 +41,7 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 /*
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
@@ -54,14 +54,35 @@ static inline void sema_init (struct sem
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 asmlinkage void __down_failed(void /* special register calling convention */);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-m68k/semaphore.h linux-2.6.13-rc6-git9/include/asm-m68k/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-m68k/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-m68k/semaphore.h	2005-08-18 00:13:09.000000000 +0200
@@ -45,19 +45,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init(struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER(*sem, val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 asmlinkage void __down_failed(void /* special register calling convention */);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-m68knommu/semaphore.h linux-2.6.13-rc6-git9/include/asm-m68knommu/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-m68knommu/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-m68knommu/semaphore.h	2005-08-18 00:14:43.000000000 +0200
@@ -44,19 +44,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+extern inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER(*sem, val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 asmlinkage void __down_failed(void /* special register calling convention */);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-mips/semaphore.h linux-2.6.13-rc6-git9/include/asm-mips/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-mips/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-mips/semaphore.h	2005-08-18 00:15:58.000000000 +0200
@@ -54,20 +54,41 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void __down(struct semaphore * sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-parisc/semaphore.h linux-2.6.13-rc6-git9/include/asm-parisc/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-parisc/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-parisc/semaphore.h	2005-08-18 00:17:32.000000000 +0200
@@ -58,19 +58,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+extern inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 static inline int sem_getcount(struct semaphore *sem)
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-ppc/semaphore.h linux-2.6.13-rc6-git9/include/asm-ppc/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-ppc/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-ppc/semaphore.h	2005-08-18 00:19:10.000000000 +0200
@@ -46,20 +46,41 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void __down(struct semaphore * sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-ppc64/semaphore.h linux-2.6.13-rc6-git9/include/asm-ppc64/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-ppc64/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-ppc64/semaphore.h	2005-08-18 00:20:51.000000000 +0200
@@ -40,20 +40,41 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void __down(struct semaphore * sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-s390/semaphore.h linux-2.6.13-rc6-git9/include/asm-s390/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-s390/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-s390/semaphore.h	2005-08-18 00:22:23.000000000 +0200
@@ -38,19 +38,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER((*sem),val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 asmlinkage void __down(struct semaphore * sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-sh/semaphore.h linux-2.6.13-rc6-git9/include/asm-sh/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-sh/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-sh/semaphore.h	2005-08-18 00:24:07.000000000 +0200
@@ -42,7 +42,7 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 /*
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
@@ -55,14 +55,35 @@ static inline void sema_init (struct sem
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 #if 0
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-sh64/semaphore.h linux-2.6.13-rc6-git9/include/asm-sh64/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-sh64/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-sh64/semaphore.h	2005-08-18 00:25:41.000000000 +0200
@@ -49,7 +49,7 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 /*
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
@@ -62,14 +62,35 @@ static inline void sema_init (struct sem
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 #if 0
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-sparc/semaphore.h linux-2.6.13-rc6-git9/include/asm-sparc/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-sparc/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-sparc/semaphore.h	2005-08-18 00:27:18.000000000 +0200
@@ -31,21 +31,42 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	atomic24_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void __down(struct semaphore * sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-sparc64/semaphore.h linux-2.6.13-rc6-git9/include/asm-sparc64/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-sparc64/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-sparc64/semaphore.h	2005-08-18 00:28:45.000000000 +0200
@@ -31,20 +31,41 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 extern void up(struct semaphore *sem);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-v850/semaphore.h linux-2.6.13-rc6-git9/include/asm-v850/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-v850/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-v850/semaphore.h	2005-08-18 00:30:12.000000000 +0200
@@ -27,19 +27,40 @@ struct semaphore {
 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC (name,1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC (name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+extern inline void init_sema(struct semaphore *sem, int val)
 {
 	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init (sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init (sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 /*
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-x86_64/semaphore.h linux-2.6.13-rc6-git9/include/asm-x86_64/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-x86_64/semaphore.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-x86_64/semaphore.h	2005-08-18 00:31:40.000000000 +0200
@@ -65,7 +65,7 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-static inline void sema_init (struct semaphore *sem, int val)
+static inline void init_sema(struct semaphore *sem, int val)
 {
 /*
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
@@ -78,14 +78,35 @@ static inline void sema_init (struct sem
 	init_waitqueue_head(&sem->wait);
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 asmlinkage void __down_failed(void /* special register calling convention */);
diff -upr linux-2.6.13-rc6-git9-orig/include/asm-xtensa/semaphore.h linux-2.6.13-rc6-git9/include/asm-xtensa/semaphore.h
--- linux-2.6.13-rc6-git9-orig/include/asm-xtensa/semaphore.h	2005-08-17 21:52:06.000000000 +0200
+++ linux-2.6.13-rc6-git9/include/asm-xtensa/semaphore.h	2005-08-18 00:32:53.000000000 +0200
@@ -47,7 +47,7 @@ struct semaphore {
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
-extern inline void sema_init (struct semaphore *sem, int val)
+extern inline void init_sema(struct semaphore *sem, int val)
 {
 /*
  *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
@@ -62,14 +62,35 @@ extern inline void sema_init (struct sem
 #endif
 }
 
-static inline void init_MUTEX (struct semaphore *sem)
+/* sema_init has been renamed init_sema, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated sema_init(struct semaphore *sem, int val)
 {
-	sema_init(sem, 1);
+	init_sema(sem, val);
 }
 
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+static inline void init_mutex(struct semaphore *sem)
 {
-	sema_init(sem, 0);
+	init_sema(sem, 1);
+}
+
+/* init_MUTEX has been renamed init_mutex, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX(struct semaphore *sem)
+{
+	init_mutex(sem);
+}
+
+static inline void init_mutex_locked(struct semaphore *sem)
+{
+	init_sema(sem, 0);
+}
+
+/* init_MUTEX_LOCKED has been renamed init_mutex_locked, please use the new name.
+   This function will go away in the near future */
+static inline void __deprecated init_MUTEX_LOCKED(struct semaphore *sem)
+{
+	init_mutex_locked(sem);
 }
 
 asmlinkage void __down(struct semaphore * sem);


