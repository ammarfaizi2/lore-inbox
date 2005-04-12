Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVDMCZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVDMCZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVDLToL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:44:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:64968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262179AbVDLKcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:03 -0400
Message-Id: <200504121031.j3CAVwPc005459@shell0.pdx.osdl.net>
Subject: [patch 083/198] x86_64: Fix a small missing schedule race 
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Could lead to a lost reschedule event when the process already rescheduled on
exception exit, and needs it again while still being in the kernel.  Unlikely
case though.

Also remove one redundant cli in another entry.S path.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/entry.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/entry.S~x86_64-fix-a-small-missing-schedule-race arch/x86_64/kernel/entry.S
--- 25/arch/x86_64/kernel/entry.S~x86_64-fix-a-small-missing-schedule-race	2005-04-12 03:21:23.062630848 -0700
+++ 25-akpm/arch/x86_64/kernel/entry.S	2005-04-12 03:21:23.066630240 -0700
@@ -284,6 +284,7 @@ int_careful:
 	pushq %rdi
 	call schedule
 	popq %rdi
+	cli
 	jmp int_with_check
 
 	/* handle signals and tracing -- both require a full stack frame */
@@ -453,7 +454,6 @@ retint_check:			
 	andl %edi,%edx
 	jnz  retint_careful
 retint_swapgs:	 	
-	cli
 	swapgs 
 retint_restore_args:				
 	cli
_
