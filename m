Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310521AbSBRMju>; Mon, 18 Feb 2002 07:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310522AbSBRMja>; Mon, 18 Feb 2002 07:39:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41496 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310521AbSBRMjU>; Mon, 18 Feb 2002 07:39:20 -0500
Date: Mon, 18 Feb 2002 13:39:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org, rsf@us.ibm.com
Subject: Re: [TEST] page tables filling non-highmem
Message-ID: <20020218133945.M7940@athlon.random>
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <E16beDZ-0002jy-00@starship.berlin> <20020218023800.A23743@athlon.random> <E16cd5S-0000Ij-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16cd5S-0000Ij-00@starship.berlin>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 02:59:26AM +0100, Daniel Phillips wrote:
> On February 18, 2002 02:38 am, Andrea Arcangeli wrote:
> > On Fri, Feb 15, 2002 at 09:59:45AM +0100, Daniel Phillips wrote:
> > > On February 15, 2002 05:51 am, William Lee Irwin III wrote:
> > > > The following testcase brought down 2.4.17 mainline on an
> > > > 8-way P-III 700MHz machine with 12GB of RAM. The last thing
> > > > logged from it was a LowFree of 2MB with 9GB of highmem free
> > > > after something like 6-8 hours of pounding away, at which
> > > > time the machine stopped responding (IIRC it was given ~12
> > > > hours to echo another character).
> > > > 
> > > > This testcase is a blatant attempt to fill the direct-mapped
> > > > portion of the kernel virtual address space with process pagetables.
> > > > It was suspected such a thing was happening in another failure scenario
> > > > which is what motivated me to devise this testcase. I believe a fix
> > > > already exists (i.e. aa's ptes in highmem stuff) though I've not yet
> > > > verified its correct operation here.
> > > 
> > > As you described it to me on irc, this demonstration turns up a
> > > considerably worse problem than just having insufficient space for
> > > page tables - the system locks up hard instead of doing anything
> > > reasonable on page table-related oom.  It's wrong that the system
> > > should behave this way, it is after all, just an oom.
> > > 
> > > Now that basic stability issues seem to be under control, perhaps
> > > it's time to give the oom problem the attention it deserves?
> > 
> > My tree doesn't lock up hard even without pte-highmem applied.  The task
> > gets killed.
> 
> Well, the obvious question is: Why Isn't It In Mainline???

Because mainline maintainers disagreed. The argument is been "the only
way to avoid suprious oom failures is to reintroduce such infinite
loop". oom deadlocks was the last of my worries (as far as my tree
doesn't deadlock) given the rest of the agreements, so I giveup waiting
somebody to complain (as with everything else it eventually happens when
something can deadlock) and really I've no fun to return discussing
this.

> > backout pte-highmem, try the same testcase again on my tree
> > and you'll see. The oom handling in mainline is deadlock prone, I always
> > known this and that's why I always rejected it. Nobody but me
> > acklowledged this problem
> 
> Lots of people acknowleged it, it seems just one guy fixed it.

As far I can tell this is the first oom deadlock email I read on l-k
(but I unfortunately don't have time to read every single email on l-k
so I may have missed some). The others were too early deadlocks (less
severe).

> > and I spent quite an amount of time convincing
> > mainline maintainers about those deadlock flaws of the mainline approch
> > but I failed so I giveup waiting for a report like this, just like with
> > all the other stuff that is now in my vm patch, 90% of it I tried to
> > push it separately into mainline before having to accumulate it.
> 
> What I'd suggest is, just post a list of each item outstanding item that
> haven't been pushed to mainline, and an explanation of which problem it
> fixes.

I'm out of sync at the moment, and I've many things pending to do, so
I'm afraid I won't have much time for it.

> Incorrect oom accounting has been a bleeding wound for well over a year,
> and if you've got a fix that's provably correct...
> 
> Marcelo??  Is this just a stupid communication problem?

It wasn't a communication problem.

Andrea
