Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbUA1MXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 07:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUA1MXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 07:23:36 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:46264 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S265942AbUA1MXa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 07:23:30 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1 (Breakage?)
Date: Wed, 28 Jan 2004 12:25:37 +0000
User-Agent: KMail/1.5.94
Cc: David =?iso-8859-1?q?Mart=EDnez_Moreno?= <ender@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
References: <20040127233402.6f5d3497.akpm@osdl.org> <200401281313.03790.ender@debian.org>
In-Reply-To: <200401281313.03790.ender@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401281225.37234.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 January 2004 12:13, David Martínez Moreno wrote:
> El Miércoles, 28 de Enero de 2004 08:34, Andrew Morton escribió:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2
> >.6 .2-rc2-mm1/
> >
> >
> > - From now on, -mm kernels will contain the latest contents of:
> >
> > 	Linus's tree:		linus.patch
> > 	The ACPI tree:		acpi.patch
> > 	Vojtech's tree:		input.patch
> > 	Jeff's tree:		netdev.patch
> > 	The ALSA tree:		alsa.patch
> >
> >   If anyone has any more external trees which need similar treatment,
> >   please let me know.
> >
> > - Various fixes.  Nothing stands out.
>
> 	Hello, Andrew, I've switched from 2.6.2-rc1-mm1 to 2.6.2-rc1-mm1, and I've
> encountered this:
>
[snip]

Decided to build my first kernel with preempt since the early 2.5 days. I'm 
seeing the same warnings in 2.6.2-rc2-mm1.

gkrellm 0 waking gkrellm: 897 1485
Badness in try_to_wake_up at kernel/sched.c:722
Call Trace:
 [<c011a6a7>] try_to_wake_up+0x97/0x1d0
 [<c011b0b0>] __wake_up_common+0x30/0x60
 [<c011b109>] __wake_up+0x29/0x50
 [<c0131f1b>] wake_futex+0x2b/0x70
 [<c013259a>] do_futex+0x3fa/0x6e0
 [<c011d9d0>] copy_process+0x7b0/0x10a0
 [<c011e3a9>] do_fork+0xe9/0x179
 [<c011a142>] schedule+0x1d2/0x640
 [<c0132988>] sys_futex+0x108/0x130
 [<c03e1b9e>] sysenter_past_esp+0x43/0x65

Every five seconds. This is when it reads the sensor information from /sys, I 
think. And during boot, similar messages to those already reported (from 
kern.log this time).

Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+233/288] interruptible_sleep_on+0xe9/0x120
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [pagebuf_daemon+0/656] pagebuf_daemon+0x0/0x290
 [pagebuf_daemon+597/656] pagebuf_daemon+0x255/0x290
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [pagebuf_daemon_wakeup+0/48] pagebuf_daemon_wakeup+0x0/0x30
 [pagebuf_daemon+0/656] pagebuf_daemon+0x0/0x290
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+233/288] interruptible_sleep_on+0xe9/0x120
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [msp3400c_setbass+144/176] msp3400c_setbass+0x90/0xb0
 [msp3410d_thread+162/1600] msp3410d_thread+0xa2/0x640
 [msp3410d_thread+0/1600] msp3410d_thread+0x0/0x640
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Etc.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
