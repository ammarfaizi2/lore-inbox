Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbULBNEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbULBNEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULBNEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:04:02 -0500
Received: from mail.gmx.de ([213.165.64.20]:34719 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261604AbULBNDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:03:55 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 14:06:12 +0100
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
Message-ID: <20041202140612.4c07bca8@mango.fruits.de>
In-Reply-To: <20041202122931.GA25357@elte.hu>
References: <20041201160632.GA3018@elte.hu>
	<20041201162034.GA8098@elte.hu>
	<33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
	<20041201212925.GA23410@elte.hu>
	<20041201213023.GA23470@elte.hu>
	<32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	<20041201220916.GA24992@elte.hu>
	<20041201234355.0dac74cf@mango.fruits.de>
	<20041202084040.GC7585@elte.hu>
	<20041202132218.02ea2c48@mango.fruits.de>
	<20041202122931.GA25357@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 13:29:31 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> it's very likely not the simple jack_test client. I've attached the
> trace in question. Here are the tasks that were running:
> 
>  gkrellm
>    IRQ 0
>   IRQ 14
>    IRQ 5
>    jackd
>  kblockd
>   korgac
> ksoftirq
> qjackctl
>   qsynth
>        X
>     xmms
> 
> the trace doesnt show what task jackd was waiting on, and it would be
> hard to establish it, the tracepoint would have to 'discover' all other
> holders of the pipe fd, which is quite complex.

I'm not knowledgable enough to read the trace, but what was for example
the last thing qsynth was doing? Did it go to sleep? I suppose this was
Rui's 9 qsynth's test, right?

Hmm, i wonder if there's a way to detect non RT behaviour in jackd
clients. I mean AFAIK the only thing allowed for the process callback of
on is the FIFO it waits on to be woken, right? Every other sleeping is
to be considered a bug. 

> 
> > Oh wow. Just before hitting send i got three xruns of around
> > 0.020-0.050msec. Ok, will read up on recent emails to see what to do
> > to debug these.
> 
> which jackd version is this? I saw similar small spurious xruns with
> 99.0, those went away in recent CVS versions.

For this test i used jackd from yesterdays CVS. With the 0.99 version i
think i saw more of these xruns, but cannot tell (still running the CVS
version right now).. They all had in common though that they are in the
0.020-0.040msec range.

Flo
