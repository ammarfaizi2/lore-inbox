Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUJIKoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUJIKoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 06:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUJIKop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 06:44:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23495 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266684AbUJIKoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 06:44:32 -0400
Date: Sat, 9 Oct 2004 12:46:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041009104600.GB19062@elte.hu>
References: <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <1097297824.1442.132.camel@krustophenia.net> <cone.1097298596.537768.1810.502@pc.kolivas.org> <1097299260.1442.142.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097299260.1442.142.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > > With VP and PREEMPT in general, does the scheduler always run the
> > > highest priority process, or do we only preempt if a SCHED_FIFO process
> > > is runnable?
> > 
> > Always the highest priority runnable.
> > 
> 
> Hmm, interesting.  Would there be any advantage to a mode where only
> SCHED_FIFO tasks can preempt?  This seems like a much lighter way to
> solve the realtime problem.

it could be done, but i dont think we should do it. It makes RT
scheduling much more of a special-case. Right now RT scheduling is 99%
like normal scheduling - with the difference that RT priorities are
"higher" than the normal priorities and that each RT priority level is
"exclusive": the scheduler will let such tasks run until they want,
without applying fairness policies.

by making RT tasks more of a special case we'd destabilize the whole
thing: there would be kernel preemptability bugs that only RT tasks
would hit - resulting in a steady deterioration of PREEMPT support in
the kernel. (the ratio of RT tasks is perhaps 0.1% of all use, or less.) 
So applying _any_ RT-only technique besides the bare minimum is asking
for trouble in the long run.

furthermore, we had hard-to-trigger SMP bugs that the PREEMPT kernel
triggered much faster - resulting in an indirect stabilization of our
SMP code. If nothing else then this alone makes PREEMPT very useful.

	Ingo
