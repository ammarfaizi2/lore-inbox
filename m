Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSL3GMN>; Mon, 30 Dec 2002 01:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSL3GMN>; Mon, 30 Dec 2002 01:12:13 -0500
Received: from dp.samba.org ([66.70.73.150]:13757 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266721AbSL3GMM>;
	Mon, 30 Dec 2002 01:12:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor compile fix for some modules.
Date: Mon, 30 Dec 2002 17:20:19 +1100
Message-Id: <20021230062036.163372C24B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply trivial patch.

Expose declaration of __this_module outside #ifdef KBUILD_MODNAME
(which is not defined for objects included in two modules).

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-section-ordering/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	Mon Dec 30 15:30:15 2002
+++ working-2.5-bk-section-ordering/include/linux/module.h	Mon Dec 30 17:14:53 2002
@@ -285,7 +285,9 @@ static inline const char *module_address
 }
 #endif /* CONFIG_MODULES */
 
-#if defined(MODULE) && defined(KBUILD_MODNAME)
+#ifdef MODULE
+extern struct module __this_module;
+#ifdef KBUILD_MODNAME
 /* We make the linker do some of the work. */
 struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) = {
@@ -296,7 +298,8 @@ __attribute__((section(".gnu.linkonce.th
 	.exit = cleanup_module,
 #endif
 };
-#endif /* MODULE && KBUILD_MODNAME */
+#endif /* KBUILD_MODNAME */
+#endif /* MODULE */
 
 /* For archs to search exception tables */
 extern struct list_head extables;




--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
