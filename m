Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWK3P5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWK3P5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030623AbWK3P5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:57:13 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:31528 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030621AbWK3P5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:57:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:from:message-id;
        b=Y7saFNIuXEZjaNUbgypbJByAglrOFpiXCsj5tbG9zDJMgpS93bYuJD6iy9hh0px+ta3/zWNavKuC8uQMtaxlKIENKCQtncExxZZpNFVq36ZrXGnmFzpqlk/2nXB09jYgRG9py/MZcnbhHJ0rtG9FLT4iuk86iwRhVwL2w+VqnT0=
Date: Fri, 01 Dec 2006 00:56:08 +0900 (JST)
To: tike64@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt and arm
In-Reply-To: <20061129085705.52839.qmail@web57906.mail.re3.yahoo.com>
References: <20061129085705.52839.qmail@web57906.mail.re3.yahoo.com>
X-Mailer: Mew version 4.2 on Emacs 22.0.91 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: junjiec@gmail.com
Message-ID: <456eff57.0e1fcf5c.617c.44a6@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Without the support of High Resolution Timer supported,
the timer resolution wouldn't change.
With high-resolution-timer supported,
our arm926-based board could get resolution like 40~50us.
There are codes you can reference ,may be you should just try to implement it.

JFI, Thanks.

From: tike64 <tike64@yahoo.com>
Subject: realtime-preempt and arm
Date: Wed, 29 Nov 2006 00:57:05 -0800 (PST)

> Hi all,
> 
> I'm trying the realtime-preempt patch-2.6.18-rt6 on
> lh7a400 arm system with little success. In a test
> program I try 5 ms timeout with select() but get 20 ms
> avg or 26 ms max. When the framebuffer scrolls, the
> max delay goes up to 59 ms. With a vanilla kernel I
> get 10 ms (because of tick resolution?), 11 ms and 39
> ms.
> 
> My question is, is the realtime-preempt patch supposed
> to work on arm architecture and/or without high
> resolution timer (which lh7a40x seems to lack) at all
> or should I just try to be more clever.
> 
> Relevant code:
> 
> ====
> prio.sched_priority = 99;
> if (sched_setscheduler(0, SCHED_RR, &prio) < 0) ...
> if (mlockall(MCL_CURRENT | MCL_FUTURE) < 0) ...
> while (1) {
> 	t = raw_timer();
> 	tv.tv_usec = 5000;
> 	tv.tv_sec = 0;
> 	select(0, 0, 0, 0, &tv);
> 	t = raw_timer() - t;
> 	if (max_t < t) max_t = t;
> 	if (min_t > t) min_t = t;
> 	avg_t += t;
> 	++n;
> 	if (n < 100) continue;
> 	printf("%i revs; min: %i max: %i avg: %i\n",
> 		n,
> 		min_t,
> 		max_t,
> 		(avg_t + n / 2) / n);
> ====
> 
> Relevant config: PREEMPT_RT, PREEMPT_SOFTIRQS,
> PREEMPT_HARDIRQS
> 
> I didnt' enable HIGH_RES_TIMERS because lh7a40x seems
> not to support it.
> 
> --
> 
> tike
> 
> 
> 
>  
> ____________________________________________________________________________________
> Cheap talk?
> Check out Yahoo! Messenger's low PC-to-Phone call rates.
> http://voice.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
