Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVDLTni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVDLTni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVDLTng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:43:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:65224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262180AbVDLKcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:03 -0400
Message-Id: <200504121031.j3CAVttS005447@shell0.pdx.osdl.net>
Subject: [patch 080/198] x86_64: Minor microoptimization in syscall entry slow path
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Minor microoptimization in syscall entry slow path

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/entry.S |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/x86_64/kernel/entry.S~x86_64-minor-microoptimization-in-syscall-entry-slow-path arch/x86_64/kernel/entry.S
--- 25/arch/x86_64/kernel/entry.S~x86_64-minor-microoptimization-in-syscall-entry-slow-path	2005-04-12 03:21:22.425727672 -0700
+++ 25-akpm/arch/x86_64/kernel/entry.S	2005-04-12 03:21:22.429727064 -0700
@@ -302,9 +302,7 @@ int_very_careful:
 	leaq 8(%rsp),%rdi	# &ptregs -> arg1	
 	call syscall_trace_leave
 	popq %rdi
-	btr  $TIF_SYSCALL_TRACE,%edi
-	btr  $TIF_SYSCALL_AUDIT,%edi
-	btr  $TIF_SINGLESTEP,%edi
+	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
 	jmp int_restore_rest
 	
 int_signal:
_
