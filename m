Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272358AbRIKSmC>; Tue, 11 Sep 2001 14:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272527AbRIKSlw>; Tue, 11 Sep 2001 14:41:52 -0400
Received: from colorfullife.com ([216.156.138.34]:34064 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272358AbRIKSlm>;
	Tue, 11 Sep 2001 14:41:42 -0400
Message-ID: <004101c13af1$6c099060$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        <torvalds@transmeta.com>
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com> <20010909162613.Q11329@athlon.random> <001201c13942$b1bec9a0$010411ac@local> <20010909173313.V11329@athlon.random>
Subject: Re: Purpose of the mm/slab.c changes
Date: Tue, 11 Sep 2001 20:41:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the cleanup
I'm sure you read of this comment in page_alloc.c:
* Buddy system. Hairy. You really aren't expected to understand this
*
* Hint: -mask = 1+~mask

and the slab allocator must sustain more 10 times more allocations/sec:
from lse netbench on sourceforge, 4-cpu, ext2, one minute:
    4 million kmallocs,
    5 million kmem_cache_alloc
    721 000 rmqueue
slab.c doesn't need to be simple, it must be fast.

> and the potential for lifo in the free slabs is much more
> sensible than the other factors you mentioned, of course there's less
> probability of having to fall into the free slabs rather than in the
> partial ones during allocations, but that doesn't mean that cannot
> happen very often, but I will glady suggest to remove it if you prove
> me wrong.

Ok, so you agree that your changes are only beneficial in one case:

kmem_cache_free(), uniprocessor or SMP not-per-cpu cached.
* frees one object
* after that free-operation no further slabs with allocated objects are
left - only full and free slabs.

Your code ensures that the next object returned will be the previously
freed object, my code doesn't guarantee that.

If I can modify my slab allocator to guarantee it, you'd drop your
patch?

--
    Manfred



