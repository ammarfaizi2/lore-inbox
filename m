Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUDCEZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 23:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUDCEZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 23:25:05 -0500
Received: from waste.org ([209.173.204.2]:55021 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261580AbUDCEZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 23:25:00 -0500
Date: Fri, 2 Apr 2004 22:24:55 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] shrink inode when quota is disabled
Message-ID: <20040403042454.GW6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drop quota array in inode struct if no quota support


 tiny-mpm/fs/inode.c         |    2 ++
 tiny-mpm/include/linux/fs.h |    2 ++
 2 files changed, 4 insertions(+)

Index: tiny/include/linux/fs.h
===================================================================
--- tiny.orig/include/linux/fs.h	2004-04-02 20:24:36.000000000 -0600
+++ tiny/include/linux/fs.h	2004-04-02 20:28:07.000000000 -0600
@@ -403,7 +403,9 @@
 	struct file_lock	*i_flock;
 	struct address_space	*i_mapping;
 	struct address_space	i_data;
+#ifdef CONFIG_QUOTA
 	struct dquot		*i_dquot[MAXQUOTAS];
+#endif
 	/* These three should probably be a union */
 	struct list_head	i_devices;
 	struct pipe_inode_info	*i_pipe;
Index: tiny/fs/inode.c
===================================================================
--- tiny.orig/fs/inode.c	2004-04-02 20:24:35.000000000 -0600
+++ tiny/fs/inode.c	2004-04-02 20:28:07.000000000 -0600
@@ -126,7 +126,9 @@
 		inode->i_blocks = 0;
 		inode->i_bytes = 0;
 		inode->i_generation = 0;
+#ifdef CONFIG_QUOTA
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
+#endif
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
