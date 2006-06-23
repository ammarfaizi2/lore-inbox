Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932997AbWFWKaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbWFWKaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933001AbWFWKaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:30:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36059 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932997AbWFWKaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:30:19 -0400
Date: Fri, 23 Jun 2006 12:25:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 07/61] lock validator: better lock debugging
Message-ID: <20060623102523.GN4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212337.GG3155@elte.hu> <20060529183334.d3e7bef9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183334.d3e7bef9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5010]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > +#define DEBUG_WARN_ON(c)						\
> > +({									\
> > +	int __ret = 0;							\
> > +									\
> > +	if (unlikely(c)) {						\
> > +		if (debug_locks_off())					\
> > +			WARN_ON(1);					\
> > +		__ret = 1;						\
> > +	}								\
> > +	__ret;								\
> > +})
> 
> Either the name of this thing is too generic, or we _make_ it generic, 
> in which case it's in the wrong header file.

this op is only intended to be used only by the lock debugging 
infrastructure. So it should be renamed - but i fail to find a good name 
for it. (it's used quite frequently within the lock debugging code, at 
60+ places) Maybe INTERNAL_WARN_ON()? [that makes it sound special 
enough.] DEBUG_LOCKS_WARN_ON() might work too.

> > +#ifdef CONFIG_SMP
> > +# define SMP_DEBUG_WARN_ON(c)			DEBUG_WARN_ON(c)
> > +#else
> > +# define SMP_DEBUG_WARN_ON(c)			do { } while (0)
> > +#endif
> 
> Probably ditto.

agreed.

	Ingo
