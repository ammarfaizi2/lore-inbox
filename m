Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273366AbRI0Phq>; Thu, 27 Sep 2001 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273371AbRI0Phg>; Thu, 27 Sep 2001 11:37:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273366AbRI0Ph1>; Thu, 27 Sep 2001 11:37:27 -0400
Date: Thu, 27 Sep 2001 11:37:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Norbert Roos <n.roos@berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: System hangs during interruptible_sleep_on_timeout() under 2.4.9
In-Reply-To: <3BB33E88.ACD1E426@berlin.de>
Message-ID: <Pine.LNX.3.95.1010927112759.1310A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Norbert Roos wrote:

> Ingo Molnar wrote:
> 
> > are you sure timer interrupts are processed while you are waiting for the
> > timeout to expire? I'd suggest to put a:
> > 
> >         printk("<%d>", irq);
> > 
> > into arch/i386/kernel/irq.c:do_IRQ().
> 
> Until the call of interruptible_sleep_on_timeout(), timer interrupts
> were processed. Right after the call no more output is made.
> 
[SNIPPED...]

wait_queue_head_t wait_thing;

Interruptible_sleep_on_timeount(&wait_thing, timeout), now requires
that "wait_thing" must have been initialized with:

init_waitqueue_head(&wait_thing);

If you didn't do this before this object was used, all bets are
off.

Also, you cannot sleep during an interrupt or when you are holding
a spin-lock that disables interrupts.


> __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
> 
> (x ist the variable where the IRQ flags are stored)
> I'm not familiar with x86 assembler; is it possible that something can
> go wrong here?

This is correct. The flags are pushed then popped into the
variable provided.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


