Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbUKQSKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUKQSKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUKQSIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:08:09 -0500
Received: from peabody.ximian.com ([130.57.169.10]:39582 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262434AbUKQSFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:05:32 -0500
Subject: [patch] inotify: vfs_permission was replaced
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1100710677.6280.2.camel@betsy.boston.ximian.com>
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Wed, 17 Nov 2004 13:02:40 -0500
Message-Id: <1100714560.6280.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

In 2.6.10-rc, vfs_permission() was replaced by generic_permission(),
which also has a slightly changed behavior and argument list.

	Robert Love


vfs_permission was replaced by generic_permission in 2.6.10-rc.

Signed-Off-By: Robert Love <rml@novell.com>

 inotify.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -u linux/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux/drivers/char/inotify.c	2004-11-15 15:28:34.951248696 -0500
+++ linux/drivers/char/inotify.c	2004-11-16 14:42:11.929575168 -0500
@@ -163,7 +151,7 @@
 	inode = nd.dentry->d_inode;
 
 	/* you can only watch an inode if you have read permissions on it */
-	error = vfs_permission(inode, MAY_READ);
+	error = generic_permission(inode, MAY_READ, NULL);
 	if (error) {
 		inode = ERR_PTR(error);
 		goto release_and_out;


