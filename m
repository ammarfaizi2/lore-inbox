Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTJFQ4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTJFQ4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:56:05 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:61966 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262366AbTJFQz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:55:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use ->d_lock instead of dcache_lock in vfat_revalidate (2/6)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 07 Oct 2003 01:55:52 +0900
Message-ID: <87ekxqpap3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This uses more fine granularity ->d_lock than ->dcache_lock for
->d_parent with d_move() race.

Please apply.

 linux-2.6.0-test6-hirofumi/fs/vfat/namei.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/vfat/namei.c~fat_d_lock-for-d_move fs/vfat/namei.c
--- linux-2.6.0-test6/fs/vfat/namei.c~fat_d_lock-for-d_move	2003-10-07 01:51:28.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/vfat/namei.c	2003-10-07 01:51:28.000000000 +0900
@@ -82,10 +82,10 @@ static int vfat_revalidate(struct dentry
 		 */
 		ret = 0;
 	else {
-		spin_lock(&dcache_lock);
+		spin_lock(&dentry->d_lock);
 		if (dentry->d_time != dentry->d_parent->d_inode->i_version)
 			ret = 0;
-		spin_unlock(&dcache_lock);
+		spin_unlock(&dentry->d_lock);
 	}
 	return ret;
 }

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
