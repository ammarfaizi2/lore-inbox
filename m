Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRHTS5y>; Mon, 20 Aug 2001 14:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRHTS5p>; Mon, 20 Aug 2001 14:57:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5630 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S268071AbRHTS5f>; Mon, 20 Aug 2001 14:57:35 -0400
Message-ID: <3B815D97.680B37A5@mvista.com>
Date: Mon, 20 Aug 2001 11:57:27 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: llx@swissonline.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: misc questions about kernel 2.4.x internals
In-Reply-To: <200108201452.f7KEqxk18219@mail.swissonline.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Widmer wrote:
> 
> hi,
> 
> 1) when using any functions that can block i need to do this in the context
> of a process. so a can't read, write to sockets in a bottom-half of a
> interrupt handler. thats why i need to use a kernel thread (i don't what to
> use a user level process). my question now is - how long does it take until
> my kernel thread starts running? do i have a way to give it very high
> priority and force my thread to be scheduled so that i can be 'sure' to run
> just after softirq's, tasklets, ...?

You would/ could assign it a real time priority and make it SCHED_FIFO
or SCHED_RR.  If you do this, it is a good idea to make the priority
used available to be "tuned".  Not every one will agree that _your_
handler is as important as you think it is.
> 
> 2) for module writers there is documented and easy to use api how to use
> tasklets to schedule it's buttom-half for later (very soon) execution.
> are tasklets like tq_immedate in 2.2.x or tq_schedule? i mean is there a
> current process or do they runn at interrupt time?
> and am i right when i say: to add a new softirq i need to patch kernel
> sources?
> 
> 3) i had a look at the ll_rw_block and realised that it can block when there
> are to many buffers locked. when i use generic_make_request can i be
> shure that i wont block so that i can call it in a tasklet and don't need to
> switch to a kernel thread? i think that also needs that clustering function
> __make_request may not block. does it or does it not?
> 
> 4) i was looking at the networking code in 2.4 because it is possible that
> i need to write a new thin network protocoll which is optimised for disk-i/o.
> i didn't find any documentation how to implement a new one in 2.4. does
> anybody have some pointers to doc's or can give me some comments?
> 
> thanks for any help or pointers to further information
> chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
