Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUJ3SUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUJ3SUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUJ3STm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:19:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261264AbUJ3SFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:05:39 -0400
Date: Sat, 30 Oct 2004 20:05:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small proc_fs cleanups
Message-ID: <20041030180508.GS4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups in the proc_fs code:
- remove an unused global function
- make two functions static


diffstat output:
 fs/proc/kcore.c         |   17 -----------------
 fs/proc/proc_misc.c     |    4 ++--
 include/linux/proc_fs.h |    5 -----
 3 files changed, 2 insertions(+), 24 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/include/linux/proc_fs.h.old	2004-10-30 14:44:47.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/include/linux/proc_fs.h	2004-10-30 14:45:11.000000000 +0200
@@ -231,13 +231,8 @@
 static inline void kclist_add(struct kcore_list *new, void *addr, size_t size)
 {
 }
-static inline struct kcore_list * kclist_del(void *addr)
-{
-	return NULL;
-}
 #else
 extern void kclist_add(struct kcore_list *, void *, size_t);
-extern struct kcore_list *kclist_del(void *);
 #endif
 
 struct proc_inode {
--- linux-2.6.10-rc1-mm2-full/fs/proc/kcore.c.old	2004-10-30 14:45:22.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/proc/kcore.c	2004-10-30 14:45:36.000000000 +0200
@@ -68,23 +68,6 @@
 	write_unlock(&kclist_lock);
 }
 
-struct kcore_list *
-kclist_del(void *addr)
-{
-	struct kcore_list *m, **p = &kclist;
-
-	write_lock(&kclist_lock);
-	for (m = *p; m; p = &m->next) {
-		if (m->addr == (unsigned long)addr) {
-			*p = m->next;
-			write_unlock(&kclist_lock);
-			return m;
-		}
-	}
-	write_unlock(&kclist_lock);
-	return NULL;
-}
-
 static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
 {
 	size_t try, size;
--- linux-2.6.10-rc1-mm2-full/fs/proc/proc_misc.c.old	2004-10-30 14:46:32.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/proc/proc_misc.c	2004-10-30 14:47:49.000000000 +0200
@@ -359,7 +359,7 @@
 	.release	= seq_release,
 };
 
-int show_stat(struct seq_file *p, void *v)
+static int show_stat(struct seq_file *p, void *v)
 {
 	int i;
 	extern unsigned long total_forks;
@@ -509,7 +509,7 @@
 	.show  = show_interrupts
 };
 
-int interrupts_open(struct inode *inode, struct file *filp)
+static int interrupts_open(struct inode *inode, struct file *filp)
 {
 	return seq_open(filp, &int_seq_ops);
 }

