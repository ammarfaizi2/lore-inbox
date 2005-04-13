Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVDMQP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDMQP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVDMQP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:15:56 -0400
Received: from fmr20.intel.com ([134.134.136.19]:62666 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261394AbVDMQPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:15:33 -0400
Date: Wed, 13 Apr 2005 10:45:18 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200504131745.j3DHjIVE017612@snoqualmie.dp.intel.com>
To: ak@muc.de
Subject: [patch] minor syctl fix in vsyscall_init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

If CONFIG_SYCTL is not enabled then the x86-64 tree
fails to build due to use of a symbol that is not 
compiled in.  Don't bother compiling in the sysctl
register call if not building with sysctl.  

matt

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>


diff -urNp linux-2.6.12-rc2/arch/x86_64/kernel/vsyscall.c linux-2.6.12-rc2-m/arch/x86_64/kernel/vsyscall.c
--- linux-2.6.12-rc2/arch/x86_64/kernel/vsyscall.c	2005-04-04 12:39:06.000000000 -0400
+++ linux-2.6.12-rc2-m/arch/x86_64/kernel/vsyscall.c	2005-04-13 09:28:47.000000000 -0400
@@ -218,7 +218,9 @@ static int __init vsyscall_init(void)
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	map_vsyscall();
 	sysctl_vsyscall = 1;
+#ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
+#endif
 	return 0;
 }
 
