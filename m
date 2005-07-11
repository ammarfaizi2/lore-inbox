Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVGKPTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVGKPTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGKPQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:16:52 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:16211 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261967AbVGKPOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:14:33 -0400
Message-ID: <63108.195.245.190.94.1121094757.squirrel@www.rncbc.org>
In-Reply-To: <20050708095600.GA5910@elte.hu>
References: <1119375988.28018.44.camel@cmn37.stanford.edu>
    <1120256404.22902.46.camel@cmn37.stanford.edu>
    <20050703133738.GB14260@elte.hu>
    <1120428465.21398.2.camel@cmn37.stanford.edu>
    <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
    <20050707194914.GA1161@elte.hu>
    <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org>
    <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org>
    <20050708085253.GA1177@elte.hu>
    <28798.195.245.190.94.1120815616.squirrel@www.rncbc.org>
    <20050708095600.GA5910@elte.hu>
Date: Mon, 11 Jul 2005 16:12:37 +0100 (WEST)
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 11 Jul 2005 15:14:26.0772 (UTC) FILETIME=[3A2DC140:01C5862B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> OTOH, I'll take this chance to show you something that is annoying me
>> for quite some time. Just look to the attached chart where I've marked
>> the spot with an arrow and a question mark. Its just one example of a
>> strange behavior/phenomenon while running the jack_test4.2 test on
>> PREEMPT_RT kernels: the CPU usage, which stays normally around 50%,
>> suddenly jumps to 60% steady, starting at random points in time but
>> always some time after the test has been started. Note that this
>> randomness surely adds to the the slight differences found on the
>> above results.
>
> how long does this condition persist? Firstly, please upgrade to the
> -51-16 kernel, previous kernels had a condition where interrupt storms
> (or repeat interrupts) could occur. (Your irqs/sec values dont suggest
> such a condition, but it could still occur.)
>
> Then could you enable profiling (CONFIG_PROFILING=y and profile=1 boot
> parameter), and create a script like this to capture a kernel profile
> for a fixed amount of time:
>
>  #!/bin/bash
>
>  readprofile -r          # reset profile
>  sleep 10
>  readprofile -n -m /home/mingo/System.map | sort -n
>
> and start it manually when the anomaly triggers. Also start it during a
> 'normal' period of the test. The output should give us a rough idea of
> what is happening. This type of profiling is very low-overhead so it
> wont disturb the condition.
>
> Note that you can increase the frequency and the quality of profiling by
> enabling the NMI watchdog (LOCAL_APIC in the .config and nmi_watchdog=2
> boot option), in the -RT kernel it will automatically switch the
> profiling tick to occur from NMI context. Such tracing will also show
> overhead occuring in irqs-off functions.
>

After several trials, with CONFIG_PROFILING=y and profile=1 nmi_watchdog=2
as boot parameters, I'm almost convinced I'm doing something wrong :)

- `readprofile` always just outputs one line:

     0 total                                    0.0000

- `readprofile -a` gives the whole kernel symbol list, all with zero times.

Is there anything else I can check around here?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

