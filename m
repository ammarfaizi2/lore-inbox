Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbRFFIdI>; Wed, 6 Jun 2001 04:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbRFFIc6>; Wed, 6 Jun 2001 04:32:58 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:24839 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263405AbRFFIcs>;
	Wed, 6 Jun 2001 04:32:48 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106060832.f568WR3253749@saturn.cs.uml.edu>
Subject: Re: Missing cache flush.
To: davem@redhat.com (David S. Miller)
Date: Wed, 6 Jun 2001 04:32:27 -0400 (EDT)
Cc: dwmw2@infradead.org (David Woodhouse), cw@f00f.org (Chris Wedgwood),
        jgarzik@mandrakesoft.com (Jeff Garzik), bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <15132.54565.311995.865807@pizda.ninka.net> from "David S. Miller" at Jun 05, 2001 05:48:37 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> David Woodhouse writes:

>>> Call it flush_ecache_full() or something.
>>
>> Strange name. Why? How about __flush_cache_range()?
>
> How about flush_cache_range_force() instead?
>
> I want something in the name that tells the reader "this flushes
> the caches, even though under every other ordinary circumstance
> you would not need to".

"flush" means what to you?

write-back
write-back-and-invalidate
discard-and-invalidate

All 3 behaviors are useful to me, and a few more. I've been
using chunks of PowerPC assembly. Using PowerPC mnemonics...

dcba -- allocate a cache block with undefined content
dcbf -- write to RAM, then invalidate ("data cache block flush")
dcbi -- invalidate, discarding any data
dcbst -- initiate write if dirty
dcbt -- prefetch, hinting about future load instructions
dcbtst -- prefetch, hinting about future store instructions
dcbz -- allocate and zero a cache block (cacheable mem only!)

So dcbf_range() and dcbi_range() sound good to me. :-)
