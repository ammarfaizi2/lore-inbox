Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWAKBlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWAKBlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWAKBlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:41:50 -0500
Received: from smtp-out.google.com ([216.239.45.12]:58270 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161049AbWAKBlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:41:50 -0500
Message-ID: <43C4624D.4040604@google.com>
Date: Tue, 10 Jan 2006 17:41:33 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <20060110173159.55cce659.akpm@osdl.org>
In-Reply-To: <20060110173159.55cce659.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Bligh <mbligh@google.com> wrote:
> 
>>OK, I fixed the graphs so you can actually read them now ;-)
> 
> They're cute.

Thanks. Hopefully we can also make them useful ;-)

Have finally got some time to play, and am working on a "push" 
comparison model that'll send you email pro-actively.

>>http://test.kernel.org/perf/kernbench.elm3b6.png (x86_64 4x)
>>http://test.kernel.org/perf/kernbench.moe.png (NUMA-Q)
>>http://test.kernel.org/perf/kernbench.elm3b132.png (4x SMP ia32)
>>
>>Both seems significantly slower on -mm (mm is green line)
> 
> 
> Well, 1% slower.  -mm has permanent not-for-linus debug things, some of
> which are expected to have a performance impact.  I don't know whether
> they'd have a 1% impact though.

OK, fair enough. Can I turn them off somehow to check? it's 10% on 
NUMA-Q. The good news is that it's stayed in -mm for long time, so ...
am praying.

Is cool to have extra debug stuff. It does make it harder to check perf 
though ... if we can do runs both with and without, it'd be ideal, I 
guess. I'd like to be able to spot perf degredations before they hit 
mainline.

>>If I look at diffprofile between 2.6.15 and 2.6.15-mm1, it just looks
>>like we have lots more idle time.
> 
> 
> Yes, we do.   It'd be useful to test -git7..

Will do. it does all of them.

>>You got strange scheduler changes in
>>there, that you've been carrying for a long time (2.6.14-mm1 at least)? 
>>or HZ piddling? See to be mainly getting much more idle time.
> 
> Yes, there are CPU scheduler changes, although much fewer than usual. 
> Ingo, any suggestions as to a culprit?

I'd truncated all -mm info in the filtering before 2.6.14 .. am putting 
it back so we can see clearly ... done. Look again.

Seems to have gone wrong between 2.6.14-rc1-mm1 and 2.6.14-rc2-mm1 ?
See http://test.kernel.org/perf/kernbench.moe.png for clearest effect.

M.
