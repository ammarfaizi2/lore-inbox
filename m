Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287863AbSAXOAb>; Thu, 24 Jan 2002 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287852AbSAXOAX>; Thu, 24 Jan 2002 09:00:23 -0500
Received: from [62.245.135.174] ([62.245.135.174]:64702 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S287848AbSAXOAE>;
	Thu, 24 Jan 2002 09:00:04 -0500
Message-ID: <3C50135B.8397484@TeraPort.de>
Date: Thu, 24 Jan 2002 14:59:55 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre4-J0-VM-22-preempt-lock i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33.0201231301560.24338-100000@coffee.psychology.mcmaster.ca> <3C4FC478.BCC44CDF@TeraPort.de> <3C4FDB80.C9F83EBB@aitel.hist.no>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/24/2002 02:59:54 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/24/2002 03:00:04 PM,
	Serialize complete at 01/24/2002 03:00:04 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Martin Knoblauch wrote:
> 
> >  you are correct in stating that it is [still] true that free memory is
> > wasted memory. The problem is that the "pool of trivially-freeable
> > pages" is under certain circumstances apprently not trivially-freeable
> > enough. And the pool has the tendency to push out processes into swap.
> > OK, most times these processes have been incative for quite some time,
> > but - and this is my opinion based on quite a few years in this field -
> > it should never do this. Task memory is "more valuable" than
>             ^^^^^
> > buffer/cache memory. At least I want (demand :-) a switch to make the VM
> > behave that way.
> 
> More valuable perhaps, but infinitely more valuable?

 It depends on the situation :-) Thats why I want to be able to tell the
VM that it should leave its greedy fingers from task memory.

> Do you want swapping to happen _only_ if the process memory alone
> overflows available memory?  Note that you'll get really unuseable
> fs performance if the page cache _never_ may push anything into
> swap.  That means you have _no_ cache left as soon as process
> memory fills RAM completely.  No cache at all.
>

 There are bordercases where I may life better with only very few cache
pages left. Most likely not on a web server or similar. But there are
applications in the HPTC field, where FS caching is useless, unless you
can pack everything in cache.

 In a former life I benchmarked an out-of-core FEM solver on
Alpha/Tru64. Sure, when we could stick the whole scratch dataset in
cache the performance was awesome. Unfortunatelly the dataset was about
40 GB and we only had 16 GB available (several constraints, one of them
the price the customer was willing to pay for :-(. The [very very well
tuned] IO pattern on the scratch dataset resulted in optimal performance
when the cache was turned off. The optimal system would have been the
next-higher-class box with 48 GB of memory and a 40 GB ramdisk. Of
course, we could't propose that :-((

 That is why I want to be able to set maximum *and* minimum cache size.
The maximum setting helps me tuning application performance (setting it
to 100% just means the current behaviour) and setting mimimum guarantees
at least some minimal FS performance.

> The balance between cache and other memory may need tweaking,
> but don't bother going too far.
>

 As I said, it depends on the situation. I am happy when 98+% of the
systems can run happily with the defaults. But for the last 2% the
tuning-knobs come handy. And sure - use on your own risk. All warranties
void.

> >  And yes, quite a few smart people are working on it. But the progress
> > in the 2.4.x series is pretty slow and the direction still seems to be
> > unclear.
> 
> There are both aa patches and Rik's rmap patch.  Hard to say who "wins",
> but you can influence the choice by testing one or both and post
> your findings.
> 

 Some of us try. Up to the point where we become annoying :-) Personally
I do not think that one of them needs to win. There is very
useful/succesful stuff in both of them - not to forget that -aa is much
more than just VM work. I see it this way: -aa is an approach to fix the
obvious bugs and make the current system behave great/better/acceptable.
rmap is more on the infrastructure side - enabling new stuff to be done.
Similar things could be said about preempt vs. ll in some other
much-too-long thread.

Martin
PS: Putting lkml back
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
