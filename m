Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVE0M5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVE0M5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVE0M5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:57:23 -0400
Received: from colin.muc.de ([193.149.48.1]:30480 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262465AbVE0M4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:56:37 -0400
Date: 27 May 2005 14:56:30 +0200
Date: Fri, 27 May 2005 14:56:30 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527125630.GE86087@muc.de>
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527124837.GA7253@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 02:48:37PM +0200, Ingo Molnar wrote:
> * Andi Kleen <ak@muc.de> wrote:
> 
> > [...] Even normal kernels must have reasonably good latency, as long 
> > as it doesnt cost unnecessary performance.
> 
> they do get reasonably good latency (within the hard constraints of the 
> possibilities of a given preemption model), due to the cross-effects 
> between the various preemption models, that i explained in detail in 
> earlier mails. Something that directly improves latencies on 
> CONFIG_PREEMPT improves the 'subsystem-use latencies' on PREEMPT_RT.  

I was more thinking of improvements for !PREEMPT.

> Also there's the positive interaction between scalability and latencies 
> as well.

That sound more like bugs that should just be fixed in the main
kernel by more scheduling. Can you give details and examples? 

> 
> but it's certainly not for free. Just like there's no zero-cost
> virtualization, or there's no zero-cost nanokernel approach either,
> there's no zero-cost single-kernel-image deterministic system either.
> 
> and the argument about binary kernels - that's a choice up to vendors

It is not only binary distribution kernels. I always use my own self compiled 
kernels, but I certainly would not want a special kernel just to do something
normal that requires good latency (like sound use).

But that said most Linux users these days use distribution binary kernels,
so we definitely need to take care of them too.

> and users. Right now PREEMPT_NONE is dominant, so do you argue that
> CONFIG_PREEMPT should be removed? It's certainly not zero-cost even on
> the source code, witness all the preempt_disable()/preempt_enable() or
> get_cpu()/put_cpu() uses.

Actually yes I would. AFAIK CONFIG_PREEMPT never improved latency
considerably (from the numbers Ive seen), but it had extreme
cost in the code base (like all this get/put cpu mess and the
impact on RCU was also not pretty) 

So it never seemed very useful to me. May be it would have been
better if it had been made UP only, that would at least have
avoided a lot of issues.

But at least CONFIG_PREEMPT is still reasonably cheap, so it is
not as intrusive as some of the stuff proposed.

-Andi
