Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUJRSVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUJRSVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJRSUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:20:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44698 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267344AbUJRSRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:17:05 -0400
Date: Mon, 18 Oct 2004 20:18:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <adam@doogie.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018181826.GC2899@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <Pine.LNX.4.58.0410181249150.1218@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410181249150.1218@gradall.private.brainfood.com>
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


* Adam Heath <adam@doogie.org> wrote:

>  =>   dump-end timestamp 29144924
> 
> The kernel is jsut getting ready to start init at this point(mounting
> root), so I don't know if you are really interested in this high
> latency trace, but I'm sending anyways.

lets skip these for the time being, large runtime ones are the first 
ones to be squashed.

> However, after I reset the threshold to 50(and got a few small traces), I got
> this whopper.
> 
> (XFree86/1129/CPU#0): new 4692 us maximum-latency critical section.
>  => started at timestamp 358506933: <call_console_drivers+0x76/0x140>
>  =>   ended at timestamp 358511625: <finish_task_switch+0x43/0xa0>
>  [<c0132480>] sub_preempt_count+0x60/0x90

interesting - this could be a printk (trace) done in a critical section
though. What does /proc/latency_trace tell, is it full of console code
functions?

one of the best ways to avoid the console-printk-ing overhead is to do a
'dmesg -n 1' and reset the maximum back to 50. (i prefer to use the
preempt_max_latency option not the preempt_thresh option.)

> ps: I've never mentioned the hardware I am running.  Athlon XP 2000, 1G ram,
>     460G(usable) software raid5(3*250g ide)(plus boot 120G), LVM, extra
>     SiliconImage UDMA133 controller(mobo can only do 100).
> 
>     I'm not certain what kind of latencies to expect with this setup.  I'm
>     tending to ignore <100us, at least for now.

this setup shouldnt produce above-100 usec latencies with -U5 and
PREEMPT_REALTIME.

	Ingo
