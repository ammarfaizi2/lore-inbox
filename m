Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVEFWxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVEFWxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVEFWxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:53:47 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:35334 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261308AbVEFWxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:53:45 -0400
Message-Id: <200505062248.j46Mmr4K010433@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: [PATCH 1/12] UML - __deprecated makes build unnecessarily noisy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:48:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the __deprecated from verify_area_skas and verify_area_tt.  Since
verify_area is itself marked __deprecated, and it is the only caller of
these, then they don't need to be marked.  Marking them only makes the
build noisier.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/skas/include/uaccess-skas.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/include/uaccess-skas.h	2005-05-06 15:10:02.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/skas/include/uaccess-skas.h	2005-05-06 15:18:46.000000000 -0400
@@ -18,8 +18,8 @@
 	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
 	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
 
-static inline int __deprecated verify_area_skas(int type, const void * addr,
-				   unsigned long size)
+static inline int verify_area_skas(int type, const void * addr,
+                                   unsigned long size)
 {
 	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
 }
Index: linux-2.6.11/arch/um/kernel/tt/include/uaccess-tt.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/include/uaccess-tt.h	2005-05-06 15:10:02.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/tt/include/uaccess-tt.h	2005-05-06 15:19:04.000000000 -0400
@@ -33,8 +33,8 @@
          (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
           (under_task_size(addr, size) || is_stack(addr, size))))
 
-static inline int __deprecated verify_area_tt(int type, const void * addr,
-				 unsigned long size)
+static inline int verify_area_tt(int type, const void * addr,
+                                 unsigned long size)
 {
 	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
 }

