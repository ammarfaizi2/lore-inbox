Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbULGVrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbULGVrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbULGVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:47:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:59523 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261949AbULGVrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:47:49 -0500
Date: Tue, 7 Dec 2004 22:47:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Eran Mann <emann@mrv.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
Message-ID: <20041207214715.GB12879@elte.hu>
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <41B5C038.1090501@mrv.com> <20041207153720.GA20712@elte.hu> <200412071340.42731.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412071340.42731.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> I'd like to report a slight improvement in the reports from tvtime
> while running 32-6 with full preemtion turned on, cfq scheduler:
> 
> ------
> Dec  7 13:29:39 coyote kernel: wow!  That was a 15 millisec bump
> Dec  7 13:29:39 coyote kernel: `IRQ 8'[838] is being piggy.
> need_resched=0, cpu=0
> Dec  7 13:29:39 coyote kernel: Read missed before next interrupt
> -----
> Each second of the log contains about 27 of these, so its pretty
> steady.  Picture looks pretty good though.
>
> Although, that particular snip was taken from the log while I was
> *not* on the same screen as tvtime.  Switching back it its screen
> returned the slip times to the 22 millisecond area. [...]

could enable WAKEUP_TIMING and LATENCY_TRACING, boot into the new kernel
and do:

	echo 0 > /proc/sys/kernel/preempt_max_latency

then you'll get the worst-case trace in /proc/latency_trace. Does it
show any millisecs-range latencies?

also, do this:

  chrt -f 90 -p `pidof 'IRQ 8'`
  chrt -f 91 -p `pidof 'IRQ 0'`

to make sure IRQ8 doesnt get preempted by other stuff. How often do you
get the rtc histogram in the syslog? Does tvtime use /dev/rtc for normal
operations perhaps? If yes then you might want to disable RTC_HISTOGRAM.

	Ingo
