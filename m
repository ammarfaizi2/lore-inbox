Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S284607AbRLIXDT>; Sun, 9 Dec 2001 18:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S284604AbRLIXDK>; Sun, 9 Dec 2001 18:03:10 -0500
Received: from mx3.port.ru ([194.67.57.13]:44048 "EHLO smtp3.port.ru") by vger.kernel.org with ESMTP id <S284635AbRLIXCx>; Sun, 9 Dec 2001 18:02:53 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200112092304.fB9N4N008315@vegae.deep.net>
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: alan@lxorguk.ukuu.org.uk
Date: Mon, 10 Dec 2001 02:04:22 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What might be interesting would be to edit 8390.c and change
>
>         /* Mask interrupts from the ethercard.
>            SMP: We have to grab the lock here otherwise the IRQ handler
>            on another CPU can flip window and race the IRQ mask set. We end
>            up trashing the mcast filter not disabling irqs if we dont lock
>         */
>
>         spin_lock_irqsave(&ei_local->page_lock, flags);
>         outb_p(0x00, e8390_base + EN0_IMR);
>         spin_unlock_irqrestore(&ei_local->page_lock, flags);
>
> to use
>
>         /* this is the missing spin_trylock_irqsave longhand.. */
>         save_flags(flags);
>         __cli();
>         if(!spin_trylock(&ei_local->page_lock))
>         {
>                 restore_flags(flags);
>                 return 1;
>         }
>         outb_p(0x00, e8390_base + EN0_IMR);
>         spin_unlock_irqrestore(&ei_local->page_lock, flags);
    building the kernel is in the progress, so i`ll report asap...

    I`m so glad somebody still cares of the good ol` boxes :-)


regards, Samium Gromoff
