Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVCVPGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVCVPGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCVPGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:06:45 -0500
Received: from mail4.utc.com ([192.249.46.193]:24765 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261336AbVCVPGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:06:40 -0500
Message-ID: <42403473.6010400@cybsft.com>
Date: Tue, 22 Mar 2005 09:06:27 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu>
In-Reply-To: <20050322112856.GA25129@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* Ingo Molnar <mingo@elte.hu> wrote:
>>
>>
>>>hm, another thing: i think call_rcu() needs to take the read-lock.
>>>Right now it assumes that it has the data structure private, but
>>>that's only statistically true on PREEMPT_RT: another CPU may have
>>>this CPU's RCU control structure in use. So IRQs-off (or preempt-off)
>>>is not a guarantee to have the data structure, the read lock has to be
>>>taken.
>>
>>i've reworked the code to use the read-lock to access the per-CPU data
>>RCU structures, and it boots with 2 CPUs and PREEMPT_RT now. The
>>-40-05 patch can be downloaded from the usual place:
> 
> 
> bah, it's leaking dentries at a massive scale. I'm giving up on this
> variant for the time being and have gone towards a much simpler variant,
> implemented in the -40-07 patch at:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 

Actually this is more correctly related to -RT-2.6.12-rc1-V0.7.41-08. 
This one boots on one of my SMP systems (dual 2.6 GHz Zeon)  doesn't on 
the other (dual PIII 933 MHz). Unfortunately not close to the one that 
doesn't boot right now so can't debug it at all.

Was still building on the UP box, but now that one seems to have gone 
down in flames. This system was running -RT-2.6.12-rc1-V0.7.41-00 while 
trying to build -RT-2.6.12-rc1-V0.7.41-07. :(

-- 
    kr
