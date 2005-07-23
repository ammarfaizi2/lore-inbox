Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVGWWJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVGWWJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVGWWHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:07:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23044 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261897AbVGWWFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:05:25 -0400
Date: Sun, 24 Jul 2005 00:05:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DEBUG_FS must depend on SYSFS
Message-ID: <20050723220518.GL3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_FS=y and CONFIG_SYSFS=n results in the following compile 
error:

<--  snip  -->

...
  LD      vmlinux
fs/built-in.o: In function `debugfs_init':
inode.c:(.init.text+0x31be): undefined reference to `kernel_subsys'
make: *** [vmlinux] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/lib/Kconfig.debug.old	2005-07-23 22:20:35.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/lib/Kconfig.debug	2005-07-23 22:20:49.000000000 +0200
@@ -170,7 +170,7 @@
 
 config DEBUG_FS
 	bool "Debug Filesystem"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && SYSFS
 	help
 	  debugfs is a virtual file system that kernel developers use to put
 	  debugging files into.  Enable this option to be able to read and

