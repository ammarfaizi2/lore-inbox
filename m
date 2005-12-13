Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVLMR5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVLMR5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVLMR5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:57:14 -0500
Received: from verein.lst.de ([213.95.11.210]:38355 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932427AbVLMR4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:56:52 -0500
Date: Tue, 13 Dec 2005 18:56:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] FS_NOATIME for ocfs
Message-ID: <20051213175646.GD17130@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OCFS is only in -mm so far, so here's a separate patch for the
FS_NOATIME in ocfs in case this patchkit goes in before ocfs is merged.

Although I think ocfs should still go into 2.6.15 a an additional driver
that stands on it's own..


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/fs/ocfs2/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/ocfs2/super.c	2005-12-12 18:51:17.000000000 +0100
+++ linux-2.6.15-rc5/fs/ocfs2/super.c	2005-12-13 11:14:40.000000000 +0100
@@ -677,7 +677,7 @@
 	.kill_sb        = kill_block_super, /* set to the generic one
 					     * right now, but do we
 					     * need to change that? */
-	.fs_flags       = FS_REQUIRES_DEV,
+	.fs_flags       = FS_REQUIRES_DEV | FS_NOATIME,
 	.next           = NULL
 };
 
@@ -1226,7 +1226,6 @@
 	sb->s_fs_info = osb;
 	sb->s_op = &ocfs2_sops;
 	sb->s_export_op = &ocfs2_export_ops;
-	sb->s_flags |= MS_NOATIME;
 	/* this is needed to support O_LARGEFILE */
 	sb->s_maxbytes = ocfs2_max_file_offset(sb->s_blocksize_bits);
 
