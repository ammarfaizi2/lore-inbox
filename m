Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUJEXV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUJEXV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUJEXVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:21:54 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:29860 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266362AbUJEXSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:18:18 -0400
Message-ID: <41632BB2.6000202@yahoo.com.au>
Date: Wed, 06 Oct 2004 09:18:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
References: <200410051828.i95ISVoc006842@magilla.sf.frob.com>
In-Reply-To: <200410051828.i95ISVoc006842@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:

>>CPU. In which case you don't need to worry about timestamp_last_tick.
> 
> 
> I don't really understand this comment.  update_cpu_clock is called from
> schedule and from scheduler_tick.  When it was last called by schedule,
> p->timestamp will mark this time.  When it was last called by
> p->scheduler_tick, rq->timestamp_last_tick will mark this time.
> Hence the max of the two is the last time update_cpu_clock was called.
> 

OK I see what its doing - ignore my comments then :P

> 
> 
>>It also seems to conveniently ignore locking when reading those values
>>off another CPU. Not a big deal for dynamic load calculations, but I'm
>>not so sure about your usage...?
> 
> 
> Here again I don't know what you are talking about.  Nothing is ever read
> "off another CPU".  A thread maintains its own sched_time counter while it
> is running on a CPU.
> 

It seemed like a syscall could read the values from a task currently
running on another CPU. If not, great.

> 
>>Lastly, even when using timestamp_last_tick correctly, I think sched_clock
>>will still drift around slightly, especially if a task switches CPUs a lot
>>(but not restricted to moving CPUs). 
> 
> 
> Please explain.
> 

As you pointed out, you are only measuring on-cpu time so this shouldn't
be a problem either.

Nick
