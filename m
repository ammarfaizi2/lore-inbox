Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWATBS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWATBS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWATBS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:18:29 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48599 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030452AbWATBS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:18:28 -0500
Message-ID: <43D03A48.8090105@jp.fujitsu.com>
Date: Fri, 20 Jan 2006 10:18:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Joel Schopp <jschopp@austin.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/5] Reducing fragmentation using zones
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie> <43CFE77B.3090708@austin.ibm.com> <Pine.LNX.4.58.0601200011190.15823@skynet>
In-Reply-To: <Pine.LNX.4.58.0601200011190.15823@skynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> To satisfy this request, I did a quick rebase of the list-based approach
> against 2.6.16-rc1-mm1 to have a comparable set of benchmarks. I will post
> the patches in the morning after a re-read.
> 
Thank you.


> So, in terms of performance on this set of tests, both approachs perform
> roughly the same as the stock kernel in terms of absolute performance. In
> terms of high-order allocations, zone-based appears to do better under
> load. However, if you look at the zones that are used, you will see that
> zone-based appears to do as well as list-based *only* because it has the
> EASYRCLM zone to play with. list-based was way better at keeping the
> normal zone defragmented as well as highmem which is especially obvious
> when tested at rest.  list-based was able to allocate 83 huge pages from
> ZONE_NORMAL at rest while zone-based only managed 8.
> 
yes, this is intersiting point :)
list-based one can defrag NORMAL zone.
The point will be "does we need to defrag NORMAL ?" , I think.
IMHO, I don't like to use NORMAL zone to alloc higher-order pages...

> Secondly, zone-based requires careful configuration to be successful.  If
> booted with kernelcore=896MB for example, it only performs slightly better
> than the standard kernel. If booted with kernelcore=1024MB, it tends to
> perform slightly worse (more zone fallbacks I guess) and still only
> manages slighly better satisfaction of high order pages.
This is because HIGHMEM is too small, right ?


> On the flip side, zone-based code changes are easier to understand than
> the list-based ones (at least in terms of volume of code changes). The
> zone-based gives guarantees on what will happen in the future while
> list-based is best-effort.
> 
> In terms of fragmentation, I still think that list-based is better overall
> without configuration. 
I agree here.

>The results above also represent the best possible
> configuration with zone-based versus no configuration at all against
> list-based. In an environment with changing workloads a constant reality,
> I bet that list-based would win overall.
> 
On x86, NORMAL is only 896M anyway. there is no discussion.


Honestly, I don't have enough experience with machines which doesn't have Highmem.
How large kernelcore should be ?
It looks using list-based and zone-based at the same time will make all people happy...

-- Kame

