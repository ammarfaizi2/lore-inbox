Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271674AbTGRCBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271680AbTGRCBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:01:05 -0400
Received: from dp.samba.org ([66.70.73.150]:27014 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271674AbTGRCBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:01:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make rmmod -f taint kernel.
Date: Fri, 18 Jul 2003 12:06:52 +1000
Message-Id: <20030718021559.0CF2A2C54F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial, but somehow this got lost.  Mark kernel as tainted when a
kernel removal is forced.

Name: Make force taint kernel.
Author: Rusty Russell
Status: Tested on 2.5.56

D: Somehow, the code which taints the kernel when rmmod -f is used got
D: lost.  Restore it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1819-linux-2.5.69-bk3/kernel/module.c .1819-linux-2.5.69-bk3.updated/kernel/module.c
--- .1819-linux-2.5.69-bk3/kernel/module.c	2003-05-05 12:37:13.000000000 +1000
+++ .1819-linux-2.5.69-bk3.updated/kernel/module.c	2003-05-09 17:22:52.000000000 +1000
@@ -447,7 +447,10 @@ static void free_module(struct module *m
 #ifdef CONFIG_MODULE_FORCE_UNLOAD
 static inline int try_force(unsigned int flags)
 {
-	return (flags & O_TRUNC);
+	int ret = (flags & O_TRUNC);
+	if (ret)
+		tainted |= TAINT_FORCED_MODULE;
+	return ret;
 }
 #else
 static inline int try_force(unsigned int flags)



--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
