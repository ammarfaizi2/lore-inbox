Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbTCKPUr>; Tue, 11 Mar 2003 10:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262946AbTCKPUr>; Tue, 11 Mar 2003 10:20:47 -0500
Received: from franka.aracnet.com ([216.99.193.44]:45495 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262945AbTCKPUq>; Tue, 11 Mar 2003 10:20:46 -0500
Date: Tue, 11 Mar 2003 07:31:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dcache hash distrubition patches
Message-ID: <31840000.1047396682@[10.10.2.4]>
In-Reply-To: <20030311152322.GA2358@averell>
References: <10280000.1047318333@[10.10.2.4]> <20030310175221.GA20060@averell> <26350000.1047368465@[10.10.2.4]> <20030311152322.GA2358@averell>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> some numbers. They still look pretty good to me. I shrunk us from
>> 1,048,576 buckets to 65536, and loaded 1,150,000 entries in there.
> 
> Interesting would be to find the sweet spot with the smallest hash table 
> size that still performs well. Not sure if find / is a good workload
> for that though.

Difficult, as it depends how many files are in the working set of the 
machine, really. Right now it eats 4Mb of lowmem ... 1M entries seems
to be about 150Mb of slab for dentries, which is probably as much as
anyone wants ... but it's nice to keep those hash chains short ;-)

I can try 1Mb or something I suppose ... what's the purpose here,
to keep the cachelines of the bucket heads warm? Not sure it's worth
the tradeoff, as we have to touch another line for each element we
walk?

I take it you're happy enough with the current hash function distribution?
 
> Also same for inode hash (but I don't have statistics for that right now)

I could hack something up ... but 1 machine ain't going to cut it. I
suspect I'd have a much smaller inode hash, as I tend to have masses
of kernel trees, mostly hardlinked to each other.

M.
