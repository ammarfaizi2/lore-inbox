Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUKJORB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUKJORB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUKJOOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:14:17 -0500
Received: from lax-gate4.raytheon.com ([199.46.200.233]:36269 "EHLO
	lax-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261941AbUKJOJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:09:43 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Date: Wed, 10 Nov 2004 08:08:11 -0600
Message-ID: <OF5FEE4152.258EB1B2-ON86256F48.004DA741-86256F48.004DA76D@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/10/2004 08:08:19 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> [4] Application level latencies are OK but not great.
>>  X test - only 90% of CPU loops are within 100 usec of nominal value.
>> In previous RT kernels I got > 99% with 100 usec.
>
>this might be a side-effect of the chrt-ing of events/[0|1] and/or
>ksoftirqd (which we did to debug the 'freeze' problems) - are those
>still chrt-ed?
For reference:
# ps -eo pid,pri,rtprio,cmd | grep '\['
    1  23      - init [5]
    2 139     99 [migration/0]
    3  34      - [ksoftirqd/0]
    4  34      - [desched/0]
    5 139     99 [migration/1]
    6  34      - [ksoftirqd/1]
    7  34      - [desched/1]
    8  41      1 [events/0]
    9  41      1 [events/1]
   10  34      - [khelper]
   15  32      - [kthread]
   27  34      - [kblockd/0]
   28  34      - [kblockd/1]
   36  24      - [khubd]
  103  23      - [kswapd0]
  104  32      - [aio/0]
  105  33      - [aio/1]
  180 139     99 [IRQ 8]
  195  14      - [kseriod]
  201 139     99 [IRQ 12]
  237 139     99 [IRQ 14]
  239 139     99 [IRQ 15]
  278 139     99 [IRQ 1]
  310  24      - [kirqd]
  313 139     99 [IRQ 4]
  320  24      - [kjournald]
  605 139     99 [IRQ 10]
 1206  24      - [kjournald]
 1207  24      - [kjournald]
 1309 139     99 [IRQ 3]
 1323  31      - [IRQ 7]
 1494 139     99 [IRQ 6]
 1748 139     99 [IRQ 11]
14131  23      - [pdflush]
14242  24      - [pdflush]
17337  21      - grep \[

>Please review and double-check all SCHED_FIFO tasks in
>the system and keep only those that are absolutely necessary for
>latencytest's operation [i.e. the soundcard IRQ and latencytest itself]
>- everything else should be SCHED_OTHER. Do latencies get any better if
>you do this?
I can, but that is not necessarily an "apples to apples" comparison.
When I compare with 2.4 preempt + low latency kernels, the X stress
test had > 99% of the samples within 100 usec of the nominal value.
Don't forget - on a 2.4 kernel, the IRQ's are all unthreaded. On
the 2.4 kernel, heavy disk I/O is where I get the worst behavior
and even then, I get > 90% of samples within 100 usec.

I still maintain that a 2.6 RT kernel has to do as well or better
than a 2.4 RT kernel (or else, why would I step up??).

  --Mark

