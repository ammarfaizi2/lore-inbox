Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbTIKGQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbTIKGQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:16:48 -0400
Received: from dp.samba.org ([66.70.73.150]:29116 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266130AbTIKGQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:16:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Missing module_arch_cleanup call
Date: Thu, 11 Sep 2003 15:29:21 +1000
Message-Id: <20030911061644.D1E422C105@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Always call module_arch_cleanup
Author: Rusty Russell
Status: Booted on 2.6.0-test5-bk1

D: Bug reported by Paul Mackerras: if a module parameter fails, we didn't
D: call module_arch_cleanup().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test5-bk1/kernel/module.c working-2.6.0-test5-bk1-module-greg-orig/kernel/module.c
--- linux-2.6.0-test5-bk1/kernel/module.c	2003-09-09 10:35:05.000000000 +1000
+++ working-2.6.0-test5-bk1-module-greg-orig/kernel/module.c	2003-09-11 15:14:32.000000000 +1000
@@ -1653,7 +1660,7 @@ static struct module *load_module(void _
 				 NULL);
 	}
 	if (err < 0)
-		goto cleanup;
+		goto arch_cleanup;
 
 	/* Get rid of temporary copy */
 	vfree(hdr);
@@ -1661,6 +1668,8 @@ static struct module *load_module(void _
 	/* Done! */
 	return mod;
 
+ arch_cleanup:
+	module_arch_cleanup(mod);
  cleanup:
 	module_unload_free(mod);
 	module_free(mod, mod->module_init);
