Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293756AbSCFTGG>; Wed, 6 Mar 2002 14:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310123AbSCFTF4>; Wed, 6 Mar 2002 14:05:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:517 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293756AbSCFTFp>;
	Wed, 6 Mar 2002 14:05:45 -0500
Message-ID: <3C866821.6DF3F65C@zip.com.au>
Date: Wed, 06 Mar 2002 11:04:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bulent Abali <abali@us.ibm.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct page shrinkage
In-Reply-To: <OFC19C560E.A00F9111-ON85256B74.006633D4@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bulent Abali wrote:
> 
> extern struct page_state {
>              unsigned long nr_dirty;
>              unsigned long nr_locked;
> } ____cacheline_aligned page_states[NR_CPUS];
> 
> This is perfect.   Looks like, if a run summation over all the CPUs I will
> get the total locked and dirty pages, provided mm.h macros are respected.

That's correct.  And the mm.h macros *are* respected.  That patch
ensures that they are.

It goes as far as to rename PG_locked and PG_dirty to PG_locked_dontuse
and PG_dirty_dontuse.

I'll be adding page_cache_size to the above struct, at least.

The "run summation" function is already there, btw: get_page_state().

> What is the outlook for inclusion of this patch in the main kernel?  Do you
> plan to submit or have been included yet?

Well it's all a part of a work to aggressively improve the efficiency
of regular file I/O.  I don't know if the big grand plan will be successful
yet.  At this time, it's thumbs up - way up.

Nor do I know if this is a direction in which Linus wishes to take
his kernel.

But this change, the readahead changes, the pdflush pool and a few other
pieces I have planned are probably appropriate for the base kernel
irrespective of the end outcome.

We'll see...

-
