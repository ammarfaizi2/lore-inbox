Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWAQUUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWAQUUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWAQUUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:20:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:29931 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964805AbWAQUUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:20:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: akpm@osdl.org
Subject: [PATCH] add missing syscall declarations
Date: Tue, 17 Jan 2006 20:30:30 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, jordi_caubet@es.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601172030.30473.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All standard system calls should be declared
in include/linux/syscalls.h.
Add some of the new additions that were previously
missed.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.16-rc/include/linux/syscalls.h
===================================================================
--- linux-2.6.16-rc.orig/include/linux/syscalls.h
+++ linux-2.6.16-rc/include/linux/syscalls.h
@@ -510,9 +510,24 @@ asmlinkage long sys_keyctl(int cmd, unsi
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
 asmlinkage long sys_ioprio_get(int which, int who);
 asmlinkage long sys_set_mempolicy(int mode, unsigned long __user *nmask,
-					unsigned long maxnode);
+				unsigned long maxnode);
 asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
-			const unsigned long __user *from, const unsigned long __user *to);
+				const unsigned long __user *from,
+				const unsigned long __user *to);
+asmlinkage long sys_mbind(unsigned long start, unsigned long len,
+				unsigned long mode,
+				unsigned long __user *nmask,
+				unsigned long maxnode,
+				unsigned flags);
+asmlinkage long sys_get_mempolicy(int __user *policy,
+				unsigned long __user *nmask,
+				unsigned long maxnode,
+				unsigned long addr, unsigned long flags);
+
+asmlinkage long sys_inotify_init(void);
+asmlinkage long sys_inotify_add_watch(int fd, const char __user *path,
+					u32 mask);
+asmlinkage long sys_inotify_rm_watch(int fd, u32 wd);
 
 asmlinkage long sys_spu_run(int fd, __u32 __user *unpc,
 				 __u32 __user *ustatus);
Index: linux-2.6.16-rc/fs/inotify.c
===================================================================
--- linux-2.6.16-rc.orig/fs/inotify.c
+++ linux-2.6.16-rc/fs/inotify.c
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/writeback.h>
 #include <linux/inotify.h>
+#include <linux/syscalls.h>
 
 #include <asm/ioctls.h>
 

