Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVASO0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVASO0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVASO0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:26:19 -0500
Received: from mail.joq.us ([67.65.12.105]:58255 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261633AbVASO0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:26:12 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <87is5tx61a.fsf@sulphur.joq.us>
	<41EE12AB.9020604@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 08:27:48 -0600
In-Reply-To: <41EE12AB.9020604@kolivas.org> (Con Kolivas's message of "Wed,
 19 Jan 2005 18:56:27 +1100")
Message-ID: <87y8eptrx7.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
>> Con Kolivas <kernel@kolivas.org> writes:
>>
>>>This patch for 2.6.11-rc1 provides a method of providing real time
>>>scheduling to unprivileged users which increasingly is desired for
>>>multimedia workloads.
>> I ran some jack_test3.2 runs with this, using all the default
>> settings.  The results of three runs differ quite significantly for no
>> obvious reason.  I can't figure out why the DSP load should vary so
>> much.  These may be bogus results.  It looks like a libjack bug
>> sometimes
>> causes clients to crash when deactivating.  I will investigate more
>> tomorrow, and come up with a fix.
>> For comparison, I also made a couple of runs using the realtime-lsm
>> to
>> grant SCHED_FIFO privileges.  There was some variablility, but nowhere
>> near as much (and no crashes).  I used schedtool to verify that the
>> jackd threads actually have the expected scheduler type.
>
> Thanks for those. If you don't know what to make of the dsp variation
> and the crashing then I'm not sure what I should make of it
> either. It's highly likely that my code still needs fixing to ensure
> it behaves as expected. Already one bug has been picked up in testing
> with respect to yield() so there may be others. By design, if you set
> iso_cpu to 100 it should be as good as SCHED_RR. If not, then the
> implementation is still buggy.

I fixed that bug in libjack, eliminating the crashes on disconnect.

They must have been perturbing the numbers quite a bit.  Here are
three more runs (all SCHED_ISO).  The results are much more
consistent.  The only significant anomaly I see now is that small
Delay Max in the first run.

*** Terminated Wed Jan 19 01:04:55 CST 2005 ***
************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    1)          (    5)         (    3)         
XRUN Count  . . . . . . . . . :     2               16              15          
Delay Count (>spare time) . . :     0                0               0          
Delay Count (>1000 usecs) . . :     0                0               0          
Delay Maximum . . . . . . . . : 11932   usecs    101053  usecs   98719   usecs  
Cycle Maximum . . . . . . . . :   868   usecs     1099   usecs     887   usecs  
Average DSP Load. . . . . . . :    37.9 %           33.6 %          36.0 %      
Average CPU System Load . . . :    10.2 %            9.0 %           9.9 %      
Average CPU User Load . . . . :    24.5 %           22.7 %          23.0 %      
Average CPU Nice Load . . . . :     0.0 %            0.0 %           0.0 %      
Average CPU I/O Wait Load . . :     0.6 %            3.4 %           0.4 %      
Average CPU IRQ Load  . . . . :     0.7 %            0.7 %           0.7 %      
Average CPU Soft-IRQ Load . . :     0.0 %            0.0 %           0.0 %      
Average Interrupt Rate  . . . :  1688.1 /sec      1696.1 /sec     1685.2 /sec   
Average Context-Switch Rate . : 11727.9 /sec     10642.4 /sec    11568.3 /sec
*********************************************

I should probably experiment with higher thresholds on the SCHED_ISO class.
-- 
  joq
