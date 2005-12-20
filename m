Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVLTOV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVLTOV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVLTOV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:21:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23051 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751070AbVLTOV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:21:26 -0500
Date: Tue, 20 Dec 2005 15:21:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: [2.6 patch] kernel/params.c: fix sysfs access with CONFIG_MODULES=n
Message-ID: <20051220142124.GE6789@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wessel <jason.wessel@windriver.com>

All the work was done to setup the file and maintain the file handles but
the access functions were zeroed out due to the #ifdef.  Removing the
#ifdef allows full access to all the parameters when CONFIG_MODULES=n.

akpm: put it back again, but use CONFIG_SYSFS instead.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- 

This patch was already sent on:
- 13 Dec 2005

This patch is 
fix-sysfs-access-to-module-parameters-with-config_modules\=n.patch
in -mm.

This patch is simple enough for getting it into 2.6.15 and I'm inclined 
to even submit it for -stable.

 kernel/params.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/params.c~fix-sysfs-access-to-module-parameters-with-config_modules=n kernel/params.c
--- devel/kernel/params.c~fix-sysfs-access-to-module-parameters-with-config_modules=n	2005-11-14 23:20:34.000000000 -0800
+++ devel-akpm/kernel/params.c	2005-11-14 23:20:51.000000000 -0800
@@ -619,7 +619,7 @@ static void __init param_sysfs_builtin(v
 
 
 /* module-related sysfs stuff */
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_SYSFS
 
 #define to_module_attr(n) container_of(n, struct module_attribute, attr);
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj);
_
