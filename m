Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSJQVWi>; Thu, 17 Oct 2002 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJQVWi>; Thu, 17 Oct 2002 17:22:38 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48398 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262112AbSJQVWb>;
	Thu, 17 Oct 2002 17:22:31 -0400
Date: Thu, 17 Oct 2002 14:28:09 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] LSM changes for 2.5.43
Message-ID: <20021017212809.GB1125@kroah.com>
References: <20021017212620.GA1125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017212620.GA1125@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.798, 2002/10/17 13:16:54-07:00, greg@kroah.com

LSM: add #include <linux/security.h> to a lot of files as they all have security calls in them.

This is needed for the next patches that change the way the security calls work.


diff -Nru a/arch/ppc64/kernel/sys_ppc32.c b/arch/ppc64/kernel/sys_ppc32.c
--- a/arch/ppc64/kernel/sys_ppc32.c	Thu Oct 17 14:19:36 2002
+++ b/arch/ppc64/kernel/sys_ppc32.c	Thu Oct 17 14:19:36 2002
@@ -53,6 +53,7 @@
 #include <linux/mman.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
+#include <linux/security.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
diff -Nru a/arch/s390x/kernel/ptrace.c b/arch/s390x/kernel/ptrace.c
--- a/arch/s390x/kernel/ptrace.c	Thu Oct 17 14:19:36 2002
+++ b/arch/s390x/kernel/ptrace.c	Thu Oct 17 14:19:36 2002
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/security.h>
 
 #include <asm/segment.h>
 #include <asm/page.h>
diff -Nru a/drivers/base/fs/class.c b/drivers/base/fs/class.c
--- a/drivers/base/fs/class.c	Thu Oct 17 14:19:36 2002
+++ b/drivers/base/fs/class.c	Thu Oct 17 14:19:36 2002
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/stat.h>
 #include "fs.h"
 
 static struct driver_dir_entry class_dir;
diff -Nru a/drivers/base/fs/intf.c b/drivers/base/fs/intf.c
--- a/drivers/base/fs/intf.c	Thu Oct 17 14:19:36 2002
+++ b/drivers/base/fs/intf.c	Thu Oct 17 14:19:36 2002
@@ -4,6 +4,8 @@
 
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/limits.h>
+#include <linux/errno.h>
 #include "fs.h"
 
 /**
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Thu Oct 17 14:19:36 2002
+++ b/fs/dquot.c	Thu Oct 17 14:19:36 2002
@@ -69,6 +69,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Thu Oct 17 14:19:36 2002
+++ b/fs/exec.c	Thu Oct 17 14:19:36 2002
@@ -43,6 +43,7 @@
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
diff -Nru a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Thu Oct 17 14:19:36 2002
+++ b/fs/locks.c	Thu Oct 17 14:19:36 2002
@@ -122,6 +122,7 @@
 #include <linux/timer.h>
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Thu Oct 17 14:19:36 2002
+++ b/fs/namespace.c	Thu Oct 17 14:19:36 2002
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
diff -Nru a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	Thu Oct 17 14:19:36 2002
+++ b/fs/proc/base.c	Thu Oct 17 14:19:36 2002
@@ -28,6 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
diff -Nru a/fs/readdir.c b/fs/readdir.c
--- a/fs/readdir.c	Thu Oct 17 14:19:36 2002
+++ b/fs/readdir.c	Thu Oct 17 14:19:36 2002
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Oct 17 14:19:36 2002
+++ b/fs/super.c	Thu Oct 17 14:19:36 2002
@@ -29,9 +29,9 @@
 #include <linux/quotaops.h>
 #include <linux/namei.h>
 #include <linux/buffer_head.h>		/* for fsync_super() */
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
-#include <linux/security.h>
 
 void get_filesystem(struct file_system_type *fs);
 void put_filesystem(struct file_system_type *fs);
diff -Nru a/fs/xattr.c b/fs/xattr.c
--- a/fs/xattr.c	Thu Oct 17 14:19:36 2002
+++ b/fs/xattr.c	Thu Oct 17 14:19:36 2002
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/xattr.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 /*
diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Thu Oct 17 14:19:36 2002
+++ b/init/do_mounts.c	Thu Oct 17 14:19:36 2002
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
+#include <linux/security.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
diff -Nru a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c	Thu Oct 17 14:19:36 2002
+++ b/kernel/acct.c	Thu Oct 17 14:19:36 2002
@@ -49,6 +49,7 @@
 #include <linux/acct.h>
 #include <linux/file.h>
 #include <linux/tty.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 /*
diff -Nru a/kernel/capability.c b/kernel/capability.c
--- a/kernel/capability.c	Thu Oct 17 14:19:36 2002
+++ b/kernel/capability.c	Thu Oct 17 14:19:36 2002
@@ -8,6 +8,7 @@
  */ 
 
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
diff -Nru a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	Thu Oct 17 14:19:36 2002
+++ b/kernel/kmod.c	Thu Oct 17 14:19:36 2002
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/file.h>
 #include <linux/workqueue.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Thu Oct 17 14:19:36 2002
+++ b/kernel/ptrace.c	Thu Oct 17 14:19:36 2002
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Thu Oct 17 14:19:36 2002
+++ b/kernel/signal.c	Thu Oct 17 14:19:36 2002
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/security.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
