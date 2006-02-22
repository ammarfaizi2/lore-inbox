Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWBVCvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWBVCvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWBVCvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:51:32 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:158 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751056AbWBVCvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:51:31 -0500
Message-ID: <43FBD1D3.109@jp.fujitsu.com>
Date: Wed, 22 Feb 2006 11:52:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haveblue@us.ibm.com,
       Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] remove zone_mem_map
References: <43FBAEBA.2020300@jp.fujitsu.com> <20060221183306.3d467d14.akpm@osdl.org>
In-Reply-To: <20060221183306.3d467d14.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>> This patch removes zone_mem_map from zone.
>>  By this, (generic) page_to_pfn and pfn_to_page can use the same logic.
> 
> I assume this is dependent upon unify-pfn_to_page-*.patch?
> 
yes. sorry for forgetting to write it.

>>  This modifies page_to_pfn implementation. Could anyone do performance test on NUMA ?
> 
> Do you expect there to be NUMA performance problems?  If so, how do they
> arise and what sort of tests should be run?
> 
I don't expect it. But when I posted this before (as RFC), some persons
(Martin J. Bligh and Dave Hansen) had concerns about it.

I think the heaviest users of page_to_pfn() are the page allocator and
mk_pte(page_to_pfn(page), hogehoge).

So, tests like  "mmap -> touch all -> unmap" will be good test.

powerpc and ia64 is not a good test environment, because they don't use
page_to_pfn() of generic DISCONTIG definitions.

other NUMAs (i386, x86_64 etc..) will be good.

Thanks,
-- Kame

