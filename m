Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbULJWMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbULJWMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbULJWMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:12:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9178 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261839AbULJWKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:10:00 -0500
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
	series
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, trivial@rustcorp.com.au
In-Reply-To: <200412091459.51583.pisa@cmp.felk.cvut.cz>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102712732.3264.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Dec 2004 21:05:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-09 at 13:59, Pavel Pisa wrote:
>   if (vm86_irqs[intno].sig)
>    send_sig(vm86_irqs[intno].sig, vm86_irqs[intno].tsk, 1);
>   /* else user will poll for IRQs */
> + spin_unlock_irqrestore(&irqbits_lock, flags); 
> + /* Next line would be required to handle correctly level activated 
> interrupts */
> + disable_irq(intno);
> + return IRQ_HANDLED;

You can't disable_irq and return to user space - the IRQ may be shared
by a device needed to make user space progress. 

The rest looks like a real bug.
