Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUJLVkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUJLVkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUJLVkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:40:17 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:47776
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267864AbUJLVkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:40:08 -0400
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bill Huey <bhuey@lnxw.com>
Cc: dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, amakarov@ru.mvista.com,
       ext-rt-dev@mvista.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041012212408.GA28707@nietzsche.lynx.com>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu>
	 <1097437314.17309.136.camel@dhcp153.mvista.com>
	 <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu>
	 <1097517191.28173.1.camel@dhcp153.mvista.com>
	 <20041011204959.GB16366@elte.hu>
	 <1097607049.9548.108.camel@dhcp153.mvista.com>
	 <1097610393.19549.69.camel@thomas>
	 <20041012211201.GA28590@nietzsche.lynx.com>
	 <20041012212408.GA28707@nietzsche.lynx.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1097616738.19549.160.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 23:32:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 23:24, Bill Huey wrote:
> On Tue, Oct 12, 2004 at 02:12:01PM -0700, Bill Huey wrote:
> > On Tue, Oct 12, 2004 at 09:46:34PM +0200, Thomas Gleixner wrote:
> > > enter_critical_section(TYPE, &var, &flags, whatever);
> > > leave_critical_section(TYPE, &var, flags, whatever);
> > 
> > FreeBSD uses these things, but it they create severe pipeline stalls
> > since they toggle interrupt flags on entry and exit. The current scheme
> > in Linux with preempt_count use to be a curse when I was working on an
> > equivalent implementation of there stuff at:

You missed the point. TYPE decides whether to toggle interrupts or not.
It's a generic function equivivalent, which identifies sections of code,
which must be protected. The grade of protection is defined in TYPE.

> > 	http://mmlinux.sf.net
> 
> Duh, I didn't finish the sentence. I meant this method above is nasty
> filled with pipeline stalls. Don't know if that's what were saying, but
> non-preemptable critical sections denoted by preempt_count must have some
> kind of conceptual overlap with local_irq* functions. I use to curse the
> seperation of the two since it made my own conception irregular, but I
> have come to the conclusion that using relatively something light weight
> like preempt_count() for that functionality instead. That's what I
> meant. :)

I dont see a drawback in the proposal of enter_critical_section and
leave_critical_section conversion.

They indicate a none preemptible region, which must be protected in one
or another way. Which way is choosen, must be evaluated by the
programmer.

There are several grades from preempt_disable over mutexes, spinlocks
and irq blocking. All those grades allow different implementations for
different goals.

Systems which are optimized for througput will use other mechanisms than
systems which are optimized for guaranteed repsonse times. 

There is no generic sulotion available for those problems.

But having a generic identifiable expression is more suitable for
improvements, than struggling with substitutions of x,y and z.

tglx







