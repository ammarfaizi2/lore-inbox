Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTE0JJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTE0JJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:09:21 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:20186 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262963AbTE0JIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:08:31 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Remove some unneeded register saving on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030527092133.B7A7C37BB@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 27 May 2003 18:21:33 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These registers are now saved in a difference place, but the old code
was inadvertently left in.

diff -ruN -X../cludes linux-2.5.70/arch/v850/kernel/entry.S linux-2.5.70-v850-20030527/arch/v850/kernel/entry.S
--- linux-2.5.70/arch/v850/kernel/entry.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.70-v850-20030527/arch/v850/kernel/entry.S	2003-05-27 16:53:39.000000000 +0900
@@ -610,10 +636,9 @@
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_sigreturn_wrapper)
 L_ENTRY(sys_rt_sigreturn_wrapper):
-        SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	movea	PTO, sp, r6		// add user context as 1st arg
-	mov	hilo(CSYM(sys_rt_sigreturn)), r18	// syscall function
-	jarl	save_extra_state_tramp, lp	// Save state and do it
+	mov	hilo(CSYM(sys_rt_sigreturn)), r18// syscall function
+	jarl	save_extra_state_tramp, lp	 // Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_rt_sigreturn_wrapper)
 
