Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSGRG4S>; Thu, 18 Jul 2002 02:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSGRG4S>; Thu, 18 Jul 2002 02:56:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31736 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316339AbSGRG4R>;
	Thu, 18 Jul 2002 02:56:17 -0400
Message-ID: <3D366732.AFEDDC97@mvista.com>
Date: Wed, 17 Jul 2002 23:58:58 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: irfan_hamid@softhome.net
CC: linux-kernel@vger.kernel.org
Subject: Re: cli()/sti() clarification
References: <courier.3D365FDC.0000712F@softhome.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irfan_hamid@softhome.net wrote:
> 
> Hi,
> 
> I added two system calls, blockintr() and unblockintr() to give cli()/sti()
> control to userland programs (yes I know its not advisable) but I only want
> to do it as a test. My test program looks like this:
> 
>         blockintr();
>         /* Some long calculations */
>         unblockintr();
> 
> The problem is that if I press Ctrl+C during the calculation, the program
> terminates. So I checked the _syscallN() and __syscall_return() macros to
> see if they explicitly call sti() before returning to userspace, but they
> dont.
> 
> Reading the lkml archives, I found that cli() disables only the interrupts,
> exceptions are allowed, so it makes sense that the SIGINT was delivered, but
> if thats the case, then how come the SIGINT was delivered from the Ctrl+C?
> Doesnt this mean that the SIGINT signal was generated as a result of the
> keyboard interrupt?
> 
> I know I am missing something here, would appreciate if someone could point
> me in the right direction.

Return from sys to user space is done by executing a "iret"
instruction.  In addition to picking up the return address
and segment it pick up EFLAGS which will contain the
interrupt flag as it was saved when the system call was
made...
> 
> Regards,
> Irfan Hamid.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
