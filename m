Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUHJKQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUHJKQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUHJKPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:15:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50371 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263980AbUHJKNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:13:10 -0400
Date: Tue, 10 Aug 2004 12:13:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810101308.GE9034@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <20040809113829.GB9793@elf.ucw.cz> <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net> <20040809212949.GA1120@elf.ucw.cz> <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, "no DMA" needs to be part of definition, too, because some
> > devices (USB) do DMA only if they have nothing to do.
> 
> I don't understand; that doesn't sound healthy.

It is not healthy. It is basicaly misdesigned piece of hardware called
UHCI. It simply does DMA all the time :-(.

> > if something like this gets merged, it will immediately break swsusp
> > because initially no drivers will have "stop" methods.
> >
> > Passing system state down to drivers and having special "quiesce"
> > (as discussed in rather long thread) state has advantage of
> > automagicaly working on drivers that ignore u32 parameter of suspend
> > callback (and that's most of them). David's patches do not bring us
> > runtime suspend capabilities, but do not force us to go through all
> > the drivers, either...
> 
> Nothing is free. ;)
> 
> We've been talking about creating and merging a sane power management
> model for 3+ years now. It's always been known that the drivers will have
> to be modified to support a sane model. It's a fact of life. At some
> point, we have to bite the bullet and do the work. I see that time rapidly
> approaching.
> 
> I do not intend to merge a patch that will break swsusp in a stable
> kernel. However, we do have this wonderful thing called the -mm tree in
> which we can a) evolve the model, b) get large testing coverage and c)
> solicit driver fixes.
> 
> Once the swsusp consolidation is merged upstream, I will merge a new
> device power model in -mm, and we can start working on the drivers. How
> does that sound?

It sounds like an acceptable plan. I see no real disadvantage in
"suspend with parameter X means quiesce", and I think we'd get smaller
patch that way, but if you go through -mm like this, we can do it.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
