Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288784AbSBIJ0h>; Sat, 9 Feb 2002 04:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288788AbSBIJ02>; Sat, 9 Feb 2002 04:26:28 -0500
Received: from femail26.sdc1.sfba.home.com ([24.254.60.16]:43170 "EHLO
	femail26.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288784AbSBIJ0I>; Sat, 9 Feb 2002 04:26:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Andreas Dilger <adilger@turbolabs.com>, Patrick Mochel <mochel@osdl.org>
Subject: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Date: Sat, 9 Feb 2002 04:27:00 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com>
In-Reply-To: <20020208203931.X15496@lynx.turbolabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020209092607.UHF12059.femail26.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 February 2002 10:39 pm, Andreas Dilger wrote:
> On Feb 08, 2002  18:25 -0800, Patrick Mochel wrote:
> > (I don't have a public repository yet, so there's no place to pull form)
>
> I don't see why everyone who is using BK is expecting Linus to do a pull.
> In the non-BK case, wasn't it always a "push" model, and Linus would not
> "pull" from URLs and such?

I'm all for it.  I think it's a good thing.

In the absence of significant latency issues, pull scales better than push.  
It always has.  Push is better in low bandwidth situations with lots of idle 
capacity, but it breaks down when the system approaches saturation.

Pull data is naturally supplied when you're ready for it (assuming no 
significant latency to access it).  Push either scrolls by unread or piles up 
in your inbox and gets buried until it goes stale.  Web pages work on a pull 
model, "push" was an internet fad a few years ago that failed for a reason.  
When push models hit saturation it breaks down and you wind up with the old 
"I love lucy" episode with the chocolate factory.  Back in the days where 
ethernet used hubs instead of switches, going over 50% utilization could lock 
the whole network pretty easily, and these days with switched gigabit 
eithernet you still have network interfaces going into interrupt livelock but 
able to handle a higher load in polling mode.  The Linux scheduler itself 
pulls tasks from a pool of runnable tasks.  If each task had a timer that 
expired generating an interrupt that pushed it to a processor, things 
wouldn't work so well.  (I could go on...)

Linus has actually been using his mailbox to simulate pull by keeping the 
push model at saturation and having repeated retransmits of stuff he expects 
to repeatedly delete until he's ready to reach out and grab it as it passes 
by when the time is right.  The flood he's plucking stuff from is his inbox 
instead of the internet, but the fact remains 90% of it flows by unread 
(wasting attention to delete it, a small amount but it adds up), and isn't 
guaranteed to be there when he IS ready for it.

Humans naturally work by pull.  It just works better to grab stuff out of the 
fridge when you're hungry instead of having it crammed down your throat at 
random.  Push winds up going into a buffer which we pull from (which is how 
mail works), and if that buffer overflows during load spikes, or is just 
constantly filling faster than it drains in the long term, then you wind up 
retransmitting stuff that got dropped (increasing the bandwidth usage) and it 
all just falls apart...

Years ago, Linus wasn't regularly at saturation, so push was fine.  (Optimal 
even: interrupts are better than polling up until you approach livelock.)  
And with Linus's previous toolset, grabbing code from URLs was a significant 
interruption in his workflow, hence a bad thing.  But with bitkeeper, it 
isn't.  And if Linus is going to focus on taking the bulk of new patches from 
a dozen or so trusted lieutenants anyway, it makes sense for them to give him 
the option of a pull model.

I'd encourage this trend.  If in the future linus pulls from lieutenants and 
lieutenants pull from maintainers, the dropped patches problem basically goes 
away.  Just make sure that when the level above you IS ready to take it from 
your level, it's there and ready for them...

Rob

Standard disclaimer: it's 4:30am, who knows how much sense this will make in 
the morning? :)
