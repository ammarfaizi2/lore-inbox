Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311739AbSCNTHn>; Thu, 14 Mar 2002 14:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311740AbSCNTHd>; Thu, 14 Mar 2002 14:07:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4367 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311739AbSCNTHV>; Thu, 14 Mar 2002 14:07:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Date: Thu, 14 Mar 2002 19:05:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6qsae$6er$1@penguin.transmeta.com>
In-Reply-To: <20020313085217.GA11658@krispykreme> <460695164.1016001894@[10.10.2.3]> <20020314112725.GA2008@krispykreme> <87wuwfxp25.fsf@fadata.bg>
X-Trace: palladium.transmeta.com 1016132822 8120 127.0.0.1 (14 Mar 2002 19:07:02 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 14 Mar 2002 19:07:02 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <87wuwfxp25.fsf@fadata.bg>,
Momchil Velikov  <velco@fadata.bg> wrote:
>
>Out of curiousity, why there's a need to update the linux page tables ?
>Doesn't pte/pmd/pgd family functions provide enough abstraction in
>order to maintain _only_ the hashed page table ?

No.  The IBM hashed page tables are not page tables at all, they are
really just a bigger 16-way set-associative in-memory TLB. 

You can't actually sanely keep track of VM layout in them.

Those POWER4 machines are wonderful things, but they have a few quirks:

 - it's so expensive that anybody who is slightly price-conscious gets a
   farm of PC's instead. Oh, well.

 - the CPU module alone is something like .5 kilowatts (translation:
   don't expect it in a nice desktop factor, even if you could afford
   it). 

 - IBM nomenclature really is broken. They call disks DASD devices, and
   they call their hash table a page table, and they just confuse
   themselves and everybody else for no good reason.  They number bits
   the wrong way around, for example (and big-endian bitordering really
   _is_ clearly inferior to little-endian, unlike byte-ordering.  Watch
   the _same_ bits in the _same_ register change name in the 32 vs
   64-bit architecture manuals, and puke)

But with all their faults, they do have this really studly setup with 8
big, fast CPU's on a single module. A few of those modules and you get
some ass-kick performance numbers. As you can see.

		Linus
