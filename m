Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbUEBNKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUEBNKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbUEBNKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:10:48 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:21516 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263045AbUEBNKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:10:36 -0400
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: small cleanup (3/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 May 2004 22:10:31 +0900
Message-ID: <87wu3vrn3s.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just small cleanup.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



 fs/fat/file.c |    2 +-
 fs/fat/misc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/fat/misc.c~fat_micro-cleanup fs/fat/misc.c
--- linux-2.6.6-rc3/fs/fat/misc.c~fat_micro-cleanup	2004-05-02 19:15:43.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/fat/misc.c	2004-05-02 19:15:43.000000000 +0900
@@ -205,7 +205,7 @@ struct buffer_head *fat_extend_dir(struc
 	if (inode->i_size & (sb->s_blocksize - 1)) {
 		fat_fs_panic(sb, "Odd directory size");
 		inode->i_size = (inode->i_size + sb->s_blocksize)
-			& ~(sb->s_blocksize - 1);
+			& ~((loff_t)sb->s_blocksize - 1);
 	}
 	inode->i_size += MSDOS_SB(sb)->cluster_size;
 	MSDOS_I(inode)->mmu_private += MSDOS_SB(sb)->cluster_size;
diff -puN fs/fat/file.c~fat_micro-cleanup fs/fat/file.c
--- linux-2.6.6-rc3/fs/fat/file.c~fat_micro-cleanup	2004-05-02 19:15:43.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/fat/file.c	2004-05-02 19:15:43.000000000 +0900
@@ -50,7 +50,7 @@ int fat_get_block(struct inode *inode, s
 		BUG();
 		return -EIO;
 	}
-	if (!((unsigned long)iblock % MSDOS_SB(sb)->sec_per_clus)) {
+	if (!((unsigned long)iblock & (MSDOS_SB(sb)->sec_per_clus - 1))) {
 		int error;
 
 		error = fat_add_cluster(inode);

_
