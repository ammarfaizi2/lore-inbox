Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUHDC5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUHDC5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUHDC5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:57:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266425AbUHDC40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:56:26 -0400
Date: Tue, 3 Aug 2004 22:56:15 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040804023120.GK2334@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0408032254250.32641-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, William Lee Irwin III wrote:

> By any chance could you repost a complete patch and/or series?

Here you are.  It is fits into the Fedora kernel rpm, but
I guess it should apply to upstream and -mm too.

Please check if there are any spots left where this patch
did something wrong. I'd like to get this merged ASAP, so
I will fix any actual errors people find.

If people find additional stuff that needs work in the same
area, I can look at that later in follow-up patches.


--- linux-2.6.7/include/asm-ppc64/resource.h.mlock	2004-08-03 22:46:28.030210685 -0400
+++ linux-2.6.7/include/asm-ppc64/resource.h	2004-08-03 22:46:43.185742010 -0400
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-m68k/resource.h.mlock	2004-08-03 22:46:27.194457109 -0400
+++ linux-2.6.7/include/asm-m68k/resource.h	2004-08-03 22:46:43.189740831 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-parisc/resource.h.mlock	2004-08-03 22:46:27.751292925 -0400
+++ linux-2.6.7/include/asm-parisc/resource.h	2004-08-03 22:46:43.192739946 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-ppc/resource.h.mlock	2004-08-03 22:46:27.918243699 -0400
+++ linux-2.6.7/include/asm-ppc/resource.h	2004-08-03 22:46:43.196738767 -0400
@@ -36,7 +36,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-x86_64/resource.h.mlock	2004-08-03 22:46:28.754996979 -0400
+++ linux-2.6.7/include/asm-x86_64/resource.h	2004-08-03 22:46:43.199737883 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE , PAGE_SIZE  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-ia64/resource.h.mlock	2004-08-03 22:46:27.039502798 -0400
+++ linux-2.6.7/include/asm-ia64/resource.h	2004-08-03 22:46:43.202736999 -0400
@@ -46,7 +46,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/linux/mm.h.mlock	2004-08-03 22:46:42.762866697 -0400
+++ linux-2.6.7/include/linux/mm.h	2004-08-03 22:46:43.209734935 -0400
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
+++ linux-2.6.7/include/linux/shm.h	2004-08-03 22:46:43.241725503 -0400
@@ -84,6 +84,7 @@ struct shmid_kernel /* private to the ke
 	time_t			shm_ctim;
 	pid_t			shm_cprid;
 	pid_t			shm_lprid;
+	struct user_struct *	mlock_user;
 };
 
 /* shm_mode upper byte flags */
--- linux-2.6.7/include/linux/sched.h.mlock	2004-08-03 22:46:42.140050338 -0400
+++ linux-2.6.7/include/linux/sched.h	2004-08-03 22:46:43.252722260 -0400
@@ -331,6 +331,7 @@ struct user_struct {
 	atomic_t sigpending;	/* How many pending signals does this user have? */
 	/* protected by mq_lock	*/
 	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
+	unsigned long locked_shm; /* How many pages of mlocked shm ? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
--- linux-2.6.7/include/asm-arm/resource.h.mlock	2004-08-03 22:46:26.638620999 -0400
+++ linux-2.6.7/include/asm-arm/resource.h	2004-08-03 22:46:43.358691015 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,      PAGE_SIZE    },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-sparc/resource.h.mlock	2004-08-03 22:46:28.557055343 -0400
+++ linux-2.6.7/include/asm-sparc/resource.h	2004-08-03 22:46:43.362689836 -0400
@@ -44,7 +44,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE, PAGE_SIZE},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-alpha/resource.h.mlock	2004-08-03 22:46:26.332711198 -0400
+++ linux-2.6.7/include/asm-alpha/resource.h	2004-08-03 22:46:43.365688951 -0400
@@ -41,7 +41,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
+    {PAGE_SIZE, PAGE_SIZE},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
     {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
     {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
--- linux-2.6.7/include/asm-h8300/resource.h.mlock	2004-08-03 22:46:26.781578848 -0400
+++ linux-2.6.7/include/asm-h8300/resource.h	2004-08-03 22:46:43.368688067 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-i386/resource.h.mlock	2004-08-03 22:46:26.959526379 -0400
+++ linux-2.6.7/include/asm-i386/resource.h	2004-08-03 22:46:43.371687183 -0400
@@ -40,7 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-s390/resource.h.mlock	2004-08-03 22:46:28.102189462 -0400
+++ linux-2.6.7/include/asm-s390/resource.h	2004-08-03 22:46:43.373686593 -0400
@@ -47,7 +47,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-cris/resource.h.mlock	2004-08-03 22:46:26.721596534 -0400
+++ linux-2.6.7/include/asm-cris/resource.h	2004-08-03 22:46:43.376685709 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },               \
+	{     PAGE_SIZE,    PAGE_SIZE  },               \
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-sparc64/resource.h.mlock	2004-08-03 22:46:28.636032057 -0400
+++ linux-2.6.7/include/asm-sparc64/resource.h	2004-08-03 22:46:43.379684825 -0400
@@ -43,7 +43,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE,     PAGE_SIZE    },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-arm26/resource.h.mlock	2004-08-03 22:46:26.671611272 -0400
+++ linux-2.6.7/include/asm-arm26/resource.h	2004-08-03 22:46:43.382683940 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,     PAGE_SIZE     },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
--- linux-2.6.7/include/asm-v850/resource.h.mlock	2004-08-03 22:46:28.683018203 -0400
+++ linux-2.6.7/include/asm-v850/resource.h	2004-08-03 22:46:43.385683056 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE, PAGE_SIZE  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/include/asm-sh/resource.h.mlock	2004-08-03 22:46:28.228152321 -0400
+++ linux-2.6.7/include/asm-sh/resource.h	2004-08-03 22:46:43.387682466 -0400
@@ -39,7 +39,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
--- linux-2.6.7/fs/hugetlbfs/inode.c.mlock	2004-08-03 22:46:41.332288511 -0400
+++ linux-2.6.7/fs/hugetlbfs/inode.c	2004-08-03 22:46:43.394680403 -0400
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
 
--- linux-2.6.7/kernel/user.c.mlock	2004-08-03 22:46:30.113596392 -0400
+++ linux-2.6.7/kernel/user.c	2004-08-03 22:46:43.396679813 -0400
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
--- linux-2.6.7/ipc/shm.c.mlock	2004-08-03 22:46:29.848674505 -0400
+++ linux-2.6.7/ipc/shm.c	2004-08-03 22:46:43.399678929 -0400
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
@@ -198,9 +201,11 @@ static int newseg (key_t key, int shmflg
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
@@ -221,6 +226,7 @@ static int newseg (key_t key, int shmflg
 	shp->shm_nattch = 0;
 	shp->id = shm_buildid(id,shp->shm_perm.seq);
 	shp->shm_file = file;
+	shp->mlock_user = NULL;
 	file->f_dentry->d_inode->i_ino = shp->id;
 	if (shmflg & SHM_HUGETLB)
 		set_file_hugepages(file);
@@ -504,14 +510,11 @@ asmlinkage long sys_shmctl (int shmid, i
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 	{
-/* Allow superuser to lock segment in memory */
-/* Should the pages be faulted in here or leave it to user? */
-/* need to determine interaction with current->swappable */
-		if (!capable(CAP_IPC_LOCK)) {
+		/* Allow superuser to lock segment in memory */
+		if (!can_do_mlock()) {
 			err = -EPERM;
 			goto out;
 		}
-
 		shp = shm_lock(shmid);
 		if(shp==NULL) {
 			err = -EINVAL;
@@ -526,13 +529,19 @@ asmlinkage long sys_shmctl (int shmid, i
 			goto out_unlock;
 		
 		if(cmd==SHM_LOCK) {
-			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 1);
-			shp->shm_flags |= SHM_LOCKED;
+			struct user_struct * user = current->user;
+			if (!is_file_hugepages(shp->shm_file)) {
+				err = shmem_lock(shp->shm_file, 1, current->user);
+				if (!err) {
+					shp->shm_flags |= SHM_LOCKED;
+					shp->mlock_user = user;
+				}
+			}
 		} else {
 			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 0);
+				shmem_lock(shp->shm_file, 0, shp->mlock_user);
 			shp->shm_flags &= ~SHM_LOCKED;
+			shp->mlock_user = NULL;
 		}
 		shm_unlock(shp);
 		goto out;
--- linux-2.6.7/ipc/util.c.mlock	2004-08-03 22:46:29.851673621 -0400
+++ linux-2.6.7/ipc/util.c	2004-08-03 22:46:43.402678045 -0400
@@ -392,8 +392,11 @@ int ipcperms (struct kern_ipc_perm *ipcp
 		granted_mode >>= 3;
 	/* is there some bit set in requested_mode but not in granted_mode? */
 	if ((requested_mode & ~granted_mode & 0007) && 
-	    !capable(CAP_IPC_OWNER))
-		return -1;
+	    !capable(CAP_IPC_OWNER)) {
+		if (!can_do_mlock())  {
+			return -1;
+		}
+	}	
 
 	return security_ipc_permission(ipcp, flag);
 }
--- linux-2.6.7/mm/mlock.c.mlock	2004-06-16 01:18:57.000000000 -0400
+++ linux-2.6.7/mm/mlock.c	2004-08-03 22:46:43.431669497 -0400
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
@@ -193,3 +193,38 @@ asmlinkage long sys_munlockall(void)
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
+	atomic_inc(&user->__count);
+	user->locked_shm += locked;
+	allowed = 1;
+out:
+	spin_unlock(&mlock_user_lock);
+	return allowed;
+}
+
+void user_subtract_mlock(size_t size, struct user_struct * user)
+{
+	if (user) {
+		spin_lock(&mlock_user_lock);
+		user->locked_shm -= (size >> PAGE_SHIFT);
+		spin_unlock(&mlock_user_lock);
+		free_uid(user);
+	}
+}
--- linux-2.6.7/mm/mmap.c.mlock	2004-08-03 22:46:42.101061834 -0400
+++ linux-2.6.7/mm/mmap.c	2004-08-03 22:46:43.436668023 -0400
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
 
--- linux-2.6.7/mm/mremap.c.mlock	2004-08-03 22:46:30.312537733 -0400
+++ linux-2.6.7/mm/mremap.c	2004-08-03 22:46:43.439667138 -0400
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
--- linux-2.6.7/mm/shmem.c.mlock	2004-08-03 22:46:39.416853287 -0400
+++ linux-2.6.7/mm/shmem.c	2004-08-03 22:46:43.444665665 -0400
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
+	if (!can_do_mlock())
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

