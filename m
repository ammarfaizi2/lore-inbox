Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSJ2Dvp>; Mon, 28 Oct 2002 22:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSJ2Dvp>; Mon, 28 Oct 2002 22:51:45 -0500
Received: from alpha8.cc.monash.edu.au ([130.194.1.8]:61964 "EHLO
	ALPHA8.CC.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S261522AbSJ2Dvo>; Mon, 28 Oct 2002 22:51:44 -0500
Date: Tue, 29 Oct 2002 14:04:42 +1100 (EST)
From: netdev-bounce@oss.sgi.com
To: undisclosed-recipients:;
Message-id: <20021029030442.437EE12D03E@blammo.its.monash.edu.au>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > 905182 total                                      0.4741
> > 121426 csum_partial_copy_generic                474.3203
>
> Well, maybe take a look at this func and try to optimize it?

I don't know assembly that good - sorry.

> >  93633 default_idle                             1800.6346
> >  74665 do_wp_page                               111.1086
>
> What's this?

do_wp_page is Defined as a function in: mm/memory.c

comments from the file:

/*
 * This routine handles present pages, when users try to write
 * to a shared page. It is done by copying the page to a new address
 * and decrementing the shared-page counter for the old page.
 *
 * Goto-purists beware: the only reason for goto's here is that it results
 * in better assembly code.. The "default" path will see no jumps at all.
 *
 * Note that this routine assumes that the protection checks have been
 * done by the caller (the low-level page fault routine in most cases).
 * Thus we can safely just mark it writable once we've done any necessary
 * COW.
 *
 * We also mark the page dirty at this point even though the page will
 * change only once the write actually happens. This avoids a few races,
 * and potentially makes it more efficient.
 *
 * We hold the mm semaphore and the page_table_lock on entry and exit
 * with the page_table_lock released.
 */

>
> >  65857 ide_intr                                 184.9916
>
> You have 1 ide_intr per 2 csum_partial_copy_generic... hmmm...
> how large is your readahead? I assume you'd like to fetch
> more sectors from ide per interrupt. (I hope you do DMA ;)

doing DMA - RAID-0 with 1MB chunk size on 4 disks.

> >  53636 handle_IRQ_event                         432.5484
> >  21973 do_softirq                               107.7108
> >  20498 e1000_intr                               244.0238
>
> I know zero about networking, but why 120 000 csum_partial_copy_generic
> and inly 20 000 nic interrupts? That may be abnormal.

sorry
I don't know

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.



