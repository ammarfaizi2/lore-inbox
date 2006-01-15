Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWAOFl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWAOFl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 00:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWAOFl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 00:41:58 -0500
Received: from [198.99.130.12] ([198.99.130.12]:21404 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751671AbWAOFl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 00:41:57 -0500
Message-Id: <200601150633.k0F6Xa2I015470@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Bryan O'Sullivan" <bos@pathscale.com>
Subject: [PATCH 3/3] UML - Add __raw_writel definition
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 01:33:36 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add implementations of the write* and __raw_write* functions.  __raw_writel
is needed by lib/iocopy.c, which shouldn't be used in UML, but which is 
unconditionally linked in anyway.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/include/asm-um/io.h
===================================================================
--- linux-2.6.15-mm.orig/include/asm-um/io.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15-mm/include/asm-um/io.h	2006-01-14 19:12:17.000000000 -0500
@@ -33,4 +33,20 @@ static inline void * phys_to_virt(unsign
  */
 #define xlate_dev_kmem_ptr(p)	p
 
+static inline void writeb(unsigned char b, volatile void __iomem *addr)
+{
+	*(volatile unsigned char __force *) addr = b;
+}
+static inline void writew(unsigned short b, volatile void __iomem *addr)
+{
+	*(volatile unsigned short __force *) addr = b;
+}
+static inline void writel(unsigned int b, volatile void __iomem *addr)
+{
+	*(volatile unsigned int __force *) addr = b;
+}
+#define __raw_writeb writeb
+#define __raw_writew writew
+#define __raw_writel writel
+
 #endif

