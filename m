Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUHaXGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUHaXGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268664AbUHaWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:55:28 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50404 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268568AbUHaWxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:53:42 -0400
Date: Wed, 01 Sep 2004 07:58:53 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator withou bitmap(2) [3/3]
In-reply-to: <1093970154.26660.4829.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>
Message-id: <413502AD.90000@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <4134573F.6060006@jp.fujitsu.com>
 <1093970154.26660.4829.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> On Tue, 2004-08-31 at 03:47, Hiroyuki KAMEZAWA wrote:
> 
>>"Does a page's buddy page exist or not ?" is checked by following.
>>------------------------
>>if ((address of buddy is smaller than that of page) &&
>>    (page->flags & PG_buddyend))
>>    this page has no buddy in this order.
>>------------------------
> 
> 
> What about the top-of-the-zone buddyend pages?  Are those covered
> elsewhere?

If zone is not aligned to MAX_ORDER, the top-of-the-zone buddyend pages
are marked as PG_buddyend.
I forget something ?



>>+static inline int page_is_buddy(struct page *page, int order)
>>+{
>>+	if (PagePrivate(page) &&
>>+	    (page_order(page) == order) &&
>>+	    !(page->flags & (1 << PG_reserved)) &&
> 
> 
> Please use a macro.
my mistake.

> 
>> 	if (order)
>> 		destroy_compound_page(page, order);
>>+
>> 	mask = (~0UL) << order;
>> 	page_idx = page - base;
> 
> 
> Repeat after me: No whitespace changes.  No whitespace changes.  No
> whitespace changes.
> 
very sorry ;(


-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

