Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSEFMU3>; Mon, 6 May 2002 08:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314398AbSEFMU2>; Mon, 6 May 2002 08:20:28 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:17602 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S314395AbSEFMU2>; Mon, 6 May 2002 08:20:28 -0400
Date: Mon, 6 May 2002 04:20:05 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020506042005.A18792@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, Randy, I seen my tree runs slower with tiobench, that's probably
> because I made the elevator anti-starvation logic more aggressive than
> mainline and the other kernel trees (to help interactive usage), could
> you try to run tiobench on -aa after elvtune -r 8192 -w 16384
> /dev/hd[abcd] to verify? Thanks for the great benchmarking effort.

I will have results on the big machine in a couple days.  On the 
small machine, elvtune increases tiobench sequential reads by
30-50%, and lowers worst case latency a little.

More -aa at:
http://home.earthlink.net/~rwhron/kernel/aa.html

> And for the reason fork is faster in -aa that's partly thanks to the
> reschedule-child-first logic, that can be easily merged in mainline,
> it's just in 2.5.

Is that part of parent_timeslice patch?  parent_timeslice helped 
fork a little when I tried to isolating patches to find what
makes fork faster in -aa.  It is more than one patch as far as 
I can tell.

On uniprocessor the unixbench execl test, all -aa kernel's going back 
at least to 2.4.15aa1 are about 20% faster than other trees, even those 
like jam and akpm's splitted vm.  Fork in -aa for more "real world" 
test (autoconf build) is about 8-10% over other kernel trees.

On quad Xeon, with bigger L2 cache, autoconf (fork test) the difference
between mainline and -aa is smaller.  The -aa based VMs in aa, jam, and
mainline have about 15% edge over rmap VM in ac and rmap.  jam has a
slight advantage for autoconf build, possibly because of O(1) effect
which is more likely to show up since more processes execute
on the 4 way box.

More quad Xeon at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html


-- 
Randy Hron

