Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUAJWkz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbUAJWky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:40:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:37087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265422AbUAJWkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:40:52 -0500
Date: Sat, 10 Jan 2004 14:40:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 SMP lockups
Message-Id: <20040110144049.5e195ebd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
References: <20040109210450.GA31404@netnation.com>
	<Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> 
> 
> On Fri, 9 Jan 2004, Simon Kirby wrote:
> 
> > 'lo all,
> 
> Hi Simon,
> 
> > We've had about 6 cases of this now, across 4 separate boxes.  Since
> > upgrading to 2.4.24, our SMP web server boxes (both Intel and AMD
> > hardware) are randomly blowing up.  This may have happened on 2.4.23 as
> > well, but they weren't really running long enough to tell.  2.4.22 was
> > fine.  GCC 3.3.3.
> >
> > These boxes are all dual CPU, and the failure case shows up suddenly with
> > no warning.  Sysreq-P works, but only reports from one CPU no matter how
> > many times I try.  In normal operation, every machine distributes all
> > IRQs across both CPUs, and Sysreq-P reports from both CPUs.
> >
> > Mapping the EIP reported by Sysreq-P to symbols shows that the responding
> > CPU is spinning on a spinlock (so far I have seen .text.lock.fcntl,
> > .text.lock.sched, .text.lock.locks, and .text.lock.inode), which I assume
> > is being held by the other (dead) CPU.
> 
> This sounds like a deadlock. I wonder why the NMI watchdog is not
> triggering.

Presumably it's spinning on the lock with interrupts enabled.  Make that
the `NMI' counters in /proc/interrupts are incrementing for all CPUs.


> > Even on boxes with nmi_watchdog=1, nothing is reported from the NMI
> > watchdog.
> 
> Can you share all available SysRQ-P output for the locked CPU ? SysRQ-T if
> possible, too.

sysrq-T would be best.

We don't have an each-CPU backtrace facility - it could be handy.  There's
one in the low-latency patch for some reason.


