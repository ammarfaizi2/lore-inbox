Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbUKUPEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbUKUPEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUKUPEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:04:35 -0500
Received: from pop.gmx.net ([213.165.64.20]:28820 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261308AbUKUPE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:04:29 -0500
X-Authenticated: #4399952
Date: Sun, 21 Nov 2004 16:05:25 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121160525.0b71c0de@mango.fruits.de>
In-Reply-To: <20041121134354.GA17759@elte.hu>
References: <20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<1100920963.1424.1.camel@krustophenia.net>
	<20041120125536.GC8091@elte.hu>
	<1100971141.6879.18.camel@krustophenia.net>
	<20041120191403.GA16262@elte.hu>
	<1100975745.6879.35.camel@krustophenia.net>
	<20041120201155.6dc43c39@mango.fruits.de>
	<20041120214035.2deceaeb@mango.fruits.de>
	<20041121125439.GA8224@elte.hu>
	<20041121134354.GA17759@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004 14:43:54 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> on a 2 GHz UP box the worst-case max jitter i can trigger via rtc_wakeup
> is 11 usecs, using the -5 kernel. The workload i used was 40 parallel
> copies of LTP plus a few hackbench runs. This is how i started
> rtc_wakeup:
> 
>  chrt -f 80 -p `pidof 'IRQ 0'`
>  chrt -f 98 -p `pidof 'IRQ 8'`
> 
>  cd rtc_wakeup
>  ./rtc_wakeup -f 1024 -t 100000
> 
> i.e. IRQ0 is below IRQ8 and the rtc_wakeup threads, but above every
> other IRQ thread. Here's the histogram of a short (~5 minutes) run:

Ah, ok, this makes sense.. Will try the same. Btw: one more question wrt the
IRQ prios:

Let's assume i have IRQ 0 at 80, my soundcard and the rtc irq both at prio
98 and all others around 40. Now the rtc handler should never get in the way
of the soundcard irq if the rtc is simply not used right? And of course, the
other way around, too. the soundcard irq should not get in the way of the
rtc handler if the soundcard simply is not used and not generating IRQ's?

> 
>   1 247383
>   2 34842
>   3 1488
>   4 3188
>   5 125
>   6 1
> 
> so this a 6 usecs max delay measured by /dev/rtc. So on your box, if the
> max histogram delay was 16 usecs, i'd not expect a worse than ~30 usecs
> jitter measured by rtc_wakeup. Can you reproduce the 150 usecs jitter
> with the above IRQ setup?

not yet.

flo
