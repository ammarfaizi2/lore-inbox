Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUJDGwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUJDGwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 02:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUJDGwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 02:52:46 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55199 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268483AbUJDGwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 02:52:44 -0400
Date: Mon, 04 Oct 2004 15:58:11 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
In-reply-to: <20041001182221.GA3191@logos.cnet>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, akpm@osdl.org, Nick Piggin <piggin@cyberone.com.au>,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Message-id: <4160F483.3000309@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <20041001182221.GA3191@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Marcelo Tosatti wrote:

> +int can_move_page(struct page *page) 
> +{
   <snip>
> +	if (page_count(page) == 0)
> +		return 1;

I think there are 3 cases when page_count(page) == 0.

1. a page is free and in the buddy allocator.
2. a page is free and in per-cpu-pages list.
3. a page is in pagevec .

I think only case 1 pages meet your requirements.

I used PG_private flag for distinguishing case 1 from 2 and 3
in my no-bitmap buddy allocator posted before.
I added PG_private flag to a page which is in buddy allocator's free_list.

Regards

-- Kame
<kamezawa.hiroyu@jp.fujitsu.com>



