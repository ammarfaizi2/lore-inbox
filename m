Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUC3MVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUC3MVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:21:20 -0500
Received: from gprs214-82.eurotel.cz ([160.218.214.82]:28033 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263629AbUC3MVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:21:15 -0500
Date: Tue, 30 Mar 2004 14:21:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Hotplug CPU toy for i386
Message-ID: <20040330122059.GA461@elf.ucw.cz>
References: <405C1F42.9030901@cyberone.com.au> <1079937266.5759.42.camel@bach> <Pine.LNX.4.58.0403220153520.28727@montezuma.fsmlabs.com> <1080189202.25555.26.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080189202.25555.26.camel@bach>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > @@ -1035,6 +1036,10 @@ inline void smp_local_timer_interrupt(st
> > >  {
> > >  	int cpu = smp_processor_id();
> > >
> > > +	/* FIXME: Actually remove timer interrupt in __cpu_disable() --RR */
> > > +	if (cpu_is_offline(cpu))
> > > +		return;
> > > +
> > 
> > We could setup an offline cpu idt with nop type interrupt stubs, this
> > could also take care of the irq_stabilizing problem later on...
> 
> The problem I have with this approach is that it shouldn't be
> neccessary.  Perhaps I'm overly optimistic.
> 
> I know *nothing* about i386: I'll play with stealing the PM code's
> APIC suspend/resume, which I think is the Right Way to do this.

Is there chance for this code to go in? It would be usefull for making
swsusp work on SMP... And probably needed for suspend-to-ram, too.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
