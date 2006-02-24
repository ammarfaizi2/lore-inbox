Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWBXMdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWBXMdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBXMdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:33:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:53913 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932156AbWBXMdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:33:31 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Date: Fri, 24 Feb 2006 13:33:15 +0100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@intel.linux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <20060224064912.GB7243@elte.hu> <43FEAF52.80705@yahoo.com.au>
In-Reply-To: <43FEAF52.80705@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241333.16190.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 08:01, Nick Piggin wrote:

> 
> Yeah, as I said above, the newly allocated page is fine, it is the
> page table pages I'm worried about.

page tables are easy because we zero them on free (as a side effect
of all the pte_clears)

I did a experimental hack some time ago to set a new struct page
flag when a page is known to be zeroed on freeing and use that for 
a GFP_ZERO allocation (basically skip the clear_page when that
flag was set)

The idea was to generalize the old page table reuse caches which
Ingo removed at some point.

It only works of course if the allocations and freeing
of page tables roughly matches up. In theory on could have
split the lists of the buddy allocator too into zero/non
zero pages to increase the hit rate, but I didn't attempt this.

I unfortunately don't remember the outcome, dropped it for some reason. 

-Andi

