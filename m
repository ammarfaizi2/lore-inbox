Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWGFUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWGFUhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWGFUhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:37:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750831AbWGFUhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:37:43 -0400
Date: Thu, 6 Jul 2006 22:37:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make fs/jffs2/nodelist.c:jffs2_obsolete_node_frag() static
Message-ID: <20060706203743.GT26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global jffs2_obsolete_node_frag() 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/jffs2/nodelist.c |    6 +++++-
 fs/jffs2/nodelist.h |    1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm6-full/fs/jffs2/nodelist.h.old	2006-07-06 22:12:01.000000000 +0200
+++ linux-2.6.17-mm6-full/fs/jffs2/nodelist.h	2006-07-06 22:12:08.000000000 +0200
@@ -334,7 +334,6 @@
 struct rb_node *rb_next(struct rb_node *);
 struct rb_node *rb_prev(struct rb_node *);
 void rb_replace_node(struct rb_node *victim, struct rb_node *new, struct rb_root *root);
-void jffs2_obsolete_node_frag(struct jffs2_sb_info *c, struct jffs2_node_frag *this);
 int jffs2_add_full_dnode_to_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f, struct jffs2_full_dnode *fn);
 void jffs2_truncate_fragtree (struct jffs2_sb_info *c, struct rb_root *list, uint32_t size);
 int jffs2_add_older_frag_to_fragtree(struct jffs2_sb_info *c, struct jffs2_inode_info *f, struct jffs2_tmp_dnode_info *tn);
--- linux-2.6.17-mm6-full/fs/jffs2/nodelist.c.old	2006-07-06 22:12:17.000000000 +0200
+++ linux-2.6.17-mm6-full/fs/jffs2/nodelist.c	2006-07-06 22:12:55.000000000 +0200
@@ -21,6 +21,9 @@
 #include <linux/pagemap.h>
 #include "nodelist.h"
 
+static void jffs2_obsolete_node_frag(struct jffs2_sb_info *c,
+				     struct jffs2_node_frag *this);
+
 void jffs2_add_fd_to_list(struct jffs2_sb_info *c, struct jffs2_full_dirent *new, struct jffs2_full_dirent **list)
 {
 	struct jffs2_full_dirent **prev = list;
@@ -87,7 +90,8 @@
 	}
 }
 
-void jffs2_obsolete_node_frag(struct jffs2_sb_info *c, struct jffs2_node_frag *this)
+static void jffs2_obsolete_node_frag(struct jffs2_sb_info *c,
+				     struct jffs2_node_frag *this)
 {
 	if (this->node) {
 		this->node->frags--;

