Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWJXIAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWJXIAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWJXIAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:00:50 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:38929 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S932299AbWJXIAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:00:49 -0400
Date: Tue, 24 Oct 2006 10:00:35 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [2.6.18-rt6] BUG / typo
Message-ID: <Pine.LNX.4.63.0610240954420.1852@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Got the following Oops:

[22644.590000] BUG: scheduling with irqs disabled: posix_cpu_timer/0x00000001/2
[22644.590000] caller is schedule+0x10/0x118
[22644.590000] [<c0024114>] (dump_stack+0x0/0x28) from [<c01e91f0>] (schedule+0xfc/0x118)
[22644.590000] [<c01e90f4>] (schedule+0x0/0x118) from [<c01ea79c>] (rt_spin_lock_slowlock+0xd8/0x1c8)
[22644.590000]  r5 = 00000000  r4 = C04B6000
[22644.590000] [<c01ea6c4>] (rt_spin_lock_slowlock+0x0/0x1c8) from [<c01eac74>] (__lock_text_start+0x6c/0x70)
[22644.590000] [<c01eac08>] (__lock_text_start+0x0/0x70) from [<c008c254>] (__kmalloc+0x60/0xe0)
[22644.590000]  r7 = C04B7D08  r6 = 00000020  r5 = C04B7C6C  r4 = C04030C0
[22644.590000] [<c008c1f4>] (__kmalloc+0x0/0xe0) from [<c01390e0>] (soft_cursor+0x70/0x1b4)
[22644.590000]  r6 = C05B2400  r5 = 00000000  r4 = 00000008
[22644.590000] [<c0139070>] (soft_cursor+0x0/0x1b4) from [<c013bf20>] (ccw_cursor+0x364/0x748)
[22644.590000] [<c013bbbc>] (ccw_cursor+0x0/0x748) from [<c0135ba0>] (fbcon_cursor+0x1a4/0x320)
[22644.590000] [<c01359fc>] (fbcon_cursor+0x0/0x320) from [<c014fe10>] (hide_cursor+0x3c/0x9c)
[22644.590000] [<c014fdd4>] (hide_cursor+0x0/0x9c) from [<c015184c>] (vt_console_print+0x2a8/0x2e8)
[22644.590000]  r5 = 00000000  r4 = C0484820
[22644.590000] [<c01515a4>] (vt_console_print+0x0/0x2e8) from [<c003e8ac>] (__call_console_drivers+0x90/0xb8)
[22644.590000] [<c003e81c>] (__call_console_drivers+0x0/0xb8) from [<c003e954>] (_call_console_drivers+0x80/0x90)
[22644.590000] [<c003e8d4>] (_call_console_drivers+0x0/0x90) from [<c003ecbc>] (release_console_sem+0x170/0x2f0)
[22644.590000]  r5 = 00002744  r4 = 00002744
[22644.590000] [<c003eb4c>] (release_console_sem+0x0/0x2f0) from [<c003f188>] (vprintk+0x324/0x410)
[22644.590000] [<c003ee64>] (vprintk+0x0/0x410) from [<c003f294>] (printk+0x20/0x24)
[22644.590000] [<c003f274>] (printk+0x0/0x24) from [<c00673ec>] (trace_stop_sched_switched+0x334/0x3a8)
[22644.590000]  r3 = 00000000  r2 = 00000002  r1 = C04B171C  r0 = C01FE0F8
[22644.590000] [<c00670b8>] (trace_stop_sched_switched+0x0/0x3a8) from [<c01e8cbc>] (__schedule+0x47c/0x810)
[22644.590000] [<c01e8840>] (__schedule+0x0/0x810) from [<c01e9140>] (schedule+0x4c/0x118)
[22644.590000] [<c01e90f4>] (schedule+0x0/0x118) from [<c005751c>] (posix_cpu_timers_thread+0xcc/0x10c)
[22644.590000]  r5 = C0521600  r4 = 00000000
[22644.590000] [<c0057450>] (posix_cpu_timers_thread+0x0/0x10c) from [<c0054b18>] (kthread+0x110/0x13c)
[22644.590000]  r6 = C04B3EFC  r5 = C04B6000  r4 = 00000000
[22644.590000] [<c0054a08>] (kthread+0x0/0x13c) from [<c0040e7c>] (do_exit+0x0/0x9b4)
[22644.590000]  r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
[22644.590000]  r4 = 00000000
[22644.590000] ---------------------------
[22644.590000] | preempt count: 00000001 ]
[22644.590000] | 1-level deep critical section nesting:
[22644.590000] ----------------------------------------
[22644.590000] .. [<c01e8894>] .... __schedule+0x54/0x810
[22644.590000] .....[<c01e9140>] ..   ( <= schedule+0x4c/0x118)
[22644.590000]
[22644.590000] skipping trace printing on CPU#0 != -1

which took me to this place in vprintk:

 		spin_lock_irqsave(&logbuf_lock, flags);
 		wake_klogd |= log_start - log_end;
 		if (con_start == log_end)
 			break;			/* Nothing to print */
 		_con_start = con_start;
 		_log_end = log_end;
 		con_start = log_end;		/* Flush */
 		/*
 		 * on PREEMPT_RT, call console drivers with
 		 * interrupts enabled (if printk was called
 		 * with interrupts disabled):
 		 */
#ifdef CONFIG_PREEMPT_RT
 		spin_unlock_irqrestore(&logbuf_lock, flags);
#else
 		spin_unlock(&logbuf_lock);
#endif

Doesn't this look like a contradiction between the comment and the code? 
If the comment is correct, shouldn't it be spin_unlock_irq()? (Patch 
below).

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

--- a/kernel/printk.c	2006-10-20 18:08:05.000000000 +0200
+++ b/kernel/printk.c	2006-10-24 09:44:05.666416354 +0200
@@ -834,7 +834,7 @@
  		 * with interrupts disabled):
  		 */
  #ifdef CONFIG_PREEMPT_RT
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock_irq(&logbuf_lock);
  #else
  		spin_unlock(&logbuf_lock);
  #endif
