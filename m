Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263401AbTDCOkf>; Thu, 3 Apr 2003 09:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbTDCOkf>; Thu, 3 Apr 2003 09:40:35 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:23940 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S263401AbTDCOkd>;
	Thu, 3 Apr 2003 09:40:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16012.19083.730422.148040@enequist.it.uu.se>
Date: Thu, 3 Apr 2003 16:51:55 +0200
From: mikpe@csd.uu.se
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.66] ioctl32 breakage on x86_64
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA32 emulation on x86_64 doesn't compile in 2.5.66 due to
conflicting declarations of sys_ioctl(). The patch below
is a quick fix to make both the generic ioctl32 one and
x86_64's private one agree with reality.

/Mikael

--- linux-2.5.66/arch/x86_64/ia32/ia32_ioctl.c.~1~	2003-03-08 17:22:31.000000000 +0100
+++ linux-2.5.66/arch/x86_64/ia32/ia32_ioctl.c	2003-04-03 15:24:12.000000000 +0200
@@ -121,7 +121,7 @@
 #define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
 #define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
 
-extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+extern asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
 static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
--- linux-2.5.66/include/linux/ioctl32.h.~1~	2003-03-25 22:17:40.000000000 +0100
+++ linux-2.5.66/include/linux/ioctl32.h	2003-04-03 15:22:49.000000000 +0200
@@ -3,7 +3,7 @@
 
 struct file;
 
-extern long sys_ioctl(unsigned int, unsigned int, unsigned long);
+extern asmlinkage long sys_ioctl(unsigned int, unsigned int, unsigned long);
 
 /* 
  * Register an 32bit ioctl translation handler for ioctl cmd.
