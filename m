Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423012AbWBOITk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423012AbWBOITk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423034AbWBOITk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:19:40 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:30543 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1423012AbWBOITj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:19:39 -0500
Subject: Re: + vmscan-rename-functions.patch added to -mm tree
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, christoph@lameter.com
In-Reply-To: <43F29B84.6020009@yahoo.com.au>
References: <200602120605.k1C65QFE028051@shell0.pdx.osdl.net>
	 <2cd57c900602141847m7af4ec7ap@mail.gmail.com>
	 <43F29B84.6020009@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 07:46:18 +0100
Message-Id: <1139985978.6722.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 14:09 +1100, Nick Piggin wrote:
> Coywolf Qi Hunt wrote:
> > 2006/2/12, akpm@osdl.org <akpm@osdl.org>:
> > 
> >>The patch titled
> >>
> >>     vmscan: rename functions
> >>
> >>has been added to the -mm tree.  Its filename is
> >>
> >>     vmscan-rename-functions.patch
> >>
> >>See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> >>out what to do about this
> >>
> >>
> >>From: Andrew Morton <akpm@osdl.org>
> >>
> >>We have:
> >>
> >>        try_to_free_pages
> >>        ->shrink_caches(struct zone **zones, ..)
> >>          ->shrink_zone(struct zone *, ...)
> >>            ->shrink_cache(struct zone *, ...)
> >>              ->shrink_list(struct list_head *, ...)
> >>
> >>which is fairly irrational.
> >>
> >>Rename things so that we have
> >>
> >>        try_to_free_pages
> >>        ->shrink_zones(struct zone **zones, ..)
> >>          ->shrink_zone(struct zone *, ...)
> >>            ->do_shrink_zone(struct zone *, ...)
> >>              ->shrink_page_list(struct list_head *, ...)
> > 
> > 
> > Every time I read this part it annoys me. Thanks.
> 
> I don't much care, but if there is renaming afoot, I'd vote for
> 
> ->shrink_zones(struct zone **zones, ..)
>   ->shrink_zone(struct zone *, ...)
>    ->shrink_inactive_list(struct zone *, ...)
>     ->shrink_page_list(struct list_head *, ...)
>    ->shrink_active_list (alternatively, leave as refill_inactive_list)
> 
> shrink_zone and do_shrink_zone don't really say any more to me than
> shrink_zone and shrink_cache.

I know not everybody believes in a plugable reclaim policy, but that is
what I'm building. And from that POV I'd rather not see the
active/inactive names get used here.

My vote goes to Coywolf's suggestion.

Peter

