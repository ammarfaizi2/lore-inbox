Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWAWBS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWAWBS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAWBS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:18:29 -0500
Received: from xenotime.net ([66.160.160.81]:26308 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932387AbWAWBS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:18:28 -0500
Date: Sun, 22 Jan 2006 17:18:30 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] jffs2: fix printk warnings
Message-Id: <20060122171830.306e1af9.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warnings in jffs2.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/jffs2/readinode.c |    6 +++---
 fs/jffs2/summary.c   |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2616-rc1g4.orig/fs/jffs2/readinode.c
+++ linux-2616-rc1g4/fs/jffs2/readinode.c
@@ -204,7 +204,7 @@ static inline int read_dnode(struct jffs
 
 	tn = jffs2_alloc_tmp_dnode_info();
 	if (!tn) {
-		JFFS2_ERROR("failed to allocate tn (%d bytes).\n", sizeof(*tn));
+		JFFS2_ERROR("failed to allocate tn (%zu bytes).\n", sizeof(*tn));
 		return -ENOMEM;
 	}
 
@@ -434,7 +434,7 @@ static int read_more(struct jffs2_sb_inf
 	}
 
 	if (retlen < len) {
-		JFFS2_ERROR("short read at %#08x: %d instead of %d.\n",
+		JFFS2_ERROR("short read at %#08x: %zu instead of %d.\n",
 				offs, retlen, len);
 		return -EIO;
 	}
@@ -542,7 +542,7 @@ static int jffs2_get_inode_nodes(struct 
 		}
 
 		if (retlen < len) {
-			JFFS2_ERROR("short read at %#08x: %d instead of %d.\n", ref_offset(ref), retlen, len);
+			JFFS2_ERROR("short read at %#08x: %zu instead of %d.\n", ref_offset(ref), retlen, len);
 			err = -EIO;
 			goto free_out;
 		}
--- linux-2616-rc1g4.orig/fs/jffs2/summary.c
+++ linux-2616-rc1g4/fs/jffs2/summary.c
@@ -655,7 +655,7 @@ static int jffs2_sum_write_data(struct j
 
 
 	if (ret || (retlen != infosize)) {
-		JFFS2_WARNING("Write of %zd bytes at 0x%08x failed. returned %d, retlen %zd\n",
+		JFFS2_WARNING("Write of %d bytes at 0x%08x failed. returned %d, retlen %zu\n",
 			infosize, jeb->offset + c->sector_size - jeb->free_size, ret, retlen);
 
 		c->summary->sum_size = JFFS2_SUMMARY_NOSUM_SIZE;


---
