Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267234AbSKPGYg>; Sat, 16 Nov 2002 01:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbSKPGYf>; Sat, 16 Nov 2002 01:24:35 -0500
Received: from dp.samba.org ([66.70.73.150]:1677 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267234AbSKPGYe>;
	Sat, 16 Nov 2002 01:24:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [PATCH] Export module_dummy_usage
Date: Sat, 16 Nov 2002 17:30:25 +1100
Message-Id: <20021116063131.92F752C0E2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch.  We keep a dummy use count for old code which wants to
know its own usecount using GET_USE_COUNT.  It needs to be exported.

Name: Export dummy_use_count
Author: Rusty Russell
Status: Trivial
Depends: Module/module.patch.gz

D: This exports dummy_use_count for the few cases of GET_USE_COUNT().
D: Thank to Doug Ledford for the bug report.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7740-linux-2.5-bk/kernel/module.c .7740-linux-2.5-bk.updated/kernel/module.c
--- .7740-linux-2.5-bk/kernel/module.c	2002-11-16 08:36:15.000000000 +1100
+++ .7740-linux-2.5-bk.updated/kernel/module.c	2002-11-16 17:28:07.000000000 +1100
@@ -1155,6 +1155,7 @@ static int __init init(void)
 
 /* Obsolete lvalue for broken code which asks about usage */
 int module_dummy_usage = 1;
+EXPORT_SYMBOL(module_dummy_usage);
 
 /* Call this at boot */
 __initcall(init);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
