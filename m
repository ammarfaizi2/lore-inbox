Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWCDMPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWCDMPk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCDMPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:15:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24592 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751843AbWCDMO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:58 -0500
Date: Sat, 4 Mar 2006 13:14:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: -mm patch] fs/locks.c: make posix_locks_deadlock() static
Message-ID: <20060304121457.GS9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm1:
>...
>  git-nfs.patch
>...
>  git trees
>...


We can now make posix_locks_deadlock() static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/locks.c         |    4 +---
 include/linux/fs.h |    1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.16-rc5-mm2-full/include/linux/fs.h.old	2006-03-03 18:15:14.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/include/linux/fs.h	2006-03-03 18:15:20.000000000 +0100
@@ -761,7 +761,6 @@
 extern int posix_lock_file(struct file *, struct file_lock *);
 extern int posix_lock_file_wait(struct file *, struct file_lock *);
 extern int posix_unblock_lock(struct file *, struct file_lock *);
-extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
 extern int flock_lock_file_wait(struct file *filp, struct file_lock *fl);
 extern int __break_lease(struct inode *inode, unsigned int flags);
 extern void lease_get_mtime(struct inode *, struct timespec *time);
--- linux-2.6.16-rc5-mm2-full/fs/locks.c.old	2006-03-03 18:15:31.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/fs/locks.c	2006-03-03 18:15:54.000000000 +0100
@@ -715,7 +715,7 @@
  * from a broken NFS client. But broken NFS clients have a lot more to
  * worry about than proper deadlock detection anyway... --okir
  */
-int posix_locks_deadlock(struct file_lock *caller_fl,
+static int posix_locks_deadlock(struct file_lock *caller_fl,
 				struct file_lock *block_fl)
 {
 	struct list_head *tmp;
@@ -734,8 +734,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(posix_locks_deadlock);
-
 /* Try to create a FLOCK lock on filp. We always insert new FLOCK locks
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.

