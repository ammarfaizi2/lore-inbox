Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVAEVUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVAEVUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVAEVUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:20:42 -0500
Received: from relay01.pair.com ([209.68.5.15]:4874 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S262592AbVAEVUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:20:21 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41DC5A0E.6000403@cybsft.com>
Date: Wed, 05 Jan 2005 15:20:14 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark_H_Johnson@Raytheon.com
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Real-Time Preemption, comparison to 2.6.10-mm1
References: <OF736AB5F1.DCE25423-ON86256F80.00622744-86256F80.0062278E@raytheon.com>
In-Reply-To: <OF736AB5F1.DCE25423-ON86256F80.00622744-86256F80.0062278E@raytheon.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark_H_Johnson@Raytheon.com wrote:
> K.R. Foley wrote:
> 
>>Mark_H_Johnson@raytheon.com wrote:
> 
> [snip - long explanation of how a nice application can starve a non
> nice application for minutes at a time on an SMP system]
> 
> 
>>>My point was that -mm definitely has the problem (though to a lesser
>>>degree). The tests I ran showed it on both the disk read and disk copy
>>>stress tests. I guess I should try a vanilla 2.6.10 run as well to see
>>>if it is something introduced in the -mm series (it certainly is not a
>>>recent change...).
>>
>>I'm curious if anyone is seeing this behavior on UP systems, or is it
>>only happening on SMP?
> 
> The build of 2.6.10 vanilla just completed and I reran my tests with
> SMP and with MAXCPUS=1 (UP w/ SMP kernel).

Well that blows one of the theories I was looking at. :( -mm is carrying 
a patch that lengthens the cache_hot_time to roughly a ms instead of a 
usec, which could effect how fast tasks might be migrated to an idle cpu.
> 
> The vanilla 2.6.10 kernel has the non RT starvation problem as well
> for both test runs. It looks like this is not something in -mm but a
> change between 2.4 and 2.6.
> 
> I did notice the test results were a little inconsistent between the
> two runs...
>              2.6.10 SMP    2.6.10 UP (w/ SMP kernel)
> disk write    starved          OK
> disk copy        OK         starved
> disk read     starved       starved
> but in both cases, a non nice (non RT) disk application was
> starved by a nice (non RT) cpu application for minutes.

Do you have a simple way of triggering and trapping the starvation? That 
of course is probably asking for a lot. :)

kr

> 
> I wonder who I should be talking to next (or submit a bug report?)
> about this.
> 
>   --Mark
> 
> 

