Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273324AbRIWJqm>; Sun, 23 Sep 2001 05:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRIWJqd>; Sun, 23 Sep 2001 05:46:33 -0400
Received: from colorfullife.com ([216.156.138.34]:50954 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273324AbRIWJqU>;
	Sun, 23 Sep 2001 05:46:20 -0400
X-Mozilla-Status: 0801
Message-ID: <3BADAF6A.8090400@colorfullife.com>
Date: Sun, 23 Sep 2001 11:46:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010725
X-Accept-Language: en-us
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre13aa1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> with only the dirty bit set?  Does somebody know for sure? I can
 >> imagine the cpu finding the tlb state writeable, and issuing
 >> just a locked bit test and set in the pte without caring to
 >> check if the pte is zero or not.
 >>
 >> If the cpu just set the bit this patch will avoid to lose a shared
 >> mapping update. Otherwise it's a safe noop so I keep it applied
 >> until this issue is sorted out
 >
 >I've tested this on all the machines I could get my hands on, and every
 >single CPU will take a page fault if the pte is not present on dirtying
 >the page.  If people are truely paranoid, then make it a boot time
 > assertion.
 >

I don't think that this is a valid argument:
you are testing on i386 and make design decisions for the architecture
independant part.

I'd prefer ptep_get_and_clear_and_flush(), then the arch part can do
what's needed to get the final pte value. (if a single page is modified,
otherwise the arch can define a suitable mmu_gather)

--
     Manfred



