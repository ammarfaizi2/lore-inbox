Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbTCYCt0>; Mon, 24 Mar 2003 21:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCYCrj>; Mon, 24 Mar 2003 21:47:39 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:50859 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261362AbTCYCrH>; Mon, 24 Mar 2003 21:47:07 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Always call schedule_tail on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030325025659.12E4637CC@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 25 Mar 2003 11:56:59 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler apparently now requires this.

diff -ruN -X../cludes linux-2.5.66-moo.orig/arch/v850/kernel/entry.S linux-2.5.66-moo/arch/v850/kernel/entry.S
--- linux-2.5.66-moo.orig/arch/v850/kernel/entry.S	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.66-moo/arch/v850/kernel/entry.S	2003-03-25 10:37:52.000000000 +0900
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
