Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUHQPn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUHQPn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUHQPmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:42:12 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:49633 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268295AbUHQPTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:19:20 -0400
Message-ID: <41222195.3020108@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:17:41 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10]
Content-Type: multipart/mixed;
	boundary="------------050403090103030605050706"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403090103030605050706
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------050403090103030605050706
Content-Type: text/plain;
	name="gcc34_inline_09.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_09.diff"

--- 28p1/fs/freevxfs/vxfs_extern.h~	2002-02-25 21:38:08.000000000 +0200
+++ 28p1/fs/freevxfs/vxfs_extern.h	2004-08-17 03:32:45.000000000 +0300
@@ -72,7 +72,7 @@
 
 /* vxfs_subr.c */
 extern struct page *		vxfs_get_page(struct address_space *, u_long);
-extern __inline__ void		vxfs_put_page(struct page *);
+extern void			vxfs_put_page(struct page *);
 extern struct buffer_head *	vxfs_bread(struct inode *, int);
 
 #endif /* _VXFS_EXTERN_H_ */
--- 28p1/fs/freevxfs/vxfs_subr.c~	2002-02-25 21:38:08.000000000 +0200
+++ 28p1/fs/freevxfs/vxfs_subr.c	2004-08-17 03:34:31.000000000 +0300
@@ -50,6 +50,12 @@
 	.sync_page =		block_sync_page,
 };
 
+__inline__ void
+vxfs_put_page(struct page *pp)
+{
+	kunmap(pp);
+	page_cache_release(pp);
+}
 
 /**
  * vxfs_get_page - read a page into memory.
@@ -88,13 +94,6 @@
 	return ERR_PTR(-EIO);
 }
 
-__inline__ void
-vxfs_put_page(struct page *pp)
-{
-	kunmap(pp);
-	page_cache_release(pp);
-}
-
 /**
  * vxfs_bread - read buffer for a give inode,block tuple
  * @ip:		inode
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
--- 28p1/fs/intermezzo/file.c~	2004-02-18 15:36:31.000000000 +0200
+++ 28p1/fs/intermezzo/file.c	2004-08-07 14:09:39.000000000 +0300
@@ -78,16 +78,19 @@
         pathlen = MYPATHLEN(buffer, path);
         
         CDEBUG(D_FILE, "de %p, dd %p\n", de, dd);
+
         if (dd->remote_ino == 0) {
                 rc = presto_get_fileid(minor, fset, de);
+                if (dd->remote_ino == 0)
+                        CERROR("get_fileid failed %d, ino: %Lx, fetching by name\n", rc,
+                               dd->remote_ino);
+
         }
         memset (&info, 0, sizeof(info));
         if (dd->remote_ino > 0) {
                 info.remote_ino = dd->remote_ino;
                 info.remote_generation = dd->remote_generation;
-        } else
-                CERROR("get_fileid failed %d, ino: %Lx, fetching by name\n", rc,
-                       dd->remote_ino);
+        }
 
         rc = izo_upc_open(minor, pathlen, path, fset->fset_name, &info);
         PRESTO_FREE(buffer, PAGE_SIZE);
--- 28p1/fs/intermezzo/methods.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/methods.c	2004-08-17 05:02:58.000000000 +0300
@@ -254,8 +254,8 @@
         if (ops == NULL) {
                 CERROR("prepare to die: unrecognized cache type for Filter\n");
         }
-        return ops;
         FEXIT;
+        return ops;
 }
 
 
--- 28p1/fs/intermezzo/journal_xfs.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/journal_xfs.c	2004-08-17 05:02:58.000000000 +0300
@@ -58,7 +57,7 @@
         VFS_STATVFS(vfsp, &stat, NULL, rc);
         avail = statp.f_bfree;
 
-        return sbp->sb_fdblocks;; 
+        return sbp->sb_fdblocks;
 #endif
         return 0x0fffffff;
 }
--- 28p1/fs/intermezzo/psdev.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/psdev.c	2004-08-17 15:18:34.000000000 +0300
@@ -564,6 +564,10 @@
         buffer->u_uniq = req->rq_unique;
         buffer->u_async = async;
 
+        /* Remove potential datarace possibility*/
+        if ( async ) 
+                req->rq_flags = REQ_ASYNC;
+
         spin_lock(&channel->uc_lock); 
         /* Append msg to pending queue and poke Lento. */
         list_add(&req->rq_chain, channel->uc_pending.prev);
@@ -576,7 +580,7 @@
 
         if ( async ) {
                 /* req, rq_data are freed in presto_psdev_read for async */
-                req->rq_flags = REQ_ASYNC;
+                /* req->rq_flags = REQ_ASYNC;*/
                 EXIT;
                 return 0;
         }
@@ -647,5 +651,6 @@
 exit_req:
         PRESTO_FREE(req, sizeof(struct upc_req));
 exit_buf:
+        PRESTO_FREE(buffer,*size);
         return error;
 }
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
--- 28p1/fs/ncpfs/ncplib_kernel.h~	2004-08-16 20:23:00.000000000 +0300
+++ 28p1/fs/ncpfs/ncplib_kernel.h	2004-08-17 12:37:24.000000000 +0300
@@ -131,7 +131,7 @@
 
 #endif /* CONFIG_NCPFS_NLS */
 
-inline int
+int
 ncp_strnicmp(struct nls_table *,
 		const unsigned char *, const unsigned char *, int);
 
--- 28p1/include/linux/reiserfs_fs.h~	2004-08-16 20:23:01.000000000 +0300
+++ 28p1/include/linux/reiserfs_fs.h	2004-08-17 12:49:58.000000000 +0300
@@ -1771,25 +1771,25 @@
 /* stree.c */
 int B_IS_IN_TREE(const struct buffer_head *);
 extern inline void copy_short_key (void * to, const void * from);
-extern inline void copy_item_head(struct item_head * p_v_to, 
+extern void copy_item_head(struct item_head * p_v_to,
 								  const struct item_head * p_v_from);
 
 // first key is in cpu form, second - le
-extern inline int comp_keys (const struct key * le_key, 
+extern int comp_keys (const struct key * le_key,
 			     const struct cpu_key * cpu_key);
-extern inline int  comp_short_keys (const struct key * le_key, 
+extern int  comp_short_keys (const struct key * le_key,
 				    const struct cpu_key * cpu_key);
-extern inline void le_key2cpu_key (struct cpu_key * to, const struct key * from);
+extern void le_key2cpu_key (struct cpu_key * to, const struct key * from);
 
 // both are cpu keys
-extern inline int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
-extern inline int comp_short_cpu_keys (const struct cpu_key *, 
+extern  int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
+extern int comp_short_cpu_keys (const struct cpu_key *,
 				       const struct cpu_key *);
-extern inline void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
+extern void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
 
 // both are in le form
-extern inline int comp_le_keys (const struct key *, const struct key *);
-extern inline int comp_short_le_keys (const struct key *, const struct key *);
+extern int comp_le_keys (const struct key *, const struct key *);
+extern int comp_short_le_keys (const struct key *, const struct key *);
 
 //
 // get key version from on disk key - kludge
@@ -1824,7 +1824,7 @@
 int search_for_position_by_key (struct super_block * p_s_sb, 
 								const struct cpu_key * p_s_cpu_key, 
 								struct path * p_s_search_path);
-extern inline void decrement_bcount (struct buffer_head * p_s_bh);
+extern void decrement_bcount (struct buffer_head * p_s_bh);
 void decrement_counters_in_path (struct path * p_s_search_path);
 void pathrelse (struct path * p_s_search_path);
 int reiserfs_check_path(struct path *p) ;
@@ -1902,7 +1902,7 @@
 void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs );
 
 /* namei.c */
-inline void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
+void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
 int search_by_entry_key (struct super_block * sb, const struct cpu_key * key, 
 			 struct path * path, 
 			 struct reiserfs_dir_entry * de);
@@ -2050,7 +2050,7 @@
                       struct buffer_head **);
 
 /* do_balance.c */
-inline void do_balance_mark_leaf_dirty (struct tree_balance * tb, 
+void do_balance_mark_leaf_dirty (struct tree_balance * tb,
 					struct buffer_head * bh, int flag);
 #define do_balance_mark_internal_dirty do_balance_mark_leaf_dirty
 #define do_balance_mark_sb_dirty do_balance_mark_leaf_dirty
--- 28p1/include/linux/fs.h~	2004-08-16 20:23:00.000000000 +0300
+++ 28p1/include/linux/fs.h	2004-08-17 13:02:49.000000000 +0300
@@ -1528,7 +1528,7 @@
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
-extern inline ssize_t do_generic_direct_read(struct file *, char *, size_t, loff_t *);
+extern ssize_t do_generic_direct_read(struct file *, char *, size_t, loff_t *);
 extern int precheck_file_write(struct file *, struct inode *, size_t *, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);

--------------050403090103030605050706--
