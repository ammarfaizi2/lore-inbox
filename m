Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSE0UZe>; Mon, 27 May 2002 16:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSE0UZd>; Mon, 27 May 2002 16:25:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40708 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316755AbSE0UZb>;
	Mon, 27 May 2002 16:25:31 -0400
Message-ID: <3CF29708.C3AF53E1@zip.com.au>
Date: Mon, 27 May 2002 13:28:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: zlatko.calusic@iskon.hr
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.5.18 / ext3 / oracle trouble
In-Reply-To: <877klr2ank.fsf@atlas.iskon.hr> <d6vi836v.fsf@sap.com>
		<3CF1E5CF.2B11258F@zip.com.au> <dnvg9am14i.fsf@magla.zg.iskon.hr> <871ybx4awp.fsf@atlas.iskon.hr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic wrote:
> 
> Zlatko Calusic <zlatko.calusic@iskon.hr> writes:
> >
> > Obviously I need to perform tests on ext2 with swap load, and repeat
> > them few times. Will do this evening (it takes some time to recover a
> > database after a corruption, so it's slightly time consuming).
> >
> 
> And I did get some interesting results. :)
> I found a great test case, rebuilding database after corruption. :)
> 
> It consists of recreation of all tablespaces, initializing data
> dictionary and finally importing useful data. The whole process takes
> between 11 and 14 minutes, depending on the type of FS. It's write
> intensive workload and induces some paging even with 768 MB RAM I
> have. Did I forgot to say that all this is on a SMP machine, dual
> PIII? It might matter.
> 
> And you know what, corruption doesn't depend on the type of FS. It
> happens on both ext2 & ext3. It's just more likely to see it when
> running on ext3.
> 
> Anyway, I managed to pinpoint the problem, it's paging that's the
> culprit. When I turned off my swap partition (swapoff -a), rebuild
> went correctly. So I was right, swapping will get you in
> trouble.

Thanks.  I'll cook up a test for that.

> I also tried to push the machine harder into swap, with artificial
> load (typical malloc() in the loop), and it locked up hard after some
> time (minute or two).
> 
> And during one of the tests on ext3, when machine actually survived,
> just after exiting X I had a welcome message waiting, saying something
> like this:
> 
>  Assertion failure: journal_dirty_metadata() at transaction.c:1146
>  "jh->b_frozen_data == 0"

I've seen them under load with data=journal.  Were you using data=journal
at the time?

-
