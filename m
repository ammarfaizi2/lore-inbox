Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269820AbUH0AF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269820AbUH0AF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbUH0AFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:05:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34209 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269671AbUH0AAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:00:12 -0400
Date: Fri, 27 Aug 2004 09:05:10 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap [3/4]
In-reply-to: <1093535709.2984.24.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
Message-id: <412E7AB6.8020707@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <412DD34A.70802@jp.fujitsu.com> <1093535709.2984.24.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>>+                       if (zone->nr_mem_map > 1) {
>>+                               /*
>>+                                * there may be hole in zone's memmap &&
>>+                                * hole is not aligned in this order.
>>+                                * currently, I think CONFIG_VIRTUAL_MEM_MAP
>>+                                * case is only case to reach here.
>>+                                * Is there any other case ?
>>+                                */
>>+                               /*
>>+                                * Is there better call than pfn_valid ?
>>+                                */
>>+                               if (!pfn_valid(zone->zone_start_pfn
>>+                                              + (page_idx ^ (1 << order))))
>>+                                       break;
>>+                       }
> 
> 
> Nice try.  How about putting the ia64 code in a macro or header function
> that you can #ifdef out on all the other architectures?  We used to be
> able to see that entire while loop on one screen.  That's a bit harder
> now.  
> 
Currently, I think zone->nr_mem_map itself is very vague.
I'm now looking for another way to remove this part entirely.

I think mem_section approarch may be helpful to remove this part,
but to implement full feature of CONFIG_NONLINEAR,
I'll need lots of different kind of patches.
(If mem_map is guaranteed to be contiguous in one mem_section)

1. Now, I think some small parts, some essence of mem_section which
   makes pfn_valid() faster may be good.

And another way,

2. A method which enables page -> page's max_order calculation
   may be good and consistent way in this no-bitmap approach.

But this problem would be my week-end homework :).

--Kame

-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

