Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270427AbTGUPvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270173AbTGUPnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:43:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:9737 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270185AbTGUPiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:38:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat_access cleanup (5/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:53:52 +0900
Message-ID: <877k6bx4dr.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the dump_fat() and dump_de() of obsoleted debug code in
vfat/namei.c.


 fs/vfat/namei.c |   31 -------------------------------
 1 files changed, 31 deletions(-)

diff -puN fs/vfat/namei.c~fat_access-cleanup2 fs/vfat/namei.c
--- linux-2.6.0-test1/fs/vfat/namei.c~fat_access-cleanup2	2003-07-21 02:48:18.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/vfat/namei.c	2003-07-21 02:48:18.000000000 +0900
@@ -204,37 +204,6 @@ static int vfat_cmp(struct dentry *dentr
 	return 1;
 }
 
-#ifdef DEBUG
-
-static void dump_fat(struct super_block *sb,int start)
-{
-	printk("[");
-	while (start) {
-		printk("%d ",start);
-		start = fat_access(sb,start,-1);
-		if (!start) {
-			printk("ERROR");
-			break;
-		}
-		if (start == -1) break;
-	}
-	printk("]\n");
-}
-
-static void dump_de(struct msdos_dir_entry *de)
-{
-	int i;
-	unsigned char *p = (unsigned char *) de;
-	printk("[");
-
-	for (i = 0; i < 32; i++, p++) {
-		printk("%02x ", *p);
-	}
-	printk("]\n");
-}
-
-#endif
-
 /* MS-DOS "device special files" */
 
 static const char *reserved3_names[] = {

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
