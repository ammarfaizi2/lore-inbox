Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUJIGHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUJIGHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUJIGHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:07:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:18086 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266538AbUJIFuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:50:01 -0400
Subject: Preemption model (was Re: voluntary-preempt-2.6.9-rc3-mm3-T3)
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <41677862.2020806@kolivas.org>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
	 <1097297824.1442.132.camel@krustophenia.net>
	 <cone.1097298596.537768.1810.502@pc.kolivas.org>
	 <1097299260.1442.142.camel@krustophenia.net>  <416775CD.70706@kolivas.org>
	 <1097299886.1442.145.camel@krustophenia.net> <41677862.2020806@kolivas.org>
Content-Type: text/plain
Message-Id: <1097300995.1442.156.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 01:50:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 01:34, Con Kolivas wrote:
> Lee Revell wrote:
> >>>>>With VP and PREEMPT in general, does the scheduler always run the
> >>>>>highest priority process, or do we only preempt if a SCHED_FIFO process
> >>>>>is runnable?
> >>>>
> >>>>Always the highest priority runnable.
> >>>>
> >>>
> >>>
> >>>Hmm, interesting.  Would there be any advantage to a mode where only
> >>>SCHED_FIFO tasks can preempt?  This seems like a much lighter way to
> >>>solve the realtime problem.
> >>
> >>No, the linux scheduler has always been preemptible. PREEMPT and VP just 
> >>allows it to preempt kernel code paths as well. It could be modified to 
> >>do such a thing but apart from real time applications it would perform 
> >>very badly overall.
> > 
> > 
> > I am talking about a mode where we only allow a SCHED_FIFO process to
> > preempt a kernel code path.  In every other case it works like !PREEMPT.
> > 
> > This is apparently how kernel preemption worked on SVR4.
> 
> Yes it could. If you ask nicely, Ingo might even throw in yet another 
> config option in the kernel. It gets messy if multiple people start 
> hacking on the same thing when it's under heavy development.

Oh, I was not going to post a patch, I don't know the code nearly well
enough at this point :-).  But it looks pretty straightforward.

This also addresses what I think was Linus' main objection to PREEMPT,
which IIRC was (paraphrasing) that maybe if the scheduler had been
smarter we would not be having to preempt all the time.  This argument
is perfectly valid except for a SCHED_FIFO task which by definition will
always know better than the scheduler does when it needs to run.

Lee  

