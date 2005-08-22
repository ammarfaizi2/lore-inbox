Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVHVUm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVHVUm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVHVUm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:42:27 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:15591 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751118AbVHVUm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:42:26 -0400
Date: Mon, 22 Aug 2005 18:20:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SECURITY must depend on SYSFS
Message-ID: <20050822162050.GC9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SECURITY=y and CONFIG_SYSFS=n results in the following compile 
error:

<--  snip  -->

...
  LD      vmlinux
security/built-in.o: In function `securityfs_init':
inode.c:(.init.text+0x1c2): undefined reference to `kernel_subsys'
make: *** [vmlinux] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 24 Jul 2005

--- linux-2.6.13-rc3-mm1-full/security/Kconfig.old	2005-07-23 20:21:09.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/security/Kconfig	2005-07-23 20:22:22.000000000 +0200
@@ -35,6 +35,7 @@
 
 config SECURITY
 	bool "Enable different security models"
+	depends on SYSFS
 	help
 	  This allows you to choose different security modules to be
 	  configured into your kernel.

