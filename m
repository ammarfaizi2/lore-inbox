Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUGYFPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUGYFPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 01:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUGYFPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 01:15:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26774 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263709AbUGYFPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 01:15:40 -0400
Subject: Re: preempt-timing-2.6.8-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040713143947.GG21066@holomorphy.com>
References: <20040713122805.GZ21066@holomorphy.com>
	 <40F3F0A0.9080100@vision.ee>  <20040713143947.GG21066@holomorphy.com>
Content-Type: text/plain
Message-Id: <1090732537.738.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 01:15:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 10:39, William Lee Irwin III wrote:
> On Tue, Jul 13, 2004 at 05:24:32PM +0300, Lenar L?hmus wrote:
> > What I've excluded (happens all the time):
> > 1) 2ms non-preemptible critical section violated 1 ms preempt threshold 
> > starting at schedule+0x36/0x480 and ending at do_IRQ+0xec/0x130
> > it's 2ms 98%. This really happens all the time. Bogus?
> 
> Wild guess is that you took an IRQ in dec_preempt_count() and that threw
> your results off. Let me know if the patch below helps at all. My guess
> is it'll cause more apparent problems than it solves.

I applied the patch to 2.6.8-rc2 + voluntary-preempt-I4, and am
constantly getting these:

2ms non-preemptible critical section violated 1 ms preempt threshold starting at schedule+0x65/0x5b0 and ending at do_IRQ+0x101/0x170
 [<c01066e7>] dump_stack+0x17/0x20
 [<c011426e>] dec_preempt_count+0x10e/0x120
 [<c0107cb1>] do_IRQ+0x101/0x170
 [<c01062a8>] common_interrupt+0x18/0x20
 [<c010421d>] cpu_idle+0x2d/0x40
 [<c030a782>] start_kernel+0x1a2/0x1f0
 [<c010019f>] 0xc010019f
printk: 1 messages suppressed.
2ms non-preemptible critical section violated 1 ms preempt threshold starting at schedule+0x65/0x5b0 and ending at do_IRQ+0x101/0x170
 [<c01066e7>] dump_stack+0x17/0x20
 [<c011426e>] dec_preempt_count+0x10e/0x120
 [<c0107cb1>] do_IRQ+0x101/0x170
 [<c01062a8>] common_interrupt+0x18/0x20
 [<c010421d>] cpu_idle+0x2d/0x40
 [<c030a782>] start_kernel+0x1a2/0x1f0
 [<c010019f>] 0xc010019f
printk: 1 messages suppressed.
2ms non-preemptible critical section violated 1 ms preempt threshold starting at schedule+0x65/0x5b0 and ending at do_IRQ+0x101/0x170
 [<c01066e7>] dump_stack+0x17/0x20
 [<c011426e>] dec_preempt_count+0x10e/0x120
 [<c0107cb1>] do_IRQ+0x101/0x170
 [<c01062a8>] common_interrupt+0x18/0x20
 [<c010421d>] cpu_idle+0x2d/0x40
 [<c030a782>] start_kernel+0x1a2/0x1f0
 [<c010019f>] 0xc010019f

This seems related to keyboard input; if I keep a key pressed down they
happen regularly.

These are similar to the XRUN traces I get from ALSA, so I think there
is a real problem here.

Lee

