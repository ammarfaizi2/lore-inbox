Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSLBHBo>; Mon, 2 Dec 2002 02:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbSLBHA2>; Mon, 2 Dec 2002 02:00:28 -0500
Received: from dp.samba.org ([66.70.73.150]:16558 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265325AbSLBG7q>;
	Mon, 2 Dec 2002 01:59:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module parameters 2/3
Date: Mon, 02 Dec 2002 18:01:06 +1100
Message-Id: <20021202070715.712A42C131@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This puts support into modules for module_param().

Name: Parameter Implementation for modules
Author: Rusty Russell
Status: Tested on 2.5.50
Depends: Module/param.patch.gz

D: This activates parameter parsing for module_param() declarations in modules.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31807-linux-2.5.43/kernel/module.c .31807-linux-2.5.43.updated/kernel/module.c
--- .31807-linux-2.5.43/kernel/module.c	2002-10-18 17:17:25.000000000 +1000
+++ .31807-linux-2.5.43.updated/kernel/module.c	2002-10-18 17:17:57.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/fcntl.h>
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/moduleparam.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/pgalloc.h>
@@ -951,8 +952,7 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
-#if 0 /* Needs param support */
-	/* Size of section 0 is 0, so this works well */
+	/* Size of section 0 is 0, so this works well if no params */
 	err = parse_args(mod->args,
 			 (struct kernel_param *)
 			 sechdrs[setupindex].sh_offset,
@@ -961,7 +961,6 @@ static struct module *load_module(void *
 			 NULL);
 	if (err < 0)
 		goto cleanup;
-#endif
 
 	/* Get rid of temporary copy */
 	vfree(hdr);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
