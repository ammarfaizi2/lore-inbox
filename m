Return-Path: <linux-kernel-owner+willy=40w.ods.org-S312024AbUKBBow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S312024AbUKBBow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381841AbUKAXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:30:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:23206 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S377006AbUKAWbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:31:16 -0500
X-Authenticated: #4399952
Date: Mon, 1 Nov 2004 23:30:37 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101233037.314337c8@mango.fruits.de>
In-Reply-To: <20041101184615.GB32009@elte.hu>
References: <1099227269.1459.45.camel@krustophenia.net>
	<20041031131318.GA23437@elte.hu>
	<20041031134016.GA24645@elte.hu>
	<20041031162059.1a3dd9eb@mango.fruits.de>
	<20041031165913.2d0ad21e@mango.fruits.de>
	<20041031200621.212ee044@mango.fruits.de>
	<20041101134235.GA18009@elte.hu>
	<20041101135358.GA19718@elte.hu>
	<20041101140630.GA20448@elte.hu>
	<1099324040.3337.32.camel@thomas>
	<20041101184615.GB32009@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

took jackit-devel off cc, since it bounced anyways [too many recipients]

On Mon, 1 Nov 2004 19:46:15 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > >   http://redhat.com/~mingo/realtime-preempt/
> > > 
> > > Thomas, can you confirm that this kernel fixes the irqs-off latencies? 
> > > (the priority loop indeed was done with irqs turned off.)
> > 
> > The latencies are still there. I have the feeling it's worse than 0.6.2.
> 
> what is the worst latency you can trigger with Florian's latest
> rtc_wakeup code? (please re-download it, there has been a recent update)

I have fixed one or two more small issues:

1] the cpu cycles/s measurement was done while not yet running SCHED_FIFO.
   changed it so the rt priv is aquired beforehand

2] when one or more irq's were missed, the cycle timestamps for the last wakeup
   do not get used  anymore for neither threshold nor max jitter reporting. 
   It's kind of pointless to calculate jitter for a period with the 
   fundamental requirement that no irq's be missed being violated.

3] the output file format (-o) is now 

num_of_irqs_since_last_wakeup  cycles_count 

and basically looks like this:

1 116817809121123
1 116817810280681
1 116817811456573
1 116817812617197
1 116817813788473
1 116817814948983
1 116817816121533
...

i suppose this data might be easily fed into a histogram producing script or
something..

New download place:

http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

direct link (has changed. i'll remove the old tarball)

http://affenbande.org/~tapas/rtc_wakeup/rtc_wakeup.tgz

Whoever wants to be notified of new versions should mail me a reply
(private), so i can drop em a line in case (lkml is hi traffic enough
already)..

> 
> also, there are no "arbitrary load" latency guarantees with
> DEADLOCK_DETECTION turned on, since we search the list of all held locks
> during task-exit time - this can generate pretty bad latencies e.g.
> during hackbench.

btw: i see the same build failure as Rui with lock debugging disabled. Since
the lock debugging can screw timings, will this be fixed in [one of] the next
version[s]?

flo
