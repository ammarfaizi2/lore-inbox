Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVKPCfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVKPCfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVKPCfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:35:19 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30856 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965187AbVKPCfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:35:18 -0500
Message-ID: <437A9AE5.8070001@jp.fujitsu.com>
Date: Wed, 16 Nov 2005 11:35:17 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: linux-mm@kvack.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/5] Light Fragmentation Avoidance V20: 003_fragcore
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie> <20051115165002.21980.14423.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115165002.21980.14423.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +/* Remove an element from the buddy allocator from the fallback list */
> +static struct page *__rmqueue_fallback(struct zone *zone, int order,
> +							int alloctype)

Should we avoid this fallback as much as possible ?
I think this is a weak point of this approach.


> +		/*
> +		 * If breaking a large block of pages, place the buddies
> +		 * on the preferred allocation list
> +		 */
> +		if (unlikely(current_order >= MAX_ORDER / 2)) {
> +			alloctype = !alloctype;
> +			change_pageblock_type(zone, page);
> +			area = &zone->free_area_lists[alloctype][current_order];
> +		}
Changing RCLM_NORCLM to RLCM_EASY is okay ??
If so, I think adding similar code to free_pages_bulk() is better.

-- Kame

