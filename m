Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSFTPPg>; Thu, 20 Jun 2002 11:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSFTPPf>; Thu, 20 Jun 2002 11:15:35 -0400
Received: from holomorphy.com ([66.224.33.161]:44990 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314835AbSFTPPd>;
	Thu, 20 Jun 2002 11:15:33 -0400
Date: Thu, 20 Jun 2002 08:15:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM benchmarks for 2.5 (mainline & rmap patches)
Message-ID: <20020620151507.GT22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206200554590.4448-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206200554590.4448-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 06:00:48AM -0700, Craig Kulesa wrote:
> Test 3: (non-swap) dbench 1,2,4,8 ... just because everyone else does...

Wow, and apples to apples, too.


On Thu, Jun 20, 2002 at 06:00:48AM -0700, Craig Kulesa wrote:
> 2.5.23:
> Throughput 35.1563 MB/sec (NB=43.9454 MB/sec  351.563 MBit/sec)  1 procs
> Throughput 33.237  MB/sec (NB=41.5463 MB/sec  332.37  MBit/sec)  2 procs
> Throughput 28.9504 MB/sec (NB=36.188  MB/sec  289.504 MBit/sec)  4 procs
> Throughput 17.1113 MB/sec (NB=21.3891 MB/sec  171.113 MBit/sec)  8 procs

> 2.5.23-rmap13b:
> Throughput 35.1443 MB/sec (NB=43.9304 MB/sec  351.443 MBit/sec)  1 procs
> Throughput 33.9223 MB/sec (NB=42.4028 MB/sec  339.223 MBit/sec)  2 procs
> Throughput 25.0807 MB/sec (NB=31.3509 MB/sec  250.807 MBit/sec)  4 procs
> Throughput 14.1789 MB/sec (NB=17.7236 MB/sec  141.789 MBit/sec)  8 procs

There's an interesting curve here. The regime between 1 and 4 procs looks
interesting, I wonder if it's really faster there and by how much, and
getting a better idea of how it's falling off would also be good.


On Thu, Jun 20, 2002 at 06:00:48AM -0700, Craig Kulesa wrote:
> 2.5.23:
> 1.710u   1.990s 0:04.76 77.7%   0+0k 0+0io 130pf+0w
> 3.430u   4.050s 0:08.95 83.5%   0+0k 0+0io 153pf+0w
> 6.780u   8.090s 0:19.24 77.2%   0+0k 0+0io 199pf+0w
> 13.810u 21.870s 1:02.73 56.8%   0+0k 0+0io 291pf+0w

> 2.5.23-rmap13b:
> 1.800u   1.930s 0:04.76 78.3%   0+0k 0+0io 132pf+0w
> 3.280u   4.100s 0:08.79 83.9%   0+0k 0+0io 155pf+0w
> 6.990u   7.910s 0:22.09 67.4%   0+0k 0+0io 202pf+0w
> 13.780u 17.830s 1:15.52 41.8%   0+0k 0+0io 293pf+0w

The correlation isn't entirely clear but at first glance I suspect
something is being waited on more by 2.5.23-rmap13b and throttling
things. There also appears to be an increased number of page faults.
I have still more suspicions.


On Thu, Jun 20, 2002 at 06:00:48AM -0700, Craig Kulesa wrote:
> Comments:  Stock 2.5 has gotten faster since the tree began.  That's
> 	   good.  Rmap patches don't affect this for small numbers of
> 	   processes, but symptomatically show a small slowdown by the
> 	   time we reach 'dbench 8'.  

I think this needs profiling, but I'm not 100% sure of how to get an
idea of what's being waited on as most profiling tools are designed
for capturing things that are actually running.


Cheers,
Bill
