Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132926AbRADMHw>; Thu, 4 Jan 2001 07:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132928AbRADMHn>; Thu, 4 Jan 2001 07:07:43 -0500
Received: from linuxcare.com.au ([203.29.91.49]:52228 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132926AbRADMH1>; Thu, 4 Jan 2001 07:07:27 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 4 Jan 2001 23:04:16 +1100
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-irda@PASTA.cs.uit.no, mzyngier@freesurf.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-IrDA]Re: [IrDA+SMP] Lockup in handle_IRQ_event
Message-ID: <20010104230416.D13759@linuxcare.com>
In-Reply-To: <wrpzoh89t1c.fsf@hina.wild-wind.fr.eu.org> <3A53B356.32353C01@uow.edu.au> <20010104115159.D7660@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010104115159.D7660@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Jan 04, 2001 at 11:51:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> BTW: What i have seen in the ircomm_tty.c (2.2.18):
> 
>     647     save_flags(flags);
>     648     cli();
>     649 
>     650     skb = self->tx_skb;
>     651     self->tx_skb = NULL;
>     652 
>     653     restore_flags(flags);
> 
> and a lot of other places simply use "save_flags(flags); cli();
> restore_flags()". Can someone enlighten me how this is supposed to work
> on SMP machines ? AFAIK "cli()" only disables IRQs on the local
> CPU so a different CPU could easily stumple half way as this
> is definitly non atomic. Or is the tty layer protected by some
> "big tty lock" ?

On SMP __cli() disables interrupts on the local cpu, cli() also grabs
the global irq lock which serialises irqs between cpus. 

Using a spinlock is much preferred if possible as grabbing the global
irq lock is expensive (and in most cases unnecessary).

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
