Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132428AbRADMHN>; Thu, 4 Jan 2001 07:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132901AbRADMGw>; Thu, 4 Jan 2001 07:06:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:31755 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132428AbRADMGm>;
	Thu, 4 Jan 2001 07:06:42 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-irda@PASTA.cs.uit.no, mzyngier@freesurf.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-IrDA]Re: [IrDA+SMP] Lockup in handle_IRQ_event 
In-Reply-To: Your message of "Thu, 04 Jan 2001 11:51:59 BST."
             <20010104115159.D7660@paradigm.rfc822.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jan 2001 23:06:35 +1100
Message-ID: <6377.978609995@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001 11:51:59 +0100, 
Florian Lohoff <flo@rfc822.org> wrote:
>and a lot of other places simply use "save_flags(flags); cli();
>restore_flags()". Can someone enlighten me how this is supposed to work
>on SMP machines ? AFAIK "cli()" only disables IRQs on the local
>CPU so a different CPU could easily stumple half way as this
>is definitly non atomic.

cli() is not the cli instruction anymore.  On smp cli() maps to
__global_cli() which is responsible for disabling interrupts on the
other processors.  See __global_cli in arch/*/kernel/irq.c.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
