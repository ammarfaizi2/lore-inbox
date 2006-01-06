Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWAFXco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWAFXco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWAFXco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:32:44 -0500
Received: from quark.didntduck.org ([69.55.226.66]:32926 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S964850AbWAFXcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:32:43 -0500
Message-ID: <43BEFE6D.6080107@didntduck.org>
Date: Fri, 06 Jan 2006 18:34:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: cleanup enter_lazy_tlb()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the #ifdef into the function body.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit bcefe96417edca37a3834ba081bc8928cf411183
tree bb6b021c691fa2cbcc85fe6c880a3a548d65bb85
parent 35b05d09cd8b10bebe341d8f315d11497b88f012
author Brian Gerst <bgerst@didntduck.org> Fri, 06 Jan 2006 17:20:20 -0500
committer Brian Gerst <bgerst@didntduck.org> Fri, 06 Jan 2006 17:20:20 -0500

 include/asm-x86_64/mmu_context.h |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/asm-x86_64/mmu_context.h b/include/asm-x86_64/mmu_context.h
index b630d52..16e4be4 100644
--- a/include/asm-x86_64/mmu_context.h
+++ b/include/asm-x86_64/mmu_context.h
@@ -15,18 +15,13 @@
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void destroy_context(struct mm_struct *mm);
 
-#ifdef CONFIG_SMP
-
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
+#ifdef CONFIG_SMP
 	if (read_pda(mmu_state) == TLBSTATE_OK) 
 		write_pda(mmu_state, TLBSTATE_LAZY);
-}
-#else
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
 #endif
+}
 
 static inline void load_cr3(pgd_t *pgd)
 {


