Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbSLSC0J>; Wed, 18 Dec 2002 21:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbSLSC0J>; Wed, 18 Dec 2002 21:26:09 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:10701 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267450AbSLSC0G>; Wed, 18 Dec 2002 21:26:06 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [v850]  Update v850 includes for slimmed-down sched.h
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021219023359.88CDD3702@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 19 Dec 2002 11:33:59 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds extra includes needed because sched.h doesn't include them anymore,
and removes includes of sched.h where they're not really necessary.

diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/irq.c arch/v850/kernel/irq.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/irq.c	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/kernel/irq.c	2002-12-19 11:18:38.000000000 +0900
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/random.h>
-#include <linux/sched.h>
 #include <linux/seq_file.h>
 
 #include <asm/system.h>
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/semaphore.c arch/v850/kernel/semaphore.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/semaphore.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/semaphore.c	2002-12-19 11:20:47.000000000 +0900
@@ -13,6 +13,7 @@
  * which was derived from the i386 version, linux/arch/i386/kernel/semaphore.c
  */
 
+#include <linux/errno.h>
 #include <linux/sched.h>
 
 #include <asm/semaphore.h>
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/setup.c arch/v850/kernel/setup.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/setup.c	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/kernel/setup.c	2002-12-19 11:19:21.000000000 +0900
@@ -11,7 +11,6 @@
  * Written by Miles Bader <miles@gnu.org>
  */
 
-#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/irq.h>
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/signal.c arch/v850/kernel/signal.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/signal.c	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/kernel/signal.c	2002-12-19 11:19:33.000000000 +0900
@@ -15,7 +15,6 @@
  * This file was derived from the sh version, arch/sh/kernel/signal.c
  */
 
-#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/syscalls.c arch/v850/kernel/syscalls.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/syscalls.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/syscalls.c	2002-12-19 11:19:39.000000000 +0900
@@ -17,7 +17,6 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/time.c arch/v850/kernel/time.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/time.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/time.c	2002-12-19 11:19:56.000000000 +0900
@@ -12,7 +12,6 @@
 
 #include <linux/config.h> /* CONFIG_HEARTBEAT */
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/param.h>
 #include <linux/string.h>
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/include/asm-v850/mmu_context.h include/asm-v850/mmu_context.h
--- ../orig/linux-2.5.52-uc0/include/asm-v850/mmu_context.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/mmu_context.h	2002-12-19 11:11:03.000000000 +0900
@@ -1,8 +1,6 @@
 #ifndef __V850_MMU_CONTEXT_H__
 #define __V850_MMU_CONTEXT_H__
 
-#include <linux/sched.h>
-
 #define destroy_context(mm)		((void)0)
 #define init_new_context(tsk,mm)	0
 #define switch_mm(prev,next,tsk,cpu)	((void)0)
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/include/asm-v850/uaccess.h include/asm-v850/uaccess.h
--- ../orig/linux-2.5.52-uc0/include/asm-v850/uaccess.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/uaccess.h	2002-12-17 17:23:49.000000000 +0900
@@ -4,7 +4,9 @@
 /*
  * User space memory access functions
  */
-#include <linux/sched.h>
+
+#include <linux/errno.h>
+#include <linux/string.h>
 
 #include <asm/segment.h>
 #include <asm/machdep.h>
