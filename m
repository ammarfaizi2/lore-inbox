Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVAFWP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVAFWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVAFWP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:15:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18701 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261168AbVAFWOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:14:46 -0500
Date: Thu, 6 Jan 2005 23:14:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jaharkes@cs.cmu.edu, coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/coda/: make some code static
Message-ID: <20050106221443.GD28628@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 fs/coda/cnode.c           |    2 -
 fs/coda/dir.c             |    2 -
 fs/coda/file.c            |    2 -
 fs/coda/inode.c           |    2 -
 fs/coda/sysctl.c          |   56 +++++++++++++++++++-------------------
 include/linux/coda_proc.h |   21 --------------
 6 files changed, 33 insertions(+), 52 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/coda/cnode.c.old	2005-01-06 22:35:31.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/coda/cnode.c	2005-01-06 22:35:40.000000000 +0100
@@ -11,7 +11,7 @@
 #include <linux/coda_fs_i.h>
 #include <linux/coda_psdev.h>
 
-inline int coda_fideq(struct CodaFid *fid1, struct CodaFid *fid2)
+static inline int coda_fideq(struct CodaFid *fid1, struct CodaFid *fid2)
 {
 	return memcmp(fid1, fid2, sizeof(*fid1)) == 0;
 }
--- linux-2.6.10-mm2-full/fs/coda/dir.c.old	2005-01-06 22:36:03.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/coda/dir.c	2005-01-06 22:50:39.000000000 +0100
@@ -55,7 +55,7 @@
 
 int coda_hasmknod;
 
-struct dentry_operations coda_dentry_operations =
+static struct dentry_operations coda_dentry_operations =
 {
 	.d_revalidate	= coda_dentry_revalidate,
 	.d_delete	= coda_dentry_delete,
--- linux-2.6.10-mm2-full/fs/coda/file.c.old	2005-01-06 22:41:15.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/coda/file.c	2005-01-06 22:41:25.000000000 +0100
@@ -26,7 +26,7 @@
 
 /* if CODA_STORE fails with EOPNOTSUPP, venus clearly doesn't support
  * CODA_STORE/CODA_RELEASE and we fall back on using the CODA_CLOSE upcall */
-int use_coda_close;
+static int use_coda_close;
 
 static ssize_t
 coda_file_read(struct file *coda_file, char __user *buf, size_t count, loff_t *ppos)
--- linux-2.6.10-mm2-full/fs/coda/inode.c.old	2005-01-06 22:41:39.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/coda/inode.c	2005-01-06 22:41:48.000000000 +0100
@@ -89,7 +89,7 @@
 }
 
 /* exported operations */
-struct super_operations coda_super_operations =
+static struct super_operations coda_super_operations =
 {
 	.alloc_inode	= coda_alloc_inode,
 	.destroy_inode	= coda_destroy_inode,
--- linux-2.6.10-mm2-full/include/linux/coda_proc.h.old	2005-01-06 22:42:42.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/coda_proc.h	2005-01-06 22:49:20.000000000 +0100
@@ -72,26 +72,5 @@
 
 /* these global variables hold the actual statistics data */
 extern struct coda_vfs_stats		coda_vfs_stat;
-extern struct coda_cache_inv_stats	coda_cache_inv_stat;
-
-/* reset statistics to 0 */
-void reset_coda_vfs_stats( void );
-void reset_coda_cache_inv_stats( void );
-
-/* like coda_dointvec, these functions are to be registered in the ctl_table
- * data structure for /proc/sys/... files 
- */
-int do_reset_coda_vfs_stats( ctl_table * table, int write, struct file * filp,
-			     void __user * buffer, size_t * lenp, loff_t * ppos );
-int do_reset_coda_cache_inv_stats( ctl_table * table, int write, 
-				   struct file * filp, void __user * buffer, 
-				   size_t * lenp, loff_t * ppos );
-
-/* these functions are called to form the content of /proc/fs/coda/... files */
-int coda_vfs_stats_get_info( char * buffer, char ** start, off_t offset,
-			     int length);
-int coda_cache_inv_stats_get_info( char * buffer, char ** start, off_t offset,
-				   int length);
-
 
 #endif /* _CODA_PROC_H */
--- linux-2.6.10-mm2-full/fs/coda/sysctl.c.old	2005-01-06 22:43:20.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/coda/sysctl.c	2005-01-06 22:49:31.000000000 +0100
@@ -41,35 +41,22 @@
 #define CODA_CACHE_INV 	 9       /* cache invalidation statistics */
 #define CODA_FAKE_STATFS 10	 /* don't query venus for actual cache usage */
 
-static ctl_table coda_table[] = {
- 	{CODA_TIMEOUT, "timeout", &coda_timeout, sizeof(int), 0644, NULL, &proc_dointvec},
- 	{CODA_HARD, "hard", &coda_hard, sizeof(int), 0644, NULL, &proc_dointvec},
- 	{CODA_VFS, "vfs_stats", NULL, 0, 0644, NULL, &do_reset_coda_vfs_stats},
- 	{CODA_CACHE_INV, "cache_inv_stats", NULL, 0, 0644, NULL, &do_reset_coda_cache_inv_stats},
- 	{CODA_FAKE_STATFS, "fake_statfs", &coda_fake_statfs, sizeof(int), 0600, NULL, &proc_dointvec},
-	{ 0 }
-};
-
-static ctl_table fs_table[] = {
-       {FS_CODA, "coda",    NULL, 0, 0555, coda_table},
-       {0}
-};
-
 struct coda_vfs_stats		coda_vfs_stat;
-struct coda_cache_inv_stats	coda_cache_inv_stat;
+static struct coda_cache_inv_stats	coda_cache_inv_stat;
 
-void reset_coda_vfs_stats( void )
+static void reset_coda_vfs_stats( void )
 {
 	memset( &coda_vfs_stat, 0, sizeof( coda_vfs_stat ) );
 }
 
-void reset_coda_cache_inv_stats( void )
+static void reset_coda_cache_inv_stats( void )
 {
 	memset( &coda_cache_inv_stat, 0, sizeof( coda_cache_inv_stat ) );
 }
 
-int do_reset_coda_vfs_stats( ctl_table * table, int write, struct file * filp,
-			     void __user * buffer, size_t * lenp, loff_t * ppos )
+static int do_reset_coda_vfs_stats( ctl_table * table, int write,
+				    struct file * filp, void __user * buffer,
+				    size_t * lenp, loff_t * ppos )
 {
 	if ( write ) {
 		reset_coda_vfs_stats();
@@ -82,9 +69,10 @@
 	return 0;
 }
 
-int do_reset_coda_cache_inv_stats( ctl_table * table, int write, 
-				   struct file * filp, void __user * buffer, 
-				   size_t * lenp, loff_t * ppos )
+static int do_reset_coda_cache_inv_stats( ctl_table * table, int write, 
+					  struct file * filp,
+					  void __user * buffer, 
+					  size_t * lenp, loff_t * ppos )
 {
 	if ( write ) {
 		reset_coda_cache_inv_stats();
@@ -97,8 +85,8 @@
 	return 0;
 }
 
-int coda_vfs_stats_get_info( char * buffer, char ** start, off_t offset,
-			     int length)
+static int coda_vfs_stats_get_info( char * buffer, char ** start,
+				    off_t offset, int length)
 {
 	int len=0;
 	off_t begin;
@@ -158,8 +146,8 @@
 	return len;
 }
 
-int coda_cache_inv_stats_get_info( char * buffer, char ** start, off_t offset,
-				   int length)
+static int coda_cache_inv_stats_get_info( char * buffer, char ** start,
+					  off_t offset, int length)
 {
 	int len=0;
 	off_t begin;
@@ -196,6 +184,20 @@
 	return len;
 }
 
+static ctl_table coda_table[] = {
+ 	{CODA_TIMEOUT, "timeout", &coda_timeout, sizeof(int), 0644, NULL, &proc_dointvec},
+ 	{CODA_HARD, "hard", &coda_hard, sizeof(int), 0644, NULL, &proc_dointvec},
+ 	{CODA_VFS, "vfs_stats", NULL, 0, 0644, NULL, &do_reset_coda_vfs_stats},
+ 	{CODA_CACHE_INV, "cache_inv_stats", NULL, 0, 0644, NULL, &do_reset_coda_cache_inv_stats},
+ 	{CODA_FAKE_STATFS, "fake_statfs", &coda_fake_statfs, sizeof(int), 0600, NULL, &proc_dointvec},
+	{ 0 }
+};
+
+static ctl_table fs_table[] = {
+       {FS_CODA, "coda",    NULL, 0, 0555, coda_table},
+       {0}
+};
+
 
 #ifdef CONFIG_PROC_FS
 
@@ -207,7 +209,7 @@
 
 */
 
-struct proc_dir_entry* proc_fs_coda;
+static struct proc_dir_entry* proc_fs_coda;
 
 #endif
 

