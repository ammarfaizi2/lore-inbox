Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312022AbSCQNQG>; Sun, 17 Mar 2002 08:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311184AbSCQNPz>; Sun, 17 Mar 2002 08:15:55 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:10000 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311177AbSCQNPh>;
	Sun, 17 Mar 2002 08:15:37 -0500
Date: Mon, 18 Mar 2002 00:12:40 +1100
From: Anton Blanchard <anton@samba.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: some RCU dcache and ratcache results
Message-ID: <20020317131240.GH22387@krispykreme>
In-Reply-To: <20020313085217.GA11658@krispykreme> <460695164.1016001894@[10.10.2.3]> <20020314112725.GA2008@krispykreme> <20020314184609.D15394@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314184609.D15394@in.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Not for this, I did do some benchmarking of the RCU dcache patches a
> > while ago which I should post.
> 
> Please do ;-) This shows why we need to ease the pressure on dcache_lock.

OK :) Here is a graph I made a while ago. It is on a 32 way ppc64 box
running dbench.

http://samba.org/~anton/linux/dcache/summary.png

rat - radix-tree pagecache patch
dcache - RCU dcache patch
ext2 - rusty's BKL removal from ext2 patch

Not surprisingly the RCU dcache patch gave a large improvement in
dbench. While dbench may not be the greatest of benchmarks I am also
seeing a lot of dcache_lock contention on large zero copy workloads (eg 8
way specweb).

> > I didnt get a chance to run lockmeter, I tend to use the kernel profiler
> > and use a hacked readprofile (originally from tridge) that displays
> > profile hits vs assembly instruction. Thats usually good enough to work
> > out which spinlocks are a problem.
> 
> Is this a PPC only hack ? Also, where can I get it ?

I thought tridge put it into cvs somewhere, I'll find out the details
from him.

Anton
