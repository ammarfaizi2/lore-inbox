Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319832AbSIMX6W>; Fri, 13 Sep 2002 19:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319833AbSIMX6W>; Fri, 13 Sep 2002 19:58:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:13037 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319832AbSIMX6V>;
	Fri, 13 Sep 2002 19:58:21 -0400
Message-ID: <3D827CB0.D227D0E9@digeo.com>
Date: Fri, 13 Sep 2002 17:02:56 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Dave Hansen <haveblue@us.ibm.com>, colpatch@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-zone^Wnode kswapd process
References: <20020913045938.GG2179@holomorphy.com> <617478427.1031868636@[10.10.2.3]> <3D8232DE.9090000@us.ibm.com> <3D823702.8E29AB4F@digeo.com> <3D8251D6.3060704@us.ibm.com> <3D82566B.EB2939D5@digeo.com> <3D826C25.5050609@us.ibm.com> <20020913234653.GF3530@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2002 00:03:01.0731 (UTC) FILETIME=[17767330:01C25B82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Fri, Sep 13, 2002 at 03:52:21PM -0700, Dave Hansen wrote:
> > Here's a per-node kswapd.  It's actually per-pg_data_t, but I guess that
> > they're equivalent.  Matt is going to follow up his topology API with
> > something to bind these to their respective nodes.
> 
> >From 64 parallel tiobench 64's (higher counts livelock in fork() etc.):
> 
>    38 root      15   0     0    0     0 RW   23.0  0.0   1:11 kswapd0
>  4779 wli       22   0  4460 3588  1648 R    17.9  0.0   0:16 top
> 
> ...
> 
>  4779 wli       25   0  4460 3592  1648 R    14.1  0.0   0:27 top
>    38 root      15   0     0    0     0 DW    3.5  0.0   1:31 kswapd0
> 

Why do I see only one kswapd here?

Are you claiming an overall 4x improvement, or what?

I'll add some instrumentation whch tells us how many pages
kswapd is reclaiming versus direct reclaim.
