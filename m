Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVH2Iyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVH2Iyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVH2Iyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:54:47 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:34224 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S1750848AbVH2Iyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:54:46 -0400
Date: Mon, 29 Aug 2005 10:59:47 +0200 (CEST)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
In-Reply-To: <20050829083552.GD28077@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0508291057400.27754@fachschaft.cup.uni-muenchen.de>
References: <1125069494.18155.27.camel@betsy> <20050827124148.GE1109@openzaurus.ucw.cz>
 <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz>
 <20050828080959.GB2039@elf.ucw.cz> <Pine.LNX.4.62.0508282109040.1489@artax.karlin.mff.cuni.cz>
 <20050829083552.GD28077@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, Pavel Machek wrote:

> Hi!
> 
> > >>I think he doesn't need to export it at all and he should write code to
> > >>park and disable hard disk instead.
> > >>(in userspace it's unsolvable --- i.e. you can't enable hard disk when
> > >>detected stable condition if the daemon is swapped out on that hard disk)
> > >
> > >man mlockall() :-).
> > 
> > You also must not use any syscall that allocates even temporary memory in 
> > kernel (select, poll, many others ...) or that waits on semaphore that 
> > might be held while allocating memory (i.e. audit and rewrite ide ioctl 
> > path).
> 
> Kernel module would have exactly same problem.

It has control of its memory allocations.
 
> > And you need extra flags to protect the daemon from being killed at 
> > shutdown or blocked at suspend.
> 
> Why?

Because the disk must be unlocked even if the laptop falls down while
a suspension or shutdown are under way.
And it should work until the heads are parked anyway.

	Regards
		Oliver

