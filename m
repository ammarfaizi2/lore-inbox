Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265611AbSKEAvB>; Mon, 4 Nov 2002 19:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbSKEAvA>; Mon, 4 Nov 2002 19:51:00 -0500
Received: from dp.samba.org ([66.70.73.150]:28351 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265611AbSKEApi>;
	Mon, 4 Nov 2002 19:45:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module loader against 2.5.46: 6/9 
In-reply-to: Your message of "Tue, 05 Nov 2002 11:21:48 +1100."
             <20021105002215.8EEE22C0F8@lists.samba.org> 
Date: Tue, 05 Nov 2002 11:36:40 +1100
Message-Id: <20021105005214.046A22C155@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivially remove the #if 0 in module.c to enable the parameter parsing
for modules.

Linus, please apply.
Rusty.

Name: Parameter Implementation for modules
Author: Rusty Russell
Status: Tested on 2.5.38
Depends: Module/param.patch.gz

D: This activates parameter parsing for PARAM() declarations in modules.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31807-linux-2.5.43/kernel/module.c .31807-linux-2.5.43.updated/kernel/module.c
--- .31807-linux-2.5.43/kernel/module.c	2002-10-18 17:17:25.000000000 +1000
+++ .31807-linux-2.5.43.updated/kernel/module.c	2002-10-18 17:17:57.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/fcntl.h>
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/params.h>
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
