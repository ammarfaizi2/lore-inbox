Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbULBIlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbULBIlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbULBIlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:41:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:33984 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261454AbULBIlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:41:07 -0500
Date: Thu, 2 Dec 2004 09:40:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202084040.GC7585@elte.hu>
References: <32831.192.168.1.5.1101905229.squirrel@192.168.1.5> <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu> <20041201162034.GA8098@elte.hu> <33059.192.168.1.5.1101927565.squirrel@192.168.1.5> <20041201212925.GA23410@elte.hu> <20041201213023.GA23470@elte.hu> <32788.192.168.1.8.1101938057.squirrel@192.168.1.8> <20041201220916.GA24992@elte.hu> <20041201234355.0dac74cf@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201234355.0dac74cf@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Wed, 1 Dec 2004 23:09:16 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > but ... this brings up the question, is this a valid scenario? How can
> > jackd block on clients for so long? Perhaps this means that every audio
> > buffer has run empty and jackd desperately needed some new audio input,
> > which it didnt get from the clients, up until after the xrun? In theory
> > this should only be possible if there's CPU saturation (that's why i
> > asked about how much CPU% time there was in use).
> > 
> > One indication that this might have been the case is that in the full
> > 3.5 msecs trace there's not a single cycle spent idle. But, lots of time
> > was spent by e.g. X or gkrellm-4356, which are not RT tasks - so from
> > the RT task POV i think there were cycles left to be utilized. Could
> > this be a client bug? That seems a bit unlikely because to let jackd
> > 'run empty', each and every client would have to starve it, correct?
> 
> actually a single client doing nasty (non RT) stuff in its process()
> callback can "starve" jackd. AFAIK jackd waits until the last client
> has finished its process callback. So, if some client's process
> callback decides to use (for example) some blocking system call (big
> no no) and consequently falls asleep for a relatively long time, then
> it can cause jackd to miss its deadline. I'm not sure though wether
> this triggers an xrun in jackd or just a delay exceeded message.

since the period size in Rui's test is so small (-p64 is 1.6 msecs?),
the 2.6 msec timeout in pipe_poll() already generates an xrun.

	Ingo
