Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUBIPuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 10:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUBIPuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 10:50:20 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:50609 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263930AbUBIPuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 10:50:14 -0500
Date: Mon, 9 Feb 2004 08:50:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Pavel Machek <pavel@suse.cz>, akpm@osdl.org, george@mvista.com,
       amitkale@emsyssoft.com, Andi Kleen <ak@suse.de>,
       jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040209155013.GF5219@smtp.west.cox.net>
References: <20040127184029.GI32525@stop.crashing.org> <20040128165104.GC1200@elf.ucw.cz> <20040128170520.GI6577@stop.crashing.org> <20040128174402.GI340@elf.ucw.cz> <20040128175646.GJ6577@stop.crashing.org> <20040206223517.GD5219@smtp.west.cox.net> <20040206225535.GB539@elf.ucw.cz> <20040206230254.GE5219@smtp.west.cox.net> <20040209012951.GE2315@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209012951.GE2315@waste.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 07:29:51PM -0600, Matt Mackall wrote:
> On Fri, Feb 06, 2004 at 04:02:54PM -0700, Tom Rini wrote:
> > On Fri, Feb 06, 2004 at 11:55:35PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > It's against 2.6 + -netpoll + Amit's patch.
> > > > > 
> > > > > But doesn't -mm have a kgdb over enet driver that does work?  It's just
> > > > > not been ported to Amit's bits, right?
> > > > 
> > > > OK.  Based on this, and some other fixes, I've pushed my first cut of
> > > > KGDB over ethernet.  It's not quite as robust as I'd like right now (I'm
> > > > still getting it just-right for connecting live), and I've got some not
> > > > quite finished improvements still locally, but it does work.
> > > 
> > > Is there way to get plain diff (against -mm or against Amit or
> > > something?)
> > 
> > I'll post a diff against -mm next week when I'm a bit happier with it,
> > but the following is against Amit's version + your patch to port it to
> > netpoll:
> 
> >  	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
> > -		printk(KERN_CRIT "Someone is trying to attach\n");
> > -//		kgdb_schedule_breakpoint();
> > +		breakpoint();
> >  
> >  	for (i = 0; i < len; i++) {
> > -		if (msg[i] == 3)	/* Check for ^C? */
> > -			printk(KERN_CRIT "Someone is trying to ^C?\n");
> > -//			kgdb_schedule_breakpoint();
> > +		if (msg[i] == 3)
> > +			breakpoint();
> 
> The kgdb_schedule_breakpoint stuff in -mm didn't just appear to make
> things more complicated, it is in fact necessary. You cannot
> reasonably expect to break deep inside the network stack IRQ handler
> and then send more packets out the same interface. Expect especially
> nasty results on SMP. It only works for the serial case because that
> path is a priori known to be lockless.

Ah, hmm...  I don't suppose there's any way to do this w/o touching
every arch's do_IRQ, is there?

-- 
Tom Rini
http://gate.crashing.org/~trini/
