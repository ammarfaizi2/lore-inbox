Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUAMBnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUAMBna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:43:30 -0500
Received: from palrel13.hp.com ([156.153.255.238]:28636 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263448AbUAMBnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:43:24 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16387.19770.848804.921771@napali.hpl.hp.com>
Date: Mon, 12 Jan 2004 17:43:22 -0800
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: make gcc 3.4 compilation work
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still need the attached "attribute((used))" declarations to get
"make modules_install" to work with the GCC pre-3.4.
Patch is relative to 2.6.1.

	--david

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/12 17:40:34-08:00 davidm@tiger.hpl.hp.com 
#   Add back __attribute_unused__ declarations which really are needed.
# 
# include/linux/moduleparam.h
#   2004/01/12 17:40:28-08:00 davidm@tiger.hpl.hp.com +1 -0
#   Add back __attribute_unused__ declarations which really are needed.
# 
# include/linux/module.h
#   2004/01/12 17:40:28-08:00 davidm@tiger.hpl.hp.com +3 -0
#   Add back __attribute_unused__ declarations which really are needed.
# 
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Mon Jan 12 17:41:33 2004
+++ b/include/linux/module.h	Mon Jan 12 17:41:33 2004
@@ -60,6 +60,7 @@
 #define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)					  \
 static const char __module_cat(name,__LINE__)[]				  \
+  __attribute_used__							  \
   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
@@ -142,6 +143,7 @@
 #define __CRC_SYMBOL(sym, sec)					\
 	extern void *__crc_##sym __attribute__((weak));		\
 	static const unsigned long __kcrctab_##sym		\
+	__attribute_used__					\
 	__attribute__((section("__kcrctab" sec), unused))	\
 	= (unsigned long) &__crc_##sym;
 #else
@@ -155,6 +157,7 @@
 	__attribute__((section("__ksymtab_strings")))		\
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
+	__attribute_used__					\
 	__attribute__((section("__ksymtab" sec), unused))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
diff -Nru a/include/linux/moduleparam.h b/include/linux/moduleparam.h
--- a/include/linux/moduleparam.h	Mon Jan 12 17:41:33 2004
+++ b/include/linux/moduleparam.h	Mon Jan 12 17:41:33 2004
@@ -52,6 +52,7 @@
 #define __module_param_call(prefix, name, set, get, arg, perm)		\
 	static char __param_str_##name[] __initdata = prefix #name;	\
 	static struct kernel_param const __param_##name			\
+	__attribute_used__						\
     __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
 	= { __param_str_##name, perm, set, get, arg }
 
