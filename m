Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269766AbUHZXIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269766AbUHZXIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269741AbUHZXEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:04:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50144 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266198AbUHZXAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:00:32 -0400
Date: Fri, 27 Aug 2004 08:05:39 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] buddy allocator without bitmap  [2/4]
In-reply-to: <1093535402.2984.11.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
Message-id: <412E6CC3.8060908@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <412DD1AA.8080408@jp.fujitsu.com>
 <1093535402.2984.11.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I understand using these macros cleans up codes as I used them in my previous
version.

In the previous version, I used SetPagePrivate()/ClearPagePrivate()/PagePrivate().
But these are "atomic" operation and looks very slow.
This is why I doesn't used these macros in this version.

My previous version, which used set_bit/test_bit/clear_bit, shows very bad performance
on my test, and I replaced it.

If I made a mistake on measuring the performance and set_bit/test_bit/clear_bit
is faster than what I think, I'd like to replace them.

-- Kame

Dave Hansen wrote:
> On Thu, 2004-08-26 at 05:03, Hiroyuki KAMEZAWA wrote:
> 
>>-		MARK_USED(index + size, high, area);
>>+		page[size].flags |= (1 << PG_private);
>>+		page[size].private = high;
>>  	}
>>  	return page;
>>  }
> 
> ...
> 
>>+		/* Atomic operation is needless here */
>>+		page->flags &= ~(1 << PG_private);
> 
> 
> See linux/page_flags.h:
> 
> #define SetPagePrivate(page)    set_bit(PG_private, &(page)->flags)
> #define ClearPagePrivate(page)  clear_bit(PG_private, &(page)->flags)
> #define PagePrivate(page)       test_bit(PG_private, &(page)->flags)
> 
> -- Dave
> 
> 


-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

