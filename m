Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292777AbSCDTBw>; Mon, 4 Mar 2002 14:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292768AbSCDTBa>; Mon, 4 Mar 2002 14:01:30 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:46261 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292770AbSCDTA2>; Mon, 4 Mar 2002 14:00:28 -0500
Date: Mon, 04 Mar 2002 10:56:11 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <204440000.1015268171@flay>
In-Reply-To: <20020304191942.M20606@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com> <190330000.1015261149@flay> <20020304191942.M20606@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1) We can balance between zones easier by "swapping out"
>> pages to another zone.
> 
> Yes, operations like "now migrate and bind this task to a certain
> cpu/mem pair" pretty much needs rmap or it will get the same complexity
> of swapout, that may be very very slow with lots of vm address space
> mapped. But this has nothing to do with the swap_out pass we were
> talking about previously.

If we're out of memory on one node, and have free memory on another,
during the swap-out pass it would be quicker to transfer the page to
another node, ie "swap out the page to another zone" rather than swap
it out to disk. This is what I mean by the above comment (though you're
right, it helps with the more esoteric case of deliberate page migration too),
though I probably phrased it badly enough to make it incomprehensible ;-)

I guess could this help with non-NUMA architectures too - if ZONE_NORMAL
is full, and ZONE_HIGHMEM has free pages, it would be nice to be able
to scan ZONE_NORMAL, and transfer pages to ZONE_HIGHMEM. In
reality, I suspect this won't be so useful, as there shouldn't be HIGHEM
capable page data sitting in ZONE_NORMAL unless ZONE_HIGHMEM
had been full at some point in the past? And I'm not sure if we keep a bit
to say where the page could have been allocated from or not ?

M.

PS. The rest of your email re: striping twisted my brain out of shape - I'll
have to think about it some more.
