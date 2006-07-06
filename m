Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWGFTiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWGFTiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWGFTiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:38:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21450 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750761AbWGFTiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:38:22 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AD658A.5070005@nortel.com>
References: <20060705114630.GA3134@elte.hu>
	 <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu>
	 <20060705131824.52fa20ec.akpm@osdl.org>
	 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	 <20060705204727.GA16615@elte.hu>
	 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	 <20060705214502.GA27597@elte.hu>
	 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	 <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	 <20060706081639.GA24179@elte.hu>
	 <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	 <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca>
	 <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org>
	 <44AD658A.5070005@nortel.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 21:38:11 +0200
Message-Id: <1152214692.3084.95.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 13:33 -0600, Chris Friesen wrote:
> Linus Torvalds wrote:
> 
> > On Thu, 6 Jul 2006, Mark Lord wrote:
> 
> >> A volatile declaration may be used to describe an object corresponding
> >> to a memory-mapped input/output port or an object accessed by an
> >> aysnchronously interrupting function.  Actions on objects so declared
> >> shall not be "optimized out" by an implementation or reordered except
> >> as permitted by the rules for evaluating expressions.
> > 
> > 
> > Note that the "reordered" is totally pointless.
> > 
> > The _hardware_ will re-order accesses. Which is the whole point. 
> > "volatile" is basically never sufficient in itself.
> 
> The "reordered" thing really only matters on SMP machines, no?  In which 
> case (for userspace) the locking mechanisms (mutexes, etc.) should do 
> The Right Thing to ensure visibility between cpus.
> 
> The C standard requires the use of volatile for signal handlers and setjmp.
> 
> For userspace at least the whole discussion of "barriers" is sort of 
> moot--there are no memory barriers defined in the C language, which 
> makes it kind of hard to write portable code that uses them.

You're falling into RBJ's trap. I did not say *MEMORY BARRIER*. While
for some uses of "volatile" that is the right substitute, for others it
is *optimization barrier* which matters. 


