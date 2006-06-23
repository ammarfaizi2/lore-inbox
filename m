Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWFWK4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWFWK4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933008AbWFWK4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:56:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4108 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932541AbWFWKzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:37 -0400
Date: Fri, 23 Jun 2006 12:55:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Jes Sorensen <jes@sgi.com>
Subject: [-mm patch] make ipc/sem.c:exit_sem() static
Message-ID: <20060623105537.GM9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
> +task-watchers-register-semundo-task-watcher.patch
>...
>  API for registering against task lifecycle events.
>...

exit_sem() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/sem.h |    5 -----
 ipc/sem.c           |    3 ++-
 2 files changed, 2 insertions(+), 6 deletions(-)

--- linux-2.6.17-mm1-full/include/linux/sem.h.old	2006-06-22 17:10:52.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/sem.h	2006-06-22 17:11:02.000000000 +0200
@@ -141,7 +141,6 @@
 #ifdef CONFIG_SYSVIPC
 
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
-extern void exit_sem(struct task_struct *tsk);
 
 #else
 static inline int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
@@ -149,10 +148,6 @@
 	return 0;
 }
 
-static inline void exit_sem(struct task_struct *tsk)
-{
-	return;
-}
 #endif
 
 #endif /* __KERNEL__ */
--- linux-2.6.17-mm1-full/ipc/sem.c.old	2006-06-22 17:11:17.000000000 +0200
+++ linux-2.6.17-mm1-full/ipc/sem.c	2006-06-22 17:12:16.000000000 +0200
@@ -103,6 +103,7 @@
 
 static int newary (struct ipc_namespace *, key_t, int, int);
 static void freeary (struct ipc_namespace *ns, struct sem_array *sma, int id);
+static void exit_sem(struct task_struct *tsk);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
 #endif
@@ -1350,7 +1351,7 @@
  * The current implementation does not do so. The POSIX standard
  * and SVID should be consulted to determine what behavior is mandated.
  */
-void exit_sem(struct task_struct *tsk)
+static void exit_sem(struct task_struct *tsk)
 {
 	struct sem_undo_list *undo_list;
 	struct sem_undo *u, **up;

