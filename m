Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDSKqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDSKqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 06:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWDSKqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 06:46:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:62389 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750702AbWDSKqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 06:46:54 -0400
X-Authenticated: #4399952
Date: Wed, 19 Apr 2006 12:46:52 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: BUG with 2.6.16-rt17
Message-ID: <20060419124652.42147536@mango.fruits>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

i found the time to build and boot into 2.6.16-rt17 and i got a BUG:

softirq-hrtmono/9[CPU#0]: BUG in check_monotonic_clock at kernel/time/timeofday.
c:162
 [<b0103ec5>] show_trace+0x25/0x30 (20)
 [<b0103ef3>] dump_stack+0x23/0x30 (20)
 [<b011840b>] __WARN_ON+0x6b/0xb0 (40)
 [<b013ca39>] check_monotonic_clock+0x119/0x130 (52)
 [<b013ddca>] __get_monotonic_clock+0xaa/0xc0 (60)
 [<b013dfe1>] get_monotonic_clock+0x21/0x50 (32)
 [<b011bca8>] it_real_fn+0x58/0xa0 (48)
 [<b0130f34>] run_hrtimer_softirq+0xc4/0x270 (60)
 [<b011de74>] ksoftirqd+0x104/0x1c0 (48)
 [<b012d4cc>] kthread+0xdc/0xe0 (48)
 [<b0100e55>] kernel_thread_helper+0x5/0x10 (268615708)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<b01183c0>] .... __WARN_ON+0x20/0xb0
.....[<b013ca39>] ..   ( <= check_monotonic_clock+0x119/0x130)

------------------------------
| showing all locks held by: |  (softirq-hrtmono/9 [effd07c0,  98]):
------------------------------


Besides the BUG i also am not able to run jackd with a periodsize of 16
frames reliably (xruns and a pretty big cpu load of around 30%). I
suppose this might be due to the tracing overhead though (as
preempt_max_latency shows a value of 34 and 16 frames at 48khz is in the
0.3ms range). Will rebuild w/o the tracing/debug stuff, to see how it
performs then.

Flo

P.S.: .config available here:

http://affenbande.org/~tapas/2.6.16-rt17-config


-- 
Palimm Palimm!
http://tapas.affenbande.org
