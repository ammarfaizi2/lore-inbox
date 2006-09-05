Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWIETp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWIETp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWIETp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:45:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:50117 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161005AbWIETp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:45:56 -0400
Date: Tue, 5 Sep 2006 21:37:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060905193742.GA1566@elte.hu>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <20060905181241.GC16207@elte.hu> <20060905190807.GA27171@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905190807.GA27171@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > The reason is that the BUILD_LOCK_OPS macros in kernel/lockdep.c 
> > > don't contain any of the *_acquire calls, while all of the _unlock 
> > > functions contain a *_release call. Hence I get immediately 
> > > unbalanced locks.
> > 
> > hmmm ... that sounds like a bug. Weird - i recently ran 
> > PREEMPT+SMP+LOCKDEP kernels and didnt notice this.
> 
> ok, the reason i didnt find this problem is because this is fixed in 
> my tree, but i didnt realize that it's a fix also for upstream ...

actually ... it works fine in the upstream kernel due to this:

  * If lockdep is enabled then we use the non-preemption spin-ops
  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
 #if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
         defined(CONFIG_DEBUG_LOCK_ALLOC)

so i'm wondering, how did you you manage to get into the 
BUILD_LOCK_OPS() branch?

	Ingo
