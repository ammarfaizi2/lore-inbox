Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWBJAvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWBJAvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWBJAvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:51:14 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43979 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750910AbWBJAvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:51:13 -0500
Message-ID: <43EBE3AB.1010009@jp.fujitsu.com>
Date: Fri, 10 Feb 2006 09:51:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
References: <200602092339.49719.kernel@kolivas.org>
In-Reply-To: <200602092339.49719.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Con Kolivas wrote:
> +void add_to_swapped_list(struct page *page)
> +{
> +	struct swapped_entry *entry;
> +	unsigned long index;
> +
> +	spin_lock(&swapped.lock);
> +	if (swapped.count >= swapped.maxcount) {

Assume x86 system with 8G memory, swapped_maxcount is maybe 5G+ here.
Then, swapped_entry can consume 5G/PAGE_SIZE * 16bytes = 10 M byte more slabs from
ZONE_NORMAL. Could you add check like this?
==
void add_to_swapped_list(struct page *page)
{
	<snip>
	if (!swap_prefetch)
		return;
	spin_lcok(&spwapped.lock);
}
==

Thanks,
-- Kame

