Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272571AbTG1AmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272568AbTG1AEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:13 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272725AbTG0W6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:18 -0400
Date: Sun, 27 Jul 2003 21:19:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272019.h6RKJ1Et029763@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix 2 byte data leak due to padding
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/fs/stat.c linux-2.6.0-test2-ac1/fs/stat.c
--- linux-2.6.0-test2/fs/stat.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/fs/stat.c	2003-07-23 16:27:42.000000000 +0100
@@ -106,7 +106,7 @@
 {
 	static int warncount = 5;
 	struct __old_kernel_stat tmp;
-
+	
 	if (warncount > 0) {
 		warncount--;
 		printk(KERN_WARNING "VFS: Warning: %s using old stat() call. Recompile your binary.\n",
@@ -116,6 +116,7 @@
 		warncount = 0;
 	}
 
+	memset(&tmp, 0, sizeof(struct __old_kernel_stat));
 	tmp.st_dev = stat->dev;
 	tmp.st_ino = stat->ino;
 	tmp.st_mode = stat->mode;

