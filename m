Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbTAFEEy>; Sun, 5 Jan 2003 23:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTAFEDh>; Sun, 5 Jan 2003 23:03:37 -0500
Received: from dp.samba.org ([66.70.73.150]:10209 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266120AbTAFEDR>;
	Sun, 5 Jan 2003 23:03:17 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] namespace pollution in procfs
Date: Mon, 06 Jan 2003 14:20:22 +1100
Message-Id: <20030106041153.858382C2D3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Arnd Bergmann <arnd@bergmann-dalldorf.de>

  de_get and de_put are used only in the file they are
  defined in, so make them static
  ===== fs/proc/inode.c 1.18 vs edited =====

--- trivial-2.5-bk/fs/proc/inode.c.orig	2003-01-06 14:08:23.000000000 +1100
+++ trivial-2.5-bk/fs/proc/inode.c	2003-01-06 14:08:23.000000000 +1100
@@ -23,7 +23,7 @@
 
 extern void free_proc_entry(struct proc_dir_entry *);
 
-struct proc_dir_entry * de_get(struct proc_dir_entry *de)
+static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
 {
 	if (de)
 		atomic_inc(&de->count);
@@ -33,7 +33,7 @@
 /*
  * Decrements the use count and checks for deferred deletion.
  */
-void de_put(struct proc_dir_entry *de)
+static void de_put(struct proc_dir_entry *de)
 {
 	if (de) {	
 		lock_kernel();		
-- 
  Don't blame me: the Monkey is driving
  File: Arnd Bergmann <arnd@bergmann-dalldorf.de>: [PATCH] namespace pollution in procfs
