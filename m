Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWCZM0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWCZM0b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWCZM0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:26:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63748 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751307AbWCZMZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:25:53 -0500
Date: Sun, 26 Mar 2006 14:25:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: joel.becker@oracle.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] CONFIGFS_FS must depend on SYSFS
Message-ID: <20060326122552.GM4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_SYSFS=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
fs/built-in.o: In function `configfs_init':mount.c:(.init.text+0x3d5d): undefined reference to `kernel_subsys'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-mm1-full/fs/Kconfig.old	2006-03-26 03:02:17.000000000 +0200
+++ linux-2.6.16-mm1-full/fs/Kconfig	2006-03-26 03:02:34.000000000 +0200
@@ -328,7 +328,7 @@
 
 config OCFS2_FS
 	tristate "OCFS2 file system support (EXPERIMENTAL)"
-	depends on NET && EXPERIMENTAL
+	depends on NET && SYSFS && EXPERIMENTAL
 	select CONFIGFS_FS
 	select JBD
 	select CRC32
@@ -863,7 +863,7 @@
 
 config CONFIGFS_FS
 	tristate "Userspace-driven configuration filesystem (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on SYSFS && EXPERIMENTAL
 	help
 	  configfs is a ram-based filesystem that provides the converse
 	  of sysfs's functionality. Where sysfs is a filesystem-based

