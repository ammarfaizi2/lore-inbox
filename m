Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUHDN5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUHDN5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUHDN5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:57:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265893AbUHDN5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:57:13 -0400
Date: Wed, 4 Aug 2004 09:56:56 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Chris Wright <chrisw@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040804135110.GA13270@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0408040955310.9630-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Arjan van de Ven wrote:

> hmmm looks bullshit now that I look at it again.

OK, I removed the ipc/util.c chunk from the patch now.

Here's the complete patch again, addressing all of Chris's
latest issues.  If nobody else has big objections, I'd like
to get this merged upstream ;)


--- linux-2.6.7/include/asm-ppc64/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-ppc64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-m68k/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-m68k/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-parisc/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-parisc/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-ppc/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-ppc/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -36,7 +36,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-x86_64/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-x86_64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE , PAGE_SIZE  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-ia64/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-ia64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -46,7 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/linux/mm.h.mlock	2004-08-04 07:47:05.000000000 -0400
+++ linux-2.6.7/include/linux/mm.h	2004-08-04 07:47:06.000000000 -0400
@@ -498,9 +498,20 @@ int shmem_set_policy(struct vm_area_stru
 struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 					unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
-void shmem_lock(struct file * file, int lock);
+int shmem_lock(struct file * file, int lock, struct user_struct *);
 int shmem_zero_setup(struct vm_area_struct *);
 
+static inline int can_do_mlock(void)
+{
+	if (capable(CAP_IPC_LOCK))
+		return 1;
+	if (current->rlim[RLIMIT_MEMLOCK].rlim_cur != 0)
+		return 1;
+	return 0;
+}
+extern int user_can_mlock(size_t, struct user_struct *);
+extern void user_subtract_mlock(size_t, struct user_struct *);
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
--- linux-2.6.7/include/linux/shm.h.mlock	2004-06-16 01:19:43.000000000 -0400
+++ linux-2.6.7/include/linux/shm.h	2004-08-04 07:47:06.000000000 -0400
@@ -84,6 +84,7 @@ struct shmid_kernel /* private to the ke
 	time_t			shm_ctim;
 	pid_t			shm_cprid;
 	pid_t			shm_lprid;
+	struct user_struct *	mlock_user;
 };
 
 /* shm_mode upper byte flags */
--- linux-2.6.7/include/linux/sched.h.mlock	2004-08-04 07:47:04.000000000 -0400
+++ linux-2.6.7/include/linux/sched.h	2004-08-04 07:47:06.000000000 -0400
@@ -331,6 +331,7 @@ struct user_struct {
 	atomic_t sigpending;	/* How many pending signals does this user have? */
 	/* protected by mq_lock	*/
 	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
+	unsigned long locked_shm; /* How many pages of mlocked shm ? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
--- linux-2.6.7/include/asm-arm/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-arm/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,      PAGE_SIZE    },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-sparc/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-sparc/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -44,7 +44,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE, PAGE_SIZE},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-alpha/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-alpha/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -41,7 +41,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
+    {PAGE_SIZE, PAGE_SIZE},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
     {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
--- linux-2.6.7/include/asm-h8300/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-h8300/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-i386/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-i386/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -40,7 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-s390/resource.h.mlock	2004-08-04 07:46:42.000000000 -0400
+++ linux-2.6.7/include/asm-s390/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -47,7 +47,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-cris/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-cris/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },               \
+	{     PAGE_SIZE,    PAGE_SIZE  },               \
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-sparc64/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-sparc64/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -43,7 +43,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE,     PAGE_SIZE    },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-arm26/resource.h.mlock	2004-08-04 07:46:41.000000000 -0400
+++ linux-2.6.7/include/asm-arm26/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,     PAGE_SIZE     },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-v850/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-v850/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE, PAGE_SIZE  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-sh/resource.h.mlock	2004-08-04 07:46:43.000000000 -0400
+++ linux-2.6.7/include/asm-sh/resource.h	2004-08-04 07:47:06.000000000 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/fs/hugetlbfs/inode.c.mlock	2004-08-04 07:47:03.000000000 -0400
+++ linux-2.6.7/fs/hugetlbfs/inode.c	2004-08-04 07:47:06.000000000 -0400
@@ -718,19 +718,22 @@ static unsigned long hugetlbfs_counter(v
 
 struct file *hugetlb_zero_setup(size_t size)
 {
-	int error;
+	int error = -ENOMEM;
 	struct file *file;
 	struct inode *inode;
 	struct dentry *dentry, *root;
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
 
 	if (!is_hugepage_mem_enough(size))
 		return ERR_PTR(-ENOMEM);
 
+	if (!user_can_mlock(size, current->user))
+		return ERR_PTR(-ENOMEM);
+
 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
 	quick_string.name = buf;
@@ -738,7 +741,7 @@ struct file *hugetlb_zero_setup(size_t s
 	quick_string.hash = 0;
 	dentry = d_alloc(root, &quick_string);
 	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+		goto out_subtract_mlock;
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -765,6 +768,8 @@ out_file:
 	put_filp(file);
 out_dentry:
 	dput(dentry);
+out_subtract_mlock:
+	user_subtract_mlock(size, current->user);
 	return ERR_PTR(error);
 }
 
--- linux-2.6.7/kernel/user.c.mlock	2004-08-04 07:46:45.000000000 -0400
+++ linux-2.6.7/kernel/user.c	2004-08-04 07:47:06.000000000 -0400
@@ -32,7 +32,8 @@ struct user_struct root_user = {
 	.processes	= ATOMIC_INIT(1),
 	.files		= ATOMIC_INIT(0),
 	.sigpending	= ATOMIC_INIT(0),
-	.mq_bytes	= 0
+	.mq_bytes	= 0,
+	.locked_shm     = 0
 };
 
 /*
@@ -113,6 +114,7 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->sigpending, 0);
 
 		new->mq_bytes = 0;
+		new->locked_shm = 0;
 
 		/*
 		 * Before adding this, check whether we raced
--- linux-2.6.7/ipc/shm.c.mlock	2004-08-04 07:46:45.000000000 -0400
+++ linux-2.6.7/ipc/shm.c	2004-08-04 08:32:39.000000000 -0400
@@ -114,7 +114,10 @@ static void shm_destroy (struct shmid_ke
 	shm_rmid (shp->id);
 	shm_unlock(shp);
 	if (!is_file_hugepages(shp->shm_file))
-		shmem_lock(shp->shm_file, 0);
+		shmem_lock(shp->shm_file, 0, shp->mlock_user);
+	else
+		user_subtract_mlock(shp->shm_file->f_dentry->d_inode->i_size,
+						shp->mlock_user);
 	fput (shp->shm_file);
 	security_shm_free(shp);
 	ipc_rcu_free(shp, sizeof(struct shmid_kernel));
@@ -190,6 +193,7 @@ static int newseg (key_t key, int shmflg
 
 	shp->shm_perm.key = key;
 	shp->shm_flags = (shmflg & S_IRWXUGO);
+	shp->mlock_user = NULL;
 
 	shp->shm_perm.security = NULL;
 	error = security_shm_alloc(shp);
@@ -198,9 +202,11 @@ static int newseg (key_t key, int shmflg
 		return error;
 	}
 
-	if (shmflg & SHM_HUGETLB)
+	if (shmflg & SHM_HUGETLB) {
+		/* hugetlb_zero_setup takes care of mlock user accounting */
 		file = hugetlb_zero_setup(size);
-	else {
+		shp->mlock_user = current->user;
+	} else {
 		sprintf (name, "SYSV%08x", key);
 		file = shmem_file_setup(name, size, VM_ACCOUNT);
 	}
@@ -504,14 +510,11 @@ asmlinkage long sys_shmctl (int shmid, i
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 	{
-/* Allow superuser to lock segment in memory */
-/* Should the pages be faulted in here or leave it to user? */
-/* need to determine interaction with current->swappable */
-		if (!capable(CAP_IPC_LOCK)) {
+		/* Allow superuser to lock segment in memory */
+		if (!can_do_mlock() && cmd == SHM_LOCK) {
 			err = -EPERM;
 			goto out;
 		}
-
 		shp = shm_lock(shmid);
 		if(shp==NULL) {
 			err = -EINVAL;
@@ -526,13 +529,18 @@ asmlinkage long sys_shmctl (int shmid, i
 			goto out_unlock;
 		
 		if(cmd==SHM_LOCK) {
-			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 1);
-			shp->shm_flags |= SHM_LOCKED;
-		} else {
-			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 0);
+			struct user_struct * user = current->user;
+			if (!is_file_hugepages(shp->shm_file)) {
+				err = shmem_lock(shp->shm_file, 1, current->user);
+				if (!err) {
+					shp->shm_flags |= SHM_LOCKED;
+					shp->mlock_user = user;
+				}
+			}
+		} else if (!is_file_hugepages(shp->shm_file)) {
+			shmem_lock(shp->shm_file, 0, shp->mlock_user);
 			shp->shm_flags &= ~SHM_LOCKED;
+			shp->mlock_user = NULL;
 		}
 		shm_unlock(shp);
 		goto out;
--- linux-2.6.7/mm/mlock.c.mlock	2004-06-16 01:18:57.000000000 -0400
+++ linux-2.6.7/mm/mlock.c	2004-08-04 09:28:14.417102357 -0400
@@ -60,7 +60,7 @@ static int do_mlock(unsigned long start,
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !capable(CAP_IPC_LOCK))
+	if (on && !can_do_mlock())
 		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -118,7 +118,7 @@ asmlinkage long sys_mlock(unsigned long 
 	lock_limit >>= PAGE_SHIFT;
 
 	/* check against resource limits */
-	if (locked <= lock_limit)
+	if ( (locked <= lock_limit) || capable(CAP_IPC_LOCK))
 		error = do_mlock(start, len, 1);
 	up_write(&current->mm->mmap_sem);
 	return error;
@@ -142,7 +142,7 @@ static int do_mlockall(int flags)
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return -EPERM;
 
 	def_flags = 0;
@@ -177,7 +177,7 @@ asmlinkage long sys_mlockall(int flags)
 	lock_limit >>= PAGE_SHIFT;
 
 	ret = -ENOMEM;
-	if (current->mm->total_vm <= lock_limit)
+	if ((current->mm->total_vm <= lock_limit) || capable(CAP_IPC_LOCK))
 		ret = do_mlockall(flags);
 out:
 	up_write(&current->mm->mmap_sem);
@@ -193,3 +193,36 @@ asmlinkage long sys_munlockall(void)
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }
+
+/*
+ * Objects with different lifetime than processes (mlocked shm segments
+ * and hugetlb files) get accounted against the user_struct instead. 
+ */
+static spinlock_t mlock_user_lock = SPIN_LOCK_UNLOCKED;
+
+int user_can_mlock(size_t size, struct user_struct * user)
+{
+	unsigned long lock_limit, locked;
+	int allowed = 0;
+
+	spin_lock(&mlock_user_lock);
+	locked = size >> PAGE_SHIFT;
+	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+	lock_limit >>= PAGE_SHIFT;
+	if (locked + user->locked_shm > lock_limit)
+		goto out;
+	get_uid(user);
+	user->locked_shm += locked;
+	allowed = 1;
+out:
+	spin_unlock(&mlock_user_lock);
+	return allowed;
+}
+
+void user_subtract_mlock(size_t size, struct user_struct * user)
+{
+	spin_lock(&mlock_user_lock);
+	user->locked_shm -= (size >> PAGE_SHIFT);
+	spin_unlock(&mlock_user_lock);
+	free_uid(user);
+}
--- linux-2.6.7/mm/mmap.c.mlock	2004-08-04 07:47:04.000000000 -0400
+++ linux-2.6.7/mm/mmap.c	2004-08-04 07:47:06.000000000 -0400
@@ -806,15 +806,17 @@ unsigned long do_mmap_pgoff(struct file 
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED) {
-		if (!capable(CAP_IPC_LOCK))
+		if (!can_do_mlock())
 			return -EPERM;
 		vm_flags |= VM_LOCKED;
 	}
 	/* mlock MCL_FUTURE? */
 	if (vm_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
@@ -1746,9 +1748,11 @@ unsigned long do_brk(unsigned long addr,
 	 * mlock MCL_FUTURE?
 	 */
 	if (mm->def_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
--- linux-2.6.7/mm/mremap.c.mlock	2004-08-04 07:46:45.000000000 -0400
+++ linux-2.6.7/mm/mremap.c	2004-08-04 07:47:06.000000000 -0400
@@ -324,10 +324,12 @@ unsigned long do_mremap(unsigned long ad
 			goto out;
 	}
 	if (vma->vm_flags & VM_LOCKED) {
-		unsigned long locked = current->mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = current->mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += new_len - old_len;
 		ret = -EAGAIN;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			goto out;
 	}
 	ret = -ENOMEM;
--- linux-2.6.7/mm/shmem.c.mlock	2004-08-04 07:46:58.000000000 -0400
+++ linux-2.6.7/mm/shmem.c	2004-08-04 09:29:47.337557579 -0400
@@ -1151,17 +1151,29 @@ shmem_get_policy(struct vm_area_struct *
 }
 #endif
 
-void shmem_lock(struct file *file, int lock)
+int shmem_lock(struct file *file, int lock, struct user_struct * user)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	int retval = -ENOMEM;
+
+	if (lock && !can_do_mlock())
+		return -EPERM;
 
 	spin_lock(&info->lock);
-	if (lock)
+	if (lock && !(info->flags & VM_LOCKED)) {
+		if (!user_can_mlock(inode->i_size, user) && !capable(CAP_IPC_LOCK))
+			goto out_nomem;
 		info->flags |= VM_LOCKED;
-	else
+	}
+	if (!lock && (info->flags & VM_LOCKED) && user) {
+		user_subtract_mlock(inode->i_size, user);
 		info->flags &= ~VM_LOCKED;
+	}
+	retval = 0;
+out_nomem:
 	spin_unlock(&info->lock);
+	return retval;
 }
 
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)

