Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291985AbSBAUlO>; Fri, 1 Feb 2002 15:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291990AbSBAUlF>; Fri, 1 Feb 2002 15:41:05 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:8652 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S291985AbSBAUkq>; Fri, 1 Feb 2002 15:40:46 -0500
Date: Fri, 1 Feb 2002 12:32:50 -0800
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: should I trust 'free' or 'top'?
Message-ID: <20020201203250.GD23997@flounder.net>
In-Reply-To: <20020201192415.GC23997@flounder.net> <20020201201145.GD834@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020201201145.GD834@holomorphy.com>
User-Agent: Mutt/1.3.25i
X-Delivery-Agent: TMDA v0.42/Python 2.1.1 (sunos5)
From: "Adam McKenna" <adam-dated-1013027573.f251b8@flounder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:11:45PM -0800, William Lee Irwin III wrote:
> On Fri, Feb 01, 2002 at 11:24:16AM -0800, Adam McKenna wrote:
> > adam@xpdb:~$ uptime
> >  11:21am  up 42 days, 18:53,  3 users,  load average: 54.72, 21.21, 17.60
> > adam@xpdb:~$ free
> >              total       used       free     shared    buffers     cached
> > Mem:       5528464    5522744       5720          0        476    5349784
> > -/+ buffers/cache:     172484    5355980
> > Swap:      2939804    1302368    1637436
> > As you can see, there are supposedly 5.3 gigs of memory free (not counting
> > memory used for cache).  However, the box is swapping like mad (about 10 megs
> > every 2 seconds according to vmstat) and the load is skyrocketing.
> 
> That 5.3GB is without kernel caches. I see 5.7MB...
> 
> On Fri, Feb 01, 2002 at 11:24:16AM -0800, Adam McKenna wrote:
> > Now top, on the other hand, has a very different idea about the amount of
> > free memory:
> > CPU states:  0.0% user,  0.1% system,  0.1% nice,  0.0% idle
> > Mem:  5528464K av, 5523484K used,   4980K free,      0K shrd,    340K buff
> > Swap: 2939804K av, 1082008K used, 1857796K free                5351892K
> > cached
> 
> They actually agree. The line you're reading with 5.3GB in it subtracts
> kernel caches from the memory in use.
> 
> The fun bit about swapping like mad is because kernel caches are not
> being flushed and shrunk properly in response to growth of the working
> set. In more concrete terms, the kernel is making decisions which prefer
> to keep things like the page cache, the dentry cache, the inode cache,
> and the buffer cache in memory over the working sets of your programs.
> There is some tradeoff: it is probably also not desirable to allow the
> working set to erode kernel caches to the absolute minimum (or at least
> not very easily), but obviously what tradeoffs are happening here are
> suboptimal for your workload (and generally insufficiently adaptive). It
> appears that when the kernel caches are done with you you've got 172MB
> out of 5.5GB of physical memory left for your programs' anonymous memory.
> 
> What kernel/VM are you using?

2.4.6-xfs but we've also seen this with 2.4.14-xfs (xfs 1.0.2 release)

> Could you follow up with /proc/slabinfo and /proc/meminfo?

We've already rebooted the box, next time we are experiencing the problem
I'll send this info.

Meanwhile, is there any way to tune the kernel cache?

--Adam

-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A
