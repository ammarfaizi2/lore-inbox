Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993142AbWJUQxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993142AbWJUQxY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993144AbWJUQv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:57 -0400
Received: from ns1.suse.de ([195.135.220.2]:46748 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993143AbWJUQve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:34 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [13/19] x86_64: Revert interrupt backlink changes
Message-Id: <20061021165133.6DBC313CB4@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:33 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


They break more than they fix
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/entry.S |    3 ---
 1 files changed, 3 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -537,8 +537,6 @@ END(stub_rt_sigreturn)
 1:	incl	%gs:pda_irqcount
 	cmoveq %gs:pda_irqstackptr,%rsp
 	push    %rbp			# backlink for old unwinder
-	CFI_ADJUST_CFA_OFFSET 8
-	CFI_REL_OFFSET rbp,0
 	/*
 	 * We entered an interrupt context - irqs are off:
 	 */
@@ -1178,7 +1176,6 @@ ENTRY(call_softirq)
 	incl %gs:pda_irqcount
 	cmove %gs:pda_irqstackptr,%rsp
 	push  %rbp			# backlink for old unwinder
-	CFI_ADJUST_CFA_OFFSET    8
 	call __do_softirq
 	leaveq
 	CFI_DEF_CFA_REGISTER	rsp
