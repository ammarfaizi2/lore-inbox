Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUITRQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUITRQC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUITRQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:16:02 -0400
Received: from mail4.utc.com ([192.249.46.193]:43770 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S266808AbUITRPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:15:33 -0400
Message-ID: <414F1010.2060504@cybsft.com>
Date: Mon, 20 Sep 2004 12:14:56 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
References: <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
In-Reply-To: <20040919122618.GA24982@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -S1 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1
> 
> NOTE: this patch is against Andrew's -mm tree and the VP patchset will
> stay based on -mm until the merging process has been finished.
> 
> to get a 2.6.9-rc2-mm1-VP-S1 kernel, the patching order is:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
>  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc2.bz2
>  + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/2.6.9-rc2-mm1.bz2
>  + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1
> 
> Changes relative to -S0:
> 
> - lots of merging. A good chunk of the VP patch latency breakers and
>   support patches are in -mm already.
> 
> - integrated my 'preemptible big kernel lock' patch into VP. This makes 
>   all BKL code preemptible while keeping correctness. A new debugging 
>   infrastructure has been added to catch code that might use the BKL
>   in an unsafe way. If the debugging check triggers it will print 
>   messages like:
> 
>     using smp_processor_id() in preemptible code: bash/1020
> 
>   please report such messages and backtraces to me. Most of the messages 
>   i've fixed so far were false positives, but one bug has been caught 
>   already via this.
> 
>   Also, this BKL patch allowed the removal of two questionable 
>   latency breakers: the tty.c and the DRM BKL relaxation hack.
> 
> - fixed an SMP hardirq redirection bug - IRQ threads could be bound to 
>   multiple CPUs resulting in potentially illegal preemption of hardirq
>   contexts.
> 
> - temporarily dropped the ppc/ppc64 GENERIC_HARDIRQS changes, they broke
>   and i cannot test them.
> 
> Reports, comments welcome,
> 
> 	Ingo
> -

Is anyone else having trouble getting this to build on x86 smp? I am 
getting undefined references to smp_processor_id within most, if not 
all, modules.

kr
