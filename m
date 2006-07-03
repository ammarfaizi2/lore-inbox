Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWGCBAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWGCBAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWGCBAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:00:25 -0400
Received: from thunk.org ([69.25.196.29]:2500 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750927AbWGCBAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:24 -0400
Message-Id: <20060703010022.214109000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/8] inode-diet: Move i_pipe into a union
Content-Disposition: inline; filename=inode-slim-2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the i_pipe pointer into a union that will be shared with i_bdev
and i_cdev.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:28:45.000000000 -0400
@@ -523,9 +523,10 @@
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
