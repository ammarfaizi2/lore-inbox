Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270245AbUJTIDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270245AbUJTIDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270004AbUJTH64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:58:56 -0400
Received: from ozlabs.org ([203.10.76.45]:44977 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269883AbUJTHm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:42:56 -0400
Subject: [PATCH 1/2] MODULE_PARM must die: make it warn first.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098258172.10571.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 17:42:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Warn on use of MODULE_PARM
Status: Trivial
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

This patch adds a warning whenever MODULE_PARM is used.  Successive
patches change them over to module_param.  Help appreciated!

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/include/linux/module.h .22800-linux-2.6-bk.updated/include/linux/module.h
--- .22800-linux-2.6-bk/include/linux/module.h	2004-10-20 15:15:30.000000000 +1000
+++ .22800-linux-2.6-bk.updated/include/linux/module.h	2004-10-20 17:11:39.000000000 +1000
@@ -562,13 +562,15 @@ struct obsolete_modparm {
 	char type[64-sizeof(void *)];
 	void *addr;
 };
+
+extern void __deprecated MODULE_PARM_(void);
 #ifdef MODULE
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type };
+{ __stringify(var), type, &MODULE_PARM_ };
 #else
-#define MODULE_PARM(var,type)
+#define MODULE_PARM(var,type) static void __attribute_unused__ *__parm_##var = &MODULE_PARM_;
 #endif
 
 #define __MODULE_STRING(x) __stringify(x)

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

