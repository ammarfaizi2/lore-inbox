Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVI2Qp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVI2Qp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVI2Qp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:45:59 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:27667 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932243AbVI2Qp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:45:58 -0400
To: Jerome Pinot <ngc891@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.14-rc2] ext3: fix build warning if !quota
References: <88ee31b7050928174557572f77@mail.gmail.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 30 Sep 2005 01:45:49 +0900
In-Reply-To: <88ee31b7050928174557572f77@mail.gmail.com> (Jerome Pinot's message of "Thu, 29 Sep 2005 09:45:22 +0900")
Message-ID: <8764sju8jm.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Pinot <ngc891@gmail.com> writes:

> sbi is not used if quota is not defined. This leads to a useless
> variable after preprocessing and a build warning.
>
> This moves the declaration in right place.

Sorry, my fault. But we use -Wdeclaration-after-statement option.
So, gcc-4.0.1 warns it, and gcc info says "not supported before GCC 3.0".

fs/ext3/super.c: In function 'ext3_show_options':
fs/ext3/super.c:525: warning: ISO C90 forbids mixed declarations and code

How about this instead?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/ext3/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN fs/ext3/super.c~aaa fs/ext3/super.c
--- linux-2.6.14-rc2-a/fs/ext3/super.c~aaa	2005-09-30 01:10:55.000000000 +0900
+++ linux-2.6.14-rc2-a-hirofumi/fs/ext3/super.c	2005-09-30 01:10:55.000000000 +0900
@@ -513,8 +513,9 @@ static void ext3_clear_inode(struct inod
 static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
 	struct super_block *sb = vfs->mnt_sb;
+#if defined(CONFIG_QUOTA)
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-
+#endif
 	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
 		seq_puts(seq, ",data=journal");
 	else if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA)
_
