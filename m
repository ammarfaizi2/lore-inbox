Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbSIYD1z>; Tue, 24 Sep 2002 23:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261901AbSIYD0Y>; Tue, 24 Sep 2002 23:26:24 -0400
Received: from dp.samba.org ([66.70.73.150]:49024 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261902AbSIYDQs>;
	Tue, 24 Sep 2002 23:16:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 10/20: Parameter Support for Modules
Date: Wed, 25 Sep 2002 13:02:38 +1000
Message-Id: <20020925032201.DFD9B2C157@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Parameter Implementation for modules
Author: Rusty Russell
Status: Tested on 2.5.38
Depends: Module/modbase-try-i386.patch.gz

D: This activates parameter parsing for PARAM() declarations in modules.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29380-linux-2.5.36/kernel/module.c .29380-linux-2.5.36.updated/kernel/module.c
--- .29380-linux-2.5.36/kernel/module.c	2002-09-20 17:20:40.000000000 +1000
+++ .29380-linux-2.5.36.updated/kernel/module.c	2002-09-20 17:21:25.000000000 +1000
@@ -809,8 +809,7 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
-#if 0 /* Needs param support */
-	/* Size of section 0 is 0, so this works well */
+	/* Size of section 0 is 0, so this works well if no params */
 	err = parse_args(mod->args,
 			 (struct kernel_param *)
 			 sechdrs[setupindex].sh_offset,
@@ -819,7 +818,6 @@ static struct module *load_module(void *
 			 NULL);
 	if (err < 0)
 		goto cleanup;
-#endif
 
 	/* Get rid of temporary copy */
 	vfree(hdr);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
