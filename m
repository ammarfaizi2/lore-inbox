Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWIAT6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWIAT6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 15:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWIAT6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 15:58:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31495 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751470AbWIAT6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 15:58:24 -0400
Date: Fri, 1 Sep 2006 21:58:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/reiser4/: possible cleanups
Message-ID: <20060901195818.GF18276@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global function static:
  - plugin/file/file.c: hint_validate()
- #if 0 the following unused global function:
  - jnode.c: page_detach_jnode()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiser4/jnode.c            |    2 ++
 fs/reiser4/jnode.h            |    3 ---
 fs/reiser4/plugin/file/file.c |    4 +++-
 fs/reiser4/plugin/file/file.h |    2 --
 4 files changed, 5 insertions(+), 6 deletions(-)

--- linux-2.6.18-rc5-mm1/fs/reiser4/plugin/file/file.h.old	2006-09-01 20:54:04.000000000 +0200
+++ linux-2.6.18-rc5-mm1/fs/reiser4/plugin/file/file.h	2006-09-01 20:54:09.000000000 +0200
@@ -157,8 +157,6 @@
 void reiser4_set_hint(hint_t *, const reiser4_key *, znode_lock_mode);
 int hint_is_set(const hint_t *);
 void reiser4_unset_hint(hint_t *);
-int hint_validate(hint_t *, const reiser4_key *, int check_key,
-		  znode_lock_mode);
 void hint_init_zero(hint_t *);
 
 int reiser4_update_file_size(struct inode *, reiser4_key *, int update_sd);
--- linux-2.6.18-rc5-mm1/fs/reiser4/plugin/file/file.c.old	2006-09-01 20:54:17.000000000 +0200
+++ linux-2.6.18-rc5-mm1/fs/reiser4/plugin/file/file.c	2006-09-01 20:55:08.000000000 +0200
@@ -26,6 +26,8 @@
 
 static int unpack(struct file *file, struct inode *inode, int forever);
 static void drop_access(unix_file_info_t *);
+static int hint_validate(hint_t * hint, const reiser4_key * key, int check_key,
+			 znode_lock_mode lock_mode);
 
 /* get unix file plugin specific portion of inode */
 unix_file_info_t *unix_file_inode_data(const struct inode *inode)
@@ -747,7 +749,7 @@
 }
 #endif
 
-int
+static int
 hint_validate(hint_t * hint, const reiser4_key * key, int check_key,
 	      znode_lock_mode lock_mode)
 {
--- linux-2.6.18-rc5-mm1/fs/reiser4/jnode.h.old	2006-09-01 20:55:19.000000000 +0200
+++ linux-2.6.18-rc5-mm1/fs/reiser4/jnode.h	2006-09-01 20:55:27.000000000 +0200
@@ -486,9 +486,6 @@
 	return atomic_read(&node->d_count) > 0;
 }
 
-extern void page_detach_jnode(struct page *page,
-			      struct address_space *mapping,
-			      unsigned long index) NONNULL;
 extern void page_clear_jnode(struct page *page, jnode * node) NONNULL;
 
 static inline void jnode_set_reloc(jnode * node)
--- linux-2.6.18-rc5-mm1/fs/reiser4/jnode.c.old	2006-09-01 20:55:33.000000000 +0200
+++ linux-2.6.18-rc5-mm1/fs/reiser4/jnode.c	2006-09-01 20:55:47.000000000 +0200
@@ -697,6 +697,7 @@
 	page_cache_release(page);
 }
 
+#if 0
 /* it is only used in one place to handle error */
 void
 page_detach_jnode(struct page *page, struct address_space *mapping,
@@ -716,6 +717,7 @@
 	}
 	unlock_page(page);
 }
+#endif  /*  0  */
 
 /* return @node page locked.
 

