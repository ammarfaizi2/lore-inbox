Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288185AbSAMWPF>; Sun, 13 Jan 2002 17:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288188AbSAMWO4>; Sun, 13 Jan 2002 17:14:56 -0500
Received: from lilly.ping.de ([62.72.90.2]:59917 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S288185AbSAMWOn>;
	Sun, 13 Jan 2002 17:14:43 -0500
Date: 13 Jan 2002 23:14:02 +0100
Message-ID: <20020113231402.A9303@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020113211731.A6543@planetzork.spacenet> <Pine.LNX.4.33.0201131533530.14774-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 03:35:08PM -0500, Mark Hahn wrote:
> > > >         13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp       18-pre3minill  
> > > > j100:   6:59.79  78%    7:07.62  76%        *           6:39.55  81%    6:24.79  83%        *
> > > > j100:   7:03.39  77%    8:10.04  66%        *           8:07.13  66%    6:21.23  83%        *
> > > > j100:   6:40.40  81%    7:43.15  70%        *           6:37.46  81%    6:03.68  87%        *
> > > > j100:   7:45.12  70%    7:11.59  75%        *           7:14.46  74%    6:06.98  87%        *
> > > > j100:   6:56.71  79%    7:36.12  71%        *           6:26.59  83%    6:11.30  86%        *
> > > > 		                                                                                          
> > > > j75:    6:22.33  85%    6:42.50  81%    6:48.83  80%    6:01.61  89%    5:42.66  93%    7:07.56  77%
> > > > j75:    6:41.47  81%    7:19.79  74%    6:49.43  79%    5:59.82  89%    6:00.83  88%    7:17.15  74%
> > > > j75:    6:10.32  88%    6:44.98  80%    7:01.01  77%    6:02.99  88%    5:48.00  91%    6:47.48  80%
> > > > j75:    6:28.55  84%    6:44.21  80%    9:33.78  57%    6:19.83  85%    5:49.07  91%    6:34.02  83%
> > > > j75:    6:17.15  86%    6:46.58  80%    7:24.52  73%    6:23.50  84%    5:58.06  88%    7:01.39  77%
> > > 
> > > Again, preempt seems to reign supreme.  Where is all the information
> > > correlating preempt is inferior?  To be fair, however, we should bench a
> > > mini-ll+s test.
> > 
> > Your wish is granted. Here are the results for mini-ll + scheduler:
> > 
> > j100:   8:26.54
> > j100:   7:50.35
> > j100:   6:49.59
> > j100:   6:39.30
> > j100:   6:39.70
> > j75:    6:01.02
> > j75:    6:12.16
> > j75:    6:04.60
> > j75:    6:24.58
> > j75:    6:28.00
> 
> how about a real benchmark like -j2 or so (is this a dual machine?)

Why does everybody think this is no *real* benchmark? When I remember
the good old days at the university the systems I tried to compile some
applications on were *always* overloaded. Would it make a difference for
you if I would run

for a in lots_of.srpm; do
  rpm --rebuild $a &
done

Basically this gives the same result: lots of compile jobs running in
parallel. All *I* am doing is doing it a little extreme since running
the compile with make -j2 does not make a *noticable* difference at all.
And as I said previously my idea was to get the system into high memory
pressure and test the different vms (AA and RvR) ...

Furthermore some people think this combination (sched+preempt) is only
good for latency (if at all) all I can say is that this works *very*
well for me latency wise. Since I don't know how to measure latency
exactly I tried to run my compile script (make -j50) while running my
usual desktop + xmms. Result: xmms was *not* skipping, although the
system was ~70MB into swap and the load was >50. Changing workspaces
worked immedeatly all the time. But I was able to get xmms to skip for
a short while by starting galeon, StarOffice, gimp with ~10 pictures
all at the same time. But when all applications came up xmms was not
skipping any more and the system was ~130MB into swap. This is the best
result for me so far but I have to admit that I did not test mini-ll
+sched in this area (I can test this earliest on wednesday, sorry).

Since it is a little while since I posted my system specs here they are:

- Athlon 1.2GHz (single proc)
- 256 MB
- IDE drive (quantum)

> also, I've often found the user/sys/elapsed components to all be interesting;
> how do they look?  (I'd expect preempt to have more sys, for instance.)

        13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp       18-pre3smini  
        (sys) (user)
j100:   30.78 297.07    32.40 294.38        *           27.74 296.02    27.55 292.95    28.30 297.67
j100:   30.92 297.11    33.04 295.15        *           29.14 296.25    26.88 292.77    28.13 296.44
j100:   29.58 297.90    34.01 294.16        *           27.56 295.76    26.25 293.79    27.96 296.47
j100:   30.62 297.13    32.00 294.30        *           28.47 296.46    27.64 293.42    27.50 297.47
j100:   30.48 299.43    32.28 295.42        *           27.77 296.44    27.53 292.10    27.23 297.24

As expected the system and the user times are almost identical. The "fastest"
compile results are always where the job gets the most %cpu time. So I guess
it would be more interesting to see how much cpu time e.g. kswapd gets.

Probably I have to enhance my script to run vmstat in the background ...
Would this provide useful data?


Regards,

   Jogi


-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
