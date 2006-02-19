Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWBSVIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBSVIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWBSVIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:08:35 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:2716 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932146AbWBSVId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:08:33 -0500
Date: Sun, 19 Feb 2006 23:08:32 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sysfs: Update relay file support for generic relay API.
Message-ID: <20060219210832.GD3682@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
	zanussi@us.ibm.com, linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219210733.GA3682@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now with the introduction of CONFIG_REPLAY, switch to using that instead
of CONFIG_REPLAYFS_FS.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 fs/sysfs/Makefile     |    2 +-
 fs/sysfs/dir.c        |    2 +-
 include/linux/sysfs.h |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

299b10030cd85eb20daa5d14cc549cf4902eb372
diff --git a/fs/sysfs/Makefile b/fs/sysfs/Makefile
index 676bf3c..7bd4d8f 100644
--- a/fs/sysfs/Makefile
+++ b/fs/sysfs/Makefile
@@ -4,4 +4,4 @@
 
 obj-y		:= inode.o file.o dir.o symlink.o mount.o bin.o \
 		   group.o
-obj-$(CONFIG_RELAYFS_FS) += relay.o
+obj-$(CONFIG_RELAY) += relay.o
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 379daa3..52a759b 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -87,7 +87,7 @@ static int init_file(struct inode * inod
 	return 0;
 }
 
-#ifdef CONFIG_RELAYFS_FS
+#ifdef CONFIG_RELAY
 static int init_relay_file(struct inode * inode)
 {
 	extern struct file_operations relay_file_operations;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 2e75d49..0faca48 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -94,7 +94,7 @@ struct sysfs_dirent {
 #define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | \
 				 SYSFS_KOBJ_LINK | SYSFS_KOBJ_RELAY_ATTR)
 
-#if defined(CONFIG_RELAYFS_FS) && defined(CONFIG_SYSFS)
+#if defined(CONFIG_RELAY) && defined(CONFIG_SYSFS)
 int sysfs_create_relay_file(struct kobject *, struct relay_attribute *);
 void sysfs_remove_relay_file(struct kobject *, struct relay_attribute *);
 #else
@@ -106,7 +106,7 @@ static inline int sysfs_create_relay_fil
 static inline void sysfs_remove_relay_file(struct kobject *kobj, struct relay_attribute *attr)
 {
 }
-#endif /* CONFIG_RELAYFS_FS && CONFIG_SYSFS */
+#endif /* CONFIG_RELAY && CONFIG_SYSFS */
 
 #ifdef CONFIG_SYSFS
 
-- 
1.2.0.geb68

