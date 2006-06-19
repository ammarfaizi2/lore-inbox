Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWFSPbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWFSPbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWFSPbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:31:10 -0400
Received: from thunk.org ([69.25.196.29]:6282 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932474AbWFSPbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:31:09 -0400
Message-Id: <20060619153108.720582000@candygram.thunk.org>
References: <20060619152003.830437000@candygram.thunk.org>
Date: Mon, 19 Jun 2006 11:20:05 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 2/8] inode-diet: Move i_pipe into a union
Content-Disposition: inline; filename=inode-slim-2
From: Theodore Tso <tytso@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the i_pipe pointer into a union that will be shared with i_bdev
and i_cdev.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-18 19:37:39.000000000 -0400
+++ linux-2.6.17/include/linux/fs.h	2006-06-18 19:39:52.000000000 -0400
@@ -508,9 +508,10 @@
 #ifdef CONFIG_QUOTA
 	struct dquot		*i_dquot[MAXQUOTAS];
 #endif
-	/* These three should probably be a union */
 	struct list_head	i_devices;
-	struct pipe_inode_info	*i_pipe;
+	union {
+		struct pipe_inode_info	*i_pipe;
+	};
 	struct block_device	*i_bdev;
 	struct cdev		*i_cdev;
 	int			i_cindex;

--
