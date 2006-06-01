Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWFAIc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWFAIc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWFAIc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:32:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37828 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750707AbWFAIc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:32:58 -0400
Date: Thu, 1 Jun 2006 10:33:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       pauldrynoff@gmail.com, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
Message-ID: <20060601083314.GA25438@elte.hu>
References: <20060530195417.e870b305.pauldrynoff@gmail.com> <20060530132540.a2c98244.akpm@osdl.org> <20060531181926.51c4f4c5.pauldrynoff@gmail.com> <1149085739.3114.34.camel@laptopd505.fenrus.org> <20060531102128.eb0020ad.akpm@osdl.org> <447DFE29.6040508@linux.intel.com> <20060531142525.5a22f9f1.akpm@osdl.org> <447E097C.2020707@linux.intel.com> <20060601080913.GA26955@gondor.apana.org.au> <1149149522.3115.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149149522.3115.14.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> > This is a serious bug in misrouted_irq().  disable_irq() is a 
> > software state and must be repsected.
> 
> no that is not correct. The api is a mix kinda and broken; it really 
> DOES mean "shut this irq source off". That your handler won't get 
> called is an assumption! You do NOT disable your handler this way. 
> What we really need is a disable_irq_handler() api that does both!

well, the short-term answer is that Herbert's fix is correct and we need 
to do it even if it degrades the efficiency of irqfixup/irqpoll.

after this fix is applied, irqfixup/irqpoll should be enhanced to take 
advantage of disable_irq_handler().

in any case, correctness comes first - not honoring IRQ_DISABLED can 
lead to lockups.

	Ingo
