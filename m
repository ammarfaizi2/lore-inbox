Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVCHKYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVCHKYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVCHKYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:24:18 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:33209 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261955AbVCHKWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:22:48 -0500
Date: Tue, 8 Mar 2005 10:22:47 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH] 2/2 Prezeroing large blocks of pages during allocation
 Version 4
In-Reply-To: <422D42BF.4060506@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0503081012270.30439@skynet>
References: <20050307194021.E6A86E594@skynet.csn.ul.ie> <422D42BF.4060506@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, KAMEZAWA Hiroyuki wrote:

> Hi,
>
> Mel Gorman wrote:
>
> > +#define BITS_PER_ALLOC_TYPE 5
> > #define ALLOC_KERNNORCLM 0
> > #define ALLOC_KERNRCLM 1
> > #define ALLOC_USERRCLM 2
> > #define ALLOC_FALLBACK 3
> > +#define ALLOC_USERZERO 4
> > +#define ALLOC_KERNZERO 5
> >
>
> Now, 5bits per  MAX_ORDER pages.
> I think it is simpler to use "char[]" for representing type of  memory alloc
> type than bitmap.
>

Possibly, but it would also use up that bit more space. That map could be
condensed to 3 bits but would make it that bit (no pun) more complex and
difficult to merge. On the other hand, it would be faster to use a char[]
as it would be an array-index lookup to get a pageblock type rather than a
number of bit operations.

So, it depends on what people know to be better in general because I have
not measured it to know for a fact. Is it better to use char[] and use
array indexes rather than bit operations or is it better to leave it as a
bitmap and condense it later when things have settled down?

-- 
Mel Gorman
