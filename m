Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUJ3VmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUJ3VmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbUJ3VmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:42:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:51372 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261341AbUJ3Viy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:38:54 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 23:38:49 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030233849.498fbb0f@mango.fruits.de>
In-Reply-To: <1099171567.1424.9.camel@krustophenia.net>
References: <20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<1099086166.1468.4.camel@krustophenia.net>
	<20041029214602.GA15605@elte.hu>
	<1099091566.1461.8.camel@krustophenia.net>
	<20041030115808.GA29692@elte.hu>
	<1099158570.1972.5.camel@krustophenia.net>
	<20041030191725.GA29747@elte.hu>
	<20041030214738.1918ea1d@mango.fruits.de>
	<1099165925.1972.22.camel@krustophenia.net>
	<20041030221548.5e82fad5@mango.fruits.de>
	<1099167996.1434.4.camel@krustophenia.net>
	<20041030231358.6f1eeeac@mango.fruits.de>
	<1099171567.1424.9.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 17:26:06 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Sat, 2004-10-30 at 23:13 +0200, Florian Schmidt wrote:
> > ah, ok.. tarball updated. The third argument is now a percentage. If the
> > cycle count difference between two different wakeups differs more than the
> > specified percentage from the "perfect" period, then a line is printed to
> > the terminal showing by how much percent it differs. 
> 
> OK this is pretty sweet.  With T3 the jitter never exceeds 7% on an idle
> system.  As soon as I start moving the mouse this goes to 7 or 8%.  I
> cannot get it to go higher than 10%.  Moving windows around has no
> effect, the highest jitter happens when I type or move the mouse really
> fast IOW it corresponds to the interrupt rate.
> 
> This is a pretty good baseline for what an xrun-free system would look
> like.  Now to test the latest version...

Well, 

on V0.5.16 i see something like the below output (which is much worse). It
seems that missed irq's with rtc show up at the same time as the xruns in
jackd do [i ran both jackd and wakeup in parallel].

While there's no way to deterministically force missed irq's by window
wiggling [we should make it olympic discipline :)], UI action seems to raise
the probability somewhat.

~/source/my_projects/wakeup$ ./rt_wakeup 1024 50000 10
freq: 1024 #: 50000
getting cpu speed
1194.908 MHz
# of cycles for "perfect" period: 1166902
setting up /dev/rtc.
locking memory...
turning irq on, beginning measurement (might take a while).
threshold violated: 1485237 cycles since last wakeup (27.2804%).
threshold violated: 1047469 cycles since last wakeup (10.235%).
threshold violated: 964069 cycles since last wakeup (17.3822%).
ouch! we missed one ore more irq[s]
threshold violated: 4037774 cycles since last wakeup (246.025%).
threshold violated: 620764 cycles since last wakeup (46.8024%).
threshold violated: 10327889 cycles since last wakeup (785.069%).
ouch! we missed one ore more irq[s]
threshold violated: 700832 cycles since last wakeup (39.9408%).
threshold violated: 3148900 cycles since last wakeup (169.851%).
ouch! we missed one ore more irq[s]
threshold violated: 231791 cycles since last wakeup (80.1362%).
threshold violated: 768584 cycles since last wakeup (34.1347%).
ouch! we missed one ore more irq[s]
threshold violated: 3500123 cycles since last wakeup (199.95%).
threshold violated: 2581587 cycles since last wakeup (121.234%).
threshold violated: 920020 cycles since last wakeup (21.157%).
threshold violated: 2430290 cycles since last wakeup (108.269%).
threshold violated: 240850 cycles since last wakeup (79.3599%).
threshold violated: 3614768 cycles since last wakeup (209.775%).
ouch! we missed one ore more irq[s]
threshold violated: 883969 cycles since last wakeup (24.2465%).
threshold violated: 479302 cycles since last wakeup (58.9253%).
threshold violated: 830208 cycles since last wakeup (28.8537%).
threshold violated: 2313154 cycles since last wakeup (98.2304%).
threshold violated: 516698 cycles since last wakeup (55.7205%).
threshold violated: 2545998 cycles since last wakeup (118.184%).
ouch! we missed one ore more irq[s]
threshold violated: 4466286 cycles since last wakeup (282.747%).
ouch! we missed one ore more irq[s]
threshold violated: 565233 cycles since last wakeup (51.5612%).
threshold violated: 184668 cycles since last wakeup (84.1745%).
threshold violated: 2854676 cycles since last wakeup (144.637%).
threshold violated: 3384620 cycles since last wakeup (190.052%).
ouch! we missed one ore more irq[s]
threshold violated: 282832 cycles since last wakeup (75.7621%).
threshold violated: 2741798 cycles since last wakeup (134.964%).
ouch! we missed one ore more irq[s]
threshold violated: 1405657 cycles since last wakeup (20.4606%).
threshold violated: 227030 cycles since last wakeup (80.5442%).
threshold violated: 3476092 cycles since last wakeup (197.891%).
ouch! we missed one ore more irq[s]
threshold violated: 448723 cycles since last wakeup (61.5458%).
threshold violated: 2390327 cycles since last wakeup (104.844%).
ouch! we missed one ore more irq[s]
threshold violated: 1489252 cycles since last wakeup (27.6244%).
threshold violated: 517884 cycles since last wakeup (55.6189%).
threshold violated: 3774860 cycles since last wakeup (223.494%).
ouch! we missed one ore more irq[s]
threshold violated: 1762452 cycles since last wakeup (51.0368%).
threshold violated: 1545052 cycles since last wakeup (32.4063%).
ouch! we missed one ore more irq[s]
threshold violated: 442749 cycles since last wakeup (62.0577%).
threshold violated: 2230841 cycles since last wakeup (91.1764%).
threshold violated: 5825655 cycles since last wakeup (399.241%).
ouch! we missed one ore more irq[s]
threshold violated: 2874721 cycles since last wakeup (146.355%).
ouch! we missed one ore more irq[s]
threshold violated: 647431 cycles since last wakeup (44.5171%).
threshold violated: 126309 cycles since last wakeup (89.1757%).
threshold violated: 5817415 cycles since last wakeup (398.535%).
ouch! we missed one ore more irq[s]
threshold violated: 661937 cycles since last wakeup (43.274%).
threshold violated: 4351747 cycles since last wakeup (272.932%).
ouch! we missed one ore more irq[s]
threshold violated: 442189 cycles since last wakeup (62.1057%).
threshold violated: 115427 cycles since last wakeup (90.1083%).
done.

total # of irqs: 50032. missed irq deadlines: 17

mean cycle difference betweem two wakeups: 1.16779e+06 cycles

min. cycle difference betweem two wakeups: 115427 cycles (#: 44584) 
 diff from mean diff: 1.05237e+06

max. cycle difference betweem two wakeups: 1.03279e+07 cycles (#: 8869) 
 diff from mean diff: 9.1601e+06

mean difference from mean difference: 6458.8 cycles

~/source/my_projects/wakeup$ 
