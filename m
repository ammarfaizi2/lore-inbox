Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTAGGYH>; Tue, 7 Jan 2003 01:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTAGGYH>; Tue, 7 Jan 2003 01:24:07 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:27017 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267309AbTAGGYG>; Tue, 7 Jan 2003 01:24:06 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH]  Quiet warnings for def of {_,}_MOD_INC_USE_COUNT when CONFIG_MODULE=n
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030107063239.27428374A@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  7 Jan 2003 15:32:39 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since `try_module_get(module)' is really just `1' when modules are
disabled, the compiler bitches.  As these definitions are inlines in a
header file, this results in a warning for every file that includes
modules.h.

diff -ruN -X../cludes linux-2.5.54-moo.orig/include/linux/module.h linux-2.5.54-moo/include/linux/module.h
--- linux-2.5.54-moo.orig/include/linux/module.h	2003-01-06 10:51:19.000000000 +0900
+++ linux-2.5.54-moo/include/linux/module.h	2003-01-06 16:30:28.000000000 +0900
@@ -314,7 +314,7 @@
 	/*
 	 * Yes, we ignore the retval here, that's why it's deprecated.
 	 */
-	try_module_get(module);
+	(void)try_module_get(module);
 }
 
 static inline void __deprecated __MOD_DEC_USE_COUNT(struct module *module)
@@ -350,7 +350,7 @@
 	local_inc(&module->ref[get_cpu()].count);
 	put_cpu();
 #else
-	try_module_get(module);
+	(void)try_module_get(module);
 #endif
 }
 #define MOD_INC_USE_COUNT \
