Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269201AbUISJt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269201AbUISJt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 05:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269203AbUISJt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 05:49:58 -0400
Received: from verein.lst.de ([213.95.11.210]:15529 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269201AbUISJt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 05:49:56 -0400
Date: Sun, 19 Sep 2004 11:49:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
Message-ID: <20040919094939.GA5626@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They've been marked deprecated since 2.5.x and there's no more users.


--- 1.79/include/linux/module.h	2004-06-27 09:19:28 +02:00
+++ edited/include/linux/module.h	2004-09-12 18:40:16 +02:00
@@ -550,30 +550,8 @@
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
 { __stringify(var), type };
-
-static inline void __deprecated MOD_INC_USE_COUNT(struct module *module)
-{
-	__unsafe(module);
-
-#if defined(CONFIG_MODULE_UNLOAD) && defined(MODULE)
-	local_inc(&module->ref[get_cpu()].count);
-	put_cpu();
-#else
-	(void)try_module_get(module);
-#endif
-}
-
-static inline void __deprecated MOD_DEC_USE_COUNT(struct module *module)
-{
-	module_put(module);
-}
-
-#define MOD_INC_USE_COUNT	MOD_INC_USE_COUNT(THIS_MODULE)
-#define MOD_DEC_USE_COUNT	MOD_DEC_USE_COUNT(THIS_MODULE)
 #else
 #define MODULE_PARM(var,type)
-#define MOD_INC_USE_COUNT	do { } while (0)
-#define MOD_DEC_USE_COUNT	do { } while (0)
 #endif
 
 #define __MODULE_STRING(x) __stringify(x)
