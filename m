Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUAEVwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUAEVwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:52:44 -0500
Received: from jupiter.loonybin.net ([208.248.0.98]:3338 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S265973AbUAEVwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:52:41 -0500
Date: Mon, 5 Jan 2004 15:52:34 -0600
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 - oops in serio(?)
Message-ID: <20040105215234.GA3141@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had an oops yesterday that caused my keyboard to stop responding.
I'm running 2.6.0 with APIC and pre-empt enabled, though I don't
know if those are affecting it.  The keyboard is an IBM model-M,
which seems a tad flakey with the new code.

The tainted module is ATI's fglrx module, and I very much doubt it's
causing the problem.

It looks like a work function is NULL or something.

Oops follows.

 printing eip:
00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P  
EFLAGS: 00010087
EIP is at 0x0
eax: dc60e918   ebx: 00000000   ecx: c0475dbc   edx: 00000001
esi: 00000000   edi: 00000001   ebp: dff8de60   esp: dff8de44
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=dff8c000 task=c151ccc0)
Stack: c011d8a1 dc60e918 00000001 00000000 dff8c000 00000292 d91c88b2 dff8de80 
       c011d901 dc61e924 00000001 00000001 00000000 dc61e000 dc61e000 00000fff 
       c026d700 dc61e0b8 0000001d 00020001 00000001 c012931f 00000001 dff8c000 
Call Trace:
 [__wake_up_common+49/96] __wake_up_common+0x31/0x60
 [__wake_up+49/96] __wake_up+0x31/0x60
 [n_tty_receive_buf+528/4048] n_tty_receive_buf+0x210/0xfd0
 [do_timer+223/240] do_timer+0xdf/0xf0
 [do_IRQ+253/304] do_IRQ+0xfd/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [schedule+791/1392] schedule+0x317/0x570
 [flush_to_ldisc+160/272] flush_to_ldisc+0xa0/0x110
 [worker_thread+477/720] worker_thread+0x1dd/0x2d0
 [flush_to_ldisc+0/272] flush_to_ldisc+0x0/0x110
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [worker_thread+0/720] worker_thread+0x0/0x2d0
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
 <6>note: events/0[3] exited with preempt_count 1

atkbd.c: Unknown key released (translated set 2, code 0x6e, data 0xff, on isa0060/serio0).
last message repeated 23 times


-- 
Zinx Verituse                                    http://zinx.xmms.org/
