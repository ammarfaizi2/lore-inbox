Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266629AbRGJQEd>; Tue, 10 Jul 2001 12:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbRGJQEX>; Tue, 10 Jul 2001 12:04:23 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:45483 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S266629AbRGJQEN>; Tue, 10 Jul 2001 12:04:13 -0400
Date: Tue, 10 Jul 2001 12:04:02 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dead mem pages -> dead machines
In-Reply-To: <Pine.LNX.4.10.10107100423460.26681-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0107101002450.24405-100000@monster000.rentec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jul 2001, Mark Hahn wrote:


> my point, perhaps to terse, was that you shouldn't run 4.3G of job on
> a 4G machine, and expect everything to necessarily work.

then i expect to have 300M+ swapped out and not 2.6GB. so what?

> > > they should all have the same priority, so swapping is distributed.
> > > currently sda5 fills (and judging by the 5, it's not on the fast
> > > part of the disk) before sdb1 is used.
> >
> > well, that's the symptom, but not the disease, medically speaking.
>
> no, it's actually orthogonal, mathematically speaking:
> your swap configuration is inefficient

i am complaining about the fact that the machines start paging
heavily without a reason and you are telling me that my swap
config is wrong?

> note also that swap listed as in use is really just allocated,
> not necessarily used.  the current VM preemptively assigns idle pages
> to swapcache; whether they ever get written out is another matter.

it IS used. after submitting the jobs the nodes were dead for a while since
they were swapping like hell.

> you should clearly run "vmstat 1" to see whether there's significant
> si/so.  it would be a symptom if there was actually a lot of *both*
> si and so (thrashing).

they were so dead, i couldn't even type on the console. load was up
to 30, culprit at that point was kswapd.

> > > the kernel thinks that there's memory pressure: perhaps you're doing
> > > file IO?  memory pressure causes it to pick on processes, especially
> > > large ones, especially the ones that are doing the allocation.
> >
> > also if i do file i/o, i don't expect the kernel to take away so much memory from
> > my apps.
>
> well, then you disagree with the VM design.  it's based on idleness,
> not some notion of categories.

so are you saying, if i want to run apps being 4GB in mem i should get
a machine having 4GB+60%= 6.4GB? you are not serious, aren't you?

> > > from appearances, you've overloaded it.  the kernel also tries to be
> > > "fair", which in this case means trying to steal pages from the hogs.
> >
> > it looks to me that the hog is the kernel, and the kernel isn't fair to me, again:
> >
> >   PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMAND
> >  3759  3684 userid    15 2105M 1.1G 928M  254M  0M R N  94.4 23.4  10:57 ceqsim
> >  3498  3425 userid    16 2189M 1.5G 609M  205M  0M R N  91.7 15.3  22:12 ceqsim
> >                                    ^^^^^^^ ^^^^
>
> what's surprising, that your app has 900/600M working set?

the arrows got wrong in the reply i am reading now. i was complaining about
the fact that 1.1 of 2.1GB and 1.5 of 2.2GB are swapped out. and there's
no need for that. period.

> > the user space or application perspective the kernel still eats my memory.
>
> the current VM does not follow your thinking, which is that ram is for apps
> and the kernel gets to keep any leftovers.

Mark, you still didn't get my point. the kernel doesn't get the leftovers.
in my case it takes mem away from my apps instead. there's a leak to /dev/dead
or there are somehow misreferenced pointers in a page table which are only
cleaned up by a reboot.

anybody else can tell me what's wrong?


	~dirkw


