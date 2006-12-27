Return-Path: <linux-kernel-owner+w=401wt.eu-S932377AbWL0LSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWL0LSm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWL0LSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:18:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42936 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932235AbWL0LSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:18:41 -0500
Date: Wed, 27 Dec 2006 12:16:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sched: remove __resched_legal() and fix cond_resched_softirq()
Message-ID: <20061227111619.GA12234@elte.hu>
References: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com> <87psa9z0wu.fsf@duaron.myhome.or.jp> <20061226130739.GB3701@elte.hu> <87ac19epqr.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ac19epqr.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0012]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> > i found another bug and realized that the whole __resched_legal() 
> > approach is fundamentally wrong! The patch below fixes this.
> 
> Hmm.. but the path seems,
> 
> -> cond_resched()
>   -> if (__resched_legal())		/* preempt_count == 0 */
>     -> __cond_resched()			/* preempt_count == 0x10000000 */
>       -> schedule()
>         [...]
>         -> cond_resched()
>           -> if (__resched_legal())	/* preempt_count == 0x10000000 */
>             -> __cond_resched()		/* preempt_count == 0x20000000 */
>               -> schedule()             /* warning */
> 
> Where is it prevented? Or warning is just wrong?

this should be handled by the second version of the patch i sent out 
yesterday. When we have PREEMPT_ACTIVE set, no schedule() call is legal.

	Ingo
