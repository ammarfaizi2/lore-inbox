Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVDWAAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDWAAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDWAAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:00:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18705 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261352AbVDVX7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 19:59:24 -0400
Date: Sat, 23 Apr 2005 01:59:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jffs-dev@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/jffs/: cleanups
Message-ID: <20050422235922.GJ4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global functions static
- provide some debugging helper functions only for appropriate
  values of CONFIG_JFFS_FS_VERBOSE

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/jffs/intrep.c  |  114 ++++++++++++++++++++++------------------------
 fs/jffs/intrep.h  |    2 
 fs/jffs/jffs_fm.c |  105 +++++++++++++++++++++---------------------
 fs/jffs/jffs_fm.h |    3 -
 4 files changed, 112 insertions(+), 112 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/jffs/intrep.h.old	2005-04-20 23:21:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jffs/intrep.h	2005-04-20 23:24:10.000000000 +0200
@@ -49,8 +49,6 @@
 void jffs_garbage_collect_trigger(struct jffs_control *c);
 
 /* For debugging purposes.  */
-void jffs_print_node(struct jffs_node *n);
-void jffs_print_raw_inode(struct jffs_raw_inode *raw_inode);
 #if 0
 int jffs_print_file(struct jffs_file *f);
 #endif  /*  0  */
--- linux-2.6.12-rc2-mm3-full/fs/jffs/intrep.c.old	2005-04-20 23:23:03.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jffs/intrep.c	2005-04-21 00:18:40.000000000 +0200
@@ -175,8 +175,64 @@
 	}
 }
 
+/* Print the contents of a node.  */
+static void
+jffs_print_node(struct jffs_node *n)
+{
+	D(printk("jffs_node: 0x%p\n", n));
+	D(printk("{\n"));
+	D(printk("        0x%08x, /* version  */\n", n->version));
+	D(printk("        0x%08x, /* data_offset  */\n", n->data_offset));
+	D(printk("        0x%08x, /* data_size  */\n", n->data_size));
+	D(printk("        0x%08x, /* removed_size  */\n", n->removed_size));
+	D(printk("        0x%08x, /* fm_offset  */\n", n->fm_offset));
+	D(printk("        0x%02x,       /* name_size  */\n", n->name_size));
+	D(printk("        0x%p, /* fm,  fm->offset: %u  */\n",
+		 n->fm, (n->fm ? n->fm->offset : 0)));
+	D(printk("        0x%p, /* version_prev  */\n", n->version_prev));
+	D(printk("        0x%p, /* version_next  */\n", n->version_next));
+	D(printk("        0x%p, /* range_prev  */\n", n->range_prev));
+	D(printk("        0x%p, /* range_next  */\n", n->range_next));
+	D(printk("}\n"));
+}
+
 #endif
 
+/* Print the contents of a raw inode.  */
+static void
+jffs_print_raw_inode(struct jffs_raw_inode *raw_inode)
+{
+	D(printk("jffs_raw_inode: inode number: %u\n", raw_inode->ino));
+	D(printk("{\n"));
+	D(printk("        0x%08x, /* magic  */\n", raw_inode->magic));
+	D(printk("        0x%08x, /* ino  */\n", raw_inode->ino));
+	D(printk("        0x%08x, /* pino  */\n", raw_inode->pino));
+	D(printk("        0x%08x, /* version  */\n", raw_inode->version));
+	D(printk("        0x%08x, /* mode  */\n", raw_inode->mode));
+	D(printk("        0x%04x,     /* uid  */\n", raw_inode->uid));
+	D(printk("        0x%04x,     /* gid  */\n", raw_inode->gid));
+	D(printk("        0x%08x, /* atime  */\n", raw_inode->atime));
+	D(printk("        0x%08x, /* mtime  */\n", raw_inode->mtime));
+	D(printk("        0x%08x, /* ctime  */\n", raw_inode->ctime));
+	D(printk("        0x%08x, /* offset  */\n", raw_inode->offset));
+	D(printk("        0x%08x, /* dsize  */\n", raw_inode->dsize));
+	D(printk("        0x%08x, /* rsize  */\n", raw_inode->rsize));
+	D(printk("        0x%02x,       /* nsize  */\n", raw_inode->nsize));
+	D(printk("        0x%02x,       /* nlink  */\n", raw_inode->nlink));
+	D(printk("        0x%02x,       /* spare  */\n",
+		 raw_inode->spare));
+	D(printk("        %u,          /* rename  */\n",
+		 raw_inode->rename));
+	D(printk("        %u,          /* deleted  */\n",
+		 raw_inode->deleted));
+	D(printk("        0x%02x,       /* accurate  */\n",
+		 raw_inode->accurate));
+	D(printk("        0x%08x, /* dchksum  */\n", raw_inode->dchksum));
+	D(printk("        0x%04x,     /* nchksum  */\n", raw_inode->nchksum));
+	D(printk("        0x%04x,     /* chksum  */\n", raw_inode->chksum));
+	D(printk("}\n"));
+}
+
 #define flash_safe_acquire(arg)
 #define flash_safe_release(arg)
 
@@ -2507,64 +2563,6 @@
 	return 0;
 }
 
-/* Print the contents of a node.  */
-void
-jffs_print_node(struct jffs_node *n)
-{
-	D(printk("jffs_node: 0x%p\n", n));
-	D(printk("{\n"));
-	D(printk("        0x%08x, /* version  */\n", n->version));
-	D(printk("        0x%08x, /* data_offset  */\n", n->data_offset));
-	D(printk("        0x%08x, /* data_size  */\n", n->data_size));
-	D(printk("        0x%08x, /* removed_size  */\n", n->removed_size));
-	D(printk("        0x%08x, /* fm_offset  */\n", n->fm_offset));
-	D(printk("        0x%02x,       /* name_size  */\n", n->name_size));
-	D(printk("        0x%p, /* fm,  fm->offset: %u  */\n",
-		 n->fm, (n->fm ? n->fm->offset : 0)));
-	D(printk("        0x%p, /* version_prev  */\n", n->version_prev));
-	D(printk("        0x%p, /* version_next  */\n", n->version_next));
-	D(printk("        0x%p, /* range_prev  */\n", n->range_prev));
-	D(printk("        0x%p, /* range_next  */\n", n->range_next));
-	D(printk("}\n"));
-}
-
-
-/* Print the contents of a raw inode.  */
-void
-jffs_print_raw_inode(struct jffs_raw_inode *raw_inode)
-{
-	D(printk("jffs_raw_inode: inode number: %u\n", raw_inode->ino));
-	D(printk("{\n"));
-	D(printk("        0x%08x, /* magic  */\n", raw_inode->magic));
-	D(printk("        0x%08x, /* ino  */\n", raw_inode->ino));
-	D(printk("        0x%08x, /* pino  */\n", raw_inode->pino));
-	D(printk("        0x%08x, /* version  */\n", raw_inode->version));
-	D(printk("        0x%08x, /* mode  */\n", raw_inode->mode));
-	D(printk("        0x%04x,     /* uid  */\n", raw_inode->uid));
-	D(printk("        0x%04x,     /* gid  */\n", raw_inode->gid));
-	D(printk("        0x%08x, /* atime  */\n", raw_inode->atime));
-	D(printk("        0x%08x, /* mtime  */\n", raw_inode->mtime));
-	D(printk("        0x%08x, /* ctime  */\n", raw_inode->ctime));
-	D(printk("        0x%08x, /* offset  */\n", raw_inode->offset));
-	D(printk("        0x%08x, /* dsize  */\n", raw_inode->dsize));
-	D(printk("        0x%08x, /* rsize  */\n", raw_inode->rsize));
-	D(printk("        0x%02x,       /* nsize  */\n", raw_inode->nsize));
-	D(printk("        0x%02x,       /* nlink  */\n", raw_inode->nlink));
-	D(printk("        0x%02x,       /* spare  */\n",
-		 raw_inode->spare));
-	D(printk("        %u,          /* rename  */\n",
-		 raw_inode->rename));
-	D(printk("        %u,          /* deleted  */\n",
-		 raw_inode->deleted));
-	D(printk("        0x%02x,       /* accurate  */\n",
-		 raw_inode->accurate));
-	D(printk("        0x%08x, /* dchksum  */\n", raw_inode->dchksum));
-	D(printk("        0x%04x,     /* nchksum  */\n", raw_inode->nchksum));
-	D(printk("        0x%04x,     /* chksum  */\n", raw_inode->chksum));
-	D(printk("}\n"));
-}
-
-
 /* Print the contents of a file.  */
 #if 0
 int
--- linux-2.6.12-rc2-mm3-full/fs/jffs/jffs_fm.h.old	2005-04-20 23:25:27.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jffs/jffs_fm.h	2005-04-20 23:27:00.000000000 +0200
@@ -139,8 +139,9 @@
 void jffs_fmfree_partly(struct jffs_fmcontrol *fmc, struct jffs_fm *fm,
 			__u32 size);
 
+#if CONFIG_JFFS_FS_VERBOSE > 0
 void jffs_print_fmcontrol(struct jffs_fmcontrol *fmc);
-void jffs_print_fm(struct jffs_fm *fm);
+#endif
 #if 0
 void jffs_print_node_ref(struct jffs_node_ref *ref);
 #endif  /*  0  */
--- linux-2.6.12-rc2-mm3-full/fs/jffs/jffs_fm.c.old	2005-04-20 23:27:07.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jffs/jffs_fm.c	2005-04-20 23:28:36.000000000 +0200
@@ -31,6 +31,60 @@
 extern kmem_cache_t     *fm_cache;
 extern kmem_cache_t     *node_cache;
 
+#if CONFIG_JFFS_FS_VERBOSE > 0
+void
+jffs_print_fmcontrol(struct jffs_fmcontrol *fmc)
+{
+	D(printk("struct jffs_fmcontrol: 0x%p\n", fmc));
+	D(printk("{\n"));
+	D(printk("        %u, /* flash_size  */\n", fmc->flash_size));
+	D(printk("        %u, /* used_size  */\n", fmc->used_size));
+	D(printk("        %u, /* dirty_size  */\n", fmc->dirty_size));
+	D(printk("        %u, /* free_size  */\n", fmc->free_size));
+	D(printk("        %u, /* sector_size  */\n", fmc->sector_size));
+	D(printk("        %u, /* min_free_size  */\n", fmc->min_free_size));
+	D(printk("        %u, /* max_chunk_size  */\n", fmc->max_chunk_size));
+	D(printk("        0x%p, /* mtd  */\n", fmc->mtd));
+	D(printk("        0x%p, /* head  */    "
+		 "(head->offset = 0x%08x)\n",
+		 fmc->head, (fmc->head ? fmc->head->offset : 0)));
+	D(printk("        0x%p, /* tail  */    "
+		 "(tail->offset + tail->size = 0x%08x)\n",
+		 fmc->tail,
+		 (fmc->tail ? fmc->tail->offset + fmc->tail->size : 0)));
+	D(printk("        0x%p, /* head_extra  */\n", fmc->head_extra));
+	D(printk("        0x%p, /* tail_extra  */\n", fmc->tail_extra));
+	D(printk("}\n"));
+}
+#endif  /*  CONFIG_JFFS_FS_VERBOSE > 0  */
+
+#if CONFIG_JFFS_FS_VERBOSE > 2
+static void
+jffs_print_fm(struct jffs_fm *fm)
+{
+	D(printk("struct jffs_fm: 0x%p\n", fm));
+	D(printk("{\n"));
+	D(printk("       0x%08x, /* offset  */\n", fm->offset));
+	D(printk("       %u, /* size  */\n", fm->size));
+	D(printk("       0x%p, /* prev  */\n", fm->prev));
+	D(printk("       0x%p, /* next  */\n", fm->next));
+	D(printk("       0x%p, /* nodes  */\n", fm->nodes));
+	D(printk("}\n"));
+}
+#endif  /*  CONFIG_JFFS_FS_VERBOSE > 2  */
+
+#if 0
+void
+jffs_print_node_ref(struct jffs_node_ref *ref)
+{
+	D(printk("struct jffs_node_ref: 0x%p\n", ref));
+	D(printk("{\n"));
+	D(printk("       0x%p, /* node  */\n", ref->node));
+	D(printk("       0x%p, /* next  */\n", ref->next));
+	D(printk("}\n"));
+}
+#endif  /*  0  */
+
 /* This function creates a new shiny flash memory control structure.  */
 struct jffs_fmcontrol *
 jffs_build_begin(struct jffs_control *c, int unit)
@@ -742,54 +796,3 @@
 {
 	return no_jffs_node;
 }
-
-void
-jffs_print_fmcontrol(struct jffs_fmcontrol *fmc)
-{
-	D(printk("struct jffs_fmcontrol: 0x%p\n", fmc));
-	D(printk("{\n"));
-	D(printk("        %u, /* flash_size  */\n", fmc->flash_size));
-	D(printk("        %u, /* used_size  */\n", fmc->used_size));
-	D(printk("        %u, /* dirty_size  */\n", fmc->dirty_size));
-	D(printk("        %u, /* free_size  */\n", fmc->free_size));
-	D(printk("        %u, /* sector_size  */\n", fmc->sector_size));
-	D(printk("        %u, /* min_free_size  */\n", fmc->min_free_size));
-	D(printk("        %u, /* max_chunk_size  */\n", fmc->max_chunk_size));
-	D(printk("        0x%p, /* mtd  */\n", fmc->mtd));
-	D(printk("        0x%p, /* head  */    "
-		 "(head->offset = 0x%08x)\n",
-		 fmc->head, (fmc->head ? fmc->head->offset : 0)));
-	D(printk("        0x%p, /* tail  */    "
-		 "(tail->offset + tail->size = 0x%08x)\n",
-		 fmc->tail,
-		 (fmc->tail ? fmc->tail->offset + fmc->tail->size : 0)));
-	D(printk("        0x%p, /* head_extra  */\n", fmc->head_extra));
-	D(printk("        0x%p, /* tail_extra  */\n", fmc->tail_extra));
-	D(printk("}\n"));
-}
-
-void
-jffs_print_fm(struct jffs_fm *fm)
-{
-	D(printk("struct jffs_fm: 0x%p\n", fm));
-	D(printk("{\n"));
-	D(printk("       0x%08x, /* offset  */\n", fm->offset));
-	D(printk("       %u, /* size  */\n", fm->size));
-	D(printk("       0x%p, /* prev  */\n", fm->prev));
-	D(printk("       0x%p, /* next  */\n", fm->next));
-	D(printk("       0x%p, /* nodes  */\n", fm->nodes));
-	D(printk("}\n"));
-}
-
-#if 0
-void
-jffs_print_node_ref(struct jffs_node_ref *ref)
-{
-	D(printk("struct jffs_node_ref: 0x%p\n", ref));
-	D(printk("{\n"));
-	D(printk("       0x%p, /* node  */\n", ref->node));
-	D(printk("       0x%p, /* next  */\n", ref->next));
-	D(printk("}\n"));
-}
-#endif  /*  0  */
-

