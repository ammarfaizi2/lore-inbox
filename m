Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbUKTPhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbUKTPhy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 10:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUKTPhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 10:37:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40932 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262980AbUKTPhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 10:37:46 -0500
Date: Sat, 20 Nov 2004 17:40:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Domen Puncer <domen@coderock.org>
Cc: janitor@sternwelten.at, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: kernel/sched.c: fix subtle TASK_RUNNING compare
Message-ID: <20041120164011.GA13360@elte.hu>
References: <E1CVL0H-0000SH-EN@sputnik> <20041120125355.GB8091@elte.hu> <20041120120722.GA3826@masina.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120120722.GA3826@masina.coderock.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Domen Puncer <domen@coderock.org> wrote:

> On 20/11/04 13:53 +0100, Ingo Molnar wrote:
> > 
> > * janitor@sternwelten.at <janitor@sternwelten.at> wrote:
> > 
> > >  	switch_count = &prev->nivcsw;
> > > -	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
> > > +	if (prev->state != TASK_RUNNING &&
> > > +			!(preempt_count() & PREEMPT_ACTIVE)) {
> > >  		switch_count = &prev->nvcsw;
> > 
> > nack. We inherently rely on the process state mask being a bitmask and
> > TASK_RUNNING thus being zero.
> 
> Hmm... but other compares in sched.c are ok? ;-)
> 1211:   BUG_ON(p->state != TASK_RUNNING);
> 2550:   if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
> 3609:   if (state == TASK_RUNNING)
> 3640:   if (state != TASK_RUNNING)

hm ... ok.

	Ingo
