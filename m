Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271801AbUKAR34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271801AbUKAR34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272241AbUKAR34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:29:56 -0500
Received: from mail3.utc.com ([192.249.46.192]:7313 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266857AbUKARYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:24:50 -0500
Message-ID: <41867143.4020709@cybsft.com>
Date: Mon, 01 Nov 2004 11:24:19 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
References: <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu>
In-Reply-To: <20041101140630.GA20448@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>>removing the poll() lines doesnt seem to impact the quality of the
>>>data, but i still see roughly 50 usecs added to the 'real' latency
>>>that i see in traces.
>>
>>this i think is related to what Thomas observed, that there's a new
>>irqs-off critical section somewhere. (it's in the new priority
>>handling code i think.)
> 
> 
> ah, found it. Only RT tasks were supposed to get special priority
> handling, while in fact all tasks got it - so when Thomas ran hackbench
> (Thomas, you did, right?) it created an O(nr_hackbench) overhead within
> the mutex code ... I've uploaded -V0.6.5 to the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 

V0.6.5 built and booted fine on my SMP workstation. However, just a few 
minutes after booting it exhibited behavior like a system does when you 
can't fork any new processses.
The system was responsive.
I could switch between windows.
I could switch from X to a virtual terminal.
I could type in commands but they never return.
At the virtual terminal login I could type the login but never get a 
passwd prompt.
Nothing in the logs during this timeframe.
Reset button was the only way to recover.

kr

