Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbULJE0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbULJE0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbULJE0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:26:53 -0500
Received: from relay03.pair.com ([209.68.5.17]:35079 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261684AbULJE0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:26:50 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41B92588.4060106@cybsft.com>
Date: Thu, 09 Dec 2004 22:26:48 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <OFADAD8EC1.8BCE1EC6-ON86256F65.005EFFA6@raytheon.com> <20041209173136.GE7975@elte.hu> <41B8B6C4.60200@cybsft.com> <20041209220632.GE14194@elte.hu>
In-Reply-To: <20041209220632.GE14194@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>running realfeel with rtc histogram generates > 100 usec entries in
>>the histogram but none of these are ever caught by the wakeup tracing.
> 
> 
> can you reproduce this with rtc_wakeup:
> 
>   http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup
> 
> ?
> 
> 
>>I think I know why we don't get traces from this. TIF_NEED_RESCHED is
>>not set for IRQ 8 at the time that it wakes up realfeel so
>>_need_resched fails and trace_start_sched_wakeup doesn't actually call
>>__trace_start_sched_wakeup(p)???
> 
> 
> here's the code:
> 
> +static inline void trace_start_sched_wakeup(task_t *p, runqueue_t *rq)
> +{
> +       if (TASK_PREEMPTS_CURR(p, rq) && (p != rq->curr) && _need_resched())
> +               __trace_start_sched_wakeup(p);
> +}
> 
> indeed this only triggers if the woken up task has a higher priority
> than the waker... hm. Could you try to reverse the priorities of 
> realfeel and IRQ8, does that produce traces?

I guess I really am slow. You laid it all out for me above and I still 
didn't get it until I looked at again. I still haven't been able to 
capture an actual trace from any of these programs, but thanks to your 
addition of logging all of the max latencies in 32-14 I can see that the 
traces were there until another trace pushes them out.
> 
> 	Ingo
> 

