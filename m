Return-Path: <linux-kernel-owner+w=401wt.eu-S1751120AbXANFfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbXANFfh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXANFfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:35:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58804 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbXANFfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:35:36 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 6/11] powerpc vDSO: use VM_ALWAYSDUMP
X-Windows: it was hard to write; it should be hard to use.
Message-Id: <20070114053533.141921800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:35:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes core dumps to include the vDSO vma, which is left out now.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/vdso.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index a4b28c7..ae0ede1 100644  
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -284,6 +284,13 @@ int arch_setup_additional_pages(struct l
 	 * pages though
 	 */
 	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	/*
+	 * Make sure the vDSO gets into every core dump.
+	 * Dumping its contents makes post-mortem fully interpretable later
+	 * without matching up the same kernel and hardware config to see
+	 * what PC values meant.
+	 */
+	vma->vm_flags |= VM_ALWAYSDUMP;
 	vma->vm_flags |= mm->def_flags;
 	vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];
 	vma->vm_ops = &vdso_vmops;
