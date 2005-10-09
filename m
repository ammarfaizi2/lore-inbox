Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVJIT6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVJIT6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVJIT6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:58:32 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:42655 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932174AbVJIT6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:58:31 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] Fix ext3 warning for unused var
Date: Sun, 09 Oct 2005 21:58:51 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051009195850.27237.90873.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix a gcc warning about an unused var. Introduced in commit
275abf5b06676ca057cf3e15f0d027eafcb204a0, after 2.6.14-rc2.
I just verified this is still current as of commit
829841146878e082613a49581ae252c071057c23.
Can please someone merge this? It's the 3rd time I send it.

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

