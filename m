Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbULBQKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbULBQKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbULBQKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:10:25 -0500
Received: from pop.gmx.de ([213.165.64.20]:46301 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261689AbULBQFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:05:51 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 17:08:08 +0100
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
Message-ID: <20041202170808.311cf43a@mango.fruits.de>
In-Reply-To: <20041202134934.GA32216@elte.hu>
References: <20041201213023.GA23470@elte.hu>
	<32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	<20041201220916.GA24992@elte.hu>
	<20041201234355.0dac74cf@mango.fruits.de>
	<20041202084040.GC7585@elte.hu>
	<20041202132218.02ea2c48@mango.fruits.de>
	<20041202122931.GA25357@elte.hu>
	<20041202140612.4c07bca8@mango.fruits.de>
	<20041202131002.GA30503@elte.hu>
	<20041202144037.5c9da188@mango.fruits.de>
	<20041202134934.GA32216@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 14:49:34 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Ok, so if i want to find out whether a client violates the RT
> > constraints for its process callback i would have to add a call to
> > gettimeofday(1,1) at the start of the process callback and
> > gettimeofday(1,0) at the end.
> > 
> > Everything which causes a reschedule inbetween will then cause SIGUSR2
> > to be sent to the client for which i could either add a signal handler
> > in the client or just use gdb to get notified of it. 
> 
> correct. I'd expect there to be a number of less critical reschedules
> happening around startup/shutdown of a client, which one could consider
> a false positive, but there should be no unexpected rescheduling while
> the client is up and running.

cool, we're discussing on jackit-devel if this could be added to jackd's
libjack which would do the gettimeofday calls right before and after
calling the process() callback. This might indeed be very very very very
useful as in this case the clients themselfes wouldn't need to be
changed and jackd might then print a console message for example when a
client does something nasty.

Flo
