Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVCUPm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVCUPm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCUPm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:42:58 -0500
Received: from mail4.utc.com ([192.249.46.193]:17616 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261831AbVCUPmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:42:53 -0500
Message-ID: <423EEB6F.3050200@cybsft.com>
Date: Mon, 21 Mar 2005 09:42:39 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
References: <20050319191658.GA5921@elte.hu> <1111278282.15042.28.camel@mindpipe>
In-Reply-To: <1111278282.15042.28.camel@mindpipe>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-03-19 at 20:16 +0100, Ingo Molnar wrote:
> 
>>i have released the -V0.7.41-00 Real-Time Preemption patch (merged to
>>2.6.12-rc1), which can be downloaded from the usual place:
>>
>>  http://redhat.com/~mingo/realtime-preempt/
>>
> 
> 
> 3ms latency in the NFS client code.  Workload was a kernel compile over
> NFS.
> 
> preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.41-00
> --------------------------------------------------------------------
>  latency: 3178 �s, #4095/14224, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
>     -----------------
>     | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
>     -----------------
> 
>                  _------=> CPU#            
>                 / _-----=> irqs-off        
>                | / _----=> need-resched    
>                || / _---=> hardirq/softirq 
>                ||| / _--=> preempt-depth   
>                |||| /                      
>                |||||     delay             
>    cmd     pid ||||| time  |   caller      
>       \   /    |||||   \   |   /           
> (T1/#0)            <...> 32105 0 3 00000004 00000000 [0011939614227867] 0.000ms (+4137027.445ms): <6500646c> (<61000000>)
> (T1/#2)            <...> 32105 0 3 00000004 00000002 [0011939614228097] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x9a/0xd0 <c013150a> (try_to_wake_up+0x94/0x140 <c0110474>)
> (T1/#3)            <...> 32105 0 3 00000003 00000003 [0011939614228436] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b57c1> (try_to_wake_up+0x94/0x140 <c0110474>)
> (T3/#4)    <...>-32105 0dn.3    0�s : try_to_wake_up+0x11e/0x140 <c01104fe> <<...>-2> (69 76): 
> (T1/#5)            <...> 32105 0 3 00000002 00000005 [0011939614228942] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b57c1> (try_to_wake_up+0xf8/0x140 <c01104d8>)
> (T1/#6)            <...> 32105 0 3 00000002 00000006 [0011939614229130] 0.000ms (+0.000ms): wake_up_process+0x35/0x40 <c0110555> (do_softirq+0x3f/0x50 <c011b05f>)
> (T6/#7)    <...>-32105 0dn.1    1�s < (1)
> (T1/#8)            <...> 32105 0 2 00000001 00000008 [0011939614229782] 0.001ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee> (nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
> (T1/#9)            <...> 32105 0 2 00000001 00000009 [0011939614229985] 0.001ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup+0x52/0x70 <c01e0632>)
> (T1/#10)            <...> 32105 0 2 00000001 0000000a [0011939614230480] 0.001ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee> (nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
> (T1/#11)            <...> 32105 0 2 00000001 0000000b [0011939614230634] 0.002ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup+0x52/0x70 <c01e0632>)
> (T1/#12)            <...> 32105 0 2 00000001 0000000c [0011939614230889] 0.002ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee> (nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
> (T1/#13)            <...> 32105 0 2 00000001 0000000d [0011939614231034] 0.002ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup+0x52/0x70 <c01e0632>)
> (T1/#14)            <...> 32105 0 2 00000001 0000000e [0011939614231302] 0.002ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee> (nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
> (T1/#15)            <...> 32105 0 2 00000001 0000000f [0011939614231419] 0.002ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup+0x52/0x70 <c01e0632>)
> 
> (last two lines just repeat)
> 
> This is probably not be a regression; I had never tested this with NFS
> before.
> 
> Lee
> 

Lee,

I did some testing with NFS quite a while ago. Actually it was the NFS 
compile within the stress-kernel pkg. I had similar crappy performance 
problems. Ingo pointed out that there were serious locking issues with 
NFS and suggested that I report the problems to the NFS folks, which I 
did. The reports seemed to fall mostly on deaf ears, at least that was 
my perspective. I decided to move on and took the NFS compile out of my 
stress testing to be revisited at a later time.

-- 
    kr
