Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbULAWmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbULAWmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbULAWmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:42:37 -0500
Received: from pop.gmx.net ([213.165.64.20]:15766 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261490AbULAWmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:42:00 -0500
X-Authenticated: #4399952
Date: Wed, 1 Dec 2004 23:43:55 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
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
Message-ID: <20041201234355.0dac74cf@mango.fruits.de>
In-Reply-To: <20041201220916.GA24992@elte.hu>
References: <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
	<20041201103251.GA18838@elte.hu>
	<32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
	<20041201154046.GA15244@elte.hu>
	<20041201160632.GA3018@elte.hu>
	<20041201162034.GA8098@elte.hu>
	<33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
	<20041201212925.GA23410@elte.hu>
	<20041201213023.GA23470@elte.hu>
	<32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	<20041201220916.GA24992@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004 23:09:16 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> but ... this brings up the question, is this a valid scenario? How can
> jackd block on clients for so long? Perhaps this means that every audio
> buffer has run empty and jackd desperately needed some new audio input,
> which it didnt get from the clients, up until after the xrun? In theory
> this should only be possible if there's CPU saturation (that's why i
> asked about how much CPU% time there was in use).
> 
> One indication that this might have been the case is that in the full
> 3.5 msecs trace there's not a single cycle spent idle. But, lots of time
> was spent by e.g. X or gkrellm-4356, which are not RT tasks - so from
> the RT task POV i think there were cycles left to be utilized. Could
> this be a client bug? That seems a bit unlikely because to let jackd
> 'run empty', each and every client would have to starve it, correct?

actually a single client doing nasty (non RT) stuff in its process()
callback can "starve" jackd. AFAIK jackd waits until the last client has
finished its process callback. So, if some client's process callback
decides to use (for example) some blocking system call (big no no) and
consequently falls asleep for a relatively long time, then it can cause
jackd to miss its deadline. I'm not sure though wether this triggers an
xrun in jackd or just a delay exceeded message.

flo

