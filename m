Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317885AbSFMWJw>; Thu, 13 Jun 2002 18:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317883AbSFMWJv>; Thu, 13 Jun 2002 18:09:51 -0400
Received: from server3.jumpleads.com ([217.151.96.171]:62169 "EHLO
	server3.jumpleads.com") by vger.kernel.org with ESMTP
	id <S317881AbSFMWJr>; Thu, 13 Jun 2002 18:09:47 -0400
Date: Thu, 13 Jun 2002 23:09:44 +0100 (BST)
From: Matthew Wakeling <mnw21@bigfoot.com>
X-X-Sender: mnw21@server3.jumpleads.com
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: BugTraq Mailing List <bugtraq@securityfocus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Very large font size crashing X Font Server and Grounding Server
 to a Halt (was: remote DoS in Mozilla 1.0)
In-Reply-To: <200206132147.QAA20200@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.44.0206132255220.4999-100000@server3.jumpleads.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jun 2002, Jesse Pollard wrote:
> > It is my experience that a single process using large amounts of memory 
> > causes the system to start swapping. Once it starts swapping, every 
> > process that does anything (apart from indefinite wait) goes into "I'm 
> > ready to do some processing, but my memory is swapped out" state, and the 
> > whole system collapses.
> 
> Not necessarily. The condition can also be caused by having a large, well
> behaved process working its' little heart out properly, and a small process
> that grows suddenly (or even slowly - it doesn't take much to push it over
> the limit). As the small process grows, the larger one is paged out. Once
> the swap space is filled just adding one more page could do it. And it doesn't
> matter what process allocates that page. Key: disable oversubscription of
> memory.

Can we at least agree that the current kernel behaviour is a positive 
feedback loop - something is bad, therefore it's about to get worse. Some 
of the suggestions I had would move this more towards a negative feedback 
loop.

> It can't decide what causes the problem. There are too may possibilities.

I think the majority of times a system will be set up with enough swap 
space to handle its normal operation. Otherwise, just give it some more 
swap. However, one circumstance that throwing lots of swap around doesn't 
fix is when a process has an insatiable need for memory. In this case, 
either the process grows very quickly, or is just plain big. I think the 
out-of-memory killer should target big or growing processes. If it doesn't 
hit the correct process the first time, it will free up a lot more RAM 
than it would otherwise, and it would be likely to get it right the second 
time.

> > My suggestion would be to set a maximum core size for the xfs-daemon 
> > process...
> 
> Also put a maximum limit on the X server.

Although this wasn't the problem in this case (and therefore wouldn't have 
a massive effect), it's a sensible precaution.

The xfs server is the important server here, because DOSing it DOSes a 
whole network of workstations.

> The easiest fix is to disable oversubscription of memory, though that may
> cause some daemons to abort if they don't check for allocation failures
> (which I do consider a bug).

That does indeed sound a good idea. I guess one would then give the system 
one big dollop of swap, to allow it to actually cater for processes that 
allocate large amounts without using it.

Matthew

-- 
Bashir:  And who told you that?
O'Brien: You did. In the future.
Bashir:  Oh. Well, who am I to argue with me?


