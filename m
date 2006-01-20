Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWATSM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWATSM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWATSM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:12:26 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:7114 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750982AbWATSMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:12:25 -0500
Message-ID: <43D127A3.1010200@jp.fujitsu.com>
Date: Sat, 21 Jan 2006 03:10:43 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie> <43CFE77B.3090708@austin.ibm.com> <43D02B3E.5030603@jp.fujitsu.com> <Pine.LNX.4.58.0601200102040.15823@skynet> <43D03C24.5080409@jp.fujitsu.com> <Pine.LNX.4.58.0601200934300.10920@skynet> <43D0BE27.5000807@jp.fujitsu.com> <Pine.LNX.4.58.0601201204100.14292@skynet>
In-Reply-To: <Pine.LNX.4.58.0601201204100.14292@skynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Fri, 20 Jan 2006, KAMEZAWA Hiroyuki wrote:
>>1. Using 1000+ processes(threads) at once
> 
> 
> Would tiobench --threads be suitable or would the IO skew what you are
> looking for? If the IO is a problem, what would you recommend instead?
> 
What I'm looking for is slab usage coming with threads/procs.

> 
>>2. heavy network load.
> 
> 
> Would iperf be suitable?
> 
maybe
> 
>>3. running NFS
> 
> 
> Is running a kernel build over NFS reasonable? Should it be a remote NFS
> server or could I setup a NFS share and mount it locally? If a kernel
> build is not suitable, would tiobench over NFS be a better plan?
> 
I considered doing kernel build on  NFS which is mounted localy.


> The scenario people really care about (someone correct me if I'm wrong
> here) for hot-remove is giving virtual machines more or less memory as
> demand requires. In this case, the "big"  area of memory required is the
> same size as a sparsemem section - 16MiB on the ppc64 and 64MiB on the x86
> (I think). Also, for hot-remove, it does not really matter where in the
> zone the chunk is, as long as it is free. For ppc64, 16MiB of contiguous
> memory is reasonably easy to get with the list-based approach and the case
> would likely be the same for x86 if the value of MAX_ORDER was increased.
> 
What I' want is just node-hotplug on NUMA, removing physical range of mem.
So I'll need and push dividing memory into removable zones or pgdat, anyway.
For people who just want resizing, what you say is main reason for hotplug.

-- Kame

