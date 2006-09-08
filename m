Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWIHJUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWIHJUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWIHJUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:20:19 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:65181 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750719AbWIHJUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:20:17 -0400
Date: Fri, 8 Sep 2006 10:20:16 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Split the free lists into kernel and user parts
In-Reply-To: <1157702040.17799.40.camel@lappy>
Message-ID: <Pine.LNX.4.64.0609081019040.7094@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie> 
 <20060907190422.6166.49758.sendpatchset@skynet.skynet.ie>
 <1157702040.17799.40.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Peter Zijlstra wrote:

> Hi Mel,
>
> Looking good, some small nits follow.
>
> On Thu, 2006-09-07 at 20:04 +0100, Mel Gorman wrote:
>
>> +#define for_each_rclmtype_order(type, order) \
>> +	for (order = 0; order < MAX_ORDER; order++) \
>> +		for (type = 0; type < RCLM_TYPES; type++)
>
> It seems odd to me that you have the for loops in reverse order of the
> arguments.
>

I'll fix that.

>> +static inline int get_pageblock_type(struct page *page)
>> +{
>> +	return (PageEasyRclm(page) != 0);
>> +}
>
> I find the naming a little odd, I would have suspected something like:
> get_page_blocktype() or thereabout since you're getting a page
> attribute.
>

This is a throwback from an early version when I used a bitmap that used 
one bit per MAX_ORDER_NR_PAGES block of pages. Many pages in a block 
shared one bit - hence get_pageblock_type(). The name is now stupid. I'll 
fix it.

>> +static inline int gfpflags_to_rclmtype(unsigned long gfp_flags)
>> +{
>> +	return ((gfp_flags & __GFP_EASYRCLM) != 0);
>> +}
>
> gfp_t argument?
>

doh, yes, it should be gfp_t

Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
