Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWFQKMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWFQKMq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWFQKMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:12:46 -0400
Received: from mx2.mail.ru ([194.67.23.122]:40039 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751376AbWFQKMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:12:45 -0400
Date: Sat, 17 Jun 2006 14:18:05 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5]: ufs: ubh_ll_rw_block cleanup
Message-ID: <20060617101805.GA5991@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ufs code there is function:
ubh_ll_rw_block,
it has parameter how many ufs_buffer_head it should
handle, but it always called with "1" on the place of this
parameter.
This patch removes unused parameter of "ubh_ll_wr_block".

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc6-mm2/fs/ufs/balloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/balloc.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/balloc.c
@@ -109,7 +109,7 @@ void ufs_free_fragments(struct inode *in
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block(SWRITE, UCPI_UBH(ucpi));
 		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
@@ -195,7 +195,7 @@ do_more:
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block(SWRITE, UCPI_UBH(ucpi));
 		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 
@@ -521,7 +521,7 @@ ufs_add_fragments (struct inode * inode,
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block(SWRITE, UCPI_UBH(ucpi));
 		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
@@ -646,7 +646,7 @@ succed:
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **)&ucpi);
+		ubh_ll_rw_block(SWRITE, UCPI_UBH(ucpi));
 		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
Index: linux-2.6.17-rc6-mm2/fs/ufs/ialloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/ialloc.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/ialloc.c
@@ -116,7 +116,7 @@ void ufs_free_inode (struct inode * inod
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **) &ucpi);
+		ubh_ll_rw_block(SWRITE, UCPI_UBH(ucpi));
 		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	
@@ -240,7 +240,7 @@ cg_found:
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ubh_ll_rw_block (SWRITE, 1, (struct ufs_buffer_head **) &ucpi);
+		ubh_ll_rw_block(SWRITE, UCPI_UBH(ucpi));
 		ubh_wait_on_buffer (UCPI_UBH(ucpi));
 	}
 	sb->s_dirt = 1;
Index: linux-2.6.17-rc6-mm2/fs/ufs/truncate.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/truncate.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/truncate.c
@@ -238,7 +238,7 @@ static int ufs_trunc_indirect (struct in
 		ind_ubh = NULL;
 	}
 	if (IS_SYNC(inode) && ind_ubh && ubh_buffer_dirty(ind_ubh)) {
-		ubh_ll_rw_block (SWRITE, 1, &ind_ubh);
+		ubh_ll_rw_block(SWRITE, ind_ubh);
 		ubh_wait_on_buffer (ind_ubh);
 	}
 	ubh_brelse (ind_ubh);
@@ -301,7 +301,7 @@ static int ufs_trunc_dindirect (struct i
 		dind_bh = NULL;
 	}
 	if (IS_SYNC(inode) && dind_bh && ubh_buffer_dirty(dind_bh)) {
-		ubh_ll_rw_block (SWRITE, 1, &dind_bh);
+		ubh_ll_rw_block(SWRITE, dind_bh);
 		ubh_wait_on_buffer (dind_bh);
 	}
 	ubh_brelse (dind_bh);
@@ -361,7 +361,7 @@ static int ufs_trunc_tindirect (struct i
 		tind_bh = NULL;
 	}
 	if (IS_SYNC(inode) && tind_bh && ubh_buffer_dirty(tind_bh)) {
-		ubh_ll_rw_block (SWRITE, 1, &tind_bh);
+		ubh_ll_rw_block(SWRITE, tind_bh);
 		ubh_wait_on_buffer (tind_bh);
 	}
 	ubh_brelse (tind_bh);
Index: linux-2.6.17-rc6-mm2/fs/ufs/util.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/util.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/util.c
@@ -112,13 +112,12 @@ void ubh_mark_buffer_uptodate (struct uf
 	}
 }
 
-void ubh_ll_rw_block (int rw, unsigned nr, struct ufs_buffer_head * ubh[])
+void ubh_ll_rw_block(int rw, struct ufs_buffer_head *ubh)
 {
-	unsigned i;
 	if (!ubh)
 		return;
-	for ( i = 0; i < nr; i++ )
-		ll_rw_block (rw, ubh[i]->count, ubh[i]->bh);
+
+	ll_rw_block(rw, ubh->count, ubh->bh);
 }
 
 void ubh_wait_on_buffer (struct ufs_buffer_head * ubh)
Index: linux-2.6.17-rc6-mm2/fs/ufs/util.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/util.h
+++ linux-2.6.17-rc6-mm2/fs/ufs/util.h
@@ -242,7 +242,7 @@ extern void ubh_brelse (struct ufs_buffe
 extern void ubh_brelse_uspi (struct ufs_sb_private_info *);
 extern void ubh_mark_buffer_dirty (struct ufs_buffer_head *);
 extern void ubh_mark_buffer_uptodate (struct ufs_buffer_head *, int);
-extern void ubh_ll_rw_block (int, unsigned, struct ufs_buffer_head **);
+extern void ubh_ll_rw_block(int, struct ufs_buffer_head *);
 extern void ubh_wait_on_buffer (struct ufs_buffer_head *);
 extern void ubh_bforget (struct ufs_buffer_head *);
 extern int  ubh_buffer_dirty (struct ufs_buffer_head *);

-- 
/Evgeniy

