Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbUKPW7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUKPW7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKPW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:57:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:37301 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261873AbUKPWyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:54:44 -0500
X-Authenticated: #4399952
Date: Tue, 16 Nov 2004 23:55:35 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116235535.6867290d@mango.fruits.de>
In-Reply-To: <20041116231145.GC31529@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
	<20041116184315.GA5492@elte.hu>
	<419A5A53.6050100@cybsft.com>
	<20041116212401.GA16845@elte.hu>
	<20041116222039.662f41ac@mango.fruits.de>
	<20041116223243.43feddf4@mango.fruits.de>
	<20041116224257.GB27550@elte.hu>
	<20041116230443.452497b9@mango.fruits.de>
	<20041116231145.GC31529@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 00:11:45 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> >     5 88010002 0.000ms (+0.000ms): wake_up_process (redirect_hardirq)
>          ^--- this one
> 
> it was zero before - indeed hard to notice optically :-|

nah, i just didn't know what to look for :)

> i've uploaded the -11 patch with a preliminary fix:
> 
> which turns off the FPU-based ops if PREEMPT_RT is specified. The speed
> difference should be small but the latency difference is large ...
> 
> could you try -11, do you still see these large latencies?

yes, this seems to fix it. no more extra jitter or large latencies on
console switches. 

Now, on to trying to lock up the machine ;)

Ah, btw: one thing i observed with my soundcard. I load the module at bootup
and chrt its IRQ handler to prio 98 (a check with chrt shows this prio
allright). Now it seems that the first time the soundcard is actually used
the thread gets back its original prio (from dmesg):

IRQ#3 thread RT prio: 42.

Maybe the sounddriver (snd-cs46xx) i use never initializes its irq before
the first time it gets used to play something. Well anyways, the workaround
is to change its prio after the first time it is used and not directly after
module loading..

flo
