Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbVAFXDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbVAFXDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbVAFXBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:01:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8975 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263111AbVAFWx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:53:58 -0500
Date: Thu, 6 Jan 2005 23:53:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/fat/cache.c: make __fat_access static
Message-ID: <20050106225351.GG28628@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 fs/fat/cache.c           |    2 +-
 include/linux/msdos_fs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/include/linux/msdos_fs.h.old	2005-01-06 23:35:38.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/msdos_fs.h	2005-01-06 23:35:44.000000000 +0100
@@ -230,7 +230,6 @@
 
 /* fat/cache.c */
 extern int fat_access(struct super_block *sb, int nr, int new_value);
-extern int __fat_access(struct super_block *sb, int nr, int new_value);
 extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys);
 extern void fat_cache_inval_inode(struct inode *inode);
 extern int fat_get_cluster(struct inode *inode, int cluster,
--- linux-2.6.10-mm2-full/fs/fat/cache.c.old	2005-01-06 23:35:59.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/fat/cache.c	2005-01-06 23:36:04.000000000 +0100
@@ -203,7 +203,7 @@
 	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
 }
 
-int __fat_access(struct super_block *sb, int nr, int new_value)
+static int __fat_access(struct super_block *sb, int nr, int new_value)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *bh2, *c_bh, *c_bh2;

