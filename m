Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWAPWed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWAPWed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWAPWed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:34:33 -0500
Received: from mail.suse.de ([195.135.220.2]:41604 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751231AbWAPWec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:34:32 -0500
Date: Mon, 16 Jan 2006 23:34:31 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060116223431.GA24841@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get 'Busy inodes after umount' very often, even with recent kernels.
Usually it remains unnoticed for a while. A bit more info about what
superblock had problems would be helpful.

bdevname() doesnt seem to be the best way for pretty-printing NFS mounts
for example. Should it just print the major:minor pair? 
Are there scripts or something that parse such kernel messages, should
the extra info go somewhere else?

 fs/super.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/fs/super.c
===================================================================
--- linux-2.6.orig/fs/super.c
+++ linux-2.6/fs/super.c
@@ -227,6 +227,7 @@ void generic_shutdown_super(struct super
 {
 	struct dentry *root = sb->s_root;
 	struct super_operations *sop = sb->s_op;
+	char b[BDEVNAME_SIZE];
 
 	if (root) {
 		sb->s_root = NULL;
@@ -247,8 +248,9 @@ void generic_shutdown_super(struct super
 
 		/* Forget any remaining inodes */
 		if (invalidate_inodes(sb)) {
-			printk("VFS: Busy inodes after unmount. "
-			   "Self-destruct in 5 seconds.  Have a nice day...\n");
+			printk("VFS: (%s) Busy inodes after unmount. "
+			   "Self-destruct in 5 seconds.  Have a nice day...\n",
+			   bdevname(sb->s_bdev, b));
 		}
 
 		unlock_kernel();
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
