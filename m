Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269274AbRHTUw7>; Mon, 20 Aug 2001 16:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269291AbRHTUwt>; Mon, 20 Aug 2001 16:52:49 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:33898
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S269274AbRHTUwc>; Mon, 20 Aug 2001 16:52:32 -0400
Message-ID: <3B81789A.3030004@fugmann.dhs.org>
Date: Mon, 20 Aug 2001 22:52:42 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: llx@swissonline.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: misc questions about kernel 2.4.x internals
In-Reply-To: <200108201452.f7KEqxk18219@mail.swissonline.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Widmer wrote:
> hi,
> 
> 1) when using any functions that can block i need to do this in the context 
> of a process. so a can't read, write to sockets in a bottom-half of a 
> interrupt handler. thats why i need to use a kernel thread (i don't what to
> use a user level process). my question now is - how long does it take until 
> my kernel thread starts running? do i have a way to give it very high 
> priority and force my thread to be scheduled so that i can be 'sure' to run 
> just after softirq's, tasklets, ...?
> 
> 2) for module writers there is documented and easy to use api how to use 
> tasklets to schedule it's buttom-half for later (very soon) execution. 
> are tasklets like tq_immedate in 2.2.x or tq_schedule? i mean is there a
> current process or do they runn at interrupt time?
> and am i right when i say: to add a new softirq i need to patch kernel 
> source

Tasklets are startet by a softirq, so there is no current process (there 
is, but is random.) I'm not sure that softirq's alwarys run in 
interrupttime.
Do thins of tasklets like BH's that are much more fair to others (not 
blocking all other processes.)

To add a new sorftirq, yes you need to patch kernel source and therfore 
not reccomended (I believe that there are max. 16 softirq's, so its a 
sparse resource.)

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

Regards
Anders Fugmann


