Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVHWVn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVHWVn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVHWVnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4022 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932428AbVHWVnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:32 -0400
To: torvalds@osdl.org
Subject: [PATCH] (21/43) Kconfig fix (IRQ_ALL_CPUS vs. MV64360)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1E7gbH-0007Bo-Oa@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MV64360 does not support IRQ_ALL_CPUS - see arch/ppc/kernel/mv64360_pic.c.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig RC13-rc6-git13-mv64360-irq/arch/ppc/Kconfig
--- RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig	2005-08-21 13:17:03.000000000 -0400
+++ RC13-rc6-git13-mv64360-irq/arch/ppc/Kconfig	2005-08-21 13:17:04.000000000 -0400
@@ -935,7 +935,7 @@
 
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
-	depends on SMP
+	depends on SMP && !MV64360
 	help
 	  This option gives the kernel permission to distribute IRQs across
 	  multiple CPUs.  Saying N here will route all IRQs to the first
