Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263531AbUKAOGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbUKAOGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbUKAOGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:06:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43144 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265189AbUKAOF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:05:27 -0500
Date: Mon, 1 Nov 2004 15:06:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101140630.GA20448@elte.hu>
References: <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101135358.GA19718@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > removing the poll() lines doesnt seem to impact the quality of the
> > data, but i still see roughly 50 usecs added to the 'real' latency
> > that i see in traces.
> 
> this i think is related to what Thomas observed, that there's a new
> irqs-off critical section somewhere. (it's in the new priority
> handling code i think.)

ah, found it. Only RT tasks were supposed to get special priority
handling, while in fact all tasks got it - so when Thomas ran hackbench
(Thomas, you did, right?) it created an O(nr_hackbench) overhead within
the mutex code ... I've uploaded -V0.6.5 to the usual place:

  http://redhat.com/~mingo/realtime-preempt/

Thomas, can you confirm that this kernel fixes the irqs-off latencies? 
(the priority loop indeed was done with irqs turned off.)

i'm not sure this fix is related to the deadlocks reported though.

	Ingo
