Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUE1J2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUE1J2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUE1J2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:28:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:26526 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262425AbUE1J15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:27:57 -0400
Subject: [PATCH] fix non-existent /dev/adb in 2.6.7-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085736115.5584.150.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 19:21:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the lack of /dev/adb in kernel 2.6.7-rc1. The call to
devfs_mk_cdev() has probably been removed too soon.
Hope this one is better than the last one ;)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Colin Leroy <colin@colino.net>

--- drivers/macintosh/adb.c.orig	2004-05-25 21:08:10.000000000 +0200
+++ drivers/macintosh/adb.c	2004-05-28 09:08:56.580390376 +0200
@@ -900,6 +900,9 @@
 		printk(KERN_ERR "adb: unable to get major %d\n", ADB_MAJOR);
 		return;
 	}
+	
+	devfs_mk_cdev(MKDEV(ADB_MAJOR, 0), S_IFCHR | S_IRUSR | S_IWUSR, "adb"); 
+	
 	adb_dev_class = class_simple_create(THIS_MODULE, "adb");
 	if (IS_ERR(adb_dev_class)) {
 		return;
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

