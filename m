Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbSKLRky>; Tue, 12 Nov 2002 12:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSKLRky>; Tue, 12 Nov 2002 12:40:54 -0500
Received: from dp.samba.org ([66.70.73.150]:19690 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266665AbSKLRku>;
	Tue, 12 Nov 2002 12:40:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] module_name()
Date: Wed, 13 Nov 2002 04:32:58 +1100
Message-Id: <20021112174741.6073E2C2B2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I prefer this: it also has the advantage of ensuring the name of
built-in modules is consistent across the kernel.

Thanks for the report,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.47-module-alias/crypto/api.c working-2.5.47-modname/crypto/api.c
--- working-2.5.47-module-alias/crypto/api.c	2002-11-11 20:00:55.000000000 +1100
+++ working-2.5.47-modname/crypto/api.c	2002-11-13 04:30:48.000000000 +1100
@@ -263,8 +263,7 @@ static int c_show(struct seq_file *m, vo
 	struct crypto_alg *alg = (struct crypto_alg *)p;
 	
 	seq_printf(m, "name         : %s\n", alg->cra_name);
-	seq_printf(m, "module       : %s\n", alg->cra_module ?
-					alg->cra_module->name : "[static]");
+	seq_printf(m, "module       : %s\n", module_name(alg->cra_module));
 	seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
 	
 	switch (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.47-module-alias/include/linux/module.h working-2.5.47-modname/include/linux/module.h
--- working-2.5.47-module-alias/include/linux/module.h	2002-11-12 22:43:55.000000000 +1100
+++ working-2.5.47-modname/include/linux/module.h	2002-11-13 04:31:16.000000000 +1100
@@ -293,6 +293,13 @@ static inline void module_put(struct mod
 
 #endif /* CONFIG_MODULE_UNLOAD */
 
+static inline char *module_name(struct module *module)
+{
+	if (module)
+		return module->name;
+	return "[built-in]";
+}
+
 #define __unsafe(mod)							     \
 do {									     \
 	if (mod && !(mod)->unsafe) {					     \
@@ -315,6 +322,10 @@ do {									     \
 #define try_module_get(module) 1
 #define module_put(module) do { } while(0)
 
+static inline char *module_name(struct module *module)
+{
+	Return "[built-in]";
+}
 #define __unsafe(mod)
 #endif /* CONFIG_MODULES */
 
