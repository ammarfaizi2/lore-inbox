Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135713AbRAWCUd>; Mon, 22 Jan 2001 21:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135860AbRAWCUX>; Mon, 22 Jan 2001 21:20:23 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:7691 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S135713AbRAWCUI>; Mon, 22 Jan 2001 21:20:08 -0500
Message-ID: <3A6CEB02.3050906@redhat.com>
Date: Mon, 22 Jan 2001 20:22:58 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <mkravetz@sequent.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: more on scheduler benchmarks
In-Reply-To: <20010122101738.B7427@w-mikek.des.sequent.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I've been off in the hardware lab for too long, but how about

1. using ioperm to give access to the parallel port.
2. have your program write a byte (thread id % 256 ?) constantly to the 
port during it's other activity
3. capture the results from another computer with an ecp port

This way you don't run the risk of altering the scheduler behavior with 
your logging procedure.

Mike Kravetz wrote:

> Last week while discussing scheduler benchmarks, Bill Hartner
> made a comment something like the following "the benchmark may
> not even be invoking the scheduler as you expect".  This comment
> did not fully sink in until this weekend when I started thinking
> about changes made to sched_yield() in 2.4.0.  (I'm cc'ing Ingo
> Molnar because I think he was involved in the changes).  If you
> haven't taken a look at sys_sched_yield() in 2.4.0, I suggest
> that you do that now.
> 
> A result of new optimizations made to sys_sched_yield() is that
> calling sched_yield() does not result in a 'reschedule' if there
> are no tasks waiting for CPU resources.  Therefore, I would claim
> that running 'scheduler benchmarks' which loop doing sched_yield()
> seem to have little meaning/value for runs where the number of
> looping tasks is less than then number of CPUs in the system.  Is
> that an accurate statement?
> 
> If the above is accurate, then I am wondering what would be a
> good scheduler benchmark for these low task count situations.
> I could undo the optimizations in sys_sched_yield() (for testing
> purposes only!), and run the existing benchmarks.  Can anyone
> suggest a better solution?
> 
> Thanks,


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
