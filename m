Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTAWOrM>; Thu, 23 Jan 2003 09:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTAWOrM>; Thu, 23 Jan 2003 09:47:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:50076 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265277AbTAWOrL>; Thu, 23 Jan 2003 09:47:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
To: linux-kernel@vger.kernel.org
Subject: [patch] gcc-3.3 warns about 2.5.59 EXPORT_SYMBOL
Date: Thu, 23 Jan 2003 15:37:04 +0100
User-Agent: KMail/1.4.3
Organization: IBM Deutschland Entwicklung GmbH
Cc: Rusty Russell <rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301231537.04168.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building linux-2.5.59 with gcc-3.3 (on s390, if that matters),
I get a warning like "warning: `__ksymtab___foo' defined but 
not used" each time that EXPORT_SYMBOL is used.
The patch below fixes this.

	Arnd <><

--- ./include/linux/module.h	17 Jan 2003 13:46:37 -0000	1.15
+++ ./include/linux/module.h	23 Jan 2003 14:53:06 -0000
@@ -145,7 +145,7 @@
 	__attribute__((section("__ksymtab_strings")))		\
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__ksymtab")))			\
+	__attribute__((section("__ksymtab"),unused))		\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
@@ -155,7 +155,7 @@
 	__attribute__((section("__ksymtab_strings")))		\
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__gpl_ksymtab")))		\
+	__attribute__((section("__gpl_ksymtab"),unused))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 struct module_ref

