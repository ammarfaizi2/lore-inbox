Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVI1XRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVI1XRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVI1XRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:17:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29367 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751230AbVI1XRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:17:51 -0400
Date: Thu, 29 Sep 2005 00:17:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] ppc64 get_user annotations
Message-ID: <20050928231749.GI7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	long is not uintptr_t, unsigned long is.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-proc_mkdir/include/asm-ppc64/uaccess.h RC14-rc2-git6-ppc64-user/include/asm-ppc64/uaccess.h
--- RC14-rc2-git6-proc_mkdir/include/asm-ppc64/uaccess.h	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git6-ppc64-user/include/asm-ppc64/uaccess.h	2005-09-28 13:02:25.000000000 -0400
@@ -164,7 +164,8 @@
 
 #define __get_user_nocheck(x,ptr,size)				\
 ({								\
-	long __gu_err, __gu_val;				\
+	long __gu_err;						\
+	unsigned long __gu_val;					\
 	might_sleep();						\
 	__get_user_size(__gu_val,(ptr),(size),__gu_err,-EFAULT);\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
@@ -173,7 +174,8 @@
 
 #define __get_user_check(x,ptr,size)					\
 ({									\
-	long __gu_err = -EFAULT, __gu_val = 0;				\
+	long __gu_err = -EFAULT;					\
+	unsigned long __gu_val = 0;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_sleep();							\
 	if (access_ok(VERIFY_READ,__gu_addr,size))			\
