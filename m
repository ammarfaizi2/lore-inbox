Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTICWO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbTICWO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:14:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41134 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263868AbTICWO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:14:56 -0400
Date: Thu, 4 Sep 2003 00:14:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030903221455.GB4199@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0309020825280.5614-100000@cherise> <Pine.LNX.3.96.1030903155520.9300B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030903155520.9300B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > >  #include "power.h"
> > > 
> > > -extern long sys_sync(void);
> > > -
> > > -unsigned char software_suspend_enabled = 0;
> > > +unsigned char software_suspend_enabled = 1;
> > > 
> > >  #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
> > > 
> > > ...by this you enable suspend even before system is booted. That's bad
> > > idea. It could hurt in the past (when we had sysrq-D so swsusp), and
> > > it may hurt again in future when battery goes low during boot.
> > 
> > Does it or does it not cause a problem? Look at the old software_suspend() 
> > function - The handling of this flag was weird and non-standard. This is 
> > cleaner. 
> 
> I don't want to get in the middle of this, but having a laptop decide
> that it doesn't have enough battery to finish a boot is something which
> happens now and again. If this change could cause data corruption where
> the old code didn't, perhaps we could stand the overhead of moving the
> enable to the end of the boot, or wherever would be safe.

We do not yet do suspend-to-disk on battery low, so Patrick's code is
actually safe. Still I do not think that's good change.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
