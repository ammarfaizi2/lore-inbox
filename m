Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbUK0FrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUK0FrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUK0DvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:51:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262529AbUKZTdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:41 -0500
Date: Fri, 26 Nov 2004 01:18:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
Message-ID: <20041126001811.GN2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296026.5805.275.camel@desktop.cunninghams> <20041125183332.GJ1417@openzaurus.ucw.cz> <1101420616.27250.65.camel@desktop.cunninghams> <20041125223610.GC2711@elf.ucw.cz> <1101422986.27250.106.camel@desktop.cunninghams> <20041125232519.GI2711@elf.ucw.cz> <1101426572.27250.151.camel@desktop.cunninghams> <20041126000502.GK2711@elf.ucw.cz> <1101427927.27250.182.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101427927.27250.182.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > Silently doing nothing when user asked for sync is not nice,
> > > > > > either. BUG() is better solution than that.
> > > > > 
> > > > > I don't think we should BUG because the user presses Sys-Rq S while
> > > > > suspending. I'll make it BUG_ON() and make the Sys_Rq printk & ignore
> > > > > when suspending. Sound reasonable?
> > > > 
> > > > Yes, that's better. ... only that it means just another hook somewhere
> > > > :-(.
> > > 
> > > :<. But we're only talking two or three lines. Let's keep it in
> > > perspective.
> > 
> > I think even three lines are bad. It means that swsusp is no longer
> > self-contained subsystem, but that it has its hooks all over the
> > place. And those hooks need to be maintained, too.
> 
> Yes, but suspending can't practically be a self contained system. We can
> try to convince ourselves that we're making it self contained by hiding
> behind the driver model, but in reality, the driver model is just a nice
> name for our sticky little fingers in all the other drivers, ensuring
> they do the right thing when we want to go to sleep. Hooks in other code
> is just the equivalent, but without the nice name. Perhaps I should
> invent one. How about the "quiescing subsystem"? :>

I know it can't be self-contained, but it should be as self-contained
as possible.

And driver-model means that interaction between swsusp and rest of the
code is pretty well defined and driver authors do not need to
understand the swsusp to properly support it.

Plus driver-model is usefull for suspend-to-ram, too.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
