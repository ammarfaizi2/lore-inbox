Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVFUDbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVFUDbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVFUDZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:25:01 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:46040 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261877AbVFUCVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:21:37 -0400
Date: Mon, 20 Jun 2005 19:21:11 -0700
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tony Lindgren <tony@atomide.com>, hugang@soulinfo.com,
       linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050610-1
Message-ID: <20050621022111.GA32021@muru.com>
References: <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com> <20050610091515.GH4173@elf.ucw.cz> <20050610151707.GB7858@atomide.com> <20050610221501.GB7575@atomide.com> <20050618033419.GA6476@hugang.soulinfo.com> <1119076233.18247.27.camel@gaston> <20050621012825.GA30990@muru.com> <1119318560.18247.134.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119318560.18247.134.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 11:49:20AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2005-06-20 at 18:28 -0700, Tony Lindgren wrote:
> > On Sat, Jun 18, 2005 at 04:30:32PM +1000, Benjamin Herrenschmidt wrote:
> > > 
> > > > I'm try to port it powerpc, Here is a patch.
> > > > 
> > > >  Port Dynamic Tick Timer to new platform is easy. :)
> > > >   1) Find the reprogram timer interface.
> > > >   2) do a hook in the idle function.
> > > > 
> > > > That worked on my PowerBookG4 12'.
> > 
> > Cool :)
> > 
> > > Did you get a measurable gain on power consumption ?
> > > 
> > > Last time I toyed with this, I didn't.
> > 
> > Just dyntick alone probably does not do much for power savings. The
> > trick is to figure out what all can be turned off for the longer idle
> > periods. And try to make the idle periods longer by cutting down on
> > polling.
> 
> I would have expected it to actually do increase savings due to avoiding
> the cost of bringing the CPU back from deep NAP mode too often. It's
> possible that my previous experiments were bogus in fact. It would be
> very useful to have some statistics on how long we _actually_ sleep, I
> supspect things like the network stack with all it's slow timer all
> kicking at slightly different times for example are screwing us up a
> little bit.

Yeah, and I've also noticed that my laptop does not stay in C2 mode, but
actually just spins around... Halt works though. Then the x86 keyboard
driver does polling if no keyboard is attached. And I believe netfilter
caused some polling too (unverified).  And then of course any kind of
CPU meter apps keep polling...

One way to test the idle savings is to temporarily disable the timer
interrupt so the system stays in idle while measuring. That does not
help with the other devices though.

I've been thinking about implementing something that would show up the
worst pollers. Maybe then have a program called polltop? :)

Tony
