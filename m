Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTCEHUu>; Wed, 5 Mar 2003 02:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTCEHUu>; Wed, 5 Mar 2003 02:20:50 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:6639 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264654AbTCEHUt>; Wed, 5 Mar 2003 02:20:49 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Always call schedule_tail on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030305073109.5E5EE3712@mcspd15.ucom.lsi.nec.co.jp>
Date: Wed,  5 Mar 2003 16:31:09 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler apparently now requires this.

diff -ruN -X../cludes linux-2.5.64-moo.orig/arch/v850/kernel/entry.S linux-2.5.64-moo/arch/v850/kernel/entry.S
--- linux-2.5.64-moo.orig/arch/v850/kernel/entry.S	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.64-moo/arch/v850/kernel/entry.S	2003-03-05 16:13:52.000000000 +0900
@@ -511,10 +511,8 @@
    (copy_thread makes ret_from_fork the return address in each new thread's
    saved context).  */
 C_ENTRY(ret_from_fork):
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 	mov	r10, r6			// switch_thread returns the prev task.
 	jarl	CSYM(schedule_tail), lp	// ...which is schedule_tail's arg
-#endif
 	mov	r0, r10			// Child's fork call should return 0.
 	br	ret_from_trap		// Do normal trap return.
 C_END(ret_from_fork)
