Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266529AbUA2Xi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUA2Xh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:37:56 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:10447 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S266523AbUA2Xhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:37:47 -0500
To: s0348365@sms.ed.ac.uk
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm1 (Breakage?)
References: <20040127233402.6f5d3497.akpm@osdl.org>
	<200401281313.03790.ender@debian.org>
	<200401281225.37234.s0348365@sms.ed.ac.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 30 Jan 2004 00:37:39 +0100
In-Reply-To: <200401281225.37234.s0348365@sms.ed.ac.uk>
Message-ID: <87r7xiba2k.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

> On Wednesday 28 January 2004 12:13, David Martínez Moreno wrote:
> > El Miércoles, 28 de Enero de 2004 08:34, Andrew Morton escribió:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2
> > >.6 .2-rc2-mm1/
> > >
> > >
> > > - From now on, -mm kernels will contain the latest contents of:
> > >
> > > 	Linus's tree:		linus.patch
> > > 	The ACPI tree:		acpi.patch
> > > 	Vojtech's tree:		input.patch
> > > 	Jeff's tree:		netdev.patch
> > > 	The ALSA tree:		alsa.patch
> > >
> > >   If anyone has any more external trees which need similar treatment,
> > >   please let me know.
> > >
> > > - Various fixes.  Nothing stands out.
> >
> > 	Hello, Andrew, I've switched from 2.6.2-rc1-mm1 to 2.6.2-rc1-mm1, and I've
> > encountered this:
> >
> [snip]
> 
> Decided to build my first kernel with preempt since the early 2.5 days. I'm 
> seeing the same warnings in 2.6.2-rc2-mm1.
> 
> gkrellm 0 waking gkrellm: 897 1485
> Badness in try_to_wake_up at kernel/sched.c:722
> Call Trace:
>  [<c011a6a7>] try_to_wake_up+0x97/0x1d0
>  [<c011b0b0>] __wake_up_common+0x30/0x60
>  [<c011b109>] __wake_up+0x29/0x50
>  [<c0131f1b>] wake_futex+0x2b/0x70
>  [<c013259a>] do_futex+0x3fa/0x6e0
>  [<c011d9d0>] copy_process+0x7b0/0x10a0
>  [<c011e3a9>] do_fork+0xe9/0x179
>  [<c011a142>] schedule+0x1d2/0x640
>  [<c0132988>] sys_futex+0x108/0x130
>  [<c03e1b9e>] sysenter_past_esp+0x43/0x65
> 
> Every five seconds. This is when it reads the sensor information from /sys, I 
> think. And during boot, similar messages to those already reported (from 
> kern.log this time).
> 

I'm getting this from many different sources not doing polling in
/sys:

Jan 30 00:31:30 lapper kernel: mozilla-bin 0 waking mozilla-bin: 10599 10641
Jan 30 00:31:30 lapper kernel: Badness in try_to_wake_up at kernel/sched.c:722
Jan 30 00:31:30 lapper kernel: Call Trace:
Jan 30 00:31:30 lapper kernel:  [try_to_wake_up+145/457] try_to_wake_up+0x91/0x1c9
Jan 30 00:31:30 lapper kernel:  [<c011e9d5>] try_to_wake_up+0x91/0x1c9
Jan 30 00:31:30 lapper kernel:  [__wake_up_common+49/80] __wake_up_common+0x31/0x50
Jan 30 00:31:30 lapper kernel:  [<c011fa0f>] __wake_up_common+0x31/0x50
Jan 30 00:31:30 lapper kernel:  [__wake_up+50/87] __wake_up+0x32/0x57
Jan 30 00:31:30 lapper kernel:  [<c011fa60>] __wake_up+0x32/0x57
Jan 30 00:31:30 lapper kernel:  [wake_futex+49/91] wake_futex+0x31/0x5b
Jan 30 00:31:30 lapper kernel:  [<c0135f3d>] wake_futex+0x31/0x5b
Jan 30 00:31:30 lapper kernel:  [futex_wake+209/223] futex_wake+0xd1/0xdf
Jan 30 00:31:30 lapper kernel:  [<c0136038>] futex_wake+0xd1/0xdf
Jan 30 00:31:30 lapper kernel:  [do_futex+123/125] do_futex+0x7b/0x7d
Jan 30 00:31:30 lapper kernel:  [<c01367de>] do_futex+0x7b/0x7d
Jan 30 00:31:30 lapper kernel:  [sys_futex+278/303] sys_futex+0x116/0x12f
Jan 30 00:31:30 lapper kernel:  [<c01368f6>] sys_futex+0x116/0x12f
Jan 30 00:31:30 lapper kernel:  [sysenter_past_esp+67/101] sysenter_past_esp+0x43/0x65
Jan 30 00:31:30 lapper kernel:  [<c029131e>] sysenter_past_esp+0x43/0x65
Jan 30 00:31:30 lapper kernel:

And:

Jan 30 00:32:26 lapper kernel: emacs 256 waking mozilla-bin: 10599 10641
Jan 30 00:32:26 lapper kernel: Badness in try_to_wake_up at kernel/sched.c:722
Jan 30 00:32:26 lapper kernel: Call Trace:
Jan 30 00:32:26 lapper kernel:  [try_to_wake_up+145/457] try_to_wake_up+0x91/0x1c9
Jan 30 00:32:26 lapper kernel:  [<c011e9d5>] try_to_wake_up+0x91/0x1c9
Jan 30 00:32:26 lapper kernel:  [process_timeout+0/12] process_timeout+0x0/0xc
Jan 30 00:32:26 lapper kernel:  [<c012b605>] process_timeout+0x0/0xc
Jan 30 00:32:26 lapper kernel:  [wake_up_process+30/34] wake_up_process+0x1e/0x22
Jan 30 00:32:26 lapper kernel:  [<c011eb2b>] wake_up_process+0x1e/0x22
Jan 30 00:32:26 lapper kernel:  [run_timer_softirq+212/456] run_timer_softirq+0xd4/0x1c8
Jan 30 00:32:26 lapper kernel:  [<c012b34e>] run_timer_softirq+0xd4/0x1c8
Jan 30 00:32:26 lapper kernel:  [do_softirq+152/154] do_softirq+0x98/0x9a
Jan 30 00:32:26 lapper kernel:  [<c0127138>] do_softirq+0x98/0x9a
Jan 30 00:32:26 lapper kernel:  [do_IRQ+271/324] do_IRQ+0x10f/0x144
Jan 30 00:32:26 lapper kernel:  [<c010c9e2>] do_IRQ+0x10f/0x144
Jan 30 00:32:26 lapper kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 30 00:32:26 lapper kernel:  [<c0291d58>] common_interrupt+0x18/0x20
Jan 30 00:32:26 lapper kernel:

With acpid running, which actually does some polling in /sys, the
machine will go out like a light within two seconds logging into gnome
and getting the acpi-based power-applet running.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
