Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbUJXN0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbUJXN0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUJXNZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:25:47 -0400
Received: from verein.lst.de ([213.95.11.210]:18598 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261483AbUJXNXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:23:17 -0400
Date: Sun, 24 Oct 2004 15:23:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove page_follow_link
Message-ID: <20041024132310.GB19927@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

all filesystems have been switched to page_follow_link_light


--- 1.113/fs/namei.c	2004-10-19 11:40:20 +02:00
+++ edited/fs/namei.c	2004-10-23 14:44:12 +02:00
@@ -2388,18 +2403,6 @@
 	}
 }
 
-int page_follow_link(struct dentry *dentry, struct nameidata *nd)
-{
-	struct page *page = NULL;
-	char *s = page_getlink(dentry, &page);
-	int res = __vfs_follow_link(nd, s);
-	if (page) {
-		kunmap(page);
-		page_cache_release(page);
-	}
-	return res;
-}
-
 int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -2455,7 +2458,6 @@
 EXPORT_SYMBOL(lock_rename);
 EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(lookup_one_len);
-EXPORT_SYMBOL(page_follow_link);
 EXPORT_SYMBOL(page_follow_link_light);
 EXPORT_SYMBOL(page_put_link);
 EXPORT_SYMBOL(page_readlink);
--- 1.358/include/linux/fs.h	2004-10-20 10:37:21 +02:00
+++ edited/include/linux/fs.h	2004-10-23 14:43:40 +02:00
@@ -1524,7 +1524,6 @@
 extern int vfs_readlink(struct dentry *, char __user *, int, const char *);
 extern int vfs_follow_link(struct nameidata *, const char *);
 extern int page_readlink(struct dentry *, char __user *, int);
-extern int page_follow_link(struct dentry *, struct nameidata *);
 extern int page_follow_link_light(struct dentry *, struct nameidata *);
 extern void page_put_link(struct dentry *, struct nameidata *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
