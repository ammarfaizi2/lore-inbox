Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVBACoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVBACoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 21:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVBACoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 21:44:55 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:22242 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261509AbVBACox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 21:44:53 -0500
Message-ID: <41FEED69.9060904@kolivas.org>
Date: Tue, 01 Feb 2005 13:46:01 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>	<41FE9582.7090003@kolivas.org> <87651di55a.fsf@sulphur.joq.us>	<41FEB8BA.7000106@kolivas.org> <87fz0hf20z.fsf@sulphur.joq.us>
In-Reply-To: <87fz0hf20z.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> The fact that the results did improve with the 90% setting suggests
> that there may be a bug in your throttling or time accounting.  The
> DSP load for this test should hover around 50% when things are working
> properly.  It should never hit a 70% limit, not even momentarily.  The
> background compile should not affect that, either.
> 
> Something seems to be causing scheduling delays when the sound card
> interrupt causes jackd to become runnable.  Ingo's nice(-20) patches
> seem to have the same problem, but his RLIMIT_RT_CPU version does not.

Good work. Looks like you're probably right about the accounting. It may 
be as simple as the fact that it is on the timer tick that we're getting 
rescheduled and this ends up being accounted as more since the 
accounting happens only at the scheduler tick. A test run setting 
iso_cpu at 100% should tell you if it's accounting related - however the 
RLIMIT_RT_CPU patch is accounted in a similar way so I'm not sure there 
isn't another bug hanging around. I'm afraid on my hardware it has been 
behaving just like SCHED_FIFO for some time which is why I've been 
hanging on your results. You're not obliged to do anything (obviously), 
but the 100% run should help discriminate where the problem is.

Since I've come this far with the code I'll have another look for any 
other obvious bugs.

Cheers,
Con
