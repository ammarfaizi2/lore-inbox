Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUHWRSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUHWRSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUHWRSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:18:38 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:39131 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266204AbUHWRPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:15:53 -0400
Message-ID: <412A2607.2080100@ttnet.net.tr>
Date: Mon, 23 Aug 2004 20:14:47 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10] [2/4]
Content-Type: multipart/mixed;
	boundary="------------020501080002050604080307"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020501080002050604080307
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

splitted-up the fs/* gcc3.4-inline-patches.

[2/4] intermezzo inlining+lvalue fixes



--------------020501080002050604080307
Content-Type: text/plain;
	name="gcc34_inline_09-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_09-2.diff"

--- 28p1/include/linux/fsfilter.h~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/include/linux/fsfilter.h	2004-08-17 04:53:12.000000000 +0300
@@ -74,22 +74,22 @@
 
 struct filter_fs *filter_get_filter_fs(const char *cache_type);
 void filter_setup_journal_ops(struct filter_fs *ops, char *cache_type);
-inline struct super_operations *filter_c2usops(struct filter_fs *cache);
-inline struct inode_operations *filter_c2ufiops(struct filter_fs *cache);
-inline struct inode_operations *filter_c2udiops(struct filter_fs *cache);
-inline struct inode_operations *filter_c2usiops(struct filter_fs *cache);
-inline struct file_operations *filter_c2uffops(struct filter_fs *cache);
-inline struct file_operations *filter_c2udfops(struct filter_fs *cache);
-inline struct file_operations *filter_c2usfops(struct filter_fs *cache);
-inline struct super_operations *filter_c2csops(struct filter_fs *cache);
-inline struct inode_operations *filter_c2cfiops(struct filter_fs *cache);
-inline struct inode_operations *filter_c2cdiops(struct filter_fs *cache);
-inline struct inode_operations *filter_c2csiops(struct filter_fs *cache);
-inline struct file_operations *filter_c2cffops(struct filter_fs *cache);
-inline struct file_operations *filter_c2cdfops(struct filter_fs *cache);
-inline struct file_operations *filter_c2csfops(struct filter_fs *cache);
-inline struct dentry_operations *filter_c2cdops(struct filter_fs *cache);
-inline struct dentry_operations *filter_c2udops(struct filter_fs *cache);
+struct super_operations *filter_c2usops(struct filter_fs *cache);
+struct inode_operations *filter_c2ufiops(struct filter_fs *cache);
+struct inode_operations *filter_c2udiops(struct filter_fs *cache);
+struct inode_operations *filter_c2usiops(struct filter_fs *cache);
+struct file_operations *filter_c2uffops(struct filter_fs *cache);
+struct file_operations *filter_c2udfops(struct filter_fs *cache);
+struct file_operations *filter_c2usfops(struct filter_fs *cache);
+struct super_operations *filter_c2csops(struct filter_fs *cache);
+struct inode_operations *filter_c2cfiops(struct filter_fs *cache);
+struct inode_operations *filter_c2cdiops(struct filter_fs *cache);
+struct inode_operations *filter_c2csiops(struct filter_fs *cache);
+struct file_operations *filter_c2cffops(struct filter_fs *cache);
+struct file_operations *filter_c2cdfops(struct filter_fs *cache);
+struct file_operations *filter_c2csfops(struct filter_fs *cache);
+struct dentry_operations *filter_c2cdops(struct filter_fs *cache);
+struct dentry_operations *filter_c2udops(struct filter_fs *cache);
 
 void filter_setup_super_ops(struct filter_fs *cache, struct super_operations *cache_ops, struct super_operations *filter_sops);
 void filter_setup_dir_ops(struct filter_fs *cache, struct inode *cache_inode, struct inode_operations *filter_iops, struct file_operations *ffops);
--- 28p1/include/linux/intermezzo_fs.h~	2004-08-17 05:11:48.000000000 +0300
+++ 28p1/include/linux/intermezzo_fs.h	2004-08-17 14:45:58.000000000 +0300
@@ -49,8 +49,6 @@
         struct presto_version remote_version;
 };
 
-static inline int izo_ioctl_is_invalid(struct izo_ioctl_data *data);
-
 #ifdef __KERNEL__
 # include <linux/smp.h>
 # include <linux/fsfilter.h>
@@ -336,7 +334,7 @@
 int presto_psdev_init(void);
 int izo_psdev_setpid(int minor);
 extern void presto_psdev_cleanup(void);
-inline int presto_lento_up(int minor);
+int presto_lento_up(int minor);
 int izo_psdev_setchannel(struct file *file, int fd);
 
 /* inode.c */
@@ -347,7 +345,7 @@
 void presto_frob_dop(struct dentry *de);
 char *presto_path(struct dentry *dentry, struct dentry *root,
                   char *buffer, int buflen);
-inline struct presto_dentry_data *izo_alloc_ddata(void);
+struct presto_dentry_data *izo_alloc_ddata(void);
 int presto_set_dd(struct dentry *);
 int presto_init_ddata_cache(void);
 void presto_cleanup_ddata_cache(void);
@@ -412,7 +410,7 @@
                        unsigned int flags);
 int presto_set_fsetroot_from_ioc(struct dentry *dentry, char *fsetname,
                                  unsigned int flags);
-inline int presto_is_read_only(struct presto_file_set *);
+int presto_is_read_only(struct presto_file_set *);
 int presto_truncate_lml(struct presto_file_set *fset);
 int lento_write_lml(char *path,
                      __u64 remote_ino,
@@ -420,13 +418,13 @@
                      __u32 remote_version,
                     struct presto_version *remote_file_version);
 int lento_complete_closes(char *path);
-inline int presto_f2m(struct presto_file_set *fset);
+int presto_f2m(struct presto_file_set *fset);
 int presto_prep(struct dentry *, struct presto_cache **,
                        struct presto_file_set **);
 /* cache.c */
 extern struct presto_cache *presto_cache_init(void);
-extern inline void presto_cache_add(struct presto_cache *cache, kdev_t dev);
-extern inline void presto_cache_init_hash(void);
+extern void presto_cache_add(struct presto_cache *cache, kdev_t dev);
+extern void presto_cache_init_hash(void);
 
 struct presto_cache *presto_cache_find(kdev_t dev);
 
@@ -553,7 +551,7 @@
 
 #define JOURNAL_PAGE_SZ  PAGE_SIZE
 
-__inline__ int presto_no_journal(struct presto_file_set *fset);
+int presto_no_journal(struct presto_file_set *fset);
 int journal_fetch(int minor);
 int presto_log(struct presto_file_set *fset, struct rec_info *rec,
                const char *buf, size_t size,
@@ -658,6 +656,8 @@
 loff_t izo_rcvd_upd_remote(struct presto_file_set *fset, char * uuid,  __u64 remote_recno,
                            __u64 remote_offset);
 
+int izo_ioctl_packlen(struct izo_ioctl_data *data);
+
 /* sysctl.c */
 int init_intermezzo_sysctl(void);
 void cleanup_intermezzo_sysctl(void);
@@ -715,6 +715,54 @@
         return tmp;
 }
 
+static inline int izo_ioctl_is_invalid(struct izo_ioctl_data *data)
+{
+        if (data->ioc_len > (1<<30)) {
+                CERROR("IZO ioctl: ioc_len larger than 1<<30\n");
+                return 1;
+        }
+        if (data->ioc_inllen1 > (1<<30)) {
+                CERROR("IZO ioctl: ioc_inllen1 larger than 1<<30\n");
+                return 1;
+        }
+        if (data->ioc_inllen2 > (1<<30)) {
+                CERROR("IZO ioctl: ioc_inllen2 larger than 1<<30\n");
+                return 1;
+        }
+        if (data->ioc_inlbuf1 && !data->ioc_inllen1) {
+                CERROR("IZO ioctl: inlbuf1 pointer but 0 length\n");
+                return 1;
+        }
+        if (data->ioc_inlbuf2 && !data->ioc_inllen2) {
+                CERROR("IZO ioctl: inlbuf2 pointer but 0 length\n");
+                return 1;
+        }
+        if (data->ioc_pbuf1 && !data->ioc_plen1) {
+                CERROR("IZO ioctl: pbuf1 pointer but 0 length\n");
+                return 1;
+        }
+        if (data->ioc_pbuf2 && !data->ioc_plen2) {
+                CERROR("IZO ioctl: pbuf2 pointer but 0 length\n");
+                return 1;
+        }
+        if (izo_ioctl_packlen(data) != data->ioc_len ) {
+                CERROR("IZO ioctl: packlen exceeds ioc_len\n");
+                return 1;
+        }
+        if (data->ioc_inllen1 &&
+            data->ioc_bulk[data->ioc_inllen1 - 1] != '\0') {
+                CERROR("IZO ioctl: inlbuf1 not 0 terminated\n");
+                return 1;
+        }
+        if (data->ioc_inllen2 &&
+            data->ioc_bulk[size_round(data->ioc_inllen1) + data->ioc_inllen2
+                           - 1] != '\0') {
+                CERROR("IZO ioctl: inlbuf2 not 0 terminated\n");
+                return 1;
+        }
+        return 0;
+}
+
 /* buffer MUST be at least the size of izo_ioctl_hdr */
 static inline int izo_ioctl_getdata(char *buf, char *end, void *arg)
 {
@@ -798,8 +846,6 @@
 int kml_iocreint(__u32 size, char *ptr, __u32 offset, int dird,
                  uuid_t uuid, __u32 generate_kml);
 
-static inline int izo_ioctl_packlen(struct izo_ioctl_data *data);
-
 static inline void izo_ioctl_init(struct izo_ioctl_data *data)
 {
         memset(data, 0, sizeof(*data));
@@ -861,62 +907,6 @@
         return "Unknown InterMezzo error";
 }
 
-static inline int izo_ioctl_packlen(struct izo_ioctl_data *data)
-{
-        int len = sizeof(struct izo_ioctl_data);
-        len += size_round(data->ioc_inllen1);
-        len += size_round(data->ioc_inllen2);
-        return len;
-}
-
-static inline int izo_ioctl_is_invalid(struct izo_ioctl_data *data)
-{
-        if (data->ioc_len > (1<<30)) {
-                CERROR("IZO ioctl: ioc_len larger than 1<<30\n");
-                return 1;
-        }
-        if (data->ioc_inllen1 > (1<<30)) {
-                CERROR("IZO ioctl: ioc_inllen1 larger than 1<<30\n");
-                return 1;
-        }
-        if (data->ioc_inllen2 > (1<<30)) {
-                CERROR("IZO ioctl: ioc_inllen2 larger than 1<<30\n");
-                return 1;
-        }
-        if (data->ioc_inlbuf1 && !data->ioc_inllen1) {
-                CERROR("IZO ioctl: inlbuf1 pointer but 0 length\n");
-                return 1;
-        }
-        if (data->ioc_inlbuf2 && !data->ioc_inllen2) {
-                CERROR("IZO ioctl: inlbuf2 pointer but 0 length\n");
-                return 1;
-        }
-        if (data->ioc_pbuf1 && !data->ioc_plen1) {
-                CERROR("IZO ioctl: pbuf1 pointer but 0 length\n");
-                return 1;
-        }
-        if (data->ioc_pbuf2 && !data->ioc_plen2) {
-                CERROR("IZO ioctl: pbuf2 pointer but 0 length\n");
-                return 1;
-        }
-        if (izo_ioctl_packlen(data) != data->ioc_len ) {
-                CERROR("IZO ioctl: packlen exceeds ioc_len\n");
-                return 1;
-        }
-        if (data->ioc_inllen1 &&
-            data->ioc_bulk[data->ioc_inllen1 - 1] != '\0') {
-                CERROR("IZO ioctl: inlbuf1 not 0 terminated\n");
-                return 1;
-        }
-        if (data->ioc_inllen2 &&
-            data->ioc_bulk[size_round(data->ioc_inllen1) + data->ioc_inllen2
-                           - 1] != '\0') {
-                CERROR("IZO ioctl: inlbuf2 not 0 terminated\n");
-                return 1;
-        }
-        return 0;
-}
-
 /* kml_unpack.c */
 char *kml_print_rec(struct kml_rec *rec, int brief);
 int kml_unpack(struct kml_rec *rec, char **buf, char *end);
--- 28p1/fs/intermezzo/cache.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/cache.c	2004-08-17 05:02:58.000000000 +0300
@@ -78,6 +78,14 @@
         }
 }
 
+int izo_ioctl_packlen(struct izo_ioctl_data *data)
+{
+        int len = sizeof(struct izo_ioctl_data);
+        len += size_round(data->ioc_inllen1);
+        len += size_round(data->ioc_inllen2);
+        return len;
+}
+
 /* map a device to a cache */
 struct presto_cache *presto_cache_find(kdev_t dev)
 {

--- 28p1/fs/intermezzo/sysctl.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/sysctl.c	2004-08-17 05:02:58.000000000 +0300
@@ -290,6 +290,8 @@
 	 * happens once per reboot.
 	 */
 	for(i = 0; i < total_dev; i++) {
+		void *p;
+
 		/* entry for this /proc/sys/intermezzo/intermezzo"i" */
 		ctl_table *psdev = &presto_table[i + PRESTO_PRIMARY_CTLCNT];
 		/* entries for the individual "files" in this "directory" */
@@ -302,7 +303,8 @@
 		/* the psdev has to point to psdev_entries, and fix the number */
 		psdev->ctl_name = psdev->ctl_name + i + 1; /* sorry */
 
-		PRESTO_ALLOC((void*)psdev->procname, PROCNAME_SIZE);
+		PRESTO_ALLOC(p, PROCNAME_SIZE);
+		psdev->procname = p;
 		if (!psdev->procname) {
 			PRESTO_FREE(dev_ctl_table,
 				    sizeof(ctl_table) * total_entries);


--------------020501080002050604080307--
