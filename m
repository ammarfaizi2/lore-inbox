Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTDUFDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 01:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTDUFDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 01:03:18 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:38047 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263765AbTDUFDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 01:03:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Remove some unneeded register saving on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030421051303.E021B3715@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon, 21 Apr 2003 14:13:03 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These registers are now saved in a difference place, but the old code
was inadvertently left in.

diff -ruN -X../cludes linux-2.5.68-uc0/arch/v850/kernel/entry.S linux-2.5.68-uc0-v850-20030421/arch/v850/kernel/entry.S
--- linux-2.5.68-uc0/arch/v850/kernel/entry.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.68-uc0-v850-20030421/arch/v850/kernel/entry.S	2003-04-21 11:27:09.000000000 +0900
@@ -610,10 +627,9 @@
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_sigreturn_wrapper)
 L_ENTRY(sys_rt_sigreturn_wrapper):
-        SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	movea	PTO, sp, r6		// add user context as 1st arg
 	mov	hilo(CSYM(sys_rt_sigreturn)), r18	// syscall function
-	jarl	save_extra_state_tramp, lp	// Save state and do it
+	jarl	save_extra_state_tramp, lp	 // Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_rt_sigreturn_wrapper)
 
