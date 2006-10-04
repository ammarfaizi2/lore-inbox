Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161548AbWJDQXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161548AbWJDQXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161550AbWJDQXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:23:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:38608 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161548AbWJDQXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:23:24 -0400
X-Authenticated: #704063
Subject: [Patch] Remove unnecessary check in fs/fat/inode.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: hirofumi@mail.parknet.co.jp
Content-Type: text/plain
Date: Wed, 04 Oct 2006 18:23:20 +0200
Message-Id: <1159979000.15934.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

since all callers dereference sb, and this function
does so earlier too, we dont need the check.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git21/fs/fat/inode.c.orig	2006-10-04 18:21:03.000000000 +0200
+++ linux-2.6.18-git21/fs/fat/inode.c	2006-10-04 18:21:22.000000000 +0200
@@ -1472,7 +1472,7 @@ int fat_flush_inodes(struct super_block 
 		ret = writeback_inode(i1);
 	if (!ret && i2)
 		ret = writeback_inode(i2);
-	if (!ret && sb) {
+	if (!ret) {
 		struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
 		ret = filemap_flush(mapping);
 	}


