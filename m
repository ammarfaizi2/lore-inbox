Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbUJ0PDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUJ0PDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUJ0PC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:02:59 -0400
Received: from mail3.utc.com ([192.249.46.192]:46552 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262478AbUJ0PAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:00:22 -0400
Message-ID: <417FB7F0.4070300@cybsft.com>
Date: Wed, 27 Oct 2004 10:00:00 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027132926.GA7171@elte.hu>
In-Reply-To: <20041027132926.GA7171@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Running amlat [...]
> 
> 
> btw., to get good 'realfeel' results i had to apply the attached patch. 
> Especially when running realfeel over the network it can easily happen
> that it's delayed for some time and gets out of sync with the RTC. So
> after a new maximum latency has triggered the code now waits 10 periods
> to wait for the timings to recover.
> 
> this does not hurt the latency measurements in any way - latencies that
> occur after these 10 ticks (~5 msecs) are over are still fully measured
> and reported.
> 
> amlat produces weird output for me, continuously increasing latency
> values:
> 
>  latency = 2967939 milliseconds
>  latency = 2967950 milliseconds
>  sigint
>  max jitter = 0 microseconds
> 
> maybe some /dev/rtc API detail changed? Or is this the normal output?
> 
> 	Ingo
> 
Well to produce useful results, amlat requires Andrew's rtc-debug patch 
that modifies the rtc driver as well as traps so that timings are kept 
when the isr gets run and when the rtc device is read to track 
scheduling latencies. Also if this patch was applied the value being 
read by amlat from the rtc device would be the last interrupt time 
instead of the interrupt info that rtc normally produces. So the latency 
values being spit out are bogus, but it's good enough to exercise the rtc.

I use the rtc-debug and amlat to generate histograms of latencies which 
is what I was trying to do when I found the rtc problem the first time. 
I believe that rtc-debug/amlat is much more accurate for generating 
histograms of latencies than realfeel is because the instrumentation is 
in the kernel rather than a userspace program.

kr

