Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVIIPZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVIIPZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVIIPZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:25:53 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:50095 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964913AbVIIPZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:25:52 -0400
Date: Fri, 9 Sep 2005 11:27:24 -0400
From: Bob Picco <bob.picco@hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bob Picco <bob.picco@hp.com>
Subject: Re: [PATCH 2.6.13] x86_64: Make trap_init() happen earlier - dropped
Message-ID: <20050909152724.GA8919@localhost.localdomain>
References: <20050908163757.GQ3966@smtp.west.cox.net> <200509091617.40770.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509091617.40770.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:	[Fri Sep 09 2005, 10:17:40AM EDT]
> On Thursday 08 September 2005 18:37, Tom Rini wrote:
> > It can be handy in some situations to have run trap_init() sooner than the
> > generic code does.  In order to do this on x86_64 we need to add a custom
> > early_setup_per_cpu_areas() call as well.
> 
> The patch is totally broken and causes crash even under light load
> (just found it after a lengthy binary search) 
> 
> >
> > +void __init early_setup_per_cpu_areas(void)
> > +{
> > +	static char cpu0[PERCPU_ENOUGH_ROOM] __cacheline_aligned
> > +		__attribute__ ((aligned (SMP_CACHE_BYTES)));
> 
> The original code does
> 
>     /* Copy section for each CPU (we discard the original) */
>         size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
> #ifdef CONFIG_MODULES
>         if (size < PERCPU_ENOUGH_ROOM)
>                 size = PERCPU_ENOUGH_ROOM;
> #endif
> 
> 
> perhaps end-start is larger than PERCPU_ENOUGH_ROOM ? (using defconfig) 
> 
> Dropped from my tree for now.
> 
> -Andi
Andi:

Sorry about that.  I originally intended this for KGDB only. The hardcoded
PERCPU_ENOUGH_ROOM value is dangerous and could be the issue.  Let me take
a look at this.

bob
