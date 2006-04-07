Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWDGLDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWDGLDB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDGLDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:03:01 -0400
Received: from mail.renesas.com ([202.234.163.13]:19857 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S932431AbWDGLDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:03:00 -0400
Date: Fri, 07 Apr 2006 20:02:54 +0900 (JST)
Message-Id: <20060407.200254.468708675.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org,
       Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>
Subject: [PATCH 2.6.17-rc1-mm1] Remove unused prepare_to_switch macro
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes prepare_to_switch() macros.
It seems that they are no longer used in the kernel.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Cc: Mikael Starvik <starvik@axis.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Miles Bader <uclinux-v850@lsi.nec.co.jp>
Cc: Chris Zankel <chris@zankel.net>
---

 include/asm-cris/system.h   |    1 -
 include/asm-frv/system.h    |    2 --
 include/asm-h8300/system.h  |    2 --
 include/asm-m32r/system.h   |    4 ----
 include/asm-v850/system.h   |    2 --
 include/asm-xtensa/system.h |    2 --
 6 files changed, 13 deletions(-)

Index: linux-2.6.17-rc1-mm1/include/asm-cris/system.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-cris/system.h	2006-04-07 12:16:12.536648308 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-cris/system.h	2006-04-07 14:59:15.539846173 +0900
@@ -8,7 +8,6 @@
  */
 
 extern struct task_struct *resume(struct task_struct *prev, struct task_struct *next, int);
-#define prepare_to_switch()     do { } while(0)
 #define switch_to(prev,next,last) last = resume(prev,next, \
 					 (int)&((struct task_struct *)0)->thread)
 
Index: linux-2.6.17-rc1-mm1/include/asm-frv/system.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-frv/system.h	2006-04-07 12:16:13.424508512 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-frv/system.h	2006-04-07 14:59:15.547844914 +0900
@@ -18,8 +18,6 @@
 
 struct thread_struct;
 
-#define prepare_to_switch()    do { } while(0)
-
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.
Index: linux-2.6.17-rc1-mm1/include/asm-h8300/system.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-h8300/system.h	2006-04-07 12:16:16.056094164 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-h8300/system.h	2006-04-07 14:59:15.559843026 +0900
@@ -4,8 +4,6 @@
 #include <linux/config.h> /* get configuration macros */
 #include <linux/linkage.h>
 
-#define prepare_to_switch()	do { } while(0)
-
 /*
  * switch_to(n) should switch tasks to task ptr, first checking that
  * ptr isn't the current task, in which case it does nothing.  This
Index: linux-2.6.17-rc1-mm1/include/asm-m32r/system.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-m32r/system.h	2006-04-07 12:16:21.918171168 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-m32r/system.h	2006-04-07 14:59:15.568841610 +0900
@@ -22,10 +22,6 @@
  * `next' and `prev' should be struct task_struct, but it isn't always defined
  */
 
-#ifndef CONFIG_SMP
-#define prepare_to_switch()  do { } while(0)
-#endif	/* not CONFIG_SMP */
-
 #define switch_to(prev, next, last)  do { \
 	register unsigned long  arg0 __asm__ ("r0") = (unsigned long)prev; \
 	register unsigned long  arg1 __asm__ ("r1") = (unsigned long)next; \
Index: linux-2.6.17-rc1-mm1/include/asm-v850/system.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-v850/system.h	2006-04-07 12:16:51.535507822 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-v850/system.h	2006-04-07 14:59:15.576840351 +0900
@@ -18,8 +18,6 @@
 #include <asm/ptrace.h>
 
 
-#define prepare_to_switch()	do { } while (0)
-
 /*
  * switch_to(n) should switch tasks to task ptr, first checking that
  * ptr isn't the current task, in which case it does nothing.
Index: linux-2.6.17-rc1-mm1/include/asm-xtensa/system.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-xtensa/system.h	2006-04-07 12:16:53.529193908 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-xtensa/system.h	2006-04-07 14:59:15.585838935 +0900
@@ -111,8 +111,6 @@ extern void *_switch_to(void *last, void
 
 #endif	/* __ASSEMBLY__ */
 
-#define prepare_to_switch()	do { } while(0)
-
 #define switch_to(prev,next,last)		\
 do {						\
 	clear_cpenable();			\

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

