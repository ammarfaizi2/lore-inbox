Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVHATGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVHATGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVHATGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:06:01 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:58524 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261172AbVHATF7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:05:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aqC9szHgUf50hTYugf9bnsLTkuKFRqwfiUQDg1Z+LXyG2QsrsDAKFl02FgotYIBJyVz5TT1Rsmq1q5cXbn4/fiMeBVmZtYoWDT6Grd74U5HopWJkglp0DFNVmwQGQYR8YYGNreEIJUsoj2HHRjarVdfLlAxqb77txgltLqPH6ds=
Message-ID: <ff1cadb205080112051847d6eb@mail.gmail.com>
Date: Mon, 1 Aug 2005 19:05:58 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
Reply-To: Luca Falavigna <dktrkranz@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED declaration
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <1122922658.6759.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EE4D27.8060500@gmail.com>
	 <1122922658.6759.22.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ingo purposely put this in to crash
> the compile so that we know where this can be a problem right away.
And it works nice ;)

> The patch you wanted to send was:
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c
> ===================================================================
> --- linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c        (revision 265)
> +++ linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c        (working copy)
> @@ -56,7 +56,7 @@
>  /* some device data */
> 
>  static struct {
> -       struct semaphore stop;
> +       struct compat_semaphore stop;
>         volatile int running;
>         struct timer_list timer;
>         volatile int queue;

Another solution could be this (as shown in drivers/cpufreq/cpufreq.c):
-	init_MUTEX_LOCKED(&policy->lock);
+	init_MUTEX(&policy->lock);
+	down(&policy->lock);
