Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTBUNeb>; Fri, 21 Feb 2003 08:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbTBUNeb>; Fri, 21 Feb 2003 08:34:31 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:15301 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S267435AbTBUNe3>; Fri, 21 Feb 2003 08:34:29 -0500
Message-ID: <3E562D31.10906@quark.didntduck.org>
Date: Fri, 21 Feb 2003 08:44:17 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trival patch to i386 enter_lazy_tlb()
Content-Type: multipart/mixed;
 boundary="------------000309030006060005080203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000309030006060005080203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Moves the #ifdef into the function to improve readability.

--
				Brian Gerst

--------------000309030006060005080203
Content-Type: text/plain;
 name="lazytlb-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lazytlb-1"

diff -urN linux-2.5.62-bk6/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- linux-2.5.62-bk6/include/asm-i386/mmu_context.h	2003-01-13 16:20:56.000000000 -0500
+++ linux/include/asm-i386/mmu_context.h	2003-02-21 08:32:36.000000000 -0500
@@ -13,18 +13,14 @@
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void destroy_context(struct mm_struct *mm);
 
-#ifdef CONFIG_SMP
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
 {
+#ifdef CONFIG_SMP
 	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
 		cpu_tlbstate[cpu].state = TLBSTATE_LAZY;	
-}
-#else
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
-{
-}
 #endif
+}
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
 {

--------------000309030006060005080203--

