Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbULBMUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbULBMUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 07:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbULBMUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 07:20:09 -0500
Received: from pop.gmx.net ([213.165.64.20]:1748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261583AbULBMUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 07:20:02 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 13:22:18 +0100
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
Message-ID: <20041202132218.02ea2c48@mango.fruits.de>
In-Reply-To: <20041202084040.GC7585@elte.hu>
References: <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
	<20041201154046.GA15244@elte.hu>
	<20041201160632.GA3018@elte.hu>
	<20041201162034.GA8098@elte.hu>
	<33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
	<20041201212925.GA23410@elte.hu>
	<20041201213023.GA23470@elte.hu>
	<32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	<20041201220916.GA24992@elte.hu>
	<20041201234355.0dac74cf@mango.fruits.de>
	<20041202084040.GC7585@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 09:40:40 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> > actually a single client doing nasty (non RT) stuff in its process()
> > callback can "starve" jackd. AFAIK jackd waits until the last client
> > has finished its process callback. So, if some client's process
> > callback decides to use (for example) some blocking system call (big
> > no no) and consequently falls asleep for a relatively long time, then
> > it can cause jackd to miss its deadline. I'm not sure though wether
> > this triggers an xrun in jackd or just a delay exceeded message.
> 
> since the period size in Rui's test is so small (-p64 is 1.6 msecs?),

ca. 1.3ms

> the 2.6 msec timeout in pipe_poll() already generates an xrun.

yep. now the question is: why did jackd have to wait so long for the
client? what was the client doing? was it sleeping? what client was it?
probably not the simple jack_test client, right?

Short tests ((20 minutes, due to lack of time) with cvs jackd and a
number of modified jack_test clients (added a for loop in the process()
callback to burn cycles to increase the cpu load) show no xruns here
even with relatively high cpu load (around 70%) and a periodsize of 64
frames. Of course i had the mandatory additional kernel compile running
in the background :)

flo

Oh wow. Just before hitting send i got three xruns of around
0.020-0.050msec. Ok, will read up on recent emails to see what to do to
debug these.
