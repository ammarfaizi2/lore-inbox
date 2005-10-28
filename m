Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVJ1Qrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVJ1Qrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVJ1Qrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:47:52 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:51469 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1030249AbVJ1Qrw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:47:52 -0400
Date: Fri, 28 Oct 2005 18:49:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] ext3: Fix warning without quota support (was: Linux 2.6.14)
Message-Id: <20051028184901.59e273db.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not spotting this one earlier...

Fix the following warning when ext3 fs is compiled without quota
support:

fs/ext3/super.c: In function `ext3_show_options':
fs/ext3/super.c:516: warning: unused variable `sbi'

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 fs/ext3/super.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.14.orig/fs/ext3/super.c	2005-10-28 18:25:56.000000000 +0200
+++ linux-2.6.14/fs/ext3/super.c	2005-10-28 18:38:36.000000000 +0200
@@ -513,7 +513,9 @@
 static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
 	struct super_block *sb = vfs->mnt_sb;
+#ifdef CONFIG_QUOTA
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
+#endif
 
 	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
 		seq_puts(seq, ",data=journal");


-- 
Jean Delvare
