Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSHFWvg>; Tue, 6 Aug 2002 18:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSHFWu0>; Tue, 6 Aug 2002 18:50:26 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:42250 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316408AbSHFWsO>; Tue, 6 Aug 2002 18:48:14 -0400
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] module cleanup (3/5)
Message-Id: <E17cDB7-0002v5-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 07 Aug 2002 00:51:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes __MODULE_STRING() in favour of __stringify().

diff -ur linux-2.5/include/linux/module.h linux-mod/include/linux/module.h
--- linux-2.5/include/linux/module.h	Thu Aug  1 16:43:07 2002
+++ linux-mod/include/linux/module.h	Thu Aug  1 14:41:01 2002
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/stringify.h>
 
 #include <asm/atomic.h>
 
@@ -147,11 +141,6 @@
 	(mod_member_present((mod), can_unload) && (mod)->can_unload	\
 	 ? (mod)->can_unload() : atomic_read(&(mod)->uc.usecount))
 
-/* Indirect stringification.  */
-
-#define __MODULE_STRING_1(x)	#x
-#define __MODULE_STRING(x)	__MODULE_STRING_1(x)
-
 /* Generic inter module communication.
  *
  * NOTE: This interface is intended for small amounts of data that are
@@ -221,12 +210,12 @@
 #define MODULE_PARM(var,type)			\
 const char __module_parm_##var[]		\
 __attribute__((section(".modinfo"))) =		\
-"parm_" __MODULE_STRING(var) "=" type
+"parm_" __stringify(var) "=" type
 
 #define MODULE_PARM_DESC(var,desc)		\
 const char __module_parm_desc_##var[]		\
 __attribute__((section(".modinfo"))) =		\
-"parm_desc_" __MODULE_STRING(var) "=" desc
+"parm_desc_" __stringify(var) "=" desc
 
 /*
  * MODULE_DEVICE_TABLE exports information about devices
@@ -392,7 +394,7 @@
  *         #include <linux/modversions.h>
  *         
  *         #define EXPORT_SYMBOL(var) \
- *          __EXPORT_SYMBOL(var, __MODULE_STRING(__VERSIONED_SYMBOL(var)))
+ *          __EXPORT_SYMBOL(var, __stringify(__VERSIONED_SYMBOL(var)))
  *
  *   The first two lines will in essence include
  *
@@ -468,17 +470,17 @@
 #define _set_ver(sym) sym
 #include <linux/modversions.h>
 
-#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(__VERSIONED_SYMBOL(var)))
-#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(__VERSIONED_SYMBOL(var)))
+#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __stringify(__VERSIONED_SYMBOL(var)))
+#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL(var, __stringify(__VERSIONED_SYMBOL(var)))
 
 #else /* !defined (CONFIG_MODVERSIONS) || defined(MODULE) */
 
-#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(var))
-#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL_GPL(var, __MODULE_STRING(var))
+#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __stringify(var))
+#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL_GPL(var, __stringify(var))
 
 #endif /* defined(CONFIG_MODVERSIONS) && !defined(MODULE) */
 
-#define EXPORT_SYMBOL_NOVERS(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(var))
+#define EXPORT_SYMBOL_NOVERS(var)  __EXPORT_SYMBOL(var, __stringify(var))
 
 #endif /* __GENKSYMS__ */
 
