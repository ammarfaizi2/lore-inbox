Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263661AbUJ3Jrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUJ3Jrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbUJ3Jrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 05:47:49 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50849 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263661AbUJ3Jrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 05:47:46 -0400
Date: Sat, 30 Oct 2004 18:53:32 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
In-reply-to: <41835F4D.2060508@tebibyte.org>
To: Chris Ross <chris@tebibyte.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Message-id: <4183649C.7070601@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3)
 Gecko/20040910
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
 <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org>
 <41834FE7.5060705@jp.fujitsu.com> <418354C0.3060207@tebibyte.org>
 <418357C5.4070304@jp.fujitsu.com> <41835F4D.2060508@tebibyte.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:

> 
> 
> Hiroyuki KAMEZAWA escreveu:
> 
>> zone->free_area[order]->nr_free is corrupted, this patch fix it.
>>
>> It looks there is no area->nr_free++ code during freeing pages, now.
> 
> 
> It's corrupt because area is out of scope at that point - it's declared 
> within the for loop above.
> 
> Should I move your fix into the loop or move the declaration of area to 
> function scope?
> 
Oh, Okay, my patch was wrong ;(.
Very sorry for wrong hack.
This one will be Okay.

Sorry,
Kame <kamezawa.hiroyu@jp.fujitsu.com>

-

  linux-2.6.10-rc1-mm2-kamezawa/mm/page_alloc.c |    1 +
  1 files changed, 1 insertion(+)

diff -puN mm/page_alloc.c~cleanup2 mm/page_alloc.c
--- linux-2.6.10-rc1-mm2/mm/page_alloc.c~cleanup2	2004-10-30 18:40:19.024529640 +0900
+++ linux-2.6.10-rc1-mm2-kamezawa/mm/page_alloc.c	2004-10-30 18:40:40.225306632 +0900
@@ -262,6 +262,7 @@ static inline void __free_pages_bulk (st
  	coalesced = base + page_idx;
  	set_page_order(coalesced, order);
  	list_add(&coalesced->lru, &zone->free_area[order].free_list);
+	zone->free_area[order].nr_free++;
  }

  static inline void free_pages_check(const char *function, struct page *page)

_

