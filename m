Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277021AbRJCX23>; Wed, 3 Oct 2001 19:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277022AbRJCX2T>; Wed, 3 Oct 2001 19:28:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:62985 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277021AbRJCX2E>;
	Wed, 3 Oct 2001 19:28:04 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.4.11-pre2 for EXPORT_SYMBOL_GPL()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Oct 2001 09:28:21 +1000
Message-ID: <5442.1002151701@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC's original EXPORT_SYMBOL_GPL() was incorrect, it has been fixed in
2.4.10-ac but not in 2.4.11-pre.  Patch against 2.4.11-pre2.

Index: 11-pre2.1/include/linux/module.h
--- 11-pre2.1/include/linux/module.h Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.4 644)
+++ 10.30/include/linux/module.h Tue, 02 Oct 2001 11:25:49 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.1.6 644)
@@ -366,10 +366,10 @@ __attribute__((section("__ksymtab"))) =	
 
 #define __EXPORT_SYMBOL_GPL(sym, str)			\
 const char __kstrtab_##sym[]				\
-__attribute__((section(".kstrtab"))) = str;		\
-const struct module_symbol __ksymtab_GPLONLY_##sym	\
+__attribute__((section(".kstrtab"))) = "GPLONLY_" str;	\
+const struct module_symbol __ksymtab_##sym		\
 __attribute__((section("__ksymtab"))) =			\
-{ (unsigned long)&sym, __kstrtab_GPLONLY_##sym }
+{ (unsigned long)&sym, __kstrtab_##sym }
 
 #if defined(MODVERSIONS) || !defined(CONFIG_MODVERSIONS)
 #define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(var))

