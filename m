Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268331AbUJDCdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268331AbUJDCdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 22:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbUJDCdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 22:33:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:1690 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268331AbUJDCdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 22:33:03 -0400
Date: Mon, 04 Oct 2004 11:38:32 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
In-reply-to: <20041001182221.GA3191@logos.cnet>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, akpm@osdl.org, Nick Piggin <piggin@cyberone.com.au>,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Message-id: <4160B7A8.7010607@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <20041001182221.GA3191@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


how about inserting this if-sentense ?

-- Kame

Marcelo Tosatti wrote:
> +int coalesce_memory(unsigned int order, struct zone *zone)
> +{
<snip>

> +		while (entry != &area->free_list) {
> +			int ret;
> +			page = list_entry(entry, struct page, lru);
> +			entry = entry->next;
> +

   +              if (((page_to_pfn(page) - zone->zone_start_pfn) & (1 << toorder)) {

> +			pwalk = page;
> +
> +			/* Look backwards */
> +
> +			for (walkcount = 1; walkcount<nr_pages; walkcount++) {
                         ..................
> +			}
> +
   +               } else {
> +forward:
> +
> +			pwalk = page;
> +
> +			/* Look forward, skipping the page frames from this 
> +			  high order page we are looking at */
> +
> +			for (walkcount = (1UL << torder); walkcount<nr_pages; 
> +					walkcount++) {
> +				pwalk = page+walkcount;
> +
> +				ret = can_move_page(pwalk);
> +
> +				if (ret) 
> +					nr_freed_pages++;
> +				else
> +					goto loopey;
> +
> +				if (nr_freed_pages == nr_pages)
> +					goto success;
> +			}
> +
   +                }

