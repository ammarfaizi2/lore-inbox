Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUCYEd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 23:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUCYEd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 23:33:26 -0500
Received: from ozlabs.org ([203.10.76.45]:46551 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263148AbUCYEdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 23:33:25 -0500
Subject: Re: [PATCH] Hotplug CPU toy for i386
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403220153520.28727@montezuma.fsmlabs.com>
References: <405C1F42.9030901@cyberone.com.au>
	 <1079937266.5759.42.camel@bach>
	 <Pine.LNX.4.58.0403220153520.28727@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1080189202.25555.26.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Mar 2004 15:33:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-22 at 20:56, Zwane Mwaikambo wrote:
> On Mon, 22 Mar 2004, Rusty Russell wrote:
> 
> > @@ -1035,6 +1036,10 @@ inline void smp_local_timer_interrupt(st
> >  {
> >  	int cpu = smp_processor_id();
> >
> > +	/* FIXME: Actually remove timer interrupt in __cpu_disable() --RR */
> > +	if (cpu_is_offline(cpu))
> > +		return;
> > +
> 
> We could setup an offline cpu idt with nop type interrupt stubs, this
> could also take care of the irq_stabilizing problem later on...

The problem I have with this approach is that it shouldn't be
neccessary.  Perhaps I'm overly optimistic.

I know *nothing* about i386: I'll play with stealing the PM code's
APIC suspend/resume, which I think is the Right Way to do this.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

