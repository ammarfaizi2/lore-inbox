Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVL2TmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVL2TmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVL2TmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:42:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:41389 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750923AbVL2TmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:42:17 -0500
Date: Thu, 29 Dec 2005 20:41:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] updates XFS mutex patch
Message-ID: <20051229194153.GA27897@elte.hu>
References: <yq0zmmktbhk.fsf@jaguar.mkp.net> <20051229144824.GC18833@infradead.org> <20051229165811.GA23502@elte.hu> <20051229171135.GA21988@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229171135.GA21988@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > > It's say just switch XFS to the one-arg mutex_init variant.
> > > 
> > > And ingo. please add the mutex_t typedef, analogue to spinlock_t it's 
> > > a totally opaqueue to the users type, so it really should be a 
> > > typedef.  After that the XFS mutex.h can just go away.
> > 
> > that's not possible, due to DEFINE_MUTEX() and due to struct mutex being 
> > embedded in other structures. I dont think we want to lose that property 
> > of struct semaphore, and only restrict mutex usage to pointers.
> 
> Sorry, but I don't get this sentence at all.  Can you try to rephrase 
> it? What does DEFINE_MUTEX have to do with declaring either a typedef 
> or structure?

i think i misunderstood you. I thought you wanted a mutex_t a'la 
kmem_cache_t (which is only fully defined in mm/slab.c) - for the 
purpose of hiding the implementation of mutex_t. If the implementation 
of mutex_t is still present in mutex.h, i dont see what the advantage 
is. What's the difference between 'struct mutex' and 'mutex_t', besides 
that first one being clearer that here we have a kernel object? (we 
generally use the _t types for type-safe variations of integer types, 
e.g. pte_t.)

	Ingo
