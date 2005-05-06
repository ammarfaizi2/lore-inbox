Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVEFXwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVEFXwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVEFXYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:24:42 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:48390 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261349AbVEFXOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:14:35 -0400
Message-Id: <200505062249.j46MnXqg010480@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 9/12] UML - Use CONFIG variable for address space size
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

tt/mem.c still uses hardcoded TOP for i386 instead of
CONFIG_TOP_ADDR provided by subarch's Kconfig_XXXX,
which would be right.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/tt/mem.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/mem.c	2005-04-29 13:44:51.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/tt/mem.c	2005-04-29 15:11:21.000000000 -0400
@@ -21,14 +21,8 @@
 	remap_data(UML_ROUND_DOWN(&__bss_start), UML_ROUND_UP(&_end), 1);
 }
 
-#ifdef CONFIG_HOST_2G_2G
-#define TOP 0x80000000
-#else
-#define TOP 0xc0000000
-#endif
-
 #define SIZE ((CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS) * 0x20000000)
-#define START (TOP - SIZE)
+#define START (CONFIG_TOP_ADDR - SIZE)
 
 unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out, 
 				unsigned long *task_size_out)

