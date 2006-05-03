Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWECU4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWECU4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWECU4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:56:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60388 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751103AbWECU4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:56:30 -0400
Date: Wed, 3 May 2006 23:01:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] revert bh_lru_lock() to preempt_disable()
Message-ID: <20060503210125.GB16696@elte.hu>
References: <200604221505.k3MF5mql022083@dwalker1.mvista.com> <20060503204747.GC15965@elte.hu> <1146689257.3363.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146689257.3363.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > i agree that this is a problem, but the fix is incorrect. What would be 
> > the right approach is to convert the PER_CPU bh_lrus to PER_CPU_LOCKED, 
> > and to use the appropriate primitives to use them. That automatically 
> > makes this code rt-safe. (it isnt right now)
> 
> Hmm, in UP it should be safe to access per cpu data under either a 
> preempt_disable or local_irq_disable . I'm not sure how RT changes 
> that .. Is there some other part of the code that isn't rt-safe, which 
> I've overlooked ?

hm, you are right - that code can be in a preempt-off section. I've 
applied your patch.

	Ingo
