Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRHMTr0>; Mon, 13 Aug 2001 15:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRHMTrR>; Mon, 13 Aug 2001 15:47:17 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:28817 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S264932AbRHMTrJ>; Mon, 13 Aug 2001 15:47:09 -0400
Message-Id: <200108131947.f7DJlKh05718@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Subject: Re: VM nuisance
Date: Mon, 13 Aug 2001 15:47:34 -0400
X-Mailer: KMail [version 1.3]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108130716321.20672-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.33.0108130716321.20672-100000@twinlark.arctic.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 August 2001 10:32 am, dean gaudet wrote:
> On Fri, 10 Aug 2001, Rik van Riel wrote:
> > I haven't got the faintest idea how to come up with an OOM
> > killer which does the right thing for everybody.
>
> maybe the concept is flawed?  not saying that it is flawed necessarily,
> but i've often wondered why linux vm issues never seem to be solved in
> the years i've been reading linux-kernel.
>
> if i understand the OOM killer correctly it's intended to make some sort
> of intelligent choice as to which application to shoot when the system
> is out of memory.

As I understand it, the problem is not what to do when the system is out 
of memory.  The problem is deciding what actually consititutes out of 
memory.  IOW, if I have a 32 MB system with 512MB of swap, I could have 
200MB of swap free and still have a system so far gone that it swaps more 
than it works.  OTOH, I could have 400MB worth of idle daemons and other 
residents taking up swap with a perfectly usable system in RAM.

It would be nice if we could sack a few tasks in swap for awhile so stuff 
in RAM could get things done.  Something like "if a page gets swapped out, 
it'll stay there for at least a minute" should work fine in normal 
conditions (since the page has probably been idle for awhile, anyway).  
Under memory pressure, the scheduler would pass by any tasks waiting on a 
page that was just swapped out.

Now that I've shown off how little I know about the current OOM design, 
I'll go sit and be quiet...
	-- Brian

> honestly, if applications can't stomach being shot then the bug is in
> the application, not in the kernel.  vi can handle being shot because it
> does the right thing:  it checkpoints state periodically.  it's a simple
> model which any sane application could follow, and many do actually
> follow.
>
> getting shot for OOM or getting shot because of power failure, or 2-bit
> RAM failure, or backhoe fade, or ... what's really the difference?
>
> so why not just use the most simple OOM around:  shoot the first app
> which can't get its page.  app writers won't like it, and users won't
> like it until the app writers fix their bugs, but then nobody likes the
> current situation, so what's the difference?
>
> maybe kernel support for making checkpointing easier would be a good way
> to advance the science?  there certainly are tools which exist that do
> part of the problem already -- except for sockets and pipes and such
> interprocess elements it's pretty trivial to checkpoint.  interprocess
> elements probably require some extra kernel support.  network elements
> are where it really becomes challenging.
>
> i would happily give up 10 to 20% system resources for checkpoint
> overhead if it meant that i'd be that much closer to a crashproof
> system.  after a year the performance deficit would be made up by
> hardware improvements.
>
> i know it's a big pill to swallow, but i've been impressed time and time
> again by the will of linux kernel hackers to just say "this is how it
> will be, because it is the only known way to perfection, deal."
>
> -dean
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
