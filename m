Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbTIDEPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTIDEPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:15:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48400 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264640AbTIDEPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:15:49 -0400
Date: Thu, 4 Sep 2003 00:06:57 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Pavel Machek <pavel@suse.cz>
cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <20030903221455.GB4199@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1030904000316.12166A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Pavel Machek wrote:

> Hi!
> 
> 
> > > >  #include "power.h"
> > > > 
> > > > -extern long sys_sync(void);
> > > > -
> > > > -unsigned char software_suspend_enabled = 0;
> > > > +unsigned char software_suspend_enabled = 1;
> > > > 
> > > >  #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
> > > > 
> > > > ...by this you enable suspend even before system is booted. That's bad
> > > > idea. It could hurt in the past (when we had sysrq-D so swsusp), and
> > > > it may hurt again in future when battery goes low during boot.
> > > 
> > > Does it or does it not cause a problem? Look at the old software_suspend() 
> > > function - The handling of this flag was weird and non-standard. This is 
> > > cleaner. 
> > 
> > I don't want to get in the middle of this, but having a laptop decide
> > that it doesn't have enough battery to finish a boot is something which
> > happens now and again. If this change could cause data corruption where
> > the old code didn't, perhaps we could stand the overhead of moving the
> > enable to the end of the boot, or wherever would be safe.
> 
> We do not yet do suspend-to-disk on battery low, so Patrick's code is
> actually safe. Still I do not think that's good change.

I'm not sure trying to suspect during boot is a good thing to do, either.
Maybe that should wait and be enabled at user option at the end of boot.
In any case, I think avoiding data damage is higher priority than
efficiency, elegance, modularity, etc.

Beyond that I'll let you guys fight it out, I'm just worried that the new
pm is going to bite me even if I don't use suspend.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

