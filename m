Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVAaXAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVAaXAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVAaXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:00:38 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:28804 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261417AbVAaXAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:00:10 -0500
Message-ID: <41FEB8BA.7000106@kolivas.org>
Date: Tue, 01 Feb 2005 10:01:14 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>	<41FE9582.7090003@kolivas.org> <87651di55a.fsf@sulphur.joq.us>
In-Reply-To: <87651di55a.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>Sure enough I found the bug in less than 5 mins, and it would
>>definitely cause this terrible behaviour.
>>
>>A silly bracket transposition error on my part :P
> 
> 
> The corrected version works noticeably better, but still nowhere near
> as well as SCHED_FIFO.  The first run had a cluster of really bad
> xruns.  The second and third were much better, but still with numerous
> small xruns.
> 
>   http://www.joq.us/jack/benchmarks/sched-iso-fix/
> 
> With a compile running in the background it was a complete failure.
> Some kind of big xrun storm triggered a collapse on every attempt.
> 
>   http://www.joq.us/jack/benchmarks/sched-iso-fix+compile/
> 
> The summary statistics are mixed.  The delay_max is noticeably better
> than before, but still much worse than SCHED_FIFO.  But, the xruns are
> really bad news...

Excellent.

Believe it or not these look like good results to me. Your XRUNS are 
happening when the DSP load is >70% which is the iso_cpu % cutoff. Try 
setting the iso_cpu to 90%

echo 90 > /proc/sys/kernel/iso_cpu

Cheers,
Con
