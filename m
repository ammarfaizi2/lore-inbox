Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUBIRjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUBIRjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:39:03 -0500
Received: from waste.org ([209.173.204.2]:1181 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264506AbUBIRjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:39:00 -0500
Date: Mon, 9 Feb 2004 11:38:28 -0600
From: Matt Mackall <mpm@selenic.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Pavel Machek <pavel@suse.cz>, akpm@osdl.org, george@mvista.com,
       amitkale@emsyssoft.com, Andi Kleen <ak@suse.de>,
       jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040209173828.GG2315@waste.org>
References: <20040127184029.GI32525@stop.crashing.org> <20040128165104.GC1200@elf.ucw.cz> <20040128170520.GI6577@stop.crashing.org> <20040128174402.GI340@elf.ucw.cz> <20040128175646.GJ6577@stop.crashing.org> <20040206223517.GD5219@smtp.west.cox.net> <20040206225535.GB539@elf.ucw.cz> <20040206230254.GE5219@smtp.west.cox.net> <20040209012951.GE2315@waste.org> <20040209155013.GF5219@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209155013.GF5219@smtp.west.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 08:50:13AM -0700, Tom Rini wrote:
> On Sun, Feb 08, 2004 at 07:29:51PM -0600, Matt Mackall wrote:
> > On Fri, Feb 06, 2004 at 04:02:54PM -0700, Tom Rini wrote:

> > >  	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
> > > -		printk(KERN_CRIT "Someone is trying to attach\n");
> > > -//		kgdb_schedule_breakpoint();
> > > +		breakpoint();
> > >  
> > >  	for (i = 0; i < len; i++) {
> > > -		if (msg[i] == 3)	/* Check for ^C? */
> > > -			printk(KERN_CRIT "Someone is trying to ^C?\n");
> > > -//			kgdb_schedule_breakpoint();
> > > +		if (msg[i] == 3)
> > > +			breakpoint();
> > 
> > The kgdb_schedule_breakpoint stuff in -mm didn't just appear to make
> > things more complicated, it is in fact necessary. You cannot
> > reasonably expect to break deep inside the network stack IRQ handler
> > and then send more packets out the same interface. Expect especially
> > nasty results on SMP. It only works for the serial case because that
> > path is a priori known to be lockless.
> 
> Ah, hmm...  I don't suppose there's any way to do this w/o touching
> every arch's do_IRQ, is there?

Probably not. On the other hand, it provides yet more motivation for
an irq handling refactoring in 2.7.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
