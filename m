Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbVH2UPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbVH2UPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbVH2UOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:14:04 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:37390 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751594AbVH2UOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:14:01 -0400
Message-Id: <200508292007.j7TK72Or029927@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 4/9] UML - Mark SMP on UML/x86_64 as broken
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:07:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed by Al Viro - SMP on x86_64 is fundamentally broken due to
UML's reuse of the host arch's percpu stuff.  This is OK on x86, but
the x86_64 pda stuff just won't work for UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/Kconfig
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/Kconfig	2005-08-15 12:03:07.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/Kconfig	2005-08-15 14:04:23.000000000 -0400
@@ -196,7 +196,7 @@
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
-	depends on MODE_TT && EXPERIMENTAL
+	depends on (MODE_TT && EXPERIMENTAL && !SMP_BROKEN) || (BROKEN && SMP_BROKEN)
 	help
 	This option enables UML SMP support.
 	It is NOT related to having a real SMP box. Not directly, at least.
Index: linux-2.6.13-rc6/arch/um/Kconfig_x86_64
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/Kconfig_x86_64	2005-08-08 12:11:18.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/Kconfig_x86_64	2005-08-15 14:04:27.000000000 -0400
@@ -33,3 +33,7 @@
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default n
+
+config SMP_BROKEN
+	bool
+	default y

