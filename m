Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTBNUXO>; Fri, 14 Feb 2003 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTBNUXO>; Fri, 14 Feb 2003 15:23:14 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19075 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267411AbTBNUXI>; Fri, 14 Feb 2003 15:23:08 -0500
Message-Id: <200302142032.h1EKWvwZ026208@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make the world safe for -Wundef
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1186688774P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Feb 2003 15:32:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1186688774P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-11867226740"

This is a multipart MIME message.

--==_Exmh_-11867226740
Content-Type: text/plain; charset=us-ascii

This is a patch to clean things up so compiling with -Wundef becomes
feasible (This patch cuts the number of warnings with 'make allyesconfig'
drop from around 10,000 to several hundred).  It was originally inspired
by the discussion of things that include linux/version.h but don't use
the contents - after doing this, I was able to find that there *WAS* at
least one place where version.h was missing (see following patch).


-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-11867226740
Content-Type: application/x-patch ; name="undef.patch"
Content-Description: undef.patch
Content-Disposition: attachment; filename="undef.patch"

--- linux-2.5.60/include/asm-i386/module.h.dist	2003-02-14 11:21:33.000000000 -0500
+++ linux-2.5.60/include/asm-i386/module.h	2003-02-14 11:52:31.000000000 -0500
@@ -12,39 +12,39 @@
 
 #ifdef CONFIG_M386
 #define MODULE_PROC_FAMILY "386 "
-#elif CONFIG_M486
+#elif defined CONFIG_M486
 #define MODULE_PROC_FAMILY "486 "
-#elif CONFIG_M586
+#elif defined CONFIG_M586
 #define MODULE_PROC_FAMILY "586 "
-#elif CONFIG_M586TSC
+#elif defined CONFIG_M586TSC
 #define MODULE_PROC_FAMILY "586TSC "
-#elif CONFIG_M586MMX
+#elif defined CONFIG_M586MMX
 #define MODULE_PROC_FAMILY "586MMX "
-#elif CONFIG_M686
+#elif defined CONFIG_M686
 #define MODULE_PROC_FAMILY "686 "
-#elif CONFIG_MPENTIUMII
+#elif defined CONFIG_MPENTIUMII
 #define MODULE_PROC_FAMILY "PENTIUMII "
-#elif CONFIG_MPENTIUMIII
+#elif defined CONFIG_MPENTIUMIII
 #define MODULE_PROC_FAMILY "PENTIUMIII "
-#elif CONFIG_MPENTIUM4
+#elif defined CONFIG_MPENTIUM4
 #define MODULE_PROC_FAMILY "PENTIUM4 "
-#elif CONFIG_MK6
+#elif defined CONFIG_MK6
 #define MODULE_PROC_FAMILY "K6 "
-#elif CONFIG_MK7
+#elif defined CONFIG_MK7
 #define MODULE_PROC_FAMILY "K7 "
-#elif CONFIG_MK8
+#elif defined CONFIG_MK8
 #define MODULE_PROC_FAMILY "K8 "
-#elif CONFIG_MELAN
+#elif defined CONFIG_MELAN
 #define MODULE_PROC_FAMILY "ELAN "
-#elif CONFIG_MCRUSOE
+#elif defined CONFIG_MCRUSOE
 #define MODULE_PROC_FAMILY "CRUSOE "
-#elif CONFIG_MWINCHIPC6
+#elif defined CONFIG_MWINCHIPC6
 #define MODULE_PROC_FAMILY "WINCHIPC6 "
-#elif CONFIG_MWINCHIP2
+#elif defined CONFIG_MWINCHIP2
 #define MODULE_PROC_FAMILY "WINCHIP2 "
-#elif CONFIG_MWINCHIP3D
+#elif defined CONFIG_MWINCHIP3D
 #define MODULE_PROC_FAMILY "WINCHIP3D "
-#elif CONFIG_MCYRIXIII
+#elif defined CONFIG_MCYRIXIII
 #define MODULE_PROC_FAMILY "CYRIXIII "
 #else
 #error unknown processor family
--- linux-2.5.60/include/asm-i386/page.h.dist	2003-02-14 11:26:38.000000000 -0500
+++ linux-2.5.60/include/asm-i386/page.h	2003-02-14 11:26:52.000000000 -0500
@@ -39,7 +39,7 @@
 /*
  * These are used to make use of C type-checking..
  */
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
--- linux-2.5.60/include/asm-i386/pgtable.h.dist	2003-02-14 11:55:12.000000000 -0500
+++ linux-2.5.60/include/asm-i386/pgtable.h	2003-02-14 11:55:39.000000000 -0500
@@ -39,7 +39,7 @@
  * newer 3-level PAE-mode page tables.
  */
 #ifndef __ASSEMBLY__
-#if CONFIG_X86_PAE
+#ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
 #else
 # include <asm/pgtable-2level.h>
@@ -79,7 +79,7 @@
 #define VMALLOC_START	(((unsigned long) high_memory + 2*VMALLOC_OFFSET-1) & \
 						~(VMALLOC_OFFSET-1))
 #define VMALLOC_VMADDR(x) ((unsigned long)(x))
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
 #else
 # define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
--- linux-2.5.60/include/asm-i386/processor.h.dist	2003-02-14 11:55:50.000000000 -0500
+++ linux-2.5.60/include/asm-i386/processor.h	2003-02-14 11:56:11.000000000 -0500
@@ -483,7 +483,7 @@
 	__asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
 }
 
-#elif CONFIG_X86_USE_3DNOW
+#elif defined CONFIG_X86_USE_3DNOW
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
--- linux-2.5.60/include/asm-i386/semaphore.h.dist	2003-02-14 11:18:56.000000000 -0500
+++ linux-2.5.60/include/asm-i386/semaphore.h	2003-02-14 11:19:54.000000000 -0500
@@ -45,12 +45,12 @@
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	long __magic;
 #endif
 };
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 # define __SEM_DEBUG_INIT(name) \
 		, (int)&(name).__magic
 #else
@@ -81,7 +81,7 @@
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	sem->__magic = (int)&sem->__magic;
 #endif
 }
@@ -113,7 +113,7 @@
  */
 static inline void down(struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	might_sleep();
@@ -139,7 +139,7 @@
 {
 	int result;
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	might_sleep();
@@ -167,7 +167,7 @@
 {
 	int result;
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 
@@ -195,7 +195,7 @@
  */
 static inline void up(struct semaphore * sem)
 {
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	__asm__ __volatile__(

--==_Exmh_-11867226740--


--==_Exmh_-1186688774P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+TVJ5cC3lWbTT17ARAlZ9AJ9U6q4B5mKCLgqCAcqQDT4pMn3LYQCgh/W4
w/Rrsyto8G8AJCp3Tf76dyk=
=is3C
-----END PGP SIGNATURE-----

--==_Exmh_-1186688774P--
