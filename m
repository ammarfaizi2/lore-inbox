Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUIJCcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUIJCcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUIJCcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:32:03 -0400
Received: from relay.pair.com ([209.68.1.20]:35083 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267189AbUIJCb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:31:57 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <41411214.4000205@cybsft.com>
Date: Thu, 09 Sep 2004 21:31:48 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Lee Revell <rlrevell@joe-job.com>,
       Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
References: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com> <20040908184231.GA8318@elte.hu>
In-Reply-To: <20040908184231.GA8318@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
> 
> 
>>If you look at the date / time of the traces, you will notice that
>>most occur in the latter part of the test. This is during the "disk
>>copy" and "disk read" parts of the testing. [...]
> 
> 
> would it be possible to test with DMA disabled? (hdparm -d0 /dev/hda) It
> might take some extra work to shun the extra latency reports from the
> PIO IDE path (which is quite slow) but once that is done you should be
> able to see whether these long 0.5 msec delays remain even if all (most)
> DMA activity has been eliminated.
> 
> 
>>preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
>>--------------------------------------------------
>> latency: 550 us, entries: 6 (6)
>>    -----------------
>>    | task: cat/6771, uid:0 nice:0 policy:0 rt_prio:0
>>    -----------------
>> => started at: kmap_atomic+0x23/0xe0
>> => ended at:   kunmap_atomic+0x7b/0xa0
>>=======>
>>00000001 0.000ms (+0.000ms): kmap_atomic (file_read_actor)
>>00000001 0.000ms (+0.000ms): page_address (file_read_actor)
>>00000001 0.000ms (+0.549ms): __copy_to_user_ll (file_read_actor)
>>00000001 0.550ms (+0.000ms): kunmap_atomic (file_read_actor)
>>00000001 0.550ms (+0.000ms): sub_preempt_count (kunmap_atomic)
>>00000001 0.550ms (+0.000ms): update_max_trace (check_preempt_timing)
>
> 
> this is a full page copy, from userspace into a kernelspace pagecache
> page. This shouldnt take 500 usecs on any hardware. Since this is a
> single instruction (memcpy's rep; movsl instruction) there's nothing
> that Linux can do to avoid (or even to cause) such a situation.

I saw this one (or one very similar) on a system that I just started 
testing on some today. Not quite as high (~219 usec if I remember 
correctly). I don't have access to the system from here. I will forward 
the trace tomorrow when I'm there tomorrow. However, I haven't seen this 
on my slower system running the same stress tests.  There are several 
possible points of interest:

System I saw this on:
P4 2.4GHz or 3.0GHz
2GB memory
2.6.9-rc1-bk12-S0 built for SMP (even though hyperthreading is off 
currently)

System I haven't seen this on:
PII 450
256MB memory
2.6.9-rc1-bk12-R6 built for UP

Sorry I don't have more complete data in front of me. I will send the 
concrete info tomorrow with the trace.

kr
