Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWGLWZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWGLWZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWGLWZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:25:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49577 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750912AbWGLWY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:24:59 -0400
Date: Thu, 13 Jul 2006 00:19:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712221910.GA12905@elte.hu>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607130006.12705.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Wednesday 12 July 2006 23:07, Ingo Molnar wrote:
> > 
> > * Andi Kleen <ak@suse.de> wrote:
> > 
> > > If the TSC disabling code is taken out the runtime overhead of seccomp 
> > > is also very small because it's only tested in slow paths.
> > 
> > correct. But when i suggested to do precisely that i got a rant from 
> > Andrea of how super duper important it was to disable the TSC for 
> > seccomp ... (which argument is almost total hogwash)
> 
> I wouldn't call it completely hogwash - there was a published paper 
> with a demo of an attack - but still the attack required to so much 
> preparation and advance knowledge of the system that it seemed more of 
> academical value to me. [...]

(certainly - that's why i added the 'almost' qualifier to 'total 
hogwash'.)

> > so i'm going with the simpler path of making seccomp default-off. (which 
> > solves the problem as far as i'm concerned - i.e. no default overhead in 
> > the scheduler.)
> 
> I think without the context switch overhead it's a moderately useful 
> facility. Ok currently near nobody uses it, but having a very 
> lightweight sandbox with simple security semantics and that's easy to 
> use is a useful facility for more secure user space.

yeah. But wouldnt it be nicer to have the same damn thing that also 
improves a vital infrastructure of Linux, namely ptrace? Andrea didnt 
even try to improve ptrace - in fact he actively (and mostly unfairly) 
attacked ptrace, implicitly weakening the security perception of other 
syscall filtering based projects like User Mode Linux. Now what we have 
is the same old ptrace, some context-switch overhead, ~900 bytes of 
bloat and a NIH API. It's a lose-lose scenario IMO ...

> > but Andrea's creative arguments wrt. his decision to not pledge the 
> > seccomp related patent to GPL users makes me worry about whether 
> > this technology is untainted.
> 
> I don't know any details about this, [...]

Andrea wrote:

"If the GPL offered any protection to my system software I would 
 consider it too, but the GPL can't protect software that runs behind 
 the corporate firewall."

see:

 http://marc.theaimsgroup.com/?l=linux-kernel&m=115167947608676&w=2

> [...] but I would generally trust Andrea not to attempt to do anything 
> evil regarding kernel & patents.

firstly, you might trust Andrea, but do you trust the entity that 
actually owns the patent (cpushare.com and its investors)? And even if 
you trusted Andrea, would you trust his heir(s)?

> > another problem is the double standard Andrea's code is enjoying. 
> > Despite good resons to apply the patch, it has not been applied yet, 
> > with no explanation. Again, i request the patch below to be applied 
> > to the upstream kernel.
> 
> I can put in a patch into my tree for the next merge to disable the 
> TSC disable code on i386 too like I did earlier for x86-64.

please do.

	Ingo
