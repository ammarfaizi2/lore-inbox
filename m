Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbRGOU2C>; Sun, 15 Jul 2001 16:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbRGOU1w>; Sun, 15 Jul 2001 16:27:52 -0400
Received: from sncgw.nai.com ([161.69.248.229]:33997 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S266976AbRGOU1n>;
	Sun, 15 Jul 2001 16:27:43 -0400
Message-ID: <XFMail.20010715133112.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010715221542.B14480@gruyere.muc.suse.de>
Date: Sun, 15 Jul 2001 13:31:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: CPU affinity & IPI latency
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Larry McVoy <lm@bitmover.com>,
        David Lang <david.lang@digitalinsight.com>,
        Mike Kravetz <mkravetz@sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15-Jul-2001 Andi Kleen wrote:
> On Fri, Jul 13, 2001 at 03:43:05PM -0700, Mike Kravetz wrote:
>> - Define a new field in the task structure 'saved_cpus_allowed'.
>>   With a little collapsing of existing fields, there is room to put
>>   this on the same cache line as 'cpus_allowed'.
>> - In reschedule_idle() if we determine that the best CPU for a task
>>   is the CPU it is associated with (p->processor), then temporarily
>>   bind the task to that CPU.  The task is temporarily bound to the
>>   CPU by overwriting the 'cpus_allowed' field such that the task can
>>   only be scheduled on the target CPU.  Of course, the original
>>   value of 'cpus_allowed' is saved in 'saved_cpus_allowed'.
>> - In schedule(), the loop which examines all tasks on the runqueue
>>   will restore the value of 'cpus_allowed'.
> 
> This sounds racy, at least with your simple description. Even other CPUs
> could walk their run queue while the IPI is being processed and reset the
> cpus_allowed flag too early. I guess it would need a check in the 
> schedule loop that restores cpus_allowed that the current CPU is the only
> on set in that task's cpus_allowed. This unfortunately would hang the
> process if the CPU for some reason cannot process schedules timely, so
> it may be needed to add a timestamp also to the task_struct that allows 
> the restoration of cpus_allowed even from non target CPUs after some
> time.

I previously expressed ( maybe in this thread, I don't remember ) my idea of
not touching ( hacking ) the current scheduler to let it fit to SMP, that IMHO,
has different problems and needs different answers.
Anyway, as I said a couple of messages ago, the solution of this problem could
be to move the moved task in a private ( per CPU ) wakeup list that, when the
idle comes up, it'll be ran.





- Davide

