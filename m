Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSDWR2O>; Tue, 23 Apr 2002 13:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSDWR2N>; Tue, 23 Apr 2002 13:28:13 -0400
Received: from [192.82.208.96] ([192.82.208.96]:56732 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315275AbSDWR2K>;
	Tue, 23 Apr 2002 13:28:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.org
Subject: [patch] 2.5.9 remove warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 13:39:31 +1000
Message-ID: <10704.1019533171@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

exit.c:40: warning: passing arg 1 of `__builtin_expect' makes integer from pointer without a cast

Index: 9.2/kernel/exit.c
--- 9.2/kernel/exit.c Tue, 23 Apr 2002 11:21:19 +1000 kaos (linux-2.5/w/d/25_exit.c 1.11.1.4 644)
+++ 9.2(w)/kernel/exit.c Tue, 23 Apr 2002 13:37:06 +1000 kaos (linux-2.5/w/d/25_exit.c 1.11.1.4 644)
@@ -37,7 +37,7 @@ static inline void __unhash_process(stru
 	list_del(&p->thread_group);
 	p->pid = 0;
 	proc_dentry = p->proc_dentry;
-	if (unlikely(proc_dentry)) {
+	if (unlikely(proc_dentry != NULL)) {
 		spin_lock(&dcache_lock);
 		if (!list_empty(&proc_dentry->d_hash)) {
 			dget_locked(proc_dentry);
@@ -47,7 +47,7 @@ static inline void __unhash_process(stru
 		spin_unlock(&dcache_lock);
 	}
 	write_unlock_irq(&tasklist_lock);
-	if (unlikely(proc_dentry)) {
+	if (unlikely(proc_dentry != NULL)) {
 		shrink_dcache_parent(proc_dentry);
 		dput(proc_dentry);
 	}

