Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVLDTKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVLDTKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVLDTKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:10:33 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.27]:51264 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932282AbVLDTKd (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 4 Dec 2005 14:10:33 -0500
Subject: Re: [PATCH 01/16] mm: delayed page activation
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <17299.1331.368159.374754@gargle.gargle.HOWL>
References: <20051203071444.260068000@localhost.localdomain>
	 <20051203071609.755741000@localhost.localdomain>
	 <17298.56560.78408.693927@gargle.gargle.HOWL>
	 <20051204134818.GA4305@mail.ustc.edu.cn>
	 <17299.1331.368159.374754@gargle.gargle.HOWL>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 20:10:23 +0100
Message-Id: <1133723423.27985.10.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 18:03 +0300, Nikita Danilov wrote:
> Wu Fengguang writes:
>  > On Sun, Dec 04, 2005 at 03:11:28PM +0300, Nikita Danilov wrote:
>  > > Wu Fengguang writes:
>  > >  > When a page is referenced the second time in inactive_list, mark it with
>  > >  > PG_activate instead of moving it into active_list immediately. The actual
>  > >  > moving work is delayed to vmscan time.
>  > >  > 
>  > >  > This implies two essential changes:
>  > >  > - keeps the adjecency of pages in lru;
>  > > 
>  > > But this change destroys LRU ordering: at the time when shrink_list()
>  > > inspects PG_activate bit, information about order in which
>  > > mark_page_accessed() was called against pages is lost. E.g., suppose
>  > 
>  > Thanks.
>  > But this order of re-access time may be pointless. In fact the original
>  > mark_page_accessed() is doing another inversion: inversion of page lifetime.
>  > In the word of CLOCK-Pro, a page first being re-accessed has lower
> 
> The brave new world of CLOCK-Pro is still yet to happen, right?

Well, I have an implementation that is showing very promising results. I
plan to polish the code a bit and post the code somewhere this week.
(current state available at: http://linux-mm.org/PeterZClockPro2)

>  > inter-reference distance, and therefore should be better protected(if ignore
>  > possible read-ahead effects). If we move re-accessed pages immediately into
>  > active_list, we are pushing them closer to danger of eviction.
> 
> Huh? Pages in the active list are closer to the eviction? If it is
> really so, then CLOCK-pro hijacks the meaning of active list in a very
> unintuitive way. In the current MM active list is supposed to contain
> hot pages that will be evicted last.

Actually, CLOCK-pro does not have an active list. Pure CLOCK-pro has but
one clock. It is possible to create approximations that have more
lists/clocks, and in those the meaning of active list are indeed
somewhat different, but I agree with nikita here, this is odd.

> Anyway, these issues should be addressed in CLOCK-pro
> implementation. Current MM tries hard to maintain LRU approximation in
> both active and inactive lists.

nod.


Peter Zijlstra
(he who has dedicated his spare time to the eradication of LRU ;-)
 


