Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313786AbSDPRrE>; Tue, 16 Apr 2002 13:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313787AbSDPRrE>; Tue, 16 Apr 2002 13:47:04 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:18956 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S313786AbSDPRrC>; Tue, 16 Apr 2002 13:47:02 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] #include <asm/bitops.h> -> #include <linux/bitops.h>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 17 Apr 2002 02:46:44 +0900
Message-ID: <87r8lf35a3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have to include linux/bitops.h for arch using generic_xxx().
And I think, at least the include/linux/* should include linux/bitops.h.
(fatfs really needed the addition of linux/bitops.h.)

The following patch changes <asm/bitops.h> of include/linux/* to
<linux/bitops.h>.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.5.8/include/linux/fs.h linux-2.5.8-bitops/include/linux/fs.h
--- linux-2.5.8/include/linux/fs.h	Mon Apr 15 23:01:35 2002
+++ linux-2.5.8-bitops/include/linux/fs.h	Tue Apr 16 22:50:53 2002
@@ -22,9 +22,9 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/radix-tree.h>
+#include <linux/bitops.h>
 
 #include <asm/atomic.h>
-#include <asm/bitops.h>
 
 struct poll_table_struct;
 
diff -urN linux-2.5.8/include/linux/ide.h linux-2.5.8-bitops/include/linux/ide.h
--- linux-2.5.8/include/linux/ide.h	Mon Apr 15 23:03:06 2002
+++ linux-2.5.8-bitops/include/linux/ide.h	Tue Apr 16 22:51:03 2002
@@ -14,8 +14,8 @@
 #include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
+#include <linux/bitops.h>
 #include <asm/hdreg.h>
-#include <asm/bitops.h>
 
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
diff -urN linux-2.5.8/include/linux/interrupt.h linux-2.5.8-bitops/include/linux/interrupt.h
--- linux-2.5.8/include/linux/interrupt.h	Mon Apr 15 23:01:49 2002
+++ linux-2.5.8-bitops/include/linux/interrupt.h	Tue Apr 16 22:51:13 2002
@@ -7,8 +7,8 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/cache.h>
+#include <linux/bitops.h>
 
-#include <asm/bitops.h>
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/ptrace.h>
diff -urN linux-2.5.8/include/linux/raid/md.h linux-2.5.8-bitops/include/linux/raid/md.h
--- linux-2.5.8/include/linux/raid/md.h	Mon Apr 15 23:04:26 2002
+++ linux-2.5.8-bitops/include/linux/raid/md.h	Tue Apr 16 22:52:20 2002
@@ -23,7 +23,7 @@
 #include <linux/major.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
-#include <asm/bitops.h>
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/hdreg.h>
 #include <linux/proc_fs.h>
diff -urN linux-2.5.8/include/linux/signal.h linux-2.5.8-bitops/include/linux/signal.h
--- linux-2.5.8/include/linux/signal.h	Mon Apr 15 23:01:34 2002
+++ linux-2.5.8-bitops/include/linux/signal.h	Tue Apr 16 22:52:28 2002
@@ -24,9 +24,9 @@
  */
 
 #ifndef __HAVE_ARCH_SIG_BITOPS
-#include <asm/bitops.h>
+#include <linux/bitops.h>
 
-/* We don't use <asm/bitops.h> for these because there is no need to
+/* We don't use <linux/bitops.h> for these because there is no need to
    be atomic.  */
 static inline void sigaddset(sigset_t *set, int _sig)
 {
diff -urN linux-2.5.8/include/linux/thread_info.h linux-2.5.8-bitops/include/linux/thread_info.h
--- linux-2.5.8/include/linux/thread_info.h	Mon Apr 15 23:01:34 2002
+++ linux-2.5.8-bitops/include/linux/thread_info.h	Tue Apr 16 22:51:44 2002
@@ -7,8 +7,8 @@
 #ifndef _LINUX_THREAD_INFO_H
 #define _LINUX_THREAD_INFO_H
 
+#include <linux/bitops.h>
 #include <asm/thread_info.h>
-#include <asm/bitops.h>
 
 #ifdef __KERNEL__
 
diff -urN linux-2.5.8/include/linux/tqueue.h linux-2.5.8-bitops/include/linux/tqueue.h
--- linux-2.5.8/include/linux/tqueue.h	Mon Apr 15 23:01:35 2002
+++ linux-2.5.8-bitops/include/linux/tqueue.h	Tue Apr 16 22:51:51 2002
@@ -15,7 +15,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
-#include <asm/bitops.h>
+#include <linux/bitops.h>
 #include <asm/system.h>
 
 /*
