Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319793AbSIMVNe>; Fri, 13 Sep 2002 17:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319794AbSIMVNe>; Fri, 13 Sep 2002 17:13:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18184 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S319793AbSIMVNc>; Fri, 13 Sep 2002 17:13:32 -0400
Date: Fri, 13 Sep 2002 23:18:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Samuel Flory <sflory@rackable.com>
Cc: Stephen Lord <lord@sgi.com>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020913211844.GP11605@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com> <20020913125345.GO11605@dualathlon.random> <3D825422.8000007@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D825422.8000007@rackable.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 02:09:54PM -0700, Samuel Flory wrote:
> Andrea Arcangeli wrote:
> 
> > 
> >
> >you can try to compile with CONFIG_3G and to set __VMALLOC_RESERVE to
> >(512 << 20) and see if it helps. If it only happens a bit later then
> >it's most probably an address space leak, should be easy to track down
> >some debugging instrumentation.
> > 
> >
> 
> 
>  It seems to be working for me now.  I'm getting about 200 on dbench 4, 
> and 90 on dbench 64.  (Note you need to increase your log size to get 
> these kinda of numbers.)  Now I get to see how fast I can read files via 
> nfs.

btw, if you run into troubles with networking with aa2 try to backout
the last net-softirq patch, not sure why yet but the last modification I
did malfunctions with some nic. Couldn't reproduce it here, but I'll
look into that next week and I'll fix it too for the next -aa. 

So, returning to xfs, it is possible dbench really generates lots of
simultaneous vmaps because of its concurrency, so I would suggest to add
an atomic counter increased at every vmap/vmalloc and decreased at every
vfree and to check it after every increase storing the max value in a
sysctl, to see what's the max concurrency you reach with the vmaps. (you
can also export the counter via the sysctl, to verify for no memleaks
after unmounting xfs)

Andrea
