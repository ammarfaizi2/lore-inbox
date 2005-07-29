Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVG2TT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVG2TT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVG2TPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:15:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:38062 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262742AbVG2TPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:15:20 -0400
Date: Fri, 29 Jul 2005 12:14:28 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: [patch 04/29] DEBUG_FS must depend on SYSFS
Message-ID: <20050729191428.GF5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/lib/Kconfig.debug	2005-07-29 11:30:02.000000000 -0700
+++ gregkh-2.6/lib/Kconfig.debug	2005-07-29 11:33:58.000000000 -0700
@@ -141,7 +141,7 @@
 
 config DEBUG_FS
 	bool "Debug Filesystem"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && SYSFS
 	help
 	  debugfs is a virtual file system that kernel developers use to put
 	  debugging files into.  Enable this option to be able to read and

--
