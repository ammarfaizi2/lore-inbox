Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269040AbUJUF3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269040AbUJUF3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJUF1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:27:43 -0400
Received: from ozlabs.org ([203.10.76.45]:48852 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269040AbUJUFZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:25:13 -0400
Subject: Fix for MODULE_PARM obsolete
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098336290.10571.341.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 15:25:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Fix MODULE_PARM warning
Status: Trivial
Depends: Module/MODULE_PARM-warning.patch.gz
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

There is no __attribute_unused__: use __attribute__((__unused__)).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16175-linux-2.6-bk/include/linux/module.h .16175-linux-2.6-bk.updated/include/linux/module.h
--- .16175-linux-2.6-bk/include/linux/module.h	2004-10-21 14:29:08.000000000 +1000
+++ .16175-linux-2.6-bk.updated/include/linux/module.h	2004-10-21 14:31:38.000000000 +1000
@@ -570,7 +570,7 @@ extern void __deprecated MODULE_PARM_(vo
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
 { __stringify(var), type, &MODULE_PARM_ };
 #else
-#define MODULE_PARM(var,type) static void __attribute_unused__ *__parm_##var = &MODULE_PARM_;
+#define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
 #endif
 
 #define __MODULE_STRING(x) __stringify(x)

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

