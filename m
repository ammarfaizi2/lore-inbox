Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVAQRs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVAQRs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVAQRqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:46:50 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:7433 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262830AbVAQRpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:45:03 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/13] FAT: kill unnecessary kmap()
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:44:50 +0900
In-Reply-To: <874qhgosrf.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:44:04 +0900")
Message-ID: <87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff -puN fs/fat/inode.c~fat_kill-unnecessary_kmap fs/fat/inode.c
--- linux-2.6.10/fs/fat/inode.c~fat_kill-unnecessary_kmap	2005-01-08 09:08:10.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/inode.c	2005-01-08 09:08:10.000000000 +0900
@@ -1137,30 +1137,22 @@ static int
 fat_prepare_write(struct file *file, struct page *page,
 			unsigned from, unsigned to)
 {
-	kmap(page);
 	return cont_prepare_write(page,from,to,fat_get_block,
 		&MSDOS_I(page->mapping->host)->mmu_private);
 }
 
-static int
-fat_commit_write(struct file *file, struct page *page,
-			unsigned from, unsigned to)
-{
-	kunmap(page);
-	return generic_commit_write(file, page, from, to);
-}
-
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,fat_get_block);
 }
+
 static struct address_space_operations fat_aops = {
-	.readpage = fat_readpage,
-	.writepage = fat_writepage,
-	.sync_page = block_sync_page,
-	.prepare_write = fat_prepare_write,
-	.commit_write = fat_commit_write,
-	.bmap = _fat_bmap
+	.readpage	= fat_readpage,
+	.writepage	= fat_writepage,
+	.sync_page	= block_sync_page,
+	.prepare_write	= fat_prepare_write,
+	.commit_write	= generic_commit_write,
+	.bmap		= _fat_bmap
 };
 
 /* doesn't deal with root inode */
_
