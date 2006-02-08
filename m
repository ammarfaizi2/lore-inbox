Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWBHDSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWBHDSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBHDSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58496 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751139AbWBHDS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:27 -0500
To: torvalds@osdl.org
Subject: [PATCH 07/29] ppc: last_task_.... is defined only on non-SMP
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1F6fqd-0006Bx-0m@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1137641660 -0500

... so it should be exported only on non-SMP.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/ppc/kernel/ppc_ksyms.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

3ba9d91208a71947b69d52e3ca2142306457d816
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 3a6e4bc..15bd9b4 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -186,11 +186,15 @@ EXPORT_SYMBOL(flush_tlb_kernel_range);
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(_tlbie);
 #ifdef CONFIG_ALTIVEC
+#ifndef CONFIG_SMP
 EXPORT_SYMBOL(last_task_used_altivec);
+#endif
 EXPORT_SYMBOL(giveup_altivec);
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
+#ifndef CONFIG_SMP
 EXPORT_SYMBOL(last_task_used_spe);
+#endif
 EXPORT_SYMBOL(giveup_spe);
 #endif /* CONFIG_SPE */
 #ifdef CONFIG_SMP
-- 
0.99.9.GIT

