Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbUK3IuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbUK3IuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUK3IuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:50:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58850 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262021AbUK3Itq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:49:46 -0500
Date: Tue, 30 Nov 2004 09:49:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041130084904.GA17799@elte.hu>
References: <20041129155752.GA17828@elte.hu> <Pine.OSF.4.05.10411291717120.14592-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411291717120.14592-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > and i'm regularly testing this property with 'hackbench 50', which
> > creates over a 1000 wildly scheduling non-RT tasks. Latency is not
> > affected by such workloads.
> >
>  
> Probably not. Even while doing that you most likely wont build up wait
> lists of more than 10, maybe 100 tasks? Doing full traversals with irq
> disabled probably wont be meassureable!(?) compared to much other
> stuff increasing responsible for the meassured latency.

there is no full list traversal of SCHED_NORMAL tasks, ever.

but the best way is to test this yourself, download Florian's rtc_wakeup
from:

  http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

and run it with the highest possible resolution, 8192 Hz:

  chrt -f 98 -p `pidof 'IRQ 8'`
  chrt -f 99 -p `pidof 'IRQ 0'`

  ./rtc_wakeup -f 8192 -t 100000

in this mode rtc_wakeup will report the worst irq-delivery latency it
measures. It will thus measure the combined effect of any type of
scheduling or irqs-off latency to RT-tasks.

then download hackbench from:

  http://developer.osdl.org/craiger/hackbench/

and try e.g.:

  ./hackbench 50

this will start 2x20x50 == 2000 SCHED_NORMAL threads, all performing a
nice pattern of scheduling simulating a busy chat server workload with
tons of messages going back and forth.

	Ingo
