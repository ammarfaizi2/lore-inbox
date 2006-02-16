Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWBPXow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWBPXow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWBPXow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 18:44:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14999 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932544AbWBPXow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 18:44:52 -0500
Date: Fri, 17 Feb 2006 00:44:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
In-Reply-To: <1140116771.7028.31.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0602162305210.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> 
 <1139827927.4932.17.camel@localhost.localdomain>  <Pine.LNX.4.61.0602131208050.30994@scrub.home>
  <20060214074151.GA29426@elte.hu>  <Pine.LNX.4.61.0602141113060.30994@scrub.home>
  <20060214122031.GA30983@elte.hu>  <Pine.LNX.4.61.0602150033150.30994@scrub.home>
  <20060215091959.GB1376@elte.hu>  <Pine.LNX.4.61.0602151259270.30994@scrub.home>
  <1140036234.27720.8.camel@leatherman>  <Pine.LNX.4.61.0602161244240.30994@scrub.home>
 <1140116771.7028.31.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Feb 2006, john stultz wrote:

> I'll admit I'm slow, but since it has taken me a number of weeks to sort
> out exactly the details of what is being done in your implementation,
> and I *still* have bugs after re-implementing it, I'd not claim your
> code is simple. The potential to be very precise and efficient: yes, but
> not so trivial to follow.

Wow, I didn't expect it to be that difficult, I'm sorry about that. :)
Next time I'll split it apart into the basic parts, so it should be easier 
to read and follow.

> (This is why I cringe at the idea of trying to implement it for each
> clock like you're prototype suggested.)

I didn't suggest that, the function itself is already quite generic and 
could be called like "clock_update(cycles);". What I'm suggesting is to 
make it a template function, so that one create a optimized version based 
on some parameters (e.g. it's possible to optimize some parts away by 
making them constant).
That's not really necessary for the first version, only that a clock can 
call the "clock_update(cycles);" directly from it's interrupt handler, 
later it can be replaced with an optimized version.

> Maybe when I send out the patch you can suggest improvements to the
> comments or other ways to better clarify the code as you suggested
> above.

Now I'm really curious. :)

> I'd be very much open to it, although I haven't seen any further updates
> to the code since I mailed you some feedback on them. Have you had a
> chance to follow up on those?

Not yet, but it would only minor updates (mostly documenting it better and 
cleanups as you suggested), the basic stuff is still the same.

> > In the end the simplification of my patches should also 
> > make your patches simpler, as it precalculates as much as possible and 
> > reduces the work done in the fast paths. It would avoid a lot of extra 
> > work, which you currently do.
> 
> Well, I'm still cautious, since it still has some dependencies on HZ
> (see equation below), which I'm trying to avoid.

There is no real dependency on HZ, it's just that the synchronisations 
steps and incremental updates are done in fixed intervals. The interval 
could easily be independent of HZ.

bye, Roman
