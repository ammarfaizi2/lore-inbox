Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVBFXfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVBFXfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 18:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVBFXeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 18:34:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261330AbVBFXdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 18:33:16 -0500
Date: Mon, 7 Feb 2005 00:33:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/intermodule.c: make inter_module_get static
Message-ID: <20050206233313.GI3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no longer any user of inter_module_get outside of 
intermodule.c .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/module.h |    1 -
 kernel/intermodule.c   |    3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/include/linux/module.h.old	2004-12-12 02:53:34.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/module.h	2004-12-12 02:53:50.000000000 +0100
@@ -571,7 +571,6 @@
 extern void __deprecated inter_module_register(const char *,
 		struct module *, const void *);
 extern void __deprecated inter_module_unregister(const char *);
-extern const void * __deprecated inter_module_get(const char *);
 extern const void * __deprecated inter_module_get_request(const char *,
 		const char *);
 extern void __deprecated inter_module_put(const char *);
--- linux-2.6.10-rc2-mm4-full/kernel/intermodule.c.old	2004-12-12 02:53:57.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/intermodule.c	2004-12-12 02:54:17.000000000 +0100
@@ -113,7 +113,7 @@
  * Try to increment the use count on the owning module, if that fails
  * then return NULL.  Otherwise return the userdata.
  */
-const void *inter_module_get(const char *im_name)
+static const void *inter_module_get(const char *im_name)
 {
 	struct list_head *tmp;
 	struct inter_module_entry *ime;
@@ -178,6 +178,5 @@
 
 EXPORT_SYMBOL(inter_module_register);
 EXPORT_SYMBOL(inter_module_unregister);
-EXPORT_SYMBOL(inter_module_get);
 EXPORT_SYMBOL(inter_module_get_request);
 EXPORT_SYMBOL(inter_module_put);


