Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVIUQrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVIUQrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVIUQrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:11 -0400
Received: from [151.97.230.9] ([151.97.230.9]:33678 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751131AbVIUQrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/10] uml: remove verify_area_{tt,skas}
Date: Wed, 21 Sep 2005 18:38:33 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921163828.30500.88418.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When removing verify_area, verify_area_{tt,skas} were forgotten.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/skas/include/uaccess-skas.h |    6 ------
 arch/um/kernel/tt/include/uaccess-tt.h     |    6 ------
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/um/kernel/skas/include/uaccess-skas.h b/arch/um/kernel/skas/include/uaccess-skas.h
--- a/arch/um/kernel/skas/include/uaccess-skas.h
+++ b/arch/um/kernel/skas/include/uaccess-skas.h
@@ -18,12 +18,6 @@
 	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
 	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
 
-static inline int verify_area_skas(int type, const void __user * addr,
-                                   unsigned long size)
-{
-	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
-}
-
 extern int copy_from_user_skas(void *to, const void __user *from, int n);
 extern int copy_to_user_skas(void __user *to, const void *from, int n);
 extern int strncpy_from_user_skas(char *dst, const char __user *src, int count);
diff --git a/arch/um/kernel/tt/include/uaccess-tt.h b/arch/um/kernel/tt/include/uaccess-tt.h
--- a/arch/um/kernel/tt/include/uaccess-tt.h
+++ b/arch/um/kernel/tt/include/uaccess-tt.h
@@ -33,12 +33,6 @@ extern unsigned long uml_physmem;
          (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
           (under_task_size(addr, size) || is_stack(addr, size))))
 
-static inline int verify_area_tt(int type, const void __user * addr,
-                                 unsigned long size)
-{
-	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
-}
-
 extern unsigned long get_fault_addr(void);
 
 extern int __do_copy_from_user(void *to, const void *from, int n,

