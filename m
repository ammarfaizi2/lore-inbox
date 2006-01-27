Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWA0LUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWA0LUH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWA0LUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:20:07 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:65197 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964986AbWA0LUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:20:05 -0500
Message-ID: <43DA01DD.9040808@jp.fujitsu.com>
Date: Fri, 27 Jan 2006 20:19:57 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/9] Reducing fragmentation using zones
 v4
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie> <43D96987.8090608@jp.fujitsu.com> <43D96C41.6020103@jp.fujitsu.com> <Pine.LNX.4.58.0601271027560.25836@skynet>
In-Reply-To: <Pine.LNX.4.58.0601271027560.25836@skynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Fri, 27 Jan 2006, KAMEZAWA Hiroyuki wrote:
> 
>> KAMEZAWA Hiroyuki wrote:
>>> Could you add this patch to your set ?
>>> This was needed to boot my x86 machine without HIGHMEM.
>>>
>> Sorry, I sent a wrong patch..
>> This is correct one.
> 
> I can add it although I would like to know more about the problem. I tried
> booting with and without CONFIG_HIGHMEM both stock kernels and with
> anti-frag and they all boot fine. What causes your machine to die? Does it
> occur with stock -mm or just with anti-frag?
> 
Sorry, it looks there is no problem with your newest set :(
This was problem of my tree...

Sigh, I should be more carefull.
my note is attached.

Sorry,
-- Kame

== Note ==

I replaced si_meminfo() like following
==
#ifdef CONFIG_HIGHMEM
         val->totalhigh = nr_total_zonetype_pages(ZONE_HIGHMEM);
         val->freehigh = nr_free_zonetype_pages(ZONE_HIGHMEM);
#else
==
If ZONE_HIGHMEM has no pages, val->totalhigh is 0 and mempool for bounce buffer
is not initialized.

But, now
==
#ifdef CONFIG_HIGHMEM
         val->totalhigh = totalhigh_pages;
         val->freehigh = nr_free_highpages();
#else
==

totalhigh_pages is defined by highstart_pfn and highend_pfn.
By Zone_EasyRclm, totalhigh_pages is not affected.
mempool for bounce buffer is properly initialized....


