Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWCIQWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWCIQWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWCIQWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:22:24 -0500
Received: from mail.parknet.jp ([210.171.160.80]:25102 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932282AbWCIQWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:22:23 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Move cond_resched() after iput() in sync_sb_inodes()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 10 Mar 2006 01:22:19 +0900
Message-ID: <87fylrziys.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In here, I think the following order is more cache-friendly. What do
you think?

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fs-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/fs-writeback.c~iput-before-cond_resched fs/fs-writeback.c
--- linux-2.6/fs/fs-writeback.c~iput-before-cond_resched	2006-03-05 21:51:12.000000000 +0900
+++ linux-2.6-hirofumi/fs/fs-writeback.c	2006-03-05 21:51:12.000000000 +0900
@@ -382,8 +382,8 @@ sync_sb_inodes(struct super_block *sb, s
 			list_move(&inode->i_list, &sb->s_dirty);
 		}
 		spin_unlock(&inode_lock);
-		cond_resched();
 		iput(inode);
+		cond_resched();
 		spin_lock(&inode_lock);
 		if (wbc->nr_to_write <= 0)
 			break;
_
