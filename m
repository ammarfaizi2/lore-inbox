Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVI2TeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVI2TeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVI2TdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:33:25 -0400
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]:54429 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S964800AbVI2TdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:33:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] Fix ext3 warning for unused var
Date: Thu, 29 Sep 2005 20:40:22 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050929184021.12780.33431.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Gcc warns about an unused var, fix this. Introduced in commit
275abf5b06676ca057cf3e15f0d027eafcb204a0, after 2.6.14-rc2.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/ext3/super.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -513,7 +513,9 @@ static void ext3_clear_inode(struct inod
 static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
 	struct super_block *sb = vfs->mnt_sb;
+#if defined(CONFIG_QUOTA)
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
+#endif
 
 	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
 		seq_puts(seq, ",data=journal");

