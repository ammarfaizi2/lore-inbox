Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422959AbWBCVEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422959AbWBCVEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWBCVEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:04:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58381 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030243AbWBCVEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:04:48 -0500
Date: Fri, 3 Feb 2006 22:04:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/namei.c: make lookup_hash() static
Message-ID: <20060203210447.GM4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As announced, lookup_hash() can now become static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    7 -------
 fs/namei.c                                 |    3 +--
 include/linux/namei.h                      |    1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

--- linux-2.6.16-rc1-mm5-full/Documentation/feature-removal-schedule.txt.old	2006-02-03 16:44:06.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/Documentation/feature-removal-schedule.txt	2006-02-03 16:44:16.000000000 +0100
@@ -116,13 +116,6 @@
 
 ---------------------------
 
-What:	EXPORT_SYMBOL(lookup_hash)
-When:	January 2006
-Why:	Too low-level interface.  Use lookup_one_len or lookup_create instead.
-Who:	Christoph Hellwig <hch@lst.de>
-
----------------------------
-
 What:	CONFIG_FORCED_INLINING
 When:	June 2006
 Why:	Config option is there to see if gcc is good enough. (in january
--- linux-2.6.16-rc1-mm5-full/include/linux/namei.h.old	2006-02-03 16:44:22.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/include/linux/namei.h	2006-02-03 16:44:26.000000000 +0100
@@ -75,7 +75,6 @@
 extern void release_open_intent(struct nameidata *);
 
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
-extern __deprecated_for_modules struct dentry * lookup_hash(struct nameidata *);
 
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);
--- linux-2.6.16-rc1-mm5-full/fs/namei.c.old	2006-02-03 16:44:34.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/fs/namei.c	2006-02-03 16:44:46.000000000 +0100
@@ -1248,7 +1248,7 @@
 	return dentry;
 }
 
-struct dentry * lookup_hash(struct nameidata *nd)
+static struct dentry * lookup_hash(struct nameidata *nd)
 {
 	return __lookup_hash(&nd->last, nd->dentry, nd);
 }
@@ -2661,7 +2661,6 @@
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(lookup_one_len);
 EXPORT_SYMBOL(page_follow_link_light);
 EXPORT_SYMBOL(page_put_link);

