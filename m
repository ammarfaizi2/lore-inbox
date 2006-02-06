Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWBFXvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBFXvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWBFXvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:51:25 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:22917 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932120AbWBFXvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:51:24 -0500
Date: Tue, 7 Feb 2006 10:50:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@osdl.org>
Subject: [PATCH] compat: move compat*at syscall prototypes into compat.h
Message-Id: <20060207105039.4add64db.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency with all the other compat syscalls.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/linux/compat.h   |    8 ++++++++
 include/linux/syscalls.h |    9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

f3e3d29e9c87c8e15e5678925f21a708b4a7c961
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f9ca534..2d7e7f1 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -161,5 +161,13 @@ int copy_siginfo_to_user32(struct compat
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
 
+asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename,
+				     struct compat_timeval __user *t);
+asmlinkage long compat_sys_newfstatat(unsigned int dfd, char __user * filename,
+				      struct compat_stat __user *statbuf,
+				      int flag);
+asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
+				   int flags, int mode);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3877209..24240b6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -50,8 +50,6 @@ struct timezone;
 struct tms;
 struct utimbuf;
 struct mq_attr;
-struct compat_stat;
-struct compat_timeval;
 
 #include <linux/config.h>
 #include <linux/types.h>
@@ -559,12 +557,5 @@ asmlinkage long sys_newfstatat(int dfd, 
 			       struct stat __user *statbuf, int flag);
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
-asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename,
-				     struct compat_timeval __user *t);
-asmlinkage long compat_sys_newfstatat(unsigned int dfd, char __user * filename,
-				      struct compat_stat __user *statbuf,
-				      int flag);
-asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
-				   int flags, int mode);
 
 #endif
-- 
1.1.5
