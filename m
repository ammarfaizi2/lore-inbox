Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273626AbRIURSq>; Fri, 21 Sep 2001 13:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273668AbRIURSg>; Fri, 21 Sep 2001 13:18:36 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:21214 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273626AbRIURSR>; Fri, 21 Sep 2001 13:18:17 -0400
Date: Fri, 21 Sep 2001 13:18:41 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre13aa1
Message-ID: <20010921131841.A15773@redhat.com>
In-Reply-To: <20010921095721.A725@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921095721.A725@athlon.random>; from andrea@suse.de on Fri, Sep 21, 2001 at 09:57:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 09:57:21AM +0200, Andrea Arcangeli wrote:
> Only in 2.4.10pre13aa1: 00_unmap-dirty-pte-1
> 
> 	I grepped over the whole 600 pages of the latest x86 system developer
> 	manual and I couldn't find the proof that I'm wrong.
> 
> 	We can have pagecache pages with pte writeable and non dirty at some
> 	point.
> 
> 	Now what happens if the userspace task in the other cpu touches the
> 	writeable page between our "ptep_get_and_clear" and the
> 	"flush_tlb_page"? Is the resulting pte still zero and the task get into
> 	a page fault? Or as I am worried it could also just end with the pte
> 	with only the dirty bit set?  Does somebody know for sure? I can
> 	imagine the cpu finding the tlb state writeable, and issuing just a
> 	locked bit test and set in the pte without caring to check if the pte
> 	is zero or not.
> 
> 	If the cpu just set the bit this patch will avoid to lose a shared
> 	mapping update. Otherwise it's a safe noop so I keep it applied
> 	until this issue is sorted out.

I've tested this on all the machines I could get my hands on, and every 
single CPU will take a page fault if the pte is not present on dirtying 
the page.  If people are truely paranoid, then make it a boot time assertion.

		-ben
