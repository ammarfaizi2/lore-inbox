Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUHJKH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUHJKH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHJKH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:07:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15043 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263851AbUHJKHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:07:52 -0400
Date: Tue, 10 Aug 2004 12:07:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810100751.GC9034@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >   This is implemented by iterating through the list of struct classes,
> > >   then through each of their struct class_device's. The class_device is
> > >   the only argument to those functions.
> >
> > Hrm... I don't agree, that iteration should be done in bus ordering too.
> >
> > For example, if you stop operation of a USB host controller, you have to
> > do that after you have stopped operation of child devices. Same goes
> > with the ATA disk vs. controller. The ordering requirements for stopping
> > operations are the same as for PM
> 
> It's easy enough to change which order things get stopped/started in. What
> matters more is the conceptual shift in responsibility for who
> stops/starts the devices, or rather their interfaces.

Can you explain why this class-based quiescing is good idea? It seems
to me that "quiesce this tree" is pretty much same as "suspend this
tree", and can be handled in the same way.

Nigel wanted to do class-based quiescing, but if we make quiescing
fast enough, it should be okay to do whole tree, always. (And I
believe quiescing *can* be fast enough).

> The driver core calls it in device_power_down() (as was in the patch ;),
> in physical topological order. The ordering of the calls is up the power
> management core, but it just wouldn't make sense to power down a device
> that wasn't stopped. Would be easy enough to add a check for it..

BUG_ON() would be welcome, otherwise someone will get it wrong.
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
