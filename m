Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292961AbSCDWrL>; Mon, 4 Mar 2002 17:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292960AbSCDWqw>; Mon, 4 Mar 2002 17:46:52 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:8601 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292952AbSCDWqn>;
	Mon, 4 Mar 2002 17:46:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre1aa1
Date: Mon, 4 Mar 2002 23:38:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Bill Davidsen <davidsen@tmr.com>,
        Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com> <20020304191942.M20606@dualathlon.random> <204440000.1015268171@flay>
In-Reply-To: <204440000.1015268171@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16i162-0000gg-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 07:56 pm, Martin J. Bligh wrote:
> >> 1) We can balance between zones easier by "swapping out"
> >> pages to another zone.
> > 
> > Yes, operations like "now migrate and bind this task to a certain
> > cpu/mem pair" pretty much needs rmap or it will get the same complexity
> > of swapout, that may be very very slow with lots of vm address space
> > mapped. But this has nothing to do with the swap_out pass we were
> > talking about previously.
> 
> If we're out of memory on one node, and have free memory on another,
> during the swap-out pass it would be quicker to transfer the page to
> another node, ie "swap out the page to another zone" rather than swap
> it out to disk. This is what I mean by the above comment (though you're
> right, it helps with the more esoteric case of deliberate page migration too),
> though I probably phrased it badly enough to make it incomprehensible ;-)
> 
> I guess could this help with non-NUMA architectures too - if ZONE_NORMAL
> is full, and ZONE_HIGHMEM has free pages, it would be nice to be able
> to scan ZONE_NORMAL, and transfer pages to ZONE_HIGHMEM. In
> reality, I suspect this won't be so useful, as there shouldn't be HIGHEM
> capable page data sitting in ZONE_NORMAL unless ZONE_HIGHMEM
> had been full at some point in the past?

That's the normal case when the cache is loaded up.

> And I'm not sure if we keep a bit
> to say where the page could have been allocated from or not ?

No, we don't record the gfp_mask or, in the case of discontigmem, the
zonelist.  Perhaps this information could be recovered from the mapping, or
lack of it.  I don't know how you'd deduce that a page was required to be
in zone_dma, for example, without specifically remembering that at
page_alloc time.

-- 
Daniel
