Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275239AbTHMQe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275254AbTHMQe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:34:56 -0400
Received: from angband.namesys.com ([212.16.7.85]:6803 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275239AbTHMQex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:34:53 -0400
Date: Wed, 13 Aug 2003 20:34:52 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030813163452.GC27515@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030813180405.3c45465d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813180405.3c45465d.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 13, 2003 at 06:04:05PM +0200, Stephan von Krawczynski wrote:
> > > Well, that's exactly the reason why I am awaiting some more days of
> > > up-and-running ext3. After how many days will you be convinced that a
> > > random memory corruption should have hit the ext3 system that bad, that it
> > > should have crashed?
> > Well, I'd prefer that you spend time to figure out at which exact
> > 2.4.21-pre version the crashes in reiserfs started to appear. ;)
> Well, Oleg, I'd love to, but there is an immanent problem with that. If
> I check pre-X and it crashes, everything is fine, because I have a certain
> result of the test. If it does not crash within 3 days, then I have a problem.
> How long do I wait before stating the pre is good? It could take months to test

You seem to be getting corruptions in at least 2 days for now, though.
And reiserfs seems to trigger the problem even faster (and may be
even more faster if you enable CONFIG_REISERFS_CHECK).

> 10 pre's ... That cannot be the way to find out what is going on. 
> On the other hand: 
> - no UP kernel ever crashed. So we can at least talk about an SMP-race.

There is still huge field to look at.

> - 2.4.20 does not crash
> - 2.4.21 does crash

diff is 20M in size.

> If we can add "ext3 does not crash" to the list, then I really hope we can use
> some brain and give good selection of patches between 2.4.20 and 2.4.21 that
> may cause the troubles.

There were not much changes in reiserfs. All those patches can easily be
reverted just for verification purposes. Let me know when you are ready/want
to test this variant and I will send you a diff.

> How many suspects do we have? We can at least begin to create a list of things

Well, suspects are all used drivers, VM, filesystem itself, arch code.

> that went in between .20 and .21, or not?

Lots of changes, 2.4.20->2.4.21 was a long trip.

> If possible I can then patch out all of them and retry. So there is much less
> time spent for testing. 
> I mean, have you looked at the length of this thread already?

Yes, I did.
Now if only we can get someone to reproduce your problems...

> > > I can add another week if you want me to, just tell me. The only thing I
> > > don't want is that any doubts are left after testing ...
> > It would be interesting to look at fsck results on the fs after some time of
> > testing.
> You mean I should do an fsck on sunday?

Yes, whenever you decide you have waited long enough (provided that it won't
crash) and decide to stop testing, please run fsck on that testing fs.

> > Probably it would be easier for you to make it crash (if there are crash
> > possibility at all) if you enable JBD debugging.
> I have never seen this in real life. Is it possible to turn this on when
> handling >100 GB of data or will some debug output flood the box?

It only enables some more checks, not debug output.

Bye,
    Oleg
