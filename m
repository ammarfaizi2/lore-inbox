Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSAUNRy>; Mon, 21 Jan 2002 08:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSAUNRp>; Mon, 21 Jan 2002 08:17:45 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:4487 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285850AbSAUNRd>;
	Mon, 21 Jan 2002 08:17:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Linux 2.4.18pre3-ac1
Date: Mon, 21 Jan 2002 14:22:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: ebiederm@xmission.com (Eric W. Biederman),
        Rik van Riel <riel@conectiva.com.br>,
        Adam Kropelin <akropel1@rochester.rr.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201140409260.32617-100000@imladris.surriel.com> <E16SVPU-0001dp-00@starship.berlin> <200201210530.g0L5UQu20723@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200201210530.g0L5UQu20723@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SeOk-0001gG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2002 06:30 am, Richard Gooch wrote:
> Daniel Phillips writes:
> > The way I see it, the purpose of lazy page table instantiation is to
> > overcome objections to the reverse pte mapping vm technique that
> > have been expressed in the past, namely the slowdown in dup_mmap
> > inside fork.  I.e., if rmap slows down fork then Linus and Davem are
> > going to veto it, as they've done in the past, because they feel
> > that the as-yet-unproven advantages of physically-based vm scanning
> > doesn't outweigh the easily measurable fork overhead.  Personally, I
> > think that's debatable, but by eliminating the overhead we eliminate
> > the objection, and as far as I know, it's the only serious
> > objection.
> 
> Will lazy page table instantiation speed up fork(2) without rmap?

Yes.

> If so, then you've got a problem, because rmap will still be slower
> than non-rmap. Linus will happily grab any speedup and make that the
> new baseline against which new schemes are compared :-)

Fortunately, rmap and non-rmap will fork at the same speed since in
each case the work will consist of copying just the page directory and
incrementing the use counts of up to 1024 page tables.

Page table instantiation, which happens at fault time, will be slower
for rmap than non-rmap.  However there are offsetting factors that
suggest the bottom line performance will be very similar in unloaded
cases, and will favor rmap under heavy load.

--
Daniel
