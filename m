Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVGROi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVGROi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVGROi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:38:59 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27856 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261780AbVGROht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:37:49 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507181607410.3743@scrub.home>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <20050712022537.GA26128@infradead.org>
	 <20050711193409.043ecb14.akpm@osdl.org>
	 <Pine.LNX.4.61.0507131809120.3743@scrub.home>
	 <17110.32325.532858.79690@tut.ibm.com>
	 <Pine.LNX.4.61.0507171551390.3728@scrub.home>
	 <17114.32450.420164.971783@tut.ibm.com>
	 <1121694275.12862.23.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507181607410.3743@scrub.home>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 18 Jul 2005 10:36:46 -0400
Message-Id: <1121697406.12862.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-18 at 16:16 +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 18 Jul 2005, Steven Rostedt wrote:
> 
> > I'm actually very much against this. Looking at a point of view from the
> > logdev device. Having a callback to know to continue at every buffer
> > switch would just be slowing down something that is expected to be very
> > fast.
> 
> What exactly would be slowed down?
> It would just move around some code and even avoid the overwrite mode 
> check.

Yes, you're adding a jump to another function via a function pointer,
that would kill the cache line of execution, to avoid a simple check, or
some other way of handling it. Since I don't want to know the internals
of relayfs, the overwrite mode could be implemented in a more officient
way. Granted, this probably isn't much of a slowdown since the copying
of data would be much longer.

> 
> > I don't see the problem with having an overwrite mode or not. Why
> > can't relayfs know this?
> 
> The point is to design a simple and flexible relayfs layer, which means 
> not every possible function has to be done in the relayfs layer, as long 
> it's flexible enough to build additional functionality on top of it (for 
> which it can again provide some library functions).

The overwrite mode isn't that complex.  You don't want to make something
so flexible that it becomes more complex.  Assembly is more flexible
than C but I wouldn't want to code a lot with it.  A library function
for me is out of the question, since what I build on top of relayfs is
mostly in the kernel.  The overwrite mode would then have to be
implemented through another kernel activity.  I might as well keep my
own ring buffers and forget about using relayfs, and all my points in
which I argue for it being merged is mute.

-- Steve


