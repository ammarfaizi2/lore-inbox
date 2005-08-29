Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVH2IgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVH2IgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVH2IgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:36:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7124 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750744AbVH2IgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:36:12 -0400
Date: Mon, 29 Aug 2005 10:35:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Message-ID: <20050829083552.GD28077@elf.ucw.cz>
References: <1125069494.18155.27.camel@betsy> <20050827124148.GE1109@openzaurus.ucw.cz> <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz> <20050828080959.GB2039@elf.ucw.cz> <Pine.LNX.4.62.0508282109040.1489@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508282109040.1489@artax.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I think he doesn't need to export it at all and he should write code to
> >>park and disable hard disk instead.
> >>(in userspace it's unsolvable --- i.e. you can't enable hard disk when
> >>detected stable condition if the daemon is swapped out on that hard disk)
> >
> >man mlockall() :-).
> 
> You also must not use any syscall that allocates even temporary memory in 
> kernel (select, poll, many others ...) or that waits on semaphore that 
> might be held while allocating memory (i.e. audit and rewrite ide ioctl 
> path).

Kernel module would have exactly same problem.

> And you need extra flags to protect the daemon from being killed at 
> shutdown or blocked at suspend.

Why?

> >Accelerometer is usefull for other stuff besides parking heads, like
> >playing marble madness or what is the name of the game, and even
> >parking heads is way too complex to be put into the kernel.
> >
> >Even if you don't like mlockall(), you can put timeout into
> >disk-freezing interface.
> 
> That makes the protection less reliable (you shake the notebook and after 
> the timeout drop it).

Idea is that userland app keeps saying "unfreeze 5 seconds in future"
as long as you keep shaking -- essentialy a deadlock prevention.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
