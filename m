Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVKGB3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVKGB3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 20:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKGB3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 20:29:04 -0500
Received: from mxsf38.cluster1.charter.net ([209.225.28.165]:60369 "EHLO
	mxsf38.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932131AbVKGB3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 20:29:03 -0500
X-IronPort-AV: i="3.97,298,1125892800"; 
   d="scan'208"; a="1697775765:sNHT315257100"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.44501.595440.472947@smtp.charter.net>
Date: Sun, 6 Nov 2005 20:28:53 -0500
From: "John Stoffel" <john@stoffel.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Best CPU chipset for Linux? (was: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19)
In-Reply-To: <Pine.LNX.4.64.0511060848010.3316@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	<Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
	<20051103221037.33ae0f53.pj@sgi.com>
	<20051104063820.GA19505@elte.hu>
	<Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
	<796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>
	<Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
	<Pine.LNX.4.64.0511060848010.3316@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> On Sun, 6 Nov 2005, Linus Torvalds wrote:
>> 
>> And no standard hardware allows you to do that in hw, so we'd end up doing 
>> a software page table walk for it (or, more likely, we'd have to make 
>> "struct page" bigger).
>> 
>> You could do it today, although at a pretty high cost. And you'd have to 
>> forget about supporting any hardware that really wants contiguous memory 
>> for DMA (sound cards etc). It just isn't worth it.

Linus> Btw, in case it wasn't clear: the cost of these kinds of things
Linus> in the kernel is usually not so much the actual "lookup"
Linus> (whether with hw assist or with another field in the "struct
Linus> page").

Linus> The biggest cost of almost everything in the kernel these days
Linus> is the extra code-footprint of yet another abstraction, and the
Linus> locking cost.

Linus> For example, the real cost of the highmem mapping seems to be
Linus> almost _all_ in the locking. It also makes some code-paths more
Linus> complex, so it's yet another I$ fill for the kernel.

This to me raises the interesting question of what are the most wanted
new features of CPUs and their chipsets by the Linux developers?  I
know there are different problem spaces, such as embedded where
power/cost is king, to user desktops to big big clusters.  

Has any vendor come close to the ideal CPU architecture for an OS?  I
would assume that you'd want:

	1. large address space, 64 bits
	2. large IO space, 64 bits
	3. high memory/io bandwidth
	4. efficient locking primitives?
	   - keep some registers for locking only?
	5. efficient memory bandwidth?
	6. simple setup where you don't need so much legacy cruft?
	7. clean CPU design?  RISC?  Is CISC king again?
	8. Variable page sizes?
	   - how does this affect TLB?
	   - how do you change sizes in a program?
        9. SMP or hyper-threading or multi-cores?	   
       10. PCI (and it's flavors) addressing/DMA support?

With the growth in data versus instructions these days, does it make
sense to have memory split into D/I sections?  Or is it better to just
have a completely flat memory model and let the OS do any splitting it
wants?

Heck, I don't know.  I'm just interested in where
Linus/Alan/Andrew/et all think that the low level system design should
think about moving towards since it will make things simpler/faster at
the OS level.  I'm completely ignoring the application level since
it's ideally not going to change much... really.

To me, it seems that some sort of efficient low level locking
primitives that work well in any of UP/SMP/NUMA environments would be
key.  Just looking at all the fine grain locking people are adding to
the kernel to get around all the issues of the BKL over the years.  

Of course making memory faster would be nice too...

I know, it's all out of left field, but it would be interesting to see
what people thought.  I honestly wonder if Intel, AMD, PowerPC, Sun
really try to work from the top down when designing their chips, or
more from "this is where we are, how can we speed up what we've got?"
type of view?  

Thanks,
John
