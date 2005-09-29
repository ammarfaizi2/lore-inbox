Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVI2CYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVI2CYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVI2CYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:24:08 -0400
Received: from relay-cv.club-internet.fr ([194.158.96.103]:8920 "EHLO
	relay-cv.club-internet.fr") by vger.kernel.org with ESMTP
	id S1751314AbVI2CYH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:24:07 -0400
From: pinotj@club-internet.fr
To: viro@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.14-rc2] ext3: fix build warning if !quota
Date: Thu, 29 Sep 2005 04:24:01 +0200
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet2.1127960641.3944.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Date: Thu, 29 Sep 2005 02:57:20 +0100
>From: Al Viro
>To: pinotj
>Cc: linux-kernel
>Subject: Re: [PATCH][2.6.14-rc2] ext3: fix build warning if !quota
[...]
>.... and puts declaration in the middle of code.
>

Is this better ?

------8<------
diff -Naur a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	2005-09-29 00:28:16.000000000 +0000
+++ b/fs/ext3/super.c	2005-09-29 02:18:22.000000000 +0000
@@ -513,7 +513,9 @@
 static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
 	struct super_block *sb = vfs->mnt_sb;
+#if defined(CONFIG_QUOTA)
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
+#endif
 
 	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
 		seq_puts(seq, ",data=journal");
------8<------


-- 
Jerome Pinot
http://ngc891.blogdns.net/

