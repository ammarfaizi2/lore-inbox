Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVFQDmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVFQDmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 23:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVFQDmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 23:42:37 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:50307 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261912AbVFQDme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 23:42:34 -0400
Subject: Re: [patch] vm early reclaim orphaned pages
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, andrea@suse.de, mason@suse.de
In-Reply-To: <20050616203446.796473a7.akpm@osdl.org>
References: <1118978590.5261.4.camel@npiggin-nld.site>
	 <20050616203446.796473a7.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 13:42:29 +1000
Message-Id: <1118979750.5261.12.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-16 at 20:34 -0700, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >  We have workloads where orphaned pages build up and appear to slow
> >  the system down when it starts reclaiming memory.
> > 
> >  Stripping the referenced bit from orphaned pages and putting them
> >  on the end of the inactive list should help improve reclaim.
> 
> Presumably if do_invalidatepage() failed, there's some reason why this page
> is not reclaimable (eg, JBD is still dinking with it).  Hence there's a
> very good chance that kswapd won't be able to reclaim it either.
> 

Yeah that is a problem I was worried about. Perhaps just stripping
PageReferenced and putting it on the *front* of the inactive list
would be better?

> Adding some instrumentation would be useful: set some new page flag on
> these pages and then accumulate the success/failure stats in vmscan.c, see
> what they say.
> 

OK.

[snip patch]

> A standalone function in swap.c would be nicer.

Will do. Thanks.


-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
