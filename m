Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVAQDdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVAQDdl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVAQDdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:33:40 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:12804
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262501AbVAQDdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:33 -0500
Message-Id: <200501170556.j0H5u2kY006047@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/10] UML - provide some initcall definitions for userspace code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:02 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide definitions of __initcall, __exitcall, and __init_call for userspace
code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/init.h
===================================================================
--- 2.6.10.orig/arch/um/include/init.h	2005-01-16 20:37:24.000000000 -0500
+++ 2.6.10/arch/um/include/init.h	2005-01-16 20:39:58.000000000 -0500
@@ -109,6 +109,15 @@
 #define __uml_postsetup_call	__attribute_used__ __attribute__ ((__section__ (".uml.postsetup.init")))
 #define __uml_exit_call		__attribute_used__ __attribute__ ((__section__ (".uml.exitcall.exit")))
 
+#ifndef __KERNEL__
+
+#define __initcall(fn) static initcall_t __initcall_##fn __init_call = fn
+#define __exitcall(fn) static exitcall_t __exitcall_##fn __exit_call = fn
+
+#define __init_call __attribute__ ((unused,__section__ (".initcall.init")))
+
+#endif
+  
 #endif /* _LINUX_UML_INIT_H */
 
 /*

