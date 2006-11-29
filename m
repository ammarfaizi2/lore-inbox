Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758818AbWK2KEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818AbWK2KEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758815AbWK2KEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:04:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2057 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966653AbWK2KED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:04:03 -0500
Date: Wed, 29 Nov 2006 11:04:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jack@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] proper prototype for remove_inode_dquot_ref()
Message-ID: <20061129100408.GJ11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a proer prototype for remove_inode_dquot_ref() in 
include/linux/quotaops.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/inode.c               |    3 ---
 include/linux/quotaops.h |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc6-mm2/include/linux/quotaops.h.old	2006-11-29 09:43:03.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/linux/quotaops.h	2006-11-29 09:43:21.000000000 +0100
@@ -37,6 +37,9 @@
 extern int dquot_commit_info(struct super_block *sb, int type);
 extern int dquot_mark_dquot_dirty(struct dquot *dquot);
 
+int remove_inode_dquot_ref(struct inode *inode, int type,
+			   struct list_head *tofree_head);
+
 extern int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path);
 extern int vfs_quota_on_mount(struct super_block *sb, char *qf_name,
 		int format_id, int type);
--- linux-2.6.19-rc6-mm2/fs/inode.c.old	2006-11-29 09:43:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2/fs/inode.c	2006-11-29 09:43:50.000000000 +0100
@@ -1249,9 +1249,6 @@
  */
 #ifdef CONFIG_QUOTA
 
-/* Function back in dquot.c */
-int remove_inode_dquot_ref(struct inode *, int, struct list_head *);
-
 void remove_dquot_ref(struct super_block *sb, int type,
 			struct list_head *tofree_head)
 {

