Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVCPTeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVCPTeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVCPTea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:34:30 -0500
Received: from [205.233.219.253] ([205.233.219.253]:28556 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262765AbVCPTbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:31:10 -0500
Date: Wed, 16 Mar 2005 14:28:29 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       willy@debian.org, nathans@sgi.com
Subject: Re: [PATCH, RFC 2/4] Add sem_getcount on arches that lack it
Message-ID: <20050316192829.GA1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org> <20050311053144.GP1111@conscoop.ottawa.on.ca> <20050310215652.76c47856.akpm@osdl.org> <20050311122747.GL21986@parcelfarce.linux.theplanet.co.uk> <20050311170449.GS1111@conscoop.ottawa.on.ca> <20050316192709.GZ1111@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316192709.GZ1111@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds sem_getcount() to architectures that were missing it.  Renames
sema_count on arm for this purpose (sema_count has no current callers.)

Tested on i386, ia64, parisc.

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: 1394-dev/include/asm-h8300/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-h8300/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-h8300/semaphore.h	2005-03-15 17:26:51.000000000 -0500
@@ -59,6 +59,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_h8300);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-sh64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sh64/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-sh64/semaphore.h	2005-03-15 17:28:46.000000000 -0500
@@ -72,6 +72,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_sh64);
+}
+
 #if 0
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
Index: 1394-dev/include/asm-m68knommu/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m68knommu/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-m68knommu/semaphore.h	2005-03-15 17:27:30.000000000 -0500
@@ -59,6 +59,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_m68knommu);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-m32r/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m32r/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-m32r/semaphore.h	2005-03-15 17:27:12.000000000 -0500
@@ -64,6 +64,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_m32r);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-ia64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ia64/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-ia64/semaphore.h	2005-03-15 17:27:06.000000000 -0500
@@ -50,6 +50,11 @@ init_MUTEX_LOCKED (struct semaphore *sem
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_ia64);
+}
+
 extern void __down (struct semaphore * sem);
 extern int  __down_interruptible (struct semaphore * sem);
 extern int  __down_trylock (struct semaphore * sem);
Index: 1394-dev/include/asm-i386/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-i386/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-i386/semaphore.h	2005-03-15 17:27:00.000000000 -0500
@@ -87,6 +87,13 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+typedef atomic_t semcount_t;
+
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_i386);
+}
+
 fastcall void __down_failed(void /* special register calling convention */);
 fastcall int  __down_failed_interruptible(void  /* params in registers */);
 fastcall int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-sparc/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sparc/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-sparc/semaphore.h	2005-03-15 17:28:51.000000000 -0500
@@ -48,6 +48,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_sparc);
+}
+
 extern void __down(struct semaphore * sem);
 extern int __down_interruptible(struct semaphore * sem);
 extern int __down_trylock(struct semaphore * sem);
Index: 1394-dev/include/asm-x86_64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-x86_64/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-x86_64/semaphore.h	2005-03-15 17:29:10.000000000 -0500
@@ -88,6 +88,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_x86_64);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-ppc/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ppc/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-ppc/semaphore.h	2005-03-15 17:28:19.000000000 -0500
@@ -62,6 +62,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_ppc);
+}
+
 extern void __down(struct semaphore * sem);
 extern int  __down_interruptible(struct semaphore * sem);
 extern void __up(struct semaphore * sem);
Index: 1394-dev/include/asm-ppc64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ppc64/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-ppc64/semaphore.h	2005-03-15 17:28:24.000000000 -0500
@@ -56,6 +56,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_ppc64);
+}
+
 extern void __down(struct semaphore * sem);
 extern int  __down_interruptible(struct semaphore * sem);
 extern void __up(struct semaphore * sem);
Index: 1394-dev/include/asm-arm26/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-arm26/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-arm26/semaphore.h	2005-03-15 17:26:15.000000000 -0500
@@ -51,6 +51,11 @@ static inline void init_MUTEX_LOCKED(str
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_arm);
+}
+
 /*
  * special register calling convention
  */
Index: 1394-dev/include/asm-s390/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-s390/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-s390/semaphore.h	2005-03-15 17:28:35.000000000 -0500
@@ -53,6 +53,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_s390);
+}
+
 asmlinkage void __down(struct semaphore * sem);
 asmlinkage int  __down_interruptible(struct semaphore * sem);
 asmlinkage int  __down_trylock(struct semaphore * sem);
Index: 1394-dev/include/asm-m68k/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m68k/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-m68k/semaphore.h	2005-03-15 17:27:18.000000000 -0500
@@ -60,6 +60,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_m68k);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-arm/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-arm/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-arm/semaphore.h	2005-03-15 17:25:57.000000000 -0500
@@ -49,9 +49,9 @@ static inline void init_MUTEX_LOCKED(str
 	sema_init(sem, 0);
 }
 
-static inline int sema_count(struct semaphore *sem)
+static inline int sem_getcount(struct semaphore *sem)
 {
-	return atomic_read(&sem->count);
+	return atomic_read(&sem->count_arm);
 }
 
 /*
Index: 1394-dev/include/asm-sparc64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sparc64/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-sparc64/semaphore.h	2005-03-15 17:28:56.000000000 -0500
@@ -47,6 +47,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_sparc64);
+}
+
 extern void up(struct semaphore *sem);
 extern void down(struct semaphore *sem);
 extern int down_trylock(struct semaphore *sem);
Index: 1394-dev/include/asm-sh/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sh/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-sh/semaphore.h	2005-03-15 17:28:40.000000000 -0500
@@ -65,6 +65,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_sh);
+}
+
 #if 0
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
Index: 1394-dev/include/asm-mips/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-mips/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-mips/semaphore.h	2005-03-15 17:27:35.000000000 -0500
@@ -70,6 +70,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_mips);
+}
+
 extern void __down(struct semaphore * sem);
 extern int  __down_interruptible(struct semaphore * sem);
 extern void __up(struct semaphore * sem);
Index: 1394-dev/include/asm-alpha/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-alpha/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-alpha/semaphore.h	2005-03-15 17:25:48.000000000 -0500
@@ -57,6 +57,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem.count_alpha);
+}
+
 extern void down(struct semaphore *);
 extern void __down_failed(struct semaphore *);
 extern int  down_interruptible(struct semaphore *);
Index: 1394-dev/include/asm-cris/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-cris/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-cris/semaphore.h	2005-03-15 17:26:26.000000000 -0500
@@ -57,6 +57,11 @@ extern inline void init_MUTEX_LOCKED (st
         sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_cris);
+}
+
 extern void __down(struct semaphore * sem);
 extern int __down_interruptible(struct semaphore * sem);
 extern int __down_trylock(struct semaphore * sem);
Index: 1394-dev/include/asm-v850/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-v850/semaphore.h	2005-03-15 17:24:16.000000000 -0500
+++ 1394-dev/include/asm-v850/semaphore.h	2005-03-15 17:29:02.000000000 -0500
@@ -42,6 +42,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init (sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count_v850);
+}
+
 /*
  * special register calling convention
  */
