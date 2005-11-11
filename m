Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVKKQse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVKKQse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVKKQse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:48:34 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:58080 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750883AbVKKQse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:48:34 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52030.133928.805582@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:47:58 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 3/12] relayfs: add relayfs_remove_file()
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds and exports relayfs_remove_file(), for API symmetry
(with relayfs_create_file()).

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/inode.c         |   12 ++++++++++++
 include/linux/relayfs_fs.h |    1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -225,6 +225,17 @@ int relayfs_remove(struct dentry *dentry
 }
 
 /**
+ *	relayfs_remove_file - remove a file from relay filesystem
+ *	@dentry: directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int relayfs_remove_file(struct dentry *dentry)
+{
+	return relayfs_remove(dentry);
+}
+
+/**
  *	relayfs_remove_dir - remove a directory in the relay filesystem
  *	@dentry: directory dentry
  *
@@ -600,6 +611,7 @@ EXPORT_SYMBOL_GPL(relayfs_file_operation
 EXPORT_SYMBOL_GPL(relayfs_create_dir);
 EXPORT_SYMBOL_GPL(relayfs_remove_dir);
 EXPORT_SYMBOL_GPL(relayfs_create_file);
+EXPORT_SYMBOL_GPL(relayfs_remove_file);
 
 MODULE_AUTHOR("Tom Zanussi <zanussi@us.ibm.com> and Karim Yaghmour <karim@opersys.com>");
 MODULE_DESCRIPTION("Relay Filesystem");
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -152,6 +152,7 @@ extern struct dentry *relayfs_create_fil
 					  int mode,
 					  struct file_operations *fops,
 					  void *data);
+extern int relayfs_remove_file(struct dentry *dentry);
 
 /**
  *	relay_write - write data into the channel


