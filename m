Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275268AbRJAQzL>; Mon, 1 Oct 2001 12:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbRJAQzB>; Mon, 1 Oct 2001 12:55:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55290 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S275268AbRJAQym>; Mon, 1 Oct 2001 12:54:42 -0400
Message-ID: <3BB89C49.99155417@mvista.com>
Date: Mon, 01 Oct 2001 09:39:37 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Norbert Roos <n.roos@berlin.de>, linux-kernel@vger.kernel.org
Subject: Re: System hangs during interruptible_sleep_on_timeout() under 2.4.9
In-Reply-To: <Pine.LNX.3.95.1010927112759.1310A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 27 Sep 2001, Norbert Roos wrote:
> 
> > Ingo Molnar wrote:
> >
> > > are you sure timer interrupts are processed while you are waiting for the
> > > timeout to expire? I'd suggest to put a:
> > >
> > >         printk("<%d>", irq);
> > >
> > > into arch/i386/kernel/irq.c:do_IRQ().
> >
> > Until the call of interruptible_sleep_on_timeout(), timer interrupts
> > were processed. Right after the call no more output is made.
> >
> [SNIPPED...]
> 
> wait_queue_head_t wait_thing;
> 
> Interruptible_sleep_on_timeount(&wait_thing, timeout), now requires
> that "wait_thing" must have been initialized with:
> 
> init_waitqueue_head(&wait_thing);
> 
> If you didn't do this before this object was used, all bets are
> off.
> 
> Also, you cannot sleep during an interrupt or when you are holding
> a spin-lock that disables interrupts.

Uh?  I thought it was BAD BAD BAD form to sleep with ANY spinlocks held!

George
> 
> > __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
> >
> > (x ist the variable where the IRQ flags are stored)
> > I'm not familiar with x86 assembler; is it possible that something can
> > go wrong here?
> 
> This is correct. The flags are pushed then popped into the
> variable provided.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
