Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269795AbUICTyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269795AbUICTyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269803AbUICTxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:53:49 -0400
Received: from mail3.utc.com ([192.249.46.192]:22162 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S269795AbUICTuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:50:35 -0400
Message-ID: <4138CACD.1030905@cybsft.com>
Date: Fri, 03 Sep 2004 14:49:33 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu> <20040903193052.GA16617@elte.hu>
In-Reply-To: <20040903193052.GA16617@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>i'll add a new feature to debug this: when crashing on an assert and
>>tracing is enabled the trace leading up to the crash will be printed
>>to the console. [...]
> 
> 
> the -R3 patch has this feature:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R3 
> 
> you can enable it via enabling CONFIG_LATENCY_TRACE and doing:
> 
>   echo 3 > /proc/sys/kernel/trace_enabled
> 
> it's all automatic from this point on: tracing will happen nonstop and
> any assert or crash that prints the process stack will also print the
> last 100 trace entries. Sample output:
> 
>  Call Trace:
>   [<c0160401>] sys_munmap+0x61/0x80
>   [<c010520d>] sysenter_past_esp+0x52/0x71
>  Last 100 trace entries:
>  00000001: zap_pmd_range+0xe/0x90  <= (unmap_page_range+0x55/0x80)
>  00000001: stop_trace+0x8/0x20  <= (bust_spinlocks+0x20/0x60)
>  00000001: bust_spinlocks+0xe/0x60  <= (die+0xbc/0x2a0)
>  [... 97 more trace entries ...]
> 
> Please capture and mail the first 'extended' oops that triggers
> (secondary followup traces are probably just side-effects of the crash),
> it could give us clues about where the bug is.
> 
> 	Ingo
> 

Building now.

kr
