Return-Path: <linux-kernel-owner+w=401wt.eu-S1752531AbWLSF3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbWLSF3T (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 00:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbWLSF3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 00:29:19 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:51409 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbWLSF3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 00:29:18 -0500
Date: Mon, 18 Dec 2006 21:27:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] noinitramfs: correct initcall return type
Message-Id: <20061218212742.7123fc8f.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Use expected function return type to fix warning.
init/noinitramfs.c:42: warning: initialization from incompatible pointer type

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 init/noinitramfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.20-rc1-mm1.orig/init/noinitramfs.c
+++ linux-2.6.20-rc1-mm1/init/noinitramfs.c
@@ -29,7 +29,7 @@
 /*
  * Create a simple rootfs that is similar to the default initramfs
  */
-static void __init default_rootfs(void)
+static int __init default_rootfs(void)
 {
 	int mkdir_err = sys_mkdir("/dev", 0755);
 	int err = sys_mknod((const char __user *) "/dev/console",
@@ -38,5 +38,6 @@ static void __init default_rootfs(void)
 	if (err == -EROFS)
 		printk("Warning: Failed to create a rootfs\n");
 	mkdir_err = sys_mkdir("/root", 0700);
+	return 0;
 }
 rootfs_initcall(default_rootfs);


---
