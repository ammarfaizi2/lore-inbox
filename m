Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVADKFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVADKFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVADKFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:05:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:26296 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261596AbVADKFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:05:48 -0500
Date: Tue, 4 Jan 2005 11:05:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Latency results with 2.6.10 - looks good
Message-ID: <20050104100523.GB14787@elte.hu>
References: <1104348820.5218.42.camel@krustophenia.net> <1104549524.3803.28.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104549524.3803.28.camel@krustophenia.net>
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

> Followup: other audio users have confirmed that 2.6.10 is the best
> release yet latency-wise.  It works most of the time at 64 frames
> (~1.33ms latency).
> 
> Now, the bad news: there are still enough xruns to make it not quite
> good enough for, say, a recording studio; as we all know with realtime
> constraints the worst case scenario is important.  As expected the RT
> kernel beats it by a wide margin.  I have attached some numbers,
> excerpted from a post by Rui on the JACK list.  The JACK test used was
> described previously on this list.
> 
> Ingo, what are your plans for pushing more of the RT patch set
> upstream? It seems that the soft/hardirq threading and voluntary
> preemption (turning the might_sleep checks into preemption points) are
> required to further improve the latency of the standard kernel.  These
> are well tested at this point and also zero cost for users who don't
> enable them. I think if these features go upstream before 2.6.11 then
> we can say all of the issues Paul raised, in that post months ago that
> led to the VP patches, will be put to rest.

for 2.6.11 we have dozens of scheduler patches queued in -mm that do
half of the work necessary for the rest of -RT. I'll split out more
stuff from -RT once the scheduler queue in -mm gets smaller (i.e. once
it gets merged upstream), but there's a natural limit to the rate of
merging in a given subsystem, if we push things too hard it will
deteriorate.

also, there's the necessary merging of preempt-bkl patch. It makes
little sense to add the more advanced stuff when the BKL is allowed to
generate up to ~200 milliseconds latencies. Hardirq and softirq
threading would be the next step after that point.

	Ingo
