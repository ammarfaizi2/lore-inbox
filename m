Return-Path: <linux-kernel-owner+w=401wt.eu-S1422677AbXAMOGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbXAMOGa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 09:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbXAMOGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 09:06:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3720 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422677AbXAMOG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 09:06:29 -0500
Date: Sat, 13 Jan 2007 15:06:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mhalcrow@us.ibm.com, phillip@hellewell.homeip.net
Cc: ecryptfs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: -mm patch] fs/ecryptfs/: make code static
Message-ID: <20070113140633.GN7469@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ecryptfs/crypto.c          |   24 ++++++++++++------------
 fs/ecryptfs/ecryptfs_kernel.h |   18 ------------------
 fs/ecryptfs/messaging.c       |   20 +++++++++++---------
 3 files changed, 23 insertions(+), 39 deletions(-)

--- linux-2.6.20-rc4-mm1/fs/ecryptfs/ecryptfs_kernel.h.old	2007-01-13 08:34:46.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/ecryptfs/ecryptfs_kernel.h	2007-01-13 14:31:01.000000000 +0100
@@ -329,18 +329,6 @@
 	struct mutex mux;
 };
 
-extern struct list_head ecryptfs_msg_ctx_free_list;
-extern struct list_head ecryptfs_msg_ctx_alloc_list;
-extern struct mutex ecryptfs_msg_ctx_lists_mux;
-
-#define ecryptfs_uid_hash(uid) \
-        hash_long((unsigned long)uid, ecryptfs_hash_buckets)
-extern struct hlist_head *ecryptfs_daemon_id_hash;
-extern struct mutex ecryptfs_daemon_id_hash_mux;
-extern int ecryptfs_hash_buckets;
-
-extern unsigned int ecryptfs_msg_counter;
-extern struct ecryptfs_msg_ctx *ecryptfs_msg_ctx_arr;
 extern unsigned int ecryptfs_transport;
 
 struct ecryptfs_daemon_id {
@@ -538,15 +526,9 @@
 int ecryptfs_decrypt_page(struct file *file, struct page *page);
 int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 			    struct file *lower_file);
-int ecryptfs_write_headers_virt(char *page_virt, size_t *size,
-				struct ecryptfs_crypt_stat *crypt_stat,
-				struct dentry *ecryptfs_dentry);
 int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry,
 			   struct file *lower_file);
 int ecryptfs_new_file_context(struct dentry *ecryptfs_dentry);
-int contains_ecryptfs_marker(char *data);
-int ecryptfs_read_header_region(char *data, struct dentry *dentry,
-				struct vfsmount *mnt);
 int ecryptfs_read_and_validate_header_region(char *data, struct dentry *dentry,
 					     struct vfsmount *mnt);
 int ecryptfs_read_and_validate_xattr_region(char *page_virt,
--- linux-2.6.20-rc4-mm1/fs/ecryptfs/crypto.c.old	2007-01-13 08:35:23.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/ecryptfs/crypto.c	2007-01-13 14:27:02.000000000 +0100
@@ -1026,7 +1026,7 @@
  *
  * Returns one if marker found; zero if not found
  */
-int contains_ecryptfs_marker(char *data)
+static int contains_ecryptfs_marker(char *data)
 {
 	u32 m_1, m_2;
 
@@ -1213,8 +1213,8 @@
  *
  * Returns zero on success; non-zero otherwise
  */
-int ecryptfs_read_header_region(char *data, struct dentry *dentry,
-				struct vfsmount *mnt)
+static int ecryptfs_read_header_region(char *data, struct dentry *dentry,
+				       struct vfsmount *mnt)
 {
 	struct file *lower_file;
 	mm_segment_t oldfs;
@@ -1310,9 +1310,9 @@
  *
  * Returns zero on success
  */
-int ecryptfs_write_headers_virt(char *page_virt, size_t *size,
-				struct ecryptfs_crypt_stat *crypt_stat,
-				struct dentry *ecryptfs_dentry)
+static int ecryptfs_write_headers_virt(char *page_virt, size_t *size,
+				       struct ecryptfs_crypt_stat *crypt_stat,
+				       struct dentry *ecryptfs_dentry)
 {
 	int rc;
 	size_t written;
@@ -1339,9 +1339,9 @@
 	return rc;
 }
 
-int ecryptfs_write_metadata_to_contents(struct ecryptfs_crypt_stat *crypt_stat,
-					struct file *lower_file,
-					char *page_virt)
+static int ecryptfs_write_metadata_to_contents(struct ecryptfs_crypt_stat *crypt_stat,
+					       struct file *lower_file,
+					       char *page_virt)
 {
 	mm_segment_t oldfs;
 	int current_header_page;
@@ -1366,9 +1366,9 @@
 	return 0;
 }
 
-int ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
-				     struct ecryptfs_crypt_stat *crypt_stat,
-				     char *page_virt, size_t size)
+static int ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
+					    struct ecryptfs_crypt_stat *crypt_stat,
+					    char *page_virt, size_t size)
 {
 	int rc;
 
--- linux-2.6.20-rc4-mm1/fs/ecryptfs/messaging.c.old	2007-01-13 14:28:20.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/ecryptfs/messaging.c	2007-01-13 14:31:27.000000000 +0100
@@ -22,16 +22,18 @@
 
 #include "ecryptfs_kernel.h"
 
-LIST_HEAD(ecryptfs_msg_ctx_free_list);
-LIST_HEAD(ecryptfs_msg_ctx_alloc_list);
-struct mutex ecryptfs_msg_ctx_lists_mux;
-
-struct hlist_head *ecryptfs_daemon_id_hash;
-struct mutex ecryptfs_daemon_id_hash_mux;
-int ecryptfs_hash_buckets;
+static LIST_HEAD(ecryptfs_msg_ctx_free_list);
+static LIST_HEAD(ecryptfs_msg_ctx_alloc_list);
+static struct mutex ecryptfs_msg_ctx_lists_mux;
+
+static struct hlist_head *ecryptfs_daemon_id_hash;
+static struct mutex ecryptfs_daemon_id_hash_mux;
+static int ecryptfs_hash_buckets;
+#define ecryptfs_uid_hash(uid) \
+        hash_long((unsigned long)uid, ecryptfs_hash_buckets)
 
-unsigned int ecryptfs_msg_counter;
-struct ecryptfs_msg_ctx *ecryptfs_msg_ctx_arr;
+static unsigned int ecryptfs_msg_counter;
+static struct ecryptfs_msg_ctx *ecryptfs_msg_ctx_arr;
 
 /**
  * ecryptfs_acquire_free_msg_ctx

