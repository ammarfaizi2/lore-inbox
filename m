Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277314AbRJEFfB>; Fri, 5 Oct 2001 01:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277316AbRJEFev>; Fri, 5 Oct 2001 01:34:51 -0400
Received: from zok.sgi.com ([204.94.215.101]:7582 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277314AbRJEFel>;
	Fri, 5 Oct 2001 01:34:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.4.11-pre4 EXPORT_SYMBOLS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 15:35:02 +1000
Message-ID: <3982.1002260102@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some developers are forgetting to update export-objs in the Makefile,
the bug is silent until somebody compiles with modversions.  This patch
catches missing Makefile changes.

Index: 11-pre4.1/include/linux/module.h
--- 11-pre4.1/include/linux/module.h Thu, 04 Oct 2001 16:23:36 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.5 644)
+++ 11-pre4.1(w)/include/linux/module.h Fri, 05 Oct 2001 15:26:43 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.5 644)
@@ -348,6 +348,13 @@ extern struct module *module_list;
 #define EXPORT_SYMBOL_NOVERS(var)  error config_must_be_included_before_module
 #define EXPORT_SYMBOL_GPL(var)  error config_must_be_included_before_module
 
+#elif !defined(EXPORT_SYMTAB)
+
+#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL(var)	   error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
+
 #elif !defined(CONFIG_MODULES)
 
 #define __EXPORT_SYMBOL(sym,str)


gcc -D__KERNEL__ -I/build/kaos/2.4.11-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe  -march=i686    -c -o gen_probe.o gen_probe.c
gen_probe.c:48: parse error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
gen_probe.c:48: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
gen_probe.c:48: warning: data definition has no type or storage class
make[4]: *** [gen_probe.o] Error 1


