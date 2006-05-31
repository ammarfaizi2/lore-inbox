Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWEaMbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWEaMbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 08:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWEaMbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 08:31:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:56200 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964975AbWEaMbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 08:31:35 -0400
Date: Wed, 31 May 2006 14:31:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: fix stacktrace on x86_64
Message-ID: <20060531123156.GA9371@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replacement for lockdep-stacktrace-oops-workaround.patch:

------------------
Subject: lock validator: fix stacktrace on x86_64
From: Ingo Molnar <mingo@elte.hu>

after hours of hair-pulling by Arjan and me the "x86_64 crashes
on bootup" problem got traced back to a brown-paperbag 32/64-bit
mixup. Sign extension got us lucky, but that luck vanished in
2.6.17-rc5-mm1 ...

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/stacktrace.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/stacktrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/stacktrace.c
+++ linux/arch/x86_64/kernel/stacktrace.c
@@ -115,9 +115,9 @@ save_context_stack(struct stack_trace *t
 	unsigned long addr;
 
 #ifdef CONFIG_FRAME_POINTER
-	unsigned prev_stack = 0;
+	unsigned long prev_stack = 0;
 
-	while (in_range(prev_stack, (unsigned long)stack, stack_end)) {
+	while (in_range(prev_stack, stack, stack_end)) {
 		pr_debug("stack:          %p\n", (void *)stack);
 		addr = (unsigned long)(((unsigned long *)stack)[1]);
 		pr_debug("addr:           %p\n", (void *)addr);
