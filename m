Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310243AbSCLAuK>; Mon, 11 Mar 2002 19:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSCLAuB>; Mon, 11 Mar 2002 19:50:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8713 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310243AbSCLAts>; Mon, 11 Mar 2002 19:49:48 -0500
Date: Mon, 11 Mar 2002 19:47:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <3C8CDA0D.7020703@evision-ventures.com>
Message-ID: <Pine.LNX.3.96.1020311191648.27404H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Martin Dalecki wrote:

> Alan Cox wrote:

> > Oh dear me. Wrong again. Microdrives require proper polite wakeups. But you
> > see camera vendors buy in IDE code from people who can read and follow 
> > standards documents. 

This seems relevant in light of:

	[snip]

> Fsck let's cite the IBM appilcation notes about the Micro Drive
> found here http://www.storage.ibm.com/hdd/micro/appguide.htm

	[snip, but relevant]

>   * Consideration for a time-out value when using the write cache
> 
> The microdrive can queue several consecutive write commands. Even if the host 
> system receives a
> command completion, the microdrive may still be performing disk writing for 
> queued commands, each of
> which could take up to 7.5 seconds as previously mentioned if an error has 
> occurred and an error
> recovery routine starts.
> This delay eventually surfaces when processing a first non-queued command during 
> write cache.
> 
> For example, suppose the microdrive queues 2 write commands and each command 
> takes 7.5 seconds
> for some extreme reason. Then if the microdrive receives Read Sectors, which is 
> a non-queue command,
> it will be processed just after disk writing is completed.  In the worst case, 
> delay for the Read Sectors
> would be close to 15 seconds (7.5 x 2).
> 
> In light of the stuation above,  IBM recommends 30 seconds as a time-out value 
> if the host system uses
> the write cache feature.
> 
> 
> And apparently we see that there is nothing special about them... Just don't
> enable the write cache and all should be well with a timeout of 30 seconds.

How can you read that recommendation into what you just quoted? IBM says
use 30 sec if you enable write buffers, why would eliminate the long delay
but use the slow timeout anyway? To slow retry to a crawl? It would seem
obvious to do one thing or the other, but not to take all possible action
to make things crawl. I suggest that the obvious solution is use a
sensible timeout without write buffers to be really safe, or to get best
performance use the write buffers and force a flush at a sensible point,
somewhat like flushing buffers to disk with bdflush. There are already
spindown timers and such in the drivers, this isn't a "whole new thing."

Since we have the ability to let the user set this now, I see no reason
not to let the user make the choice, Linux is about choice.

Finally, about copying other drivers: to quote my youngest, "yuckie-poo!"
Drivers should be written to the standard, with reality dictating that it
is sometimes required to write to the hardware when you absolutely MUST
use non-compliant hardware. To copy code from another driver seems like a
lack or either ability or committment.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

