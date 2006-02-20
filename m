Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWBTWig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWBTWig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWBTWhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:37:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63244 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932698AbWBTWgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:23 -0500
Date: Mon, 20 Feb 2006 23:36:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/inode.c: make iprune_mutex static
Message-ID: <20060220223621.GN4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason for iprune_mutex being global.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/inode.c         |    2 +-
 include/linux/fs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.16-rc4-mm1-full/include/linux/fs.h.old	2006-02-20 19:43:08.000000000 +0100
+++ linux-2.6.16-rc4-mm1-full/include/linux/fs.h	2006-02-20 19:43:14.000000000 +0100
@@ -1562,7 +1562,6 @@
 extern struct inode *new_inode(struct super_block *);
 extern int remove_suid(struct dentry *);
 extern void remove_dquot_ref(struct super_block *, int, struct list_head *);
-extern struct mutex iprune_mutex;
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 extern void remove_inode_hash(struct inode *);
--- linux-2.6.16-rc4-mm1-full/fs/inode.c.old	2006-02-20 19:43:23.000000000 +0100
+++ linux-2.6.16-rc4-mm1-full/fs/inode.c	2006-02-20 19:43:32.000000000 +0100
@@ -91,7 +91,7 @@
  * from its final dispose_list, the struct super_block they refer to
  * (for inode->i_sb->s_op) may already have been freed and reused.
  */
-DEFINE_MUTEX(iprune_mutex);
+static DEFINE_MUTEX(iprune_mutex);
 
 /*
  * Statistics gathering..

