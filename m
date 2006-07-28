Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWG1DFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWG1DFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWG1DFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:05:53 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:50154 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751256AbWG1DFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:05:53 -0400
Message-Id: <200607280304.k6S34j4R007921@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/7] UML - semaphore build fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jul 2006 23:04:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc2-mm1 broke the UML build on i386.  The culprit was i386
moving kernel/semaphore.c to lib/semaphore.S.  I needed to change that
path, plus pull a couple of i386 headers to asm-um.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/Makefile	2006-07-27 12:36:56.000000000 -0400
+++ linux-2.6.18-mm/arch/um/sys-i386/Makefile	2006-07-27 12:38:40.000000000 -0400
@@ -4,7 +4,7 @@ obj-y = bugs.o checksum.o delay.o fault.
 
 obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
-subarch-obj-y = lib/bitops.o kernel/semaphore.o
+subarch-obj-y = lib/bitops.o lib/semaphore.o
 subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem.o
 subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
Index: linux-2.6.18-mm/include/asm-um/alternative-asm.i
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/include/asm-um/alternative-asm.i	2006-07-27 12:38:40.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_ALTERNATIVE_ASM_I
+#define __UM_ALTERNATIVE_ASM_I
+
+#include "asm/arch/alternative-asm.i"
+
+#endif
Index: linux-2.6.18-mm/include/asm-um/frame.i
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/include/asm-um/frame.i	2006-07-27 12:38:40.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_FRAME_I
+#define __UM_FRAME_I
+
+#include "asm/arch/frame.i"
+
+#endif

