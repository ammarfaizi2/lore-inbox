Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbUBJH62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUBJH62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:58:28 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:11492 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265711AbUBJH60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:58:26 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Matt Mackall <mpm@selenic.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: BitKeeper repo for KGDB
Date: Tue, 10 Feb 2004 13:27:40 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@suse.cz>, akpm@osdl.org, george@mvista.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040127184029.GI32525@stop.crashing.org> <20040209155013.GF5219@smtp.west.cox.net> <20040209173828.GG2315@waste.org>
In-Reply-To: <20040209173828.GG2315@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402101327.40378.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.codemonkey.org.uk/projects/bitkeeper/kgdb/kgdb-2004-02-10.diff
has grown over 10MB. Something wrong in generating a diff?

On Monday 09 Feb 2004 11:08 pm, Matt Mackall wrote:
> On Mon, Feb 09, 2004 at 08:50:13AM -0700, Tom Rini wrote:
> > On Sun, Feb 08, 2004 at 07:29:51PM -0600, Matt Mackall wrote:
> > > On Fri, Feb 06, 2004 at 04:02:54PM -0700, Tom Rini wrote:
> > > >  	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
> > > > -		printk(KERN_CRIT "Someone is trying to attach\n");
> > > > -//		kgdb_schedule_breakpoint();
> > > > +		breakpoint();
> > > >
> > > >  	for (i = 0; i < len; i++) {
> > > > -		if (msg[i] == 3)	/* Check for ^C? */
> > > > -			printk(KERN_CRIT "Someone is trying to ^C?\n");
> > > > -//			kgdb_schedule_breakpoint();
> > > > +		if (msg[i] == 3)
> > > > +			breakpoint();
> > >
> > > The kgdb_schedule_breakpoint stuff in -mm didn't just appear to make
> > > things more complicated, it is in fact necessary. You cannot
> > > reasonably expect to break deep inside the network stack IRQ handler
> > > and then send more packets out the same interface. Expect especially
> > > nasty results on SMP. It only works for the serial case because that
> > > path is a priori known to be lockless.
> >
> > Ah, hmm...  I don't suppose there's any way to do this w/o touching
> > every arch's do_IRQ, is there?
>
> Probably not. On the other hand, it provides yet more motivation for
> an irq handling refactoring in 2.7.

