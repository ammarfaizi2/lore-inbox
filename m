Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271743AbTGXWBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271745AbTGXWBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:01:50 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:32486
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271743AbTGXWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:01:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Szonyi Calin" <sony@etc.utt.ro>, <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O8int for interactivity
Date: Fri, 25 Jul 2003 08:20:49 +1000
User-Agent: KMail/1.5.2
Cc: <linux-kernel@vger.kernel.org>
References: <200307232155.27107.kernel@kolivas.org> <1058978784.740.4.camel@teapot.felipe-alfaro.com> <5783.194.138.39.55.1059063130.squirrel@webmail.etc.utt.ro>
In-Reply-To: <5783.194.138.39.55.1059063130.squirrel@webmail.etc.utt.ro>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307250820.49434.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 02:12, Szonyi Calin wrote:
> Felipe Alfaro Solana said:
> > I'm playing a bit with tunables to see if I can tune the scheduler a
> > little bit for my system/workload. I've had good results reducing max
> > timeslice to 100 (yeah, I know I shouldn't do this too).
> >
> > Will keep you informed :-)
>
> same thing here. Reducing max timeslice to 100 is much better.
> It's the only thing that allow me to watch a movie while compiling
> the kernel with make -j 2 bzImage on my Duron 700Mhz with 256M RAM

Does this patch help?

Con

--- linux-2.6.0-test1-mm2/kernel/sched.c	2003-07-24 10:31:41.000000000 +1000
+++ linux-2.6.0-test1ck2/kernel/sched.c	2003-07-25 08:18:54.000000000 +1000
@@ -1243,7 +1243,7 @@ void scheduler_tick(int user_ticks, int 
 		} else
 			enqueue_task(p, rq->active);
 	} else if (p->mm && !((task_timeslice(p) - p->time_slice) %
-		 (MIN_TIMESLICE * (MAX_BONUS + 1 - p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG)))){
+		 (MIN_TIMESLICE * (1 + (MAX_BONUS - p->sleep_avg * MAX_BONUS / MAX_SLEEP_AVG) / 2)))){
 		/*
 		 * Running user tasks get requeued with their remaining timeslice
 		 * after a period proportional to how cpu intensive they are to

