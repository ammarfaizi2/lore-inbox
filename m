Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319841AbSINA7U>; Fri, 13 Sep 2002 20:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319842AbSINA7U>; Fri, 13 Sep 2002 20:59:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:10222 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319841AbSINA7S>;
	Fri, 13 Sep 2002 20:59:18 -0400
Message-ID: <3D828EA8.EF24BAD0@digeo.com>
Date: Fri, 13 Sep 2002 18:19:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Dave Hansen <haveblue@us.ibm.com>, colpatch@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-zone^Wnode kswapd process
References: <20020913045938.GG2179@holomorphy.com> <617478427.1031868636@[10.10.2.3]> <3D8232DE.9090000@us.ibm.com> <3D823702.8E29AB4F@digeo.com> <3D8251D6.3060704@us.ibm.com> <3D82566B.EB2939D5@digeo.com> <3D826C25.5050609@us.ibm.com> <20020913234653.GF3530@holomorphy.com> <3D827CB0.D227D0E9@digeo.com> <20020914001235.GG3530@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2002 01:04:02.0356 (UTC) FILETIME=[9D5D7F40:01C25B8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> On Fri, Sep 13, 2002 at 05:02:56PM -0700, Andrew Morton wrote:
> > Why do I see only one kswapd here?
> > Are you claiming an overall 4x improvement, or what?
> > I'll add some instrumentation whch tells us how many pages
> > kswapd is reclaiming versus direct reclaim.
> 
> I can catch the others running if I refresh more often:
> 
>    38 root      15   0     0    0     0 DW    4.8  0.0   1:57 kswapd0
>    36 root      15   0     0    0     0 SW    2.7  0.0   0:16 kswapd2
> 
>  4779 wli       22   0  4476 3604  1648 R     9.2  0.0   0:58 top
>    37 root      15   0     0    0     0 SW    2.6  0.0   0:16 kswapd1
> 
>    38 root      15   0     0    0     0 DW    2.9  0.0   2:12 kswapd0
>    36 root      15   0     0    0     0 SW    1.8  0.0   0:22 kswapd2
> 
>  4779 wli       25   0  4476 3600  1648 R     7.4  0.0   1:18 top
>    37 root      15   0     0    0     0 SW    2.7  0.0   0:21 kswapd1
> 
>  4779 wli       24   0  4476 3600  1648 R    37.5  0.0   1:49 top
>    37 root      16   0     0    0     0 RW   11.1  0.0   0:23 kswapd1
> 
>  4779 wli       25   0  4476 3600  1648 R    14.1  0.0   1:51 top
>    35 root      15   0     0    0     0 SW    6.9  0.0   0:24 kswapd3
> 
>    38 root      15   0     0    0     0 RW    2.9  0.0   2:29 kswapd0
>    37 root      16   0     0    0     0 SW    1.4  0.0   0:28 kswapd1
> 
> etc.
> 
> Not sure about baselines. I'm happier because there's more cpu
> utilization. kswapd0 is relatively busy so the other ones take some
> load off of it. The benchmark isn't quite done yet. I think four
> dbench 512's in parallel might be easier to extract results from.
> tiobench also looks like it's getting some cpu:
> 

OK, thanks.

Could you please go into /proc/<pif_of_kswapd>/cpu and double
check that each kswapd is only racking up points on the CPUs
which it is supposed to be running on?  As a little sanity check...

(hm.  Why isn't cpus_allowed displayed from in there?)

Also, we need to double check that I'm not completely full of
unmentionables, and that kswapd really is doing useful work there.
I can check that.

I'll do an mm4 in a mo (as soon as I work out who did the dud patch
which stops it booting) and we can see what the kwapd-versus-direct-reclaim
ratio looks like.
