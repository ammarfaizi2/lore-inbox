Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268400AbUHLAh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268400AbUHLAh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268455AbUHLAfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:35:10 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:56848 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268452AbUHLAVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:21:25 -0400
Message-ID: <411ABF85.2080200@techsource.com>
Date: Wed, 11 Aug 2004 20:53:25 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, eric@cisu.net, kernel@kolivas.org,
       barryn@pobox.com, swsnyder@insightbb.com, linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
References: <200408021602.34320.swsnyder@insightbb.com>	<410FA145.70701@kolivas.org>	<20040804060625.GE10340@suse.de>	<200408040614.30820.eric@cisu.net>	<20040804130707.GN10340@suse.de> <20040804120633.4dca57b3.akpm@osdl.org>
In-Reply-To: <20040804120633.4dca57b3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

> 
> 
> The 896M/128M split has a bit of a problem now each zone has its own LRU:
> the size of the highmem zone is less than the amount of memory which is
> described by the default /proc/sys/vm/dirty_ratio.  So it is easy to
> completely fill highmem with dirty pages.  This causes a fairly large
> amount of writeback via vmscan.c's writepage().  This causes poor I/O
> submission patterns.  This causes a simple large, linear `dd' write to run
> at only 50-70% of disk bandwidth.  (This was 6-12 months ago - it might be
> a bit better now)
> 


Hey, that rings a bell.  I have a 3ware 7000-2 controller with two 
WD1200JB drives in RAID1.  I find that if I dd from the disk, I get 
exactly the read throughput that is the max for the drives (47MB/sec). 
However, if I do a WRITE test, the performance is miserable.

I have been going back and forth with 3ware for months, and what's odd 
is that my drives with my controller in any machine other than the 
primary box get great write throughput, BUT on my main box with 1G of 
RAM, I get MISERABLE write throughput.  When I should be getting 
36MB/sec or faster, I get 8 to 12 MB/sec.

Now, I have tried limiting the memory with a mem= boot option, but that 
doesn't change the performance any.

