Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267297AbUBNAnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUBNAnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:43:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:7570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267297AbUBNAnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:43:07 -0500
Date: Fri, 13 Feb 2004 16:35:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>, davej@redhat.com, arnd@arndb.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] syscalls.h update #9 (open/close)
Message-Id: <20040213163559.75f877b1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's the next installment in moving syscall prototypes
to linux/syscalls.h and removing the ad hoc instances of them.

Built on ia32, ia64, and x86_64.

(patch archive is at:
  http://developer.osdl.org/rddunlap/syscalls/)

This is my last planned patch, but I'll be looking for
syscalls that I've missed.  I expect that there will be a few.


I'm going to ask DaveJ or Arnd to take over on the
__KERNEL_SYSCALLS_ patches... please.

--
~Randy



applies_to:	linux-263-rc2-mm1
description:	remove sys_open() & sys_close() from linux/fs.h;
		add linux/syscalls.h to several files that use
		  sys_open() / sys_close();

diffstat:=
 arch/alpha/kernel/alpha_ksyms.c          |    1 +
 arch/sparc64/solaris/socksys.c           |    1 +
 drivers/media/dvb/frontends/alps_tdlb7.c |    1 +
 drivers/media/dvb/frontends/sp887x.c     |    1 +
 drivers/media/dvb/frontends/tda1004x.c   |    1 +
 fs/binfmt_elf.c                          |    1 +
 fs/binfmt_misc.c                         |    1 +
 fs/eventpoll.c                           |    1 +
 fs/exec.c                                |    1 +
 include/linux/fs.h                       |    3 ---
 include/linux/syscalls.h                 |    2 +-
 net/socket.c                             |    1 +
 security/selinux/hooks.c                 |    1 +
 13 files changed, 12 insertions(+), 4 deletions(-)


diff -Naurp ./fs/binfmt_misc.c~openclose ./fs/binfmt_misc.c
--- ./fs/binfmt_misc.c~openclose	2004-02-12 09:30:09.000000000 -0800
+++ ./fs/binfmt_misc.c	2004-02-13 13:38:21.000000000 -0800
@@ -26,6 +26,7 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 
diff -Naurp ./fs/exec.c~openclose ./fs/exec.c
--- ./fs/exec.c~openclose	2004-02-13 13:39:47.000000000 -0800
+++ ./fs/exec.c	2004-02-13 13:39:55.000000000 -0800
@@ -44,6 +44,7 @@
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/rmap-locking.h>
 
 #include <asm/uaccess.h>
diff -Naurp ./fs/eventpoll.c~openclose ./fs/eventpoll.c
--- ./fs/eventpoll.c~openclose	2004-02-12 09:28:52.000000000 -0800
+++ ./fs/eventpoll.c	2004-02-13 13:40:43.000000000 -0800
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/spinlock.h>
+#include <linux/syscalls.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <linux/eventpoll.h>
diff -Naurp ./fs/binfmt_elf.c~openclose ./fs/binfmt_elf.c
--- ./fs/binfmt_elf.c~openclose	2004-02-12 09:28:52.000000000 -0800
+++ ./fs/binfmt_elf.c	2004-02-13 13:41:24.000000000 -0800
@@ -36,6 +36,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
diff -Naurp ./arch/sparc64/solaris/socksys.c~openclose ./arch/sparc64/solaris/socksys.c
--- ./arch/sparc64/solaris/socksys.c~openclose	2004-02-12 09:30:04.000000000 -0800
+++ ./arch/sparc64/solaris/socksys.c	2004-02-13 13:45:55.000000000 -0800
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 #include <linux/in.h>
 #include <linux/devfs_fs_kernel.h>
 
diff -Naurp ./arch/alpha/kernel/alpha_ksyms.c~openclose ./arch/alpha/kernel/alpha_ksyms.c
--- ./arch/alpha/kernel/alpha_ksyms.c~openclose	2004-02-03 19:43:09.000000000 -0800
+++ ./arch/alpha/kernel/alpha_ksyms.c	2004-02-13 14:14:36.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/socket.h>
+#include <linux/syscalls.h>
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/pci.h>
diff -Naurp ./drivers/media/dvb/frontends/tda1004x.c~openclose ./drivers/media/dvb/frontends/tda1004x.c
--- ./drivers/media/dvb/frontends/tda1004x.c~openclose	2004-02-03 19:43:05.000000000 -0800
+++ ./drivers/media/dvb/frontends/tda1004x.c	2004-02-13 13:57:21.000000000 -0800
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/unistd.h>
 #include <linux/fcntl.h>
diff -Naurp ./drivers/media/dvb/frontends/alps_tdlb7.c~openclose ./drivers/media/dvb/frontends/alps_tdlb7.c
--- ./drivers/media/dvb/frontends/alps_tdlb7.c~openclose	2004-02-03 19:43:19.000000000 -0800
+++ ./drivers/media/dvb/frontends/alps_tdlb7.c	2004-02-13 13:58:03.000000000 -0800
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/delay.h>
 
diff -Naurp ./drivers/media/dvb/frontends/sp887x.c~openclose ./drivers/media/dvb/frontends/sp887x.c
--- ./drivers/media/dvb/frontends/sp887x.c~openclose	2004-02-03 19:44:16.000000000 -0800
+++ ./drivers/media/dvb/frontends/sp887x.c	2004-02-13 13:58:32.000000000 -0800
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/unistd.h>
 #include <linux/fcntl.h>
diff -Naurp ./include/linux/fs.h~openclose ./include/linux/fs.h
--- ./include/linux/fs.h~openclose	2004-02-12 09:30:10.000000000 -0800
+++ ./include/linux/fs.h	2004-02-13 13:48:30.000000000 -0800
@@ -1125,10 +1125,7 @@ static inline int break_lease(struct ino
 
 /* fs/open.c */
 
-asmlinkage long sys_open(const char __user *, int, int);
-asmlinkage long sys_close(unsigned int);	/* yes, it's really unsigned */
 extern int do_truncate(struct dentry *, loff_t start);
-
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
 extern int filp_close(struct file *, fl_owner_t id);
diff -Naurp ./include/linux/syscalls.h~openclose ./include/linux/syscalls.h
--- ./include/linux/syscalls.h~openclose	2004-02-12 16:13:27.000000000 -0800
+++ ./include/linux/syscalls.h	2004-02-13 15:12:57.000000000 -0800
@@ -380,7 +380,7 @@ asmlinkage long sys_getdents64(unsigned 
 asmlinkage long sys_setsockopt(int fd, int level, int optname,
 				char *optval, int optlen);
 asmlinkage long sys_getsockopt(int fd, int level, int optname,
-				void *optval, int *optlen);
+				char __user *optval, int __user *optlen);
 asmlinkage long sys_bind(int, struct sockaddr *, int);
 asmlinkage long sys_connect(int, struct sockaddr *, int);
 asmlinkage long sys_accept(int, struct sockaddr *, int *);
diff -Naurp ./net/socket.c~openclose ./net/socket.c
--- ./net/socket.c~openclose	2004-02-03 19:43:42.000000000 -0800
+++ ./net/socket.c	2004-02-13 13:51:08.000000000 -0800
@@ -78,6 +78,7 @@
 #include <linux/divert.h>
 #include <linux/mount.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/kmod.h>
 
diff -Naurp ./security/selinux/hooks.c~openclose ./security/selinux/hooks.c
--- ./security/selinux/hooks.c~openclose	2004-02-12 09:30:11.000000000 -0800
+++ ./security/selinux/hooks.c	2004-02-13 13:50:15.000000000 -0800
@@ -34,6 +34,7 @@
 #include <linux/swap.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
+#include <linux/syscalls.h>
 #include <linux/file.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
