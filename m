Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293647AbSBRELq>; Sun, 17 Feb 2002 23:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293649AbSBRELh>; Sun, 17 Feb 2002 23:11:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:269 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293647AbSBRELd>; Sun, 17 Feb 2002 23:11:33 -0500
Date: Mon, 18 Feb 2002 01:02:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrea Arcangeli <andrea@suse.de>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>, rsf@us.ibm.com,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: [TEST] page tables filling non-highmem
In-Reply-To: <E16cd5S-0000Ij-00@starship.berlin>
Message-ID: <Pine.LNX.4.21.0202180100430.24710-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Feb 2002, Daniel Phillips wrote:

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
> 
> > backout pte-highmem, try the same testcase again on my tree
> > and you'll see. The oom handling in mainline is deadlock prone, I always
> > known this and that's why I always rejected it. Nobody but me
> > acklowledged this problem
> 
> Lots of people acknowleged it, it seems just one guy fixed it.
> 
> > and I spent quite an amount of time convincing
> > mainline maintainers about those deadlock flaws of the mainline approch
> > but I failed so I giveup waiting for a report like this, just like with
> > all the other stuff that is now in my vm patch, 90% of it I tried to
> > push it separately into mainline before having to accumulate it.
> 
> What I'd suggest is, just post a list of each item outstanding item that
> haven't been pushed to mainline, and an explanation of which problem it
> fixes.
> 
> Incorrect oom accounting has been a bleeding wound for well over a year,
> and if you've got a fix that's provably correct...
> 
> Marcelo??  Is this just a stupid communication problem?

Andrew talked with me about merging parts of -aa VM into mainline.

I guess he will be doing the job during the 2.4.19-pre cycle. Am I right
Andrew? 

