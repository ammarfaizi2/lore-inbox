Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314230AbSEBCfE>; Wed, 1 May 2002 22:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314231AbSEBCfD>; Wed, 1 May 2002 22:35:03 -0400
Received: from holomorphy.com ([66.224.33.161]:33236 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314230AbSEBCfD>;
	Wed, 1 May 2002 22:35:03 -0400
Date: Wed, 1 May 2002 19:33:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502023350.GE32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Anton Blanchard <anton@samba.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172j1d-0001rS-00@starship> <20020502014504.GD32767@holomorphy.com> <E172jRy-0001rq-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 03:45, William Lee Irwin III wrote:
>> I remember suggesting a sorted array of extents on which binary
>> search could be performed. A B-tree seems unlikely but perhaps if
>> it were contiguously allocated and some other tricks done it might
>> do, maybe I don't remember the special sauce used for the occasion.

On Wed, May 01, 2002 at 04:02:33AM +0200, Daniel Phillips wrote:
> Thanks for the correction.  When you said 'extents' I automatically thought
> 'btree of extents'.  I'd tend to go for the hash table anyway - your binary
> search is going to take quite a few more steps to terminate than the bucket
> search, given some reasonable choice of hash table size.

It's probably motivated more by sheer terror of another huge hash table
sized proportional to memory eating the kernel virtual address space
alive than anything else. I probably should have used reverse psychology
instead. I should note that the size of the array I suggested is not
proportional to memory, only to the number of fragments. It would
probably only have a distinct advantage in a situation where both the
fragment sizes and distributions are irregular; when the number of
fragments is in fact proportional to memory it gains little aside from
a small factor of compactness and/or in-core contiguity. The hashing
techniques that seem obvious to me effectively require some sort of
objects to back a direct mapping, which translates to per-page overhead,
which I'm very very picky about. I also like things to behave gracefully
about space and time when faced with irregular or "hostile" layouts.

Actually, now that I think about it, a contiguously-allocated B-tree of
extents doesn't sound bad at all, even without additional dressing. Do
you think it's worth a try?

Cheers,
Bill
