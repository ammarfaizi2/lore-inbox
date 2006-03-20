Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWCTWCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWCTWCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbWCTWB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:53945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030529AbWCTWBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:11 -0500
Cc: Eric Sesterhenn <snakebyte@gmx.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/23] sysfs: kzalloc conversion
In-Reply-To: <1142892038657-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920381250-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this converts fs/sysfs to kzalloc() usage.
compile tested with make allyesconfig

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/sysfs/file.c  |    3 +--
 fs/sysfs/inode.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

58d49283b87751f7af75e021a629dcddb027e8eb
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d0e3d84..e21f402 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -301,9 +301,8 @@ static int check_perm(struct inode * ino
 	/* No error? Great, allocate a buffer for the file, and store it
 	 * it in file->private_data for easy access.
 	 */
-	buffer = kmalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
+	buffer = kzalloc(sizeof(struct sysfs_buffer), GFP_KERNEL);
 	if (buffer) {
-		memset(buffer,0,sizeof(struct sysfs_buffer));
 		init_MUTEX(&buffer->sem);
 		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 6beee6f..4c29ac4 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -54,11 +54,10 @@ int sysfs_setattr(struct dentry * dentry
 
 	if (!sd_iattr) {
 		/* setting attributes for the first time, allocate now */
-		sd_iattr = kmalloc(sizeof(struct iattr), GFP_KERNEL);
+		sd_iattr = kzalloc(sizeof(struct iattr), GFP_KERNEL);
 		if (!sd_iattr)
 			return -ENOMEM;
 		/* assign default attributes */
-		memset(sd_iattr, 0, sizeof(struct iattr));
 		sd_iattr->ia_mode = sd->s_mode;
 		sd_iattr->ia_uid = 0;
 		sd_iattr->ia_gid = 0;
-- 
1.2.4


