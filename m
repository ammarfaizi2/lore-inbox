Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUJINWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUJINWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 09:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJINWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 09:22:05 -0400
Received: from relay.pair.com ([209.68.1.20]:63499 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266820AbUJINV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 09:21:58 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <4167E5F5.3040700@cybsft.com>
Date: Sat, 09 Oct 2004 08:21:57 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: voluntary-preempt-2.6.9-rc3-mm3-T3
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>	 <20041007105230.GA17411@elte.hu>	 <1097297824.1442.132.camel@krustophenia.net>	 <cone.1097298596.537768.1810.502@pc.kolivas.org> <1097299260.1442.142.camel@krustophenia.net>
In-Reply-To: <1097299260.1442.142.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2004-10-09 at 01:09, Con Kolivas wrote:
> 
>>Lee Revell writes:
>>
>>
>>>On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
>>>
>>>>i've released the -T3 VP patch:
>>>>
>>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
>>>>
>>>
>>>With VP and PREEMPT in general, does the scheduler always run the
>>>highest priority process, or do we only preempt if a SCHED_FIFO process
>>>is runnable?
>>
>>Always the highest priority runnable.
>>
> 
> 
> Hmm, interesting.  Would there be any advantage to a mode where only
> SCHED_FIFO tasks can preempt?  This seems like a much lighter way to
> solve the realtime problem.
> 
> Lee
> 
> 
IMHO I don't think this gains us anything and I think that it would be a
big step backward for desktop performance (any processes not scheduled
RT). Not only that but I think you still have to have all of the
overhead of the scheduler and the preemption points if you are going to
service the RT threads. Otherwise, how do you schedule RT processes that
are waiting for some I/O (that is ready) and another non-RT process is
going through a code path in the kernel. The RT process now has a much
worse latency. There very well may be ways to accomplish this
effectively that I just don't understand.

kr

