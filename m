Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUH3Rgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUH3Rgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUH3RgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:36:01 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:12551 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268582AbUH3Rb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:31:57 -0400
Message-ID: <41336CB1.6030105@techsource.com>
Date: Mon, 30 Aug 2004 14:06:41 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, eric@cisu.net,
       kernel@kolivas.org, barryn@pobox.com, swsnyder@insightbb.com,
       linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
References: <200408021602.34320.swsnyder@insightbb.com>	<410FA145.70701@kolivas.org>	<20040804060625.GE10340@suse.de>	<200408040614.30820.eric@cisu.net>	<20040804130707.GN10340@suse.de> <20040804120633.4dca57b3.akpm@osdl.org> <411ABF85.2080200@techsource.com>
In-Reply-To: <411ABF85.2080200@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Timothy Miller wrote:
> 
> 
> Andrew Morton wrote:
> 
>>
>>
>> The 896M/128M split has a bit of a problem now each zone has its own LRU:
>> the size of the highmem zone is less than the amount of memory which is
>> described by the default /proc/sys/vm/dirty_ratio.  So it is easy to
>> completely fill highmem with dirty pages.  This causes a fairly large
>> amount of writeback via vmscan.c's writepage().  This causes poor I/O
>> submission patterns.  This causes a simple large, linear `dd' write to 
>> run
>> at only 50-70% of disk bandwidth.  (This was 6-12 months ago - it 
>> might be
>> a bit better now)
>>
> 
> 
> Hey, that rings a bell.  I have a 3ware 7000-2 controller with two 
> WD1200JB drives in RAID1.  I find that if I dd from the disk, I get 
> exactly the read throughput that is the max for the drives (47MB/sec). 
> However, if I do a WRITE test, the performance is miserable.
> 
> I have been going back and forth with 3ware for months, and what's odd 
> is that my drives with my controller in any machine other than the 
> primary box get great write throughput, BUT on my main box with 1G of 
> RAM, I get MISERABLE write throughput.  When I should be getting 
> 36MB/sec or faster, I get 8 to 12 MB/sec.
> 
> Now, I have tried limiting the memory with a mem= boot option, but that 
> doesn't change the performance any.
>

Scratch all this.  Even if I physically remove half the memory, I STILL 
get the performance problem.

