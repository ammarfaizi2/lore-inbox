Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWIHHyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWIHHyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWIHHyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:54:40 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:50143 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750825AbWIHHyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:54:40 -0400
Subject: Re: [PATCH 2/8] Split the free lists into kernel and user parts
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060907190422.6166.49758.sendpatchset@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
	 <20060907190422.6166.49758.sendpatchset@skynet.skynet.ie>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 09:54:00 +0200
Message-Id: <1157702040.17799.40.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

Looking good, some small nits follow.

On Thu, 2006-09-07 at 20:04 +0100, Mel Gorman wrote:

> +#define for_each_rclmtype_order(type, order) \
> +	for (order = 0; order < MAX_ORDER; order++) \
> +		for (type = 0; type < RCLM_TYPES; type++)

It seems odd to me that you have the for loops in reverse order of the
arguments.

> +static inline int get_pageblock_type(struct page *page)
> +{
> +	return (PageEasyRclm(page) != 0);
> +}

I find the naming a little odd, I would have suspected something like:
get_page_blocktype() or thereabout since you're getting a page
attribute.

> +static inline int gfpflags_to_rclmtype(unsigned long gfp_flags)
> +{
> +	return ((gfp_flags & __GFP_EASYRCLM) != 0);
> +}

gfp_t argument?


