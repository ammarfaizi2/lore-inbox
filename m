Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVLPXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVLPXQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVLPXNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:13:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45532 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964831AbVLPXNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:34 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8DK019633@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 6/12]: MUTEX: Rename DECLARE_MUTEX for fs/ dir
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
fs/ directory.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-fs-2615rc5-2.diff
 fs/char_dev.c         |    2 +-
 fs/cramfs/inode.c     |    2 +-
 fs/dcookies.c         |    2 +-
 fs/inode.c            |    2 +-
 fs/jffs2/compr_zlib.c |    4 ++--
 fs/jfs/jfs_logmgr.c   |    2 +-
 fs/lockd/host.c       |    2 +-
 fs/lockd/svc.c        |    4 ++--
 fs/lockd/svcsubs.c    |    2 +-
 fs/nfs/callback.c     |    2 +-
 fs/nfsd/nfs4state.c   |    2 +-
 fs/ntfs/super.c       |    2 +-
 fs/partitions/devfs.c |    2 +-
 fs/super.c            |    2 +-
 14 files changed, 16 insertions(+), 16 deletions(-)

diff -uNrp linux-2.6.15-rc5/fs/char_dev.c linux-2.6.15-rc5-mutex/fs/char_dev.c
--- linux-2.6.15-rc5/fs/char_dev.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/char_dev.c	2005-12-15 17:14:57.000000000 +0000
@@ -28,7 +28,7 @@ static struct kobj_map *cdev_map;
 
 #define MAX_PROBE_HASH 255	/* random */
 
-static DECLARE_MUTEX(chrdevs_lock);
+static DECLARE_SEM_MUTEX(chrdevs_lock);
 
 static struct char_device_struct {
 	struct char_device_struct *next;
diff -uNrp linux-2.6.15-rc5/fs/cramfs/inode.c linux-2.6.15-rc5-mutex/fs/cramfs/inode.c
--- linux-2.6.15-rc5/fs/cramfs/inode.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/cramfs/inode.c	2005-12-15 17:14:57.000000000 +0000
@@ -31,7 +31,7 @@ static struct inode_operations cramfs_di
 static struct file_operations cramfs_directory_operations;
 static struct address_space_operations cramfs_aops;
 
-static DECLARE_MUTEX(read_mutex);
+static DECLARE_SEM_MUTEX(read_mutex);
 
 
 /* These two macros may change in future, to provide better st_ino
diff -uNrp linux-2.6.15-rc5/fs/dcookies.c linux-2.6.15-rc5-mutex/fs/dcookies.c
--- linux-2.6.15-rc5/fs/dcookies.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/dcookies.c	2005-12-15 17:14:57.000000000 +0000
@@ -35,7 +35,7 @@ struct dcookie_struct {
 };
 
 static LIST_HEAD(dcookie_users);
-static DECLARE_MUTEX(dcookie_sem);
+static DECLARE_SEM_MUTEX(dcookie_sem);
 static kmem_cache_t * dcookie_cache;
 static struct list_head * dcookie_hashtable;
 static size_t hash_size;
diff -uNrp linux-2.6.15-rc5/fs/inode.c linux-2.6.15-rc5-mutex/fs/inode.c
--- linux-2.6.15-rc5/fs/inode.c	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/inode.c	2005-12-15 17:14:57.000000000 +0000
@@ -90,7 +90,7 @@ DEFINE_SPINLOCK(inode_lock);
  * from its final dispose_list, the struct super_block they refer to
  * (for inode->i_sb->s_op) may already have been freed and reused.
  */
-DECLARE_MUTEX(iprune_sem);
+DECLARE_SEM_MUTEX(iprune_sem);
 
 /*
  * Statistics gathering..
diff -uNrp linux-2.6.15-rc5/fs/jffs2/compr_zlib.c linux-2.6.15-rc5-mutex/fs/jffs2/compr_zlib.c
--- linux-2.6.15-rc5/fs/jffs2/compr_zlib.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/jffs2/compr_zlib.c	2005-12-15 17:14:57.000000000 +0000
@@ -33,8 +33,8 @@
 	*/
 #define STREAM_END_SPACE 12
 
-static DECLARE_MUTEX(deflate_sem);
-static DECLARE_MUTEX(inflate_sem);
+static DECLARE_SEM_MUTEX(deflate_sem);
+static DECLARE_SEM_MUTEX(inflate_sem);
 static z_stream inf_strm, def_strm;
 
 #ifdef __KERNEL__ /* Linux-only */
diff -uNrp linux-2.6.15-rc5/fs/jfs/jfs_logmgr.c linux-2.6.15-rc5-mutex/fs/jfs/jfs_logmgr.c
--- linux-2.6.15-rc5/fs/jfs/jfs_logmgr.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/jfs/jfs_logmgr.c	2005-12-15 17:14:57.000000000 +0000
@@ -165,7 +165,7 @@ do {						\
  */
 static LIST_HEAD(jfs_external_logs);
 static struct jfs_log *dummy_log = NULL;
-static DECLARE_MUTEX(jfs_log_sem);
+static DECLARE_SEM_MUTEX(jfs_log_sem);
 
 /*
  * forward references
diff -uNrp linux-2.6.15-rc5/fs/lockd/host.c linux-2.6.15-rc5-mutex/fs/lockd/host.c
--- linux-2.6.15-rc5/fs/lockd/host.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/lockd/host.c	2005-12-15 17:14:57.000000000 +0000
@@ -30,7 +30,7 @@
 static struct nlm_host *	nlm_hosts[NLM_HOST_NRHASH];
 static unsigned long		next_gc;
 static int			nrhosts;
-static DECLARE_MUTEX(nlm_host_sema);
+static DECLARE_SEM_MUTEX(nlm_host_sema);
 
 
 static void			nlm_gc_hosts(void);
diff -uNrp linux-2.6.15-rc5/fs/lockd/svc.c linux-2.6.15-rc5-mutex/fs/lockd/svc.c
--- linux-2.6.15-rc5/fs/lockd/svc.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/lockd/svc.c	2005-12-15 17:14:57.000000000 +0000
@@ -43,13 +43,13 @@ static struct svc_program	nlmsvc_program
 struct nlmsvc_binding *		nlmsvc_ops;
 EXPORT_SYMBOL(nlmsvc_ops);
 
-static DECLARE_MUTEX(nlmsvc_sema);
+static DECLARE_SEM_MUTEX(nlmsvc_sema);
 static unsigned int		nlmsvc_users;
 static pid_t			nlmsvc_pid;
 int				nlmsvc_grace_period;
 unsigned long			nlmsvc_timeout;
 
-static DECLARE_MUTEX_LOCKED(lockd_start);
+static DECLARE_SEM_MUTEX_LOCKED(lockd_start);
 static DECLARE_WAIT_QUEUE_HEAD(lockd_exit);
 
 /*
diff -uNrp linux-2.6.15-rc5/fs/lockd/svcsubs.c linux-2.6.15-rc5-mutex/fs/lockd/svcsubs.c
--- linux-2.6.15-rc5/fs/lockd/svcsubs.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/lockd/svcsubs.c	2005-12-15 17:14:57.000000000 +0000
@@ -28,7 +28,7 @@
 #define FILE_HASH_BITS		5
 #define FILE_NRHASH		(1<<FILE_HASH_BITS)
 static struct nlm_file *	nlm_files[FILE_NRHASH];
-static DECLARE_MUTEX(nlm_file_sema);
+static DECLARE_SEM_MUTEX(nlm_file_sema);
 
 #ifdef NFSD_DEBUG
 static inline void nlm_debug_print_fh(char *msg, struct nfs_fh *f)
diff -uNrp linux-2.6.15-rc5/fs/nfs/callback.c linux-2.6.15-rc5-mutex/fs/nfs/callback.c
--- linux-2.6.15-rc5/fs/nfs/callback.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/nfs/callback.c	2005-12-15 17:14:57.000000000 +0000
@@ -28,7 +28,7 @@ struct nfs_callback_data {
 };
 
 static struct nfs_callback_data nfs_callback_info;
-static DECLARE_MUTEX(nfs_callback_sema);
+static DECLARE_SEM_MUTEX(nfs_callback_sema);
 static struct svc_program nfs4_callback_program;
 
 unsigned short nfs_callback_tcpport;
diff -uNrp linux-2.6.15-rc5/fs/nfsd/nfs4state.c linux-2.6.15-rc5-mutex/fs/nfsd/nfs4state.c
--- linux-2.6.15-rc5/fs/nfsd/nfs4state.c	2005-11-01 13:19:15.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/nfsd/nfs4state.c	2005-12-15 17:14:57.000000000 +0000
@@ -81,7 +81,7 @@ static void nfs4_set_recdir(char *recdir
  * 	protects clientid_hashtbl[], clientstr_hashtbl[],
  * 	unconfstr_hashtbl[], uncofid_hashtbl[].
  */
-static DECLARE_MUTEX(client_sema);
+static DECLARE_SEM_MUTEX(client_sema);
 
 static kmem_cache_t *stateowner_slab = NULL;
 static kmem_cache_t *file_slab = NULL;
diff -uNrp linux-2.6.15-rc5/fs/ntfs/super.c linux-2.6.15-rc5-mutex/fs/ntfs/super.c
--- linux-2.6.15-rc5/fs/ntfs/super.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/ntfs/super.c	2005-12-15 17:14:57.000000000 +0000
@@ -3012,7 +3012,7 @@ kmem_cache_t *ntfs_attr_ctx_cache;
 kmem_cache_t *ntfs_index_ctx_cache;
 
 /* Driver wide semaphore. */
-DECLARE_MUTEX(ntfs_lock);
+DECLARE_SEM_MUTEX(ntfs_lock);
 
 static struct super_block *ntfs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
diff -uNrp linux-2.6.15-rc5/fs/partitions/devfs.c linux-2.6.15-rc5-mutex/fs/partitions/devfs.c
--- linux-2.6.15-rc5/fs/partitions/devfs.c	2005-01-04 11:13:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/partitions/devfs.c	2005-12-15 17:14:57.000000000 +0000
@@ -16,7 +16,7 @@ struct unique_numspace {
 	struct semaphore  mutex;
 };
 
-static DECLARE_MUTEX(numspace_mutex);
+static DECLARE_SEM_MUTEX(numspace_mutex);
 
 static int expand_numspace(struct unique_numspace *s)
 {
diff -uNrp linux-2.6.15-rc5/fs/super.c linux-2.6.15-rc5-mutex/fs/super.c
--- linux-2.6.15-rc5/fs/super.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/super.c	2005-12-15 17:14:57.000000000 +0000
@@ -380,7 +380,7 @@ restart:
 void sync_filesystems(int wait)
 {
 	struct super_block *sb;
-	static DECLARE_MUTEX(mutex);
+	static DECLARE_SEM_MUTEX(mutex);
 
 	down(&mutex);		/* Could be down_interruptible */
 	spin_lock(&sb_lock);
