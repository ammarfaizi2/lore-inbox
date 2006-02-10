Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWBJA4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWBJA4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWBJA4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:56:50 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:38606 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750919AbWBJA4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:56:49 -0500
From: Con Kolivas <kernel@kolivas.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
Date: Fri, 10 Feb 2006 11:56:08 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>, Paul Jackson <pj@sgi.com>
References: <200602092339.49719.kernel@kolivas.org> <43EBE3AB.1010009@jp.fujitsu.com>
In-Reply-To: <43EBE3AB.1010009@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101156.09326.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 11:51, KAMEZAWA Hiroyuki wrote:
> Hi,
>
> Con Kolivas wrote:
> > +void add_to_swapped_list(struct page *page)
> > +{
> > +	struct swapped_entry *entry;
> > +	unsigned long index;
> > +
> > +	spin_lock(&swapped.lock);
> > +	if (swapped.count >= swapped.maxcount) {
>
> Assume x86 system with 8G memory, swapped_maxcount is maybe 5G+ here.
> Then, swapped_entry can consume 5G/PAGE_SIZE * 16bytes = 10 M byte more
> slabs from ZONE_NORMAL. Could you add check like this?
> ==
> void add_to_swapped_list(struct page *page)
> {
> 	<snip>
> 	if (!swap_prefetch)
> 		return;
> 	spin_lcok(&spwapped.lock);
> }
> ==

Sure why not. It made testing easier to not stop adding entries to the swapped 
list when it was disabled, but for release your idea makes sense. Thanks for 
the suggestion.

Cheers,
Con
