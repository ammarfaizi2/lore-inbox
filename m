Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUHaQgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUHaQgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUHaQgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:36:43 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23545 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264113AbUHaQgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:36:14 -0400
Subject: Re: [RFC] buddy allocator withou bitmap(2) [3/3]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <4134573F.6060006@jp.fujitsu.com>
References: <4134573F.6060006@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093970154.26660.4829.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 09:35:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 03:47, Hiroyuki KAMEZAWA wrote:
> "Does a page's buddy page exist or not ?" is checked by following.
> ------------------------
> if ((address of buddy is smaller than that of page) &&
>     (page->flags & PG_buddyend))
>     this page has no buddy in this order.
> ------------------------

What about the top-of-the-zone buddyend pages?  Are those covered
elsewhere?

> +static inline int page_is_buddy(struct page *page, int order)
> +{
> +	if (PagePrivate(page) &&
> +	    (page_order(page) == order) &&
> +	    !(page->flags & (1 << PG_reserved)) &&

Please use a macro.

>  	if (order)
>  		destroy_compound_page(page, order);
> +
>  	mask = (~0UL) << order;
>  	page_idx = page - base;

Repeat after me: No whitespace changes.  No whitespace changes.  No
whitespace changes.

-- Dave

