Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWFAKD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWFAKD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWFAKDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:03:55 -0400
Received: from ns2.suse.de ([195.135.220.15]:51654 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964942AbWFAKCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:02:54 -0400
Message-Id: <20060601100134.682629000@hasse.suse.de>
References: <20060601095125.773684000@hasse.suse.de>
User-Agent: quilt/0.44-16
Date: Thu, 01 Jun 2006 11:51:26 +0200
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       dgc@sgi.com, balbir@in.ibm.com
Subject: [patch 1/5] vfs: remove whitespace noise from fs/dcache.c
Content-Disposition: inline; filename=patches.jbl/vfs-whitespace-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some whitespace noise from fs/dcache.c.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/dcache.c |  128 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

Index: work-2.6/fs/dcache.c
===================================================================
--- work-2.6.orig/fs/dcache.c
+++ work-2.6/fs/dcache.c
@@ -74,7 +74,7 @@ static void d_callback(struct rcu_head *
 
 	if (dname_external(dentry))
 		kfree(dentry->d_name.name);
-	kmem_cache_free(dentry_cache, dentry); 
+	kmem_cache_free(dentry_cache, dentry);
 }
 
 /*
@@ -85,7 +85,7 @@ static void d_free(struct dentry *dentry
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
- 	call_rcu(&dentry->d_u.d_rcu, d_callback);
+	call_rcu(&dentry->d_u.d_rcu, d_callback);
 }
 
 /*
@@ -113,7 +113,7 @@ static void dentry_iput(struct dentry * 
 	}
 }
 
-/* 
+/*
  * This is dput
  *
  * This is complicated by the fact that we do not want to put
@@ -132,7 +132,7 @@ static void dentry_iput(struct dentry * 
 
 /*
  * dput - release a dentry
- * @dentry: dentry to release 
+ * @dentry: dentry to release
  *
  * Release a dentry. This will drop the usage count and if appropriate
  * call the dentry unlink method as well as removing it from the queues and
@@ -168,14 +168,14 @@ repeat:
 			goto unhash_it;
 	}
 	/* Unreachable? Get rid of it */
- 	if (d_unhashed(dentry))
+	if (d_unhashed(dentry))
 		goto kill_it;
-  	if (list_empty(&dentry->d_lru)) {
-  		dentry->d_flags |= DCACHE_REFERENCED;
-  		list_add(&dentry->d_lru, &dentry_unused);
-  		dentry_stat.nr_unused++;
-  	}
- 	spin_unlock(&dentry->d_lock);
+	if (list_empty(&dentry->d_lru)) {
+		dentry->d_flags |= DCACHE_REFERENCED;
+		list_add(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
+	}
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 	return;
 
@@ -188,11 +188,11 @@ kill_it: {
 		/* If dentry was on d_lru list
 		 * delete it from there
 		 */
-  		if (!list_empty(&dentry->d_lru)) {
-  			list_del(&dentry->d_lru);
-  			dentry_stat.nr_unused--;
-  		}
-  		list_del(&dentry->d_u.d_child);
+		if (!list_empty(&dentry->d_lru)) {
+			list_del(&dentry->d_lru);
+			dentry_stat.nr_unused--;
+		}
+		list_del(&dentry->d_u.d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/*drops the locks, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
@@ -216,7 +216,7 @@ kill_it: {
  *
  * no dcache lock.
  */
- 
+
 int d_invalidate(struct dentry * dentry)
 {
 	/*
@@ -308,7 +308,7 @@ static struct dentry * __d_find_alias(st
 		next = tmp->next;
 		prefetch(next);
 		alias = list_entry(tmp, struct dentry, d_alias);
- 		if (S_ISDIR(inode->i_mode) || !d_unhashed(alias)) {
+		if (S_ISDIR(inode->i_mode) || !d_unhashed(alias)) {
 			if (alias->d_flags & DCACHE_DISCONNECTED)
 				discon_alias = alias;
 			else if (!want_discon) {
@@ -391,7 +391,7 @@ static inline void prune_one_dentry(stru
  * This function may fail to free any resources if
  * all the dentries are in use.
  */
- 
+
 static void prune_dcache(int count)
 {
 	spin_lock(&dcache_lock);
@@ -406,25 +406,25 @@ static void prune_dcache(int count)
 			break;
 		list_del_init(tmp);
 		prefetch(dentry_unused.prev);
- 		dentry_stat.nr_unused--;
+		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
- 		spin_lock(&dentry->d_lock);
+		spin_lock(&dentry->d_lock);
 		/*
 		 * We found an inuse dentry which was not removed from
 		 * dentry_unused because of laziness during lookup.  Do not free
 		 * it - just keep it off the dentry_unused list.
 		 */
- 		if (atomic_read(&dentry->d_count)) {
- 			spin_unlock(&dentry->d_lock);
+		if (atomic_read(&dentry->d_count)) {
+			spin_unlock(&dentry->d_lock);
 			continue;
 		}
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_flags & DCACHE_REFERENCED) {
 			dentry->d_flags &= ~DCACHE_REFERENCED;
- 			list_add(&dentry->d_lru, &dentry_unused);
- 			dentry_stat.nr_unused++;
- 			spin_unlock(&dentry->d_lock);
+			list_add(&dentry->d_lru, &dentry_unused);
+			dentry_stat.nr_unused++;
+			spin_unlock(&dentry->d_lock);
 			continue;
 		}
 		prune_one_dentry(dentry);
@@ -499,7 +499,7 @@ repeat:
  * We descend to the next level whenever the d_subdirs
  * list is non-empty and continue searching.
  */
- 
+
 /**
  * have_submounts - check for mounts over a dentry
  * @parent: dentry to check.
@@ -507,7 +507,7 @@ repeat:
  * Return true if the parent or its subdirectories contain
  * a mount point
  */
- 
+
 int have_submounts(struct dentry *parent)
 {
 	struct dentry *this_parent = parent;
@@ -579,8 +579,8 @@ resume:
 			dentry_stat.nr_unused--;
 			list_del_init(&dentry->d_lru);
 		}
-		/* 
-		 * move only zero ref count dentries to the end 
+		/*
+		 * move only zero ref count dentries to the end
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
@@ -624,7 +624,7 @@ out:
  *
  * Prune the dcache to remove unused children of the parent dentry.
  */
- 
+
 void shrink_dcache_parent(struct dentry * parent)
 {
 	int found;
@@ -657,8 +657,8 @@ void shrink_dcache_anon(struct hlist_hea
 				list_del_init(&this->d_lru);
 			}
 
-			/* 
-			 * move only zero ref count dentries to the end 
+			/*
+			 * move only zero ref count dentries to the end
 			 * of the unused list for prune_dcache
 			 */
 			if (!atomic_read(&this->d_count)) {
@@ -703,25 +703,25 @@ static int shrink_dcache_memory(int nr, 
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
+
 struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 {
 	struct dentry *dentry;
 	char *dname;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
+	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
 	if (!dentry)
 		return NULL;
 
 	if (name->len > DNAME_INLINE_LEN-1) {
 		dname = kmalloc(name->len + 1, GFP_KERNEL);
 		if (!dname) {
-			kmem_cache_free(dentry_cache, dentry); 
+			kmem_cache_free(dentry_cache, dentry);
 			return NULL;
 		}
 	} else  {
 		dname = dentry->d_iname;
-	}	
+	}
 	dentry->d_name.name = dname;
 
 	dentry->d_name.len = name->len;
@@ -786,7 +786,7 @@ struct dentry *d_alloc_name(struct dentr
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
+
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!list_empty(&entry->d_alias));
@@ -861,7 +861,7 @@ EXPORT_SYMBOL(d_instantiate_unique);
  * instantiated and returned. %NULL is returned if there is insufficient
  * memory or the inode passed is %NULL.
  */
- 
+
 struct dentry * d_alloc_root(struct inode * root_inode)
 {
 	struct dentry *res = NULL;
@@ -892,7 +892,7 @@ static inline struct hlist_head *d_hash(
  * @inode: inode to allocate the dentry for
  *
  * This is similar to d_alloc_root.  It is used by filesystems when
- * creating a dentry for a given inode, often in the process of 
+ * creating a dentry for a given inode, often in the process of
  * mapping a filehandle to a dentry.  The returned dentry may be
  * anonymous, or may have a full name (if the inode was already
  * in the cache).  The file system may need to make further
@@ -923,7 +923,7 @@ struct dentry * d_alloc_anon(struct inod
 		return NULL;
 
 	tmp->d_parent = tmp; /* make sure dput doesn't croak */
-	
+
 	spin_lock(&dcache_lock);
 	res = __d_find_alias(inode, 0);
 	if (!res) {
@@ -1009,7 +1009,7 @@ struct dentry *d_splice_alias(struct ino
  * finished using it. %NULL is returned on failure.
  *
  * __d_lookup is dcache_lock free. The hash list is protected using RCU.
- * Memory barriers are used while updating and doing lockless traversal. 
+ * Memory barriers are used while updating and doing lockless traversal.
  * To avoid races with d_move while rename is happening, d_lock is used.
  *
  * Overflows in memcmp(), while d_move, are avoided by keeping the length
@@ -1032,10 +1032,10 @@ struct dentry * d_lookup(struct dentry *
 	struct dentry * dentry = NULL;
 	unsigned long seq;
 
-        do {
-                seq = read_seqbegin(&rename_lock);
-                dentry = __d_lookup(parent, name);
-                if (dentry)
+	do {
+		seq = read_seqbegin(&rename_lock);
+		dentry = __d_lookup(parent, name);
+		if (dentry)
 			break;
 	} while (read_seqretry(&rename_lock, seq));
 	return dentry;
@@ -1052,7 +1052,7 @@ struct dentry * __d_lookup(struct dentry
 	struct dentry *dentry;
 
 	rcu_read_lock();
-	
+
 	hlist_for_each_entry_rcu(dentry, node, head, d_hash) {
 		struct qstr *qstr;
 
@@ -1094,10 +1094,10 @@ struct dentry * __d_lookup(struct dentry
 		break;
 next:
 		spin_unlock(&dentry->d_lock);
- 	}
- 	rcu_read_unlock();
+	}
+	rcu_read_unlock();
 
- 	return found;
+	return found;
 }
 
 /**
@@ -1137,7 +1137,7 @@ out:
  * This is used by ncpfs in its readdir implementation.
  * Zero is returned in the dentry is invalid.
  */
- 
+
 int d_validate(struct dentry *dentry, struct dentry *dparent)
 {
 	struct hlist_head *base;
@@ -1152,7 +1152,7 @@ int d_validate(struct dentry *dentry, st
 
 	spin_lock(&dcache_lock);
 	base = d_hash(dparent, dentry->d_name.hash);
-	hlist_for_each(lhp,base) { 
+	hlist_for_each(lhp,base) {
 		/* hlist_for_each_entry_rcu() not required for d_hash list
 		 * as it is parsed under dcache_lock
 		 */
@@ -1179,7 +1179,7 @@ out:
  * it from the hash queues and waiting for
  * it to be deleted later when it has no users
  */
- 
+
 /**
  * d_delete - delete a dentry
  * @dentry: The dentry to delete
@@ -1187,7 +1187,7 @@ out:
  * Turn the dentry into a negative dentry if possible, otherwise
  * remove it from the hash queues so it can be deleted later
  */
- 
+
 void d_delete(struct dentry * dentry)
 {
 	int isdir = 0;
@@ -1218,8 +1218,8 @@ void d_delete(struct dentry * dentry)
 static void __d_rehash(struct dentry * entry, struct hlist_head *list)
 {
 
- 	entry->d_flags &= ~DCACHE_UNHASHED;
- 	hlist_add_head_rcu(&entry->d_hash, list);
+	entry->d_flags &= ~DCACHE_UNHASHED;
+	hlist_add_head_rcu(&entry->d_hash, list);
 }
 
 /**
@@ -1228,7 +1228,7 @@ static void __d_rehash(struct dentry * e
  *
  * Adds a dentry to the hash according to its name.
  */
- 
+
 void d_rehash(struct dentry * entry)
 {
 	struct hlist_head *list = d_hash(entry->d_parent, entry->d_name.hash);
@@ -1302,7 +1302,7 @@ static void switch_names(struct dentry *
  * up under the name it got deleted rather than the name that
  * deleted it.
  */
- 
+
 /**
  * d_move - move a dentry
  * @dentry: entry to move
@@ -1560,7 +1560,7 @@ out:
  * Returns 0 otherwise.
  * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
  */
-  
+
 int is_subdir(struct dentry * new_dentry, struct dentry * old_dentry)
 {
 	int result;
@@ -1571,7 +1571,7 @@ int is_subdir(struct dentry * new_dentry
 	 * d_move
 	 */
 	rcu_read_lock();
-        do {
+	do {
 		/* for restarting inner loop in case of seq retry */
 		new_dentry = saved;
 		result = 0;
@@ -1636,7 +1636,7 @@ resume:
  * filesystems using synthetic inode numbers, and is necessary
  * to keep getcwd() working.
  */
- 
+
 ino_t find_inode_number(struct dentry *dir, struct qstr *name)
 {
 	struct dentry * dentry;
@@ -1689,10 +1689,10 @@ static void __init dcache_init(unsigned 
 {
 	int loop;
 
-	/* 
+	/*
 	 * A constructor could be added for stable state like the lists,
 	 * but it is probably not worth it because of the cache nature
-	 * of the dcache. 
+	 * of the dcache.
 	 */
 	dentry_cache = kmem_cache_create("dentry_cache",
 					 sizeof(struct dentry),
@@ -1700,7 +1700,7 @@ static void __init dcache_init(unsigned 
 					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
 					 SLAB_MEM_SPREAD),
 					 NULL, NULL);
-	
+
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
 	/* Hash may have been set up in dcache_init_early */

