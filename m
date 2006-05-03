Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWECVBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWECVBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWECVBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:01:54 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:29160 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751345AbWECVBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:01:53 -0400
Subject: Re: [PATCH -rt] revert bh_lru_lock() to preempt_disable()
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060503210125.GB16696@elte.hu>
References: <200604221505.k3MF5mql022083@dwalker1.mvista.com>
	 <20060503204747.GC15965@elte.hu>
	 <1146689257.3363.13.camel@localhost.localdomain>
	 <20060503210125.GB16696@elte.hu>
Content-Type: text/plain
Date: Wed, 03 May 2006 14:01:51 -0700
Message-Id: <1146690111.3363.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 23:01 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > > i agree that this is a problem, but the fix is incorrect. What would be 
> > > the right approach is to convert the PER_CPU bh_lrus to PER_CPU_LOCKED, 
> > > and to use the appropriate primitives to use them. That automatically 
> > > makes this code rt-safe. (it isnt right now)
> > 
> > Hmm, in UP it should be safe to access per cpu data under either a 
> > preempt_disable or local_irq_disable . I'm not sure how RT changes 
> > that .. Is there some other part of the code that isn't rt-safe, which 
> > I've overlooked ?
> 
> hm, you are right - that code can be in a preempt-off section. I've 
> applied your patch.

We could switch it to locked types if it's a latency concern..

Daniel

