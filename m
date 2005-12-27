Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVL0NPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVL0NPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 08:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVL0NPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 08:15:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11408 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751106AbVL0NPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 08:15:20 -0500
Date: Tue, 27 Dec 2005 14:15:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] mutex subsystem: trylock
Message-ID: <20051227131501.GA29134@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain> <1135685158.2926.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135685158.2926.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > + * 1) if the exclusive store fails we fail, and
> > + *
> > + * 2) if the decremented value is not zero we don't even attempt the store.
> 
> 
> btw I really think that 1) is wrong. trylock should do everything it 
> can to get the semaphore short of sleeping. Just because some 
> cacheline got written to (which might even be shared!) in the middle 
> of the atomic op is not a good enough reason to fail the trylock imho. 
> Going into the slowpath.. fine. But here it's a quality of 
> implementation issue; you COULD get the semaphore without sleeping (at 
> least probably, you'd have to retry to know for sure) but because 
> something wrote to the same cacheline as the lock... no. that's just 
> not good enough.. sorry.

point. I solved this in my tree by calling the generic trylock <fn> if 
there's an __ex_flag failure in the ARMv6 case. Should be rare (and thus 
the call is under unlikely()), and should thus still enable the fast 
implementation.

	Ingo
