Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSL3MoS>; Mon, 30 Dec 2002 07:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSL3MoR>; Mon, 30 Dec 2002 07:44:17 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:50665 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S266939AbSL3MoQ>; Mon, 30 Dec 2002 07:44:16 -0500
Date: Mon, 30 Dec 2002 15:01:36 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: PATCH: module.h - silence "statement with no effect" warnings 2.5.53-bk
Message-ID: <20021230130136.GE25419@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.53-bk complains about "statement with no effect" in module.h in
multiple files including module.h. This patch shuts it up. 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.973   -> 1.974  
#	include/linux/module.h	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/30	mulix@alhambra.mulix.org	1.974
# get rid of "statement has no effect" warnings from gcc
# --------------------------------------------
#
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Mon Dec 30 14:10:56 2002
+++ b/include/linux/module.h	Mon Dec 30 14:10:56 2002
@@ -311,7 +311,7 @@
 	/*
 	 * Yes, we ignore the retval here, that's why it's deprecated.
 	 */
-	try_module_get(module);
+	(void)try_module_get(module);
 }
 
 static inline void __deprecated __MOD_DEC_USE_COUNT(struct module *module)
@@ -347,7 +347,7 @@
 	local_inc(&module->ref[get_cpu()].count);
 	put_cpu();
 #else
-	try_module_get(module);
+	(void)try_module_get(module);
 #endif
 }
 #define MOD_INC_USE_COUNT \

-- 
Muli Ben-Yehuda
