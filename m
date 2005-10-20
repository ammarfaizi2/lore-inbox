Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVJTWCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVJTWCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVJTWCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:02:07 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16349 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932539AbVJTWCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:02:05 -0400
Date: Fri, 21 Oct 2005 00:02:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8 bits
Message-ID: <20051020220228.GA26247@elte.hu>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com> <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org> <434BDB1C.60105@cosmosbay.com> <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org> <434BEA0D.9010802@cosmosbay.com> <20051017000343.782d46fc.akpm@osdl.org> <1129533603.2907.12.camel@laptopd505.fenrus.org> <20051020215047.GA24178@elte.hu> <Pine.LNX.4.64.0510201455030.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510201455030.10477@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Thu, 20 Oct 2005, Ingo Molnar wrote:
> >
> > +/*
> > + * We inline the unlock functions in the nondebug case:
> > + */
> > +#ifdef CONFIG_DEBUG_SPINLOCK
> 
> That can't be right. What about preemption etc?
> 
> There's a lot more to spin_unlock() than just the debugging stuff.

the unlock is simple even in the preemption case - it's the _lock that 
gets complicated there. Once there's some attachment to the unlock 
operation (irq restore, or bh enabling) it again makes sense to keep 
things uninlined, but for the specific case of the simple-unlocks, it's 
a 0.2% space win to not inline - mostly from reduced clobbering of %eax, 
%ecx, %edx. Should be less of a win on 64-bit CPUs with enough 
registers.

	Ingo
