Return-Path: <linux-kernel-owner+willy=40w.ods.org-S282331AbUKBFIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S282331AbUKBFIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S771430AbUKBFIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:08:51 -0500
Received: from ozlabs.org ([203.10.76.45]:62357 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S318259AbUKBFIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 00:08:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
Date: Tue, 2 Nov 2004 16:11:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: nathanl@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 mmu_context_init needs to run earlier
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <nathanl@austin.ibm.com>.

This patch changes mmu_context_init to be called as a core_initcall
rather than an arch_initcall, since mmu_context_init needs to run
before we try to run any userspace processes, and arch_initcall was
found to be too late.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/mm/init.c~ppc64-make-mmu_context_init-core_initcall arch/ppc64/mm/init.c
--- linux-2.6.10-rc1-bk11/arch/ppc64/mm/init.c~ppc64-make-mmu_context_init-core_initcall	2004-11-01 19:51:46.000000000 -0600
+++ linux-2.6.10-rc1-bk11-nathanl/arch/ppc64/mm/init.c	2004-11-01 19:53:24.000000000 -0600
@@ -529,7 +529,7 @@ static int __init mmu_context_init(void)
 
 	return 0;
 }
-arch_initcall(mmu_context_init);
+core_initcall(mmu_context_init);
 
 /*
  * Do very early mm setup.
