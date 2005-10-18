Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVJRL5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVJRL5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 07:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVJRL5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 07:57:34 -0400
Received: from wine.ocn.ne.jp ([220.111.47.146]:32473 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1750715AbVJRL5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 07:57:33 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Allow RAMFS build as a module
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Message-Id: <200510182052.JAG06195.JMLFOVFPtMSGYNtSO@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Tue, 18 Oct 2005 20:57:11 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think a line ".owner = THIS_MODULE," should be
inserted at http://lxr.linux.no/source/fs/ramfs/inode.c#L216 .
Without this line, ramfs can't work safely as a module, for
it doesn't increment module usage counter,
resulting successful rmmod while ramfs is mounted
and subsequent crash.

I know ramfs in 2.6 are always built into kernel,
but someone would get troubled when
examining ramfs code for study purpose.

Best Regards.

---------- START OF PATCH ----------
--- linux-2.6.13.4/fs/ramfs/inode.c	2005-10-11 03:54:29.000000000 +0900
+++ linux-2.6.13.4-ramfs/fs/ramfs/inode.c	2005-10-18 08:53:51.000000000 +0900
@@ -215,11 +215,13 @@
 }
 
 static struct file_system_type ramfs_fs_type = {
+	.owner		= THIS_MODULE,
 	.name		= "ramfs",
 	.get_sb		= ramfs_get_sb,
 	.kill_sb	= kill_litter_super,
 };
 static struct file_system_type rootfs_fs_type = {
+	.owner		= THIS_MODULE,
 	.name		= "rootfs",
 	.get_sb		= rootfs_get_sb,
 	.kill_sb	= kill_litter_super,
---------- END OF PATCH ----------
