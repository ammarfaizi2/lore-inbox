Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVIIQPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVIIQPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVIIQPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:15:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16776 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030210AbVIIQPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:15:17 -0400
Date: Fri, 9 Sep 2005 17:15:13 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uaccess.h annotations (uml)
Message-ID: <20050909161513.GL9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-m68k-hardirq/arch/um/kernel/skas/include/uaccess-skas.h RC13-git7-uml-user/arch/um/kernel/skas/include/uaccess-skas.h
--- RC13-git7-m68k-hardirq/arch/um/kernel/skas/include/uaccess-skas.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-git7-uml-user/arch/um/kernel/skas/include/uaccess-skas.h	2005-09-07 13:55:07.000000000 -0400
@@ -18,18 +18,18 @@
 	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
 	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
 
-static inline int verify_area_skas(int type, const void * addr,
+static inline int verify_area_skas(int type, const void __user * addr,
                                    unsigned long size)
 {
 	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
 }
 
-extern int copy_from_user_skas(void *to, const void *from, int n);
-extern int copy_to_user_skas(void *to, const void *from, int n);
-extern int strncpy_from_user_skas(char *dst, const char *src, int count);
-extern int __clear_user_skas(void *mem, int len);
-extern int clear_user_skas(void *mem, int len);
-extern int strnlen_user_skas(const void *str, int len);
+extern int copy_from_user_skas(void *to, const void __user *from, int n);
+extern int copy_to_user_skas(void __user *to, const void *from, int n);
+extern int strncpy_from_user_skas(char *dst, const char __user *src, int count);
+extern int __clear_user_skas(void __user *mem, int len);
+extern int clear_user_skas(void __user *mem, int len);
+extern int strnlen_user_skas(const void __user *str, int len);
 
 #endif
 
diff -urN RC13-git7-m68k-hardirq/arch/um/kernel/tt/include/uaccess-tt.h RC13-git7-uml-user/arch/um/kernel/tt/include/uaccess-tt.h
--- RC13-git7-m68k-hardirq/arch/um/kernel/tt/include/uaccess-tt.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-git7-uml-user/arch/um/kernel/tt/include/uaccess-tt.h	2005-09-07 13:55:07.000000000 -0400
@@ -33,7 +33,7 @@
          (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
           (under_task_size(addr, size) || is_stack(addr, size))))
 
-static inline int verify_area_tt(int type, const void * addr,
+static inline int verify_area_tt(int type, const void __user * addr,
                                  unsigned long size)
 {
 	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
@@ -50,12 +50,12 @@
 extern int __do_strnlen_user(const char *str, unsigned long n,
 			     void **fault_addr, void **fault_catcher);
 
-extern int copy_from_user_tt(void *to, const void *from, int n);
-extern int copy_to_user_tt(void *to, const void *from, int n);
-extern int strncpy_from_user_tt(char *dst, const char *src, int count);
-extern int __clear_user_tt(void *mem, int len);
-extern int clear_user_tt(void *mem, int len);
-extern int strnlen_user_tt(const void *str, int len);
+extern int copy_from_user_tt(void *to, const void __user *from, int n);
+extern int copy_to_user_tt(void __user *to, const void *from, int n);
+extern int strncpy_from_user_tt(char *dst, const char __user *src, int count);
+extern int __clear_user_tt(void __user *mem, int len);
+extern int clear_user_tt(void __user *mem, int len);
+extern int strnlen_user_tt(const void __user *str, int len);
 
 #endif
 
