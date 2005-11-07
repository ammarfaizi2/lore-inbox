Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVKGCIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVKGCIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 21:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVKGCIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 21:08:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932404AbVKGCIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 21:08:39 -0500
Date: Sun, 6 Nov 2005 18:08:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Stoffel <john@stoffel.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Best CPU chipset for Linux? (was: [Lhms-devel] [PATCH 0/7]
 Fragmentation Avoidance V19)
In-Reply-To: <17262.44501.595440.472947@smtp.charter.net>
Message-ID: <Pine.LNX.4.64.0511061750360.3316@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com>
 <20051104063820.GA19505@elte.hu> <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
 <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com> <Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
 <Pine.LNX.4.64.0511060848010.3316@g5.osdl.org> <17262.44501.595440.472947@smtp.charter.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Nov 2005, John Stoffel wrote:
> 
> Has any vendor come close to the ideal CPU architecture for an OS?  I
> would assume that you'd want:

Well, in the end, the #1 requirement ends up being "wide availability of 
development boxes".

For example, I think Apple made a huge difference to the PowerPC platform, 
and we'll see what happens when Apple boxes are x86. Can IBM continue to 
make Power available enough to be relevant.

Note that raw numbers of CPU's don't much matter - ARM sells a lot more 
than x86, but it's not to developers. Similarly, the game consoles may 
sell a lot of Power, but the actual developers that are using it is a very 
specialized bunch and much smaller in number.

> 	1. large address space, 64 bits
> 	2. large IO space, 64 bits
> 	3. high memory/io bandwidth
> 	4. efficient locking primitives?
> 	   - keep some registers for locking only?
> 	5. efficient memory bandwidth?
> 	6. simple setup where you don't need so much legacy cruft?
> 	7. clean CPU design?  RISC?  Is CISC king again?
> 	8. Variable page sizes?
> 	   - how does this affect TLB?
> 	   - how do you change sizes in a program?
>         9. SMP or hyper-threading or multi-cores?	   
>        10. PCI (and it's flavors) addressing/DMA support?

It's personal, but I don't think the above are huge deal-breakers.

We do want a "big enough" virtual address space, that's pretty much 
required. It doesn't necessarily have to be the full 64 bits, and it's 
fine if the IO space is just a part of that.

As to ISA and registers - nobody much cares. The compiler takes care of 
it, and I'd personally _much_ rather see a common ISA than a "clean" one. 
The x86 architecture may be odd, but it works well.

So the ISA doesn't matter that much, but from a microarchitectural 
standpoint:

 - fast large first-level caches help a lot. And I'd rather take a bigger 
   L1 that has a two- or even three-cycle latency than a small one. That's 
   assuming the uarch is out-of-order, of course.

 - good fast L2, and I'll take low-latency memory access over an L3 any 
   day. 

 - low-latency serialization (locking and memory barriers). In fact, 
   pretty much low-latency everything (branch mispredict latency etc). 

 - cheap and powerful.

but the fact is, we'll work with pretty much any crap we're given. If it's 
bad, it won't make it in the marketplace.

		Linus
