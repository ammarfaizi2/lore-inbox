Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbUKFP0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUKFP0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUKFP0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:26:47 -0500
Received: from calvin.codito.com ([203.199.140.162]:21126 "EHLO
	magrathea.codito.co.in") by vger.kernel.org with ESMTP
	id S261400AbUKFP0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:26:44 -0500
From: Amit Shah <amitshah@gmx.net>
Organization: Codito Technologies
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Date: Sat, 6 Nov 2004 20:54:39 +0530
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200411051837.02083.amitshah@gmx.net> <200411061414.11719.amitshah@gmx.net> <20041106120525.GA15363@elte.hu>
In-Reply-To: <20041106120525.GA15363@elte.hu>
X-GnuPG-Fingerprint: 3001 346D 47C2 E445 EC1B  2EE1 E8FD 8F83 4E56 1092
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411062054.40384.amitshah@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 Nov 2004 17:35, Ingo Molnar wrote:
> found the bug(s), the e1000 driver disabled interrupts on
> PREEMPT_REALTIME too, and the debug-message printout had a bug as well.
> Found a similar problem in the tg3 driver too. Could you check out
> -V0.7.15 that i've just uploaded to:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> does this work any better? [you'll still get the e100 message but that
> is harmless.]

Yes; solved. (I'm using -18). Thanks.

However, I get this:

IRQ#18 thread RT prio: 46.
ifconfig/4106: BUG in enable_irq at kernel/irq/manage.c:112
 [<c0107fc0>] dump_stack+0x1e/0x22 (20)
 [<c0142a9b>] enable_irq+0xeb/0xf0 (52)
 [<f892b290>] e100_up+0x111/0x20c [e100] (48)
 [<f892c4d7>] e100_open+0x2c/0x71 [e100] (32)
 [<c027747d>] dev_open+0x78/0x86 (28)
 [<c0278aed>] dev_change_flags+0x56/0x127 (36)
 [<c02b4538>] devinet_ioctl+0x242/0x5bc (104)
 [<c02b66aa>] inet_ioctl+0x5a/0x9a (28)
 [<c026e2a4>] sock_ioctl+0xbb/0x21f (32)
 [<c01777bf>] sys_ioctl+0xdc/0x241 (44)
 [<c0107153>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02c81b8>] .... _raw_spin_lock_irqsave+0x1d/0x7a
.....[<c01429d8>] ..   ( <= enable_irq+0x28/0xf0)
.. [<c013b8c8>] .... print_traces+0x18/0x4c
.....[<c0107fc0>] ..   ( <= dump_stack+0x1e/0x22)

IRQ#17 thread RT prio: 45.
IRQ#4 thread RT prio: 44.
IRQ#3 thread RT prio: 43.
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
IRQ#8 thread RT prio: 42.

But as you say, this should be harmless.

>
>  Ingo

Amit.
-- 
Amit Shah
http://amitshah.nav.to/
