Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263303AbTCUGmd>; Fri, 21 Mar 2003 01:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263305AbTCUGmd>; Fri, 21 Mar 2003 01:42:33 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56840
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263303AbTCUGm3>; Fri, 21 Mar 2003 01:42:29 -0500
Subject: Re: [PATCH] arch-independent syscalls to return long
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>, Linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, ak@suse.de
In-Reply-To: <20030320222358.454a1f4f.akpm@digeo.com>
References: <3E7AAD0C.B8CB2926@verizon.net>
	 <20030320222358.454a1f4f.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048229509.2026.19.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 21 Mar 2003 01:51:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 01:23, Andrew Morton wrote:

> Thanks.  Is that all of them done now?

I think so, I just grepped the whole tree.

But... Here are some related cleanups that should accompany the original
patch.

Against 2.5.65.

	Robert Love


 Documentation/DocBook/kernel-hacking.tmpl |    2 +-
 drivers/macintosh/via-pmu.c               |    2 +-
 drivers/message/fusion/mptctl.c           |    2 +-
 include/asm-parisc/unistd.h               |   10 +++++-----
 include/linux/ioctl32.h                   |    2 +-
 kernel/suspend.c                          |    2 +-
 net/compat.c                              |    6 +++---
 7 files changed, 13 insertions(+), 13 deletions(-)


diff -urN linux-2.5.65/Documentation/DocBook/kernel-hacking.tmpl linux/Documentation/DocBook/kernel-hacking.tmpl
--- linux-2.5.65/Documentation/DocBook/kernel-hacking.tmpl	2003-03-17 16:44:07.000000000 -0500
+++ linux/Documentation/DocBook/kernel-hacking.tmpl	2003-03-21 01:46:28.202341104 -0500
@@ -319,7 +319,7 @@
   </para>
 
   <programlisting>
-asmlinkage int sys_mycall(int arg) 
+asmlinkage long sys_mycall(int arg)
 {
         return 0; 
 }
diff -urN linux-2.5.65/drivers/macintosh/via-pmu.c linux/drivers/macintosh/via-pmu.c
--- linux-2.5.65/drivers/macintosh/via-pmu.c	2003-03-17 16:44:43.000000000 -0500
+++ linux/drivers/macintosh/via-pmu.c	2003-03-21 01:41:26.874149952 -0500
@@ -2002,7 +2002,7 @@
 	last_jiffy_stamp(0) = tb_last_stamp = get_tbl();
 }
 
-extern int sys_sync(void);
+extern long sys_sync(void);
 
 #define	GRACKLE_PM	(1<<7)
 #define GRACKLE_DOZE	(1<<5)
diff -urN linux-2.5.65/drivers/message/fusion/mptctl.c linux/drivers/message/fusion/mptctl.c
--- linux-2.5.65/drivers/message/fusion/mptctl.c	2003-03-17 16:43:38.000000000 -0500
+++ linux/drivers/message/fusion/mptctl.c	2003-03-21 01:40:43.187791288 -0500
@@ -2743,7 +2743,7 @@
 						      unsigned long,
 						      struct file *));
 int unregister_ioctl32_conversion(unsigned int cmd);
-extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+extern long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /* sparc32_XXX functions are used to provide a conversion between
diff -urN linux-2.5.65/include/asm-parisc/unistd.h linux/include/asm-parisc/unistd.h
--- linux-2.5.65/include/asm-parisc/unistd.h	2003-03-17 16:43:37.000000000 -0500
+++ linux/include/asm-parisc/unistd.h	2003-03-21 01:45:35.018426288 -0500
@@ -842,19 +842,19 @@
 
 static inline pid_t setsid(void)
 {
-	extern int sys_setsid(void);
+	extern long sys_setsid(void);
 	return sys_setsid();
 }
 
 static inline int write(int fd, const char *buf, off_t count)
 {
-	extern int sys_write(int, const char *, int);
+	extern long sys_write(int, const char *, int);
 	return sys_write(fd, buf, count);
 }
 
 static inline int read(int fd, char *buf, off_t count)
 {
-	extern int sys_read(int, char *, int);
+	extern long sys_read(int, char *, int);
 	return sys_read(fd, buf, count);
 }
 
@@ -866,7 +866,7 @@
 
 static inline int dup(int fd)
 {
-	extern int sys_dup(int);
+	extern long sys_dup(int);
 	return sys_dup(fd);
 }
 
@@ -891,7 +891,7 @@
 
 static inline int _exit(int exitcode)
 {
-	extern int sys_exit(int) __attribute__((noreturn));
+	extern long sys_exit(int) __attribute__((noreturn));
 	return sys_exit(exitcode);
 }
 
diff -urN linux-2.5.65/include/linux/ioctl32.h linux/include/linux/ioctl32.h
--- linux-2.5.65/include/linux/ioctl32.h	2003-03-17 16:43:38.000000000 -0500
+++ linux/include/linux/ioctl32.h	2003-03-21 01:45:54.559455600 -0500
@@ -3,7 +3,7 @@
 
 struct file;
 
-int sys_ioctl(unsigned int, unsigned int, unsigned long);
+extern long sys_ioctl(unsigned int, unsigned int, unsigned long);
 
 /* 
  * Register an 32bit ioctl translation handler for ioctl cmd.
diff -urN linux-2.5.65/kernel/suspend.c linux/kernel/suspend.c
--- linux-2.5.65/kernel/suspend.c	2003-03-17 16:43:49.000000000 -0500
+++ linux/kernel/suspend.c	2003-03-21 01:40:50.000000000 -0500
@@ -65,7 +65,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
-extern int sys_sync(void);
+extern long sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
 
diff -urN linux-2.5.65/net/compat.c linux/net/compat.c
--- linux-2.5.65/net/compat.c	2003-03-17 16:44:11.000000000 -0500
+++ linux/net/compat.c	2003-03-21 01:44:53.000000000 -0500
@@ -365,8 +365,8 @@
 	kmsg->msg_control = (void *) orig_cmsg_uptr;
 }
 
-extern asmlinkage int sys_setsockopt(int fd, int level, int optname,
-				     char *optval, int optlen);
+extern long sys_setsockopt(int fd, int level, int optname,
+			   char *optval, int optlen);
 
 static int do_netfilter_replace(int fd, int level, int optname,
 				char *optval, int optlen)
@@ -530,7 +530,7 @@
 	return err;
 }
 
-asmlinkage int compat_sys_setsockopt(int fd, int level, int optname,
+asmlinkage long compat_sys_setsockopt(int fd, int level, int optname,
 				char *optval, int optlen)
 {
 	if (optname == IPT_SO_SET_REPLACE)



