Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVI2BrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVI2BrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVI2BrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:47:17 -0400
Received: from relay-bv.club-internet.fr ([194.158.96.102]:64745 "EHLO
	relay-bv.club-internet.fr") by vger.kernel.org with ESMTP
	id S1751306AbVI2BrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:47:16 -0400
From: pinotj@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.14-rc2] ext3: fix build warning if !quota
Date: Thu, 29 Sep 2005 03:46:53 +0200
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1127958413.3944.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(My first e-mail seems to be lost somewhere, here is a second try)

sbi is not used if quota is not defined. This leads to a useless
variable after preprocessing and a build warning.

This moves the declaration in right place.

 ------8<------
diff -Naur a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	2005-09-29 00:28:16.000000000 +0000
+++ b/fs/ext3/super.c	2005-09-29 00:25:02.000000000 +0000
@@ -513,7 +513,6 @@
 static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
 	struct super_block *sb = vfs->mnt_sb;
-	struct ext3_sb_info *sbi = EXT3_SB(sb);

 	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
 		seq_puts(seq, ",data=journal");
@@ -523,6 +522,8 @@
 		seq_puts(seq, ",data=writeback");

 #if defined(CONFIG_QUOTA)
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+
 	if (sbi->s_jquota_fmt)
 		seq_printf(seq, ",jqfmt=%s",
 		(sbi->s_jquota_fmt == QFMT_VFS_OLD) ? "vfsold": "vfsv0");
 ------8<------

Signed-off-by: Jerome Pinot <ngc891@gmail.com>


Regards,

--
Jerome Pinot
http://ngc891.blogdns.net/

