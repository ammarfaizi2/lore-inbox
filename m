Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSEXD72>; Thu, 23 May 2002 23:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314123AbSEXD71>; Thu, 23 May 2002 23:59:27 -0400
Received: from adsl-216-62-200-54.dsl.austtx.swbell.net ([216.62.200.54]:49536
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S314101AbSEXD70>; Thu, 23 May 2002 23:59:26 -0400
Subject: Re: Recent kernel SMP scalability Benchmark/White-paper References.
From: Austin Gonyou <austin@digitalroadkill.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205240230.g4O2U97457880@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: http://www.digitalroadkill.net
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 23 May 2002 22:59:04 -0500
Message-Id: <1022212744.23882.27.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-23 at 21:30, Albert D. Cahalan wrote:
> > problems or successes, etc. Mainly centering around 4-way/8-way x86
> > testing in terms of memory bandwidth/utilization, threading performance,
> 
> Never mind the OS: x86 SMP memory bandwidth is lame.
> AMD does a respectable job with 2-way systems, but
> doesn't produce anything bigger AFAIK.

Right, this is understood, although on the newer Xeons, the underlying
memory architecture is *far* better than it used to be, especially when
we're talking about 400Mhz FSB and up, more pipelined streams, etc.


> Threads are usually a very bad idea, no matter what OS.
> They blow away the cache locality with extra stacks.
> http://www.kegel.com/c10k.html

hrmmm..well..I can't entirely agree with that, mainly in the realm of
the 2.4 kernel with Andrea's patches plus knowing that a threaded app,
when synchronized correctly and designed to perform a specific function
really does perform well. I *can* be more resource intensive, but
usually in disk/network I/O and CPU usage. There can be a memory
bandwidth bottleneck too, but most apps people are going to run which
are threaded and need *a lot* of memory to run are not fast context
switchers/swappers, etc. (e.g. swapping 10 GB RAM or trying to flush
10GB ram to disk for that matter, is nearly impossible in any sane
amount of time. example: oracle or db2)

> > In addition to this info, I'm trying to gather information as it
> > pertains to the scalability of Linux kernels on 4/8-way x86 systems
> > versus Solaris Sparc 4/8-way systems with measurements of the same
> > statistics. 
> 
> This is worthless, because one type of system might not need
> many processors to get your work done. What if the performance
> goes like this:
> 
> CPUs Linux/x86 Solaris/SPARC
>  0        0          0
>  1       10          6
>  2       19         12
>  4       36         24
>  8       60         47
> 16      110         93
> 32      130        182
> 
> Solaris is fastest. Solaris scales almost perfectly.
> Solaris stinks on anything less than 32 CPUs.
> 
> While I pulled these numbers out of my ass, they
> aren't too far from the truth I think. Google has
> about 2200 hits for "Slowaris".

I know about this, we had 3 E10K's at one point with 16P ea to push a
very large set of monolithic DBs. After the tuning was done to that
platform though, we actually were able to get it down to 8CPUs and back
into E4500's. (not to mention actually re-writing most of the Oracle
Packages, reducing the time data stayed in the db so we didn't have to
go through so much, etc)

So, this brings us to where we are now. I've done a crap load of testing
2/4-way configs and comparing them against our E4500's with 8P. Problem
is, I've never been allowed to keep the config around long enough to get
the numbers in a way like you showed above.(political and monetary
issues prevented this a bit I'm afraid) Now we're back into a far better
position to do this type of thing and I just got asked to find
information regarding scalability of x86 arch, versus Sparc in 4 and 8
way scenarios. Our application runs nearly as well on 4 x86 cpus than it
does with 8 Sparc cpus, but equal ram, and nearly equal storage. 

Some seem to believe though that it's just our application running slow
on the Sparc boxes, but I have to say no to this. We've spent years
tuning our application now, with spot checks every couple of weeks to
squeeze out more from our nearly overloaded infrastructure. On top of
that, we've squeezed as much, ATM, as we can out of our disk subsystem
to get better performance there. The only out left is to go to Oracle9i
on Solaris, and then re-tune for *that*. A task not able to be done in a
short amount of time with the sizes of our DBs I assure you.

> You should consider memory. 32-bit hardware gets
> really slow as the amount of physical memory
> gets into the gigabyte range.
> 
> Also consider what happens when a part breaks.
> The Linux/x86 system is easy to repair or replace.
> 
> This is really old, but still fun to look at:
> http://www.cs.uml.edu/~acahalan/linux/benchmark.html

As to memory, I've seen what you're talking about first hand here as
well. 8gb ram on a 250GB oracle db takes a crapload of time to shutdown
if it's been doing any inserts/etc. for any respectable length of time. 
Still, with the 1.6Ghz Xeons and 400Mhz FSB, I would imagine the speed
with which the ram is addressed is quite more impressive than with the
lesser architectures. 

Thanks much for the discussion around this. I truly appreciate it.


