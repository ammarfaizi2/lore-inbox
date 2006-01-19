Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWASE3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWASE3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWASE3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:29:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161031AbWASE3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:29:41 -0500
Date: Wed, 18 Jan 2006 23:29:32 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200601190429.k0J4TWXD018136@devserv.devel.redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] prototypes for *at functions & typo fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the follow-up patch which introduces the prototypes for the new syscalls.  There was also a typo in one of the new symbols.  Do we really need the __NR_ia32_* macros?  The userlevel on x86-64 should be bi-arch and provide the native ia32 unistd.h.

Signed-off-by: Ulrich Drepper <drepper@redhat.com>

diff --git a/include/asm-x86_64/ia32_unistd.h b/include/asm-x86_64/ia32_unistd.h
index e87cd83..9afc0c7 100644
--- a/include/asm-x86_64/ia32_unistd.h
+++ b/include/asm-x86_64/ia32_unistd.h
@@ -300,7 +300,7 @@
 #define __NR_ia32_inotify_add_watch	292
 #define __NR_ia32_inotify_rm_watch	293
 #define __NR_ia32_migrate_pages		294
-#define __NR_ia32_opanat		295
+#define __NR_ia32_openat		295
 #define __NR_ia32_mkdirat		296
 #define __NR_ia32_mknodat		297
 #define __NR_ia32_fchownat		298
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e666d60..c0c894d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -534,4 +534,35 @@ asmlinkage long sys_spu_run(int fd, __u3
 asmlinkage long sys_spu_create(const char __user *name,
 		unsigned int flags, mode_t mode);
 
+asmlinkage long sys_mknodat(int dfd, const char __user * filename, int mode,
+			    unsigned dev);
+asmlinkage long sys_mkdirat(int dfd, const char __user * pathname, int mode);
+asmlinkage long sys_unlinkat(int dfd, const char __user * pathname, int flag);
+asmlinkage long sys_symlinkat(const char __user * oldname,
+			      int newdfd, const char __user * newname);
+asmlinkage long sys_linkat(int olddfd, const char __user *oldname,
+			   int newdfd, const char __user *newname);
+asmlinkage long sys_renameat(int olddfd, const char __user * oldname,
+			     int newdfd, const char __user * newname);
+asmlinkage long sys_futimesat(int dfd, char __user *filename,
+			      struct timeval __user *utimes);
+asmlinkage long sys_faccessat(int dfd, const char __user *filename, int mode);
+asmlinkage long sys_fchmodat(int dfd, const char __user * filename,
+			     mode_t mode);
+asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
+			     gid_t group, int flag);
+asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
+			   int mode);
+asmlinkage long sys_newfstatat(int dfd, char __user *filename,
+			       struct stat __user *statbuf, int flag);
+asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
+			       int bufsiz);
+asmlinkage long compat_sys_futimesat(int dfd, char __user *filename,
+				     struct compat_timeval __user *t);
+asmlinkage long compat_sys_newfstatat(int dfd, char __user * filename,
+				      struct compat_stat __user *statbuf,
+				      int flag);
+asmlinkage long +compat_sys_openat(int dfd, const char __user *filename,
+				   int flags, int mode);
+
 #endif
