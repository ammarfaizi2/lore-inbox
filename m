Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVJVQJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVJVQJc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVJVQJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:09:31 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:24841 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751358AbVJVQJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:09:31 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: [PATCH 2.6.14-rc5] uml: fix compile failure for TT mode 
Message-Id: <E1ETLuw-0003OU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 22 Oct 2005 18:08:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, uml compile fails with:

  LD      .tmp_vmlinux1
arch/um/kernel/built-in.o: In function `config_gdb_cb':
arch/um/kernel/tt/gdb.c:129: undefined reference to `TASK_EXTERN_PID'

Tested on i386, but fix needed on x86_64 too AFAICS.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/arch/um/include/sysdep-i386/thread.h
===================================================================
--- linux.orig/arch/um/include/sysdep-i386/thread.h	2005-10-22 17:45:55.000000000 +0200
+++ linux/arch/um/include/sysdep-i386/thread.h	2005-10-22 17:55:44.000000000 +0200
@@ -4,7 +4,7 @@
 #include <kern_constants.h>
 
 #define TASK_DEBUGREGS(task) ((unsigned long *) &(((char *) (task))[HOST_TASK_DEBUGREGS]))
-#ifdef CONFIG_MODE_TT
+#ifdef UML_CONFIG_MODE_TT
 #define TASK_EXTERN_PID(task) *((int *) &(((char *) (task))[HOST_TASK_EXTERN_PID]))
 #endif
 
Index: linux/arch/um/include/sysdep-x86_64/thread.h
===================================================================
--- linux.orig/arch/um/include/sysdep-x86_64/thread.h	2005-10-22 17:09:00.000000000 +0200
+++ linux/arch/um/include/sysdep-x86_64/thread.h	2005-10-22 17:55:58.000000000 +0200
@@ -3,7 +3,7 @@
 
 #include <kern_constants.h>
 
-#ifdef CONFIG_MODE_TT
+#ifdef UML_CONFIG_MODE_TT
 #define TASK_EXTERN_PID(task) *((int *) &(((char *) (task))[HOST_TASK_EXTERN_PID]))
 #endif
 

