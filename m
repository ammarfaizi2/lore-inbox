Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUFDPO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUFDPO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265790AbUFDPO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:14:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265799AbUFDPNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:13:07 -0400
Date: Fri, 4 Jun 2004 17:12:51 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Re: mlock as non-root: use rlimits
Message-ID: <20040604151251.GD16897@devserv.devel.redhat.com>
References: <20040604112845.GA28413@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604112845.GA28413@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 05:12:02PM +0200, Arjan van de Ven wrote:
> Hi,

missed one chunk (sorry)

diff -urN linux-2.6.1-1.138.2.1/fs/hugetlbfs/inode.c linux-2.6.1-1.138.2.1custom/fs/hugetlbfs/inode.c
--- linux-2.6.1-1.138.2.1/fs/hugetlbfs/inode.c	2004-01-30 15:15:50.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/fs/hugetlbfs/inode.c	2004-02-26 14:17:48.000000000 -0800
@@ -755,7 +755,7 @@
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
 
 	if (!is_hugepage_mem_enough(size))
diff -urN linux-2.6.1-1.138.2.1/include/asm-alpha/resource.h linux-2.6.1-1.138.2.1custom/include/asm-alpha/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-alpha/resource.h	2004-01-08 22:59:08.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-alpha/resource.h	2004-03-02 13:45:23.000000000 -0800
@@ -39,7 +39,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
+    {PAGE_SIZE,PAGE_SIZE},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},                       /* RLIMIT_LOCKS */      \
 }
 
diff -urN linux-2.6.1-1.138.2.1/include/asm-arm/resource.h linux-2.6.1-1.138.2.1custom/include/asm-arm/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-arm/resource.h	2004-01-08 22:59:56.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-arm/resource.h	2004-03-02 13:46:40.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,      PAGE_SIZE    },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-arm26/resource.h linux-2.6.1-1.138.2.1custom/include/asm-arm26/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-arm26/resource.h	2004-01-08 22:59:04.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-arm26/resource.h	2004-03-02 13:48:39.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,     PAGE_SIZE     },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-cris/resource.h linux-2.6.1-1.138.2.1custom/include/asm-cris/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-cris/resource.h	2004-01-08 22:59:45.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-cris/resource.h	2004-03-02 13:47:33.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },               \
+	{ PAGE_SIZE,     PAGE_SIZE     },               \
         { RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-h8300/resource.h linux-2.6.1-1.138.2.1custom/include/asm-h8300/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-h8300/resource.h	2004-01-08 22:59:06.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-h8300/resource.h	2004-03-02 13:49:00.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-i386/resource.h linux-2.6.1-1.138.2.1custom/include/asm-i386/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-i386/resource.h	2004-01-08 22:59:09.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-i386/resource.h	2004-03-02 13:47:47.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-ia64/resource.h linux-2.6.1-1.138.2.1custom/include/asm-ia64/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-ia64/resource.h	2004-01-08 22:59:55.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-ia64/resource.h	2004-03-02 13:48:07.000000000 -0800
@@ -42,7 +42,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-m68k/resource.h linux-2.6.1-1.138.2.1custom/include/asm-m68k/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-m68k/resource.h	2004-01-08 22:59:05.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-m68k/resource.h	2004-03-02 13:49:18.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-parisc/resource.h linux-2.6.1-1.138.2.1custom/include/asm-parisc/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-parisc/resource.h	2004-01-08 22:59:46.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-parisc/resource.h	2004-03-02 13:50:30.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-ppc/resource.h linux-2.6.1-1.138.2.1custom/include/asm-ppc/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-ppc/resource.h	2004-01-08 22:59:26.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-ppc/resource.h	2004-03-02 13:50:57.000000000 -0800
@@ -34,7 +34,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-ppc64/resource.h linux-2.6.1-1.138.2.1custom/include/asm-ppc64/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-ppc64/resource.h	2004-01-08 22:59:46.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-ppc64/resource.h	2004-03-02 13:50:44.000000000 -0800
@@ -43,7 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-s390/resource.h linux-2.6.1-1.138.2.1custom/include/asm-s390/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-s390/resource.h	2004-01-08 22:59:19.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-s390/resource.h	2004-03-02 13:51:12.000000000 -0800
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-sh/resource.h linux-2.6.1-1.138.2.1custom/include/asm-sh/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-sh/resource.h	2004-01-08 22:59:45.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-sh/resource.h	2004-03-02 13:51:38.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-sparc/resource.h linux-2.6.1-1.138.2.1custom/include/asm-sparc/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-sparc/resource.h	2004-01-08 22:59:09.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-sparc/resource.h	2004-03-02 13:52:06.000000000 -0800
@@ -42,7 +42,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE, PAGE_SIZE},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-sparc64/resource.h linux-2.6.1-1.138.2.1custom/include/asm-sparc64/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-sparc64/resource.h	2004-01-08 22:59:06.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-sparc64/resource.h	2004-03-02 13:51:58.000000000 -0800
@@ -41,7 +41,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE,     PAGE_SIZE    },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-v850/resource.h linux-2.6.1-1.138.2.1custom/include/asm-v850/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-v850/resource.h	2004-01-08 22:59:06.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-v850/resource.h	2004-03-02 13:52:59.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE, PAGE_SIZE  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/include/asm-x86_64/resource.h linux-2.6.1-1.138.2.1custom/include/asm-x86_64/resource.h
--- linux-2.6.1-1.138.2.1/include/asm-x86_64/resource.h	2004-01-08 22:59:47.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/include/asm-x86_64/resource.h	2004-03-02 13:53:10.000000000 -0800
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE , PAGE_SIZE  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urN linux-2.6.1-1.138.2.1/ipc/shm.c linux-2.6.1-1.138.2.1custom/ipc/shm.c
--- linux-2.6.1-1.138.2.1/ipc/shm.c	2004-01-08 22:59:34.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/ipc/shm.c	2004-03-02 13:57:21.000000000 -0800
@@ -502,14 +502,11 @@
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
@@ -524,9 +521,11 @@
 			goto out_unlock;
 		
 		if(cmd==SHM_LOCK) {
-			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 1);
-			shp->shm_flags |= SHM_LOCKED;
+			if (!is_file_hugepages(shp->shm_file)) {
+				err = shmem_lock(shp->shm_file, 1);
+				if (!err)
+					shp->shm_flags |= SHM_LOCKED;
+			}
 		} else {
 			if (!is_file_hugepages(shp->shm_file))
 				shmem_lock(shp->shm_file, 0);
diff -urN linux-2.6.1-1.138.2.1/ipc/util.c linux-2.6.1-1.138.2.1custom/ipc/util.c
--- linux-2.6.1-1.138.2.1/ipc/util.c	2004-01-08 22:59:26.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/ipc/util.c	2004-03-02 15:03:08.000000000 -0800
@@ -377,8 +377,11 @@
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
diff -urN linux-2.6.1-1.138.2.1/mm/mlock.c linux-2.6.1-1.138.2.1custom/mm/mlock.c
--- linux-2.6.1-1.138.2.1/mm/mlock.c	2004-01-08 22:59:07.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/mm/mlock.c	2004-02-24 14:19:53.000000000 -0800
@@ -57,7 +57,7 @@
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !capable(CAP_IPC_LOCK))
+	if (on && !can_do_mlock())
 		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -139,7 +139,7 @@
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return -EPERM;
 
 	def_flags = 0;
diff -urN linux-2.6.1-1.138.2.1/mm/mmap.c linux-2.6.1-1.138.2.1custom/mm/mmap.c
--- linux-2.6.1-1.138.2.1/mm/mmap.c	2004-01-30 15:15:50.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/mm/mmap.c	2004-02-24 14:26:15.000000000 -0800
@@ -519,15 +519,17 @@
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
 
@@ -1360,9 +1362,11 @@
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
 
diff -urN linux-2.6.1-1.138.2.1/mm/mremap.c linux-2.6.1-1.138.2.1custom/mm/mremap.c
--- linux-2.6.1-1.138.2.1/mm/mremap.c	2004-01-30 15:15:50.000000000 -0800
+++ linux-2.6.1-1.138.2.1custom/mm/mremap.c	2004-02-24 14:28:06.000000000 -0800
@@ -377,10 +377,12 @@
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
diff -urNp linux-530/mm/shmem.c linux-550/mm/shmem.c
--- linux-530/mm/shmem.c
+++ linux-550/mm/shmem.c
@@ -1161,17 +1161,36 @@ shmem_get_policy(struct vm_area_struct *
 }
 #endif
 
-void shmem_lock(struct file *file, int lock)
+int shmem_lock(struct file *file, int lock)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct mm_struct *mm = current->mm;
+	unsigned long lock_limit, locked;
+	int retval = -ENOMEM;
 
 	spin_lock(&info->lock);
+	if (lock && !(info->flags & VM_LOCKED)) {
+		locked = inode->i_size >> PAGE_SHIFT;
+		locked += mm->locked_vm;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+		lock_limit >>= PAGE_SHIFT;
+		if ((locked > lock_limit) && !capable(CAP_IPC_LOCK))
+			goto out_nomem;
+		mm->locked_vm = locked;
+	}
+	if (!lock && (info->flags & VM_LOCKED) && mm) {
+		locked = inode->i_size >> PAGE_SHIFT;
+		mm->locked_vm -= locked;
+	}
 	if (lock)
 		info->flags |= VM_LOCKED;
 	else
 		info->flags &= ~VM_LOCKED;
+	retval = 0;
+out_nomem:
 	spin_unlock(&info->lock);
+	return retval;
 }
 
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
--- linux-2.6.6/include/linux/mm.h~	2004-06-02 10:59:42.600139423 +0200
+++ linux-2.6.6/include/linux/mm.h	2004-06-02 10:59:42.600139423 +0200
@@ -495,9 +495,19 @@
 struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 					unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
-void shmem_lock(struct file * file, int lock);
+int shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
 
+static inline int can_do_mlock(void)
+{
+	if (capable(CAP_IPC_LOCK))
+		return 1;
+	if (current->rlim[RLIMIT_MEMLOCK].rlim_cur != 0)
+		return 1;
+	return 0;
+}
+
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
