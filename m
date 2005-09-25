Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVIYAHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVIYAHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 20:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVIYAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 20:07:52 -0400
Received: from quark.didntduck.org ([69.55.226.66]:3978 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750796AbVIYAHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 20:07:52 -0400
Message-ID: <4335EA3A.60903@didntduck.org>
Date: Sat, 24 Sep 2005 20:07:22 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trivial cleanup to x86_64 enter_lazy_tlb()
Content-Type: multipart/mixed;
 boundary="------------010700050305040206010505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010700050305040206010505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Move the #ifdef into the function body.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------010700050305040206010505
Content-Type: text/plain;
 name="0002-Trivial-cleanup-to-x86_64-enter_lazy_tlb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Trivial-cleanup-to-x86_64-enter_lazy_tlb.txt"

Subject: [PATCH] Trivial cleanup to x86_64 enter_lazy_tlb()

Move the #ifdef into the function body.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 include/asm-x86_64/mmu_context.h |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

f01fd56b69e46c6cb3af9eaebe7b3a4ad3b0757a
diff --git a/include/asm-x86_64/mmu_context.h b/include/asm-x86_64/mmu_context.h
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

--------------010700050305040206010505--
