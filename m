Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVCEPjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVCEPjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVCEPid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:38:33 -0500
Received: from coderock.org ([193.77.147.115]:47523 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262130AbVCEPfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:55 -0500
Subject: [patch 09/12] include/linux/module.h - compile warning cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:35 +0100
Message-Id: <20050305153535.EFDCC1EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


, extinguish warning for module structure that is still 
live when module is compiled into the kernel; do this in one central 
place so all such type warnings are automatically taken care of

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/include/linux/module.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN include/linux/module.h~extinguish_warnings-include_linux_module.h include/linux/module.h
--- kj/include/linux/module.h~extinguish_warnings-include_linux_module.h	2005-03-05 16:12:03.000000000 +0100
+++ kj-domen/include/linux/module.h	2005-03-05 16:12:03.000000000 +0100
@@ -93,7 +93,10 @@ extern struct module __this_module;
 
 #else  /* !MODULE */
 
-#define MODULE_GENERIC_TABLE(gtype,name)
+#define MODULE_GENERIC_TABLE(gtype,name)			\
+extern const struct gtype##_id __not_mod_##name##_unused	\
+  __attribute__ ((unused, weak, alias(__stringify(name))))
+
 #define __MODULE_INFO(tag, name, info)
 #define THIS_MODULE ((struct module *)0)
 #endif
_
