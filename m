Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSEYLv4>; Sat, 25 May 2002 07:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314471AbSEYLvz>; Sat, 25 May 2002 07:51:55 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:39940 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S314465AbSEYLvy>; Sat, 25 May 2002 07:51:54 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the utf8 option of vfat (2/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 25 May 2002 20:51:46 +0900
Message-ID: <873cwg1m3x.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the bug which happens when utf8 option was used,
by using iocharset for upper/lower conversion.

It's a bit strange that utf8 use iocharset, but this is still needed.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_dentry-2.5.18/fs/fat/inode.c fat_utf8_oops-2.5.18/fs/fat/inode.c
--- fat_dentry-2.5.18/fs/fat/inode.c	Sat May 25 16:52:06 2002
+++ fat_utf8_oops-2.5.18/fs/fat/inode.c	Sat May 25 17:14:49 2002
@@ -872,7 +872,8 @@
 	if (!silent)
 		printk("FAT: Using codepage %s\n", sbi->nls_disk->charset);
 
-	if (sbi->options.isvfat && !sbi->options.utf8) {
+	/* FIXME: utf8 is using iocharset for upper/lower conversion */
+	if (sbi->options.isvfat) {
 		if (sbi->options.iocharset != NULL) {
 			sbi->nls_io = load_nls(sbi->options.iocharset);
 			if (!sbi->nls_io) {
