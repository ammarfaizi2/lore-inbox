Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVK1TtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVK1TtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVK1TtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:49:18 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:17925 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932212AbVK1TtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:49:17 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1EgoyM-0006uH-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 28 Nov 2005 20:47:34 +0100)
Subject: [PATCH 5/7] fuse: bump interface version
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu> <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu> <E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu> <E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu> <E1EgoyM-0006uH-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1Egozl-0006uy-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 20:49:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change interface version to 7.4.

Following changes will need backward compatibility support, so store
the minor version returned by userspace.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2005-11-22 14:45:54.000000000 +0100
+++ linux/fs/fuse/dev.c	2005-11-28 12:02:10.000000000 +0100
@@ -178,6 +178,8 @@ static void request_end(struct fuse_conn
 		if (req->misc.init_in_out.major != FUSE_KERNEL_VERSION)
 			fc->conn_error = 1;
 
+		fc->minor = req->misc.init_in_out.minor;
+
 		/* After INIT reply is received other requests can go
 		   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
 		   up()s on outstanding_sem.  The last up() is done in
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2005-11-22 14:45:58.000000000 +0100
+++ linux/include/linux/fuse.h	2005-11-28 11:59:01.000000000 +0100
@@ -14,7 +14,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 3
+#define FUSE_KERNEL_MINOR_VERSION 4
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2005-11-22 14:45:54.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2005-11-28 12:02:36.000000000 +0100
@@ -272,6 +272,9 @@ struct fuse_conn {
 	/** Is create not implemented by fs? */
 	unsigned no_create : 1;
 
+	/** Negotiated minor version */
+	unsigned minor;
+
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 };
