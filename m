Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWIHIbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWIHIbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 04:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWIHIbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 04:31:12 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:8504 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751035AbWIHIbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 04:31:10 -0400
Subject: Re: [PATCH 0/8] Avoiding fragmentation with subzone groupings v25
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060907175848.63379fe1.akpm@osdl.org>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
	 <20060907175848.63379fe1.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 10:30:32 +0200
Message-Id: <1157704232.17799.48.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 17:58 -0700, Andrew Morton wrote:
> On Thu,  7 Sep 2006 20:03:42 +0100 (IST)
> Mel Gorman <mel@csn.ul.ie> wrote:
> 
> > When a page is allocated, the page-flags
> > are updated with a value indicating it's type of reclaimability so that it
> > is placed on the correct list on free.
> 
> We're getting awful tight on page-flags.
> 
> Would it be possible to avoid adding the flag?  Say, have a per-zone bitmap
> of size (zone->present_pages/(1<<MAX_ORDER)) bits, then do a lookup in
> there to work out whether a particular page is within a MAX_ORDER clump of
> easy-reclaimable pages?

That would not actually work, the fallback allocation path can move
blocks smaller than MAX_ORDER to another recaim type.

But yeah, page flags are getting right, perhaps Rafael can use his
recently introduced bitmaps to rid us of the swsusp flags?


