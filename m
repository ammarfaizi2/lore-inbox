Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbWF1JeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbWF1JeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWF1JeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:34:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53202 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423243AbWF1JeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:34:12 -0400
Date: Wed, 28 Jun 2006 11:29:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Zou Nan hai <nanhai.zou@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-ID: <20060628092919.GA14765@elte.hu>
References: <1151470123.6052.17.camel@linux-znh> <20060627234005.dda13686.akpm@osdl.org> <20060628063859.GA9726@elte.hu> <20060627235500.8c2c290e.akpm@osdl.org> <1151473582.6052.28.camel@linux-znh> <20060628004029.efcc8a03.akpm@osdl.org> <1151474577.6052.33.camel@linux-znh> <20060628010422.dc73b7e9.akpm@osdl.org> <1151477429.6052.42.camel@linux-znh> <20060628014544.198b9eb4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628014544.198b9eb4.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> >  However I still have some concern on cond_resched_lock(), on an UP 
> > kernel it will return 1 if schedule happen, but actually it does not 
> > drop any lock, that semantic seems to be different to SMP kernel.
> 
> That's OK (I think - I don't have a good track record in this thread).
> 
> If the kernel is non-preemptible and UP, we want to return true from 
> cond_resched_foo() if we called schedule().  Because schedule() might 
> allow a different thread into the kernel which might modify the locked 
> data.
> 
> And if the kernel is preemptible and UP, we want to return true from 
> cond_resched_foo() if we dropped the lock, because that internally 
> does a preempt_enable().
> 
> And the patch (hopefully) satisfies those requirements.  Does that all 
> sound solid?

it looks solid to me ... but this is subtle stuff and i dont seem to 
have a good track record for these details today. I guess if it's 
inadequate Zou ought to see them in practice?

	Ingo
