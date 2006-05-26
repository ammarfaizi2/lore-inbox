Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWEZJl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWEZJl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWEZJl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:41:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27567 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751353AbWEZJl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:41:27 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Date: Fri, 26 May 2006 11:39:21 +0200
User-Agent: KMail/1.9.1
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de> <20060526085916.GA14388@elte.hu>
In-Reply-To: <20060526085916.GA14388@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261139.22193.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 10:59, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > 
> > > This patch adds the base support for the kernel memory leak detector. It
> > > traces the memory allocation/freeing in a way similar to the Boehm's
> > > conservative garbage collector, the difference being that the orphan
> > > pointers are not freed but only shown in /proc/memleak. Enabling this
> > > feature would introduce an overhead to memory allocations.
> > 
> > Interesting approach. Did you actually find any leaks with this?
> 
> we should be very careful here, since 'low hanging fruit' memory leaks 
> have already been clean-sweeped by a proprietary tool (Coverity), so the 
> utility of this free (GPL-ed) tool is artificially depressed!

It should be more. A real dynamic GC can find much larger
classes of leaks than even the best static checker.

iirc Coverty mostly just found missing free()s in error handling paths.
Which is surely nice, but in practice most of these error handling cases only occur 
rarely if at all.
 
> What kmemleak will find are all the cases that Coverity does not check: 
> developer's own trees, uncommon architectures/drivers.

> Also, kmemleak guarantees (assuming the implementation is correct) that 
> if a leak happens in practice, it will be detected immediately. 

Not if the slab object is reused quickly - which it often is.

That is why I think it would at least need some tweaks to slab to make
the reuse times longer.

>All in one, i'm very much in favor of adding kmemleak to the upstream 
>kernel, once it gets clean enough and has seen some exposure on -mm.

Yes.

-Andi
