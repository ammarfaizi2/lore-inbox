Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVCXBKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVCXBKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVCXBKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:10:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262174AbVCXBKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:10:46 -0500
Date: Thu, 24 Mar 2005 02:10:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/attr.c: fix check after use
Message-ID: <20050324011043.GI1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/fs/attr.c.old	2005-03-23 04:44:40.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/fs/attr.c	2005-03-23 04:45:40.000000000 +0100
@@ -112,7 +112,7 @@
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
-	mode_t mode = inode->i_mode;
+	mode_t mode;
 	int error;
 	struct timespec now = current_fs_time(inode->i_sb);
 	unsigned int ia_valid = attr->ia_valid;
@@ -120,6 +120,8 @@
 	if (!inode)
 		BUG();
 
+	mode = inode->i_mode;
+
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
 		attr->ia_atime = now;

