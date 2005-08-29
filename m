Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVH2JKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVH2JKw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 05:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVH2JKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 05:10:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11941 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750889AbVH2JKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 05:10:51 -0400
Date: Mon, 29 Aug 2005 11:10:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Message-ID: <20050829091038.GA30073@elf.ucw.cz>
References: <1125069494.18155.27.camel@betsy> <20050827124148.GE1109@openzaurus.ucw.cz> <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz> <20050828080959.GB2039@elf.ucw.cz> <Pine.LNX.4.62.0508282109040.1489@artax.karlin.mff.cuni.cz> <20050829083552.GD28077@elf.ucw.cz> <Pine.LNX.4.58.0508291057400.27754@fachschaft.cup.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508291057400.27754@fachschaft.cup.uni-muenchen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >>I think he doesn't need to export it at all and he should write code to
> > > >>park and disable hard disk instead.
> > > >>(in userspace it's unsolvable --- i.e. you can't enable hard disk when
> > > >>detected stable condition if the daemon is swapped out on that hard disk)
> > > >
> > > >man mlockall() :-).
> > > 
> > > You also must not use any syscall that allocates even temporary memory in 
> > > kernel (select, poll, many others ...) or that waits on semaphore that 
> > > might be held while allocating memory (i.e. audit and rewrite ide ioctl 
> > > path).
> > 
> > Kernel module would have exactly same problem.
> 
> It has control of its memory allocations.

It will have to be carefull with doing calls that allocate memory, and
to avoid semaphores that may block it... 

> > > And you need extra flags to protect the daemon from being killed at 
> > > shutdown or blocked at suspend.
> > 
> > Why?
> 
> Because the disk must be unlocked even if the laptop falls down while
> a suspension or shutdown are under way.
> And it should work until the heads are parked anyway.

It can't. It has to be user controllable at any point, or you will not
be able to shutdown your notebook while on bumpy road.

Anyone who wants to put it into kernel _please_ read that IBM
paper. It is really complex, with some signal processing, and it goes
wrong at times, so it needs UI so you can disable it.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
