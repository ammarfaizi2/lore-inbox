Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVGWWHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVGWWHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVGWWHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:07:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24836 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261902AbVGWWFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:05:32 -0400
Date: Sun, 24 Jul 2005 00:05:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: chrisw@osdl.org
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SECURITY must depend on SYSFS
Message-ID: <20050723220526.GN3160@stusta.de>
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

--- linux-2.6.13-rc3-mm1-full/security/Kconfig.old	2005-07-23 20:21:09.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/security/Kconfig	2005-07-23 20:22:22.000000000 +0200
@@ -35,6 +35,7 @@
 
 config SECURITY
 	bool "Enable different security models"
+	depends on SYSFS
 	help
 	  This allows you to choose different security modules to be
 	  configured into your kernel.

