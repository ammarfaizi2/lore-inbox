Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161218AbVIPSCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161218AbVIPSCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbVIPSCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:02:41 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:32006 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1161218AbVIPSCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:02:40 -0400
Message-Id: <200509161755.j8GHtR4G006755@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/1] UML - UML/i386 cmpxchg fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Sep 2005 13:55:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.14 material, as it works in current mainline, and is a slight 
improvment there.

In -rc1-mm1, this fixes a compilation breakage caused by the cmpxchg changes
in asm-i386/system.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc1-mm1/arch/um/Kconfig.i386
===================================================================
--- linux-2.6.13-rc1-mm1.orig/arch/um/Kconfig.i386	2005-09-16 12:33:07.000000000 -0400
+++ linux-2.6.13-rc1-mm1/arch/um/Kconfig.i386	2005-09-16 13:20:49.000000000 -0400
@@ -42,3 +42,7 @@
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default y
+
+config X86_CMPXCHG
+	bool
+	default y
Index: linux-2.6.13-rc1-mm1/include/asm-um/system-i386.h
===================================================================
--- linux-2.6.13-rc1-mm1.orig/include/asm-um/system-i386.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-rc1-mm1/include/asm-um/system-i386.h	2005-09-16 13:20:20.000000000 -0400
@@ -3,6 +3,4 @@
 
 #include "asm/system-generic.h"
     
-#define __HAVE_ARCH_CMPXCHG 1
-
 #endif

