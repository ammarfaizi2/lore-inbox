Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSGPJJU>; Tue, 16 Jul 2002 05:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSGPJJT>; Tue, 16 Jul 2002 05:09:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34574 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311025AbSGPJJT>;
	Tue, 16 Jul 2002 05:09:19 -0400
Message-ID: <3D33E532.E078914E@zip.com.au>
Date: Tue, 16 Jul 2002 02:19:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au> <20020716083142.GQ811@suse.de> <3D33DED8.C5C92C06@zip.com.au> <20020716085233.GA1096@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Jens Axboe wrote:
> >> GFP_NOIO has __GFP_WAIT set, so bio_copy -> bio_alloc -> mempool_alloc
> >> should never fail. Puzzled.
> 
> On Tue, Jul 16, 2002 at 01:52:40AM -0700, Andrew Morton wrote:
> > Presumably the loop driver was called from within shrink_cache(),
> > as PF_MEMALLOC.  Those allocations can fail.
> > That's maybe wrong - if there are a decent number of pages
> > under writeback then we should be able to just wait it out.
> > But it gets tricky with the loop driver...
> 
> I included a backtrace in my original post showing that the allocation
> failure did indeed occur beneath shrink_cache().
> 
> >From watching /proc/meminfo it was clear that there were only 1MB or
> 2MB under writeback, but it also showed that the dirty memory thresholds
> were being exceeded.

Ah, that may well happen with loop.  Mark a page clean, "submit"
it and that just goes and marks a different page dirty.

If you could please share the setup details (amount of memory,
file sizes, workload etc) I'll have a look.

btw, Jens: where do the pages which bio_copy allocates get freed?

-
