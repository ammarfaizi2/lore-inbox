Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVAQRtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVAQRtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVAQRss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:48:48 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:11529 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262820AbVAQRr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:47:59 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/13] FAT: fs/fat/cache.c: make __fat_access static
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
	<87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:47:51 +0900
In-Reply-To: <87zmz8ne5p.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:44:50 +0900")
Message-ID: <877jmcne0o.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c           |    2 +-
 include/linux/msdos_fs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff -puN fs/fat/cache.c~fat__fat_access fs/fat/cache.c
--- linux-2.6.10/fs/fat/cache.c~fat__fat_access	2005-01-08 09:08:14.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/cache.c	2005-01-08 09:08:14.000000000 +0900
@@ -203,7 +203,7 @@ void fat_cache_inval_inode(struct inode 
 	spin_unlock(&MSDOS_I(inode)->cache_lru_lock);
 }
 
-int __fat_access(struct super_block *sb, int nr, int new_value)
+static int __fat_access(struct super_block *sb, int nr, int new_value)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *bh2, *c_bh, *c_bh2;
diff -puN include/linux/msdos_fs.h~fat__fat_access include/linux/msdos_fs.h
--- linux-2.6.10/include/linux/msdos_fs.h~fat__fat_access	2005-01-08 09:08:14.000000000 +0900
+++ linux-2.6.10-hirofumi/include/linux/msdos_fs.h	2005-01-08 09:08:14.000000000 +0900
@@ -306,7 +306,6 @@ static inline void fatwchar_to16(__u8 *d
 
 /* fat/cache.c */
 extern int fat_access(struct super_block *sb, int nr, int new_value);
-extern int __fat_access(struct super_block *sb, int nr, int new_value);
 extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys);
 extern void fat_cache_inval_inode(struct inode *inode);
 extern int fat_get_cluster(struct inode *inode, int cluster,
_
