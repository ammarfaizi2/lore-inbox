Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135879AbRAMAUs>; Fri, 12 Jan 2001 19:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135895AbRAMAU3>; Fri, 12 Jan 2001 19:20:29 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:11020 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135879AbRAMAU0>;
	Fri, 12 Jan 2001 19:20:26 -0500
Date: Sat, 13 Jan 2001 01:19:57 +0100
From: Frank de Lange <frank@unternet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Manfred Spraul <manfred@colorfullife.com>,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010113011957.A29757@unternet.org>
In-Reply-To: <20010112214642.A27809@unternet.org> <Pine.LNX.4.10.10101121610050.8097-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121610050.8097-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 04:15:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 04:15:37PM -0800, Linus Torvalds wrote:
> On Fri, 12 Jan 2001, Frank de Lange wrote:
> > 
> > Gentleman, this (the patch to 8390.c) seems to fix the problem.
> 
> The problem with this patch is that anybody with a slow ISA ne2000 clone
> will basically have absolutely _horrible_ interrupt latency because we
> hold the irq lock over some quite expensive operations.
> 
> The spin_lock_irqsave() is absolutely my preferred fix, and if I remember
> correctly this is in fact how some early 2.1.x code fixed the ne2000
> driver when the original irq scalability stuff happened (for some time
> during development we did not have a working "disable_irq()" AT ALL
> because the irq-disabling counters etc logic hadn't been done).

And that's the patch I meant... Manfred's
spin_lock_irqsave/spin_unlock_irqrestore based one, not my
(spin_lock_irq/spin_unlock_irq) based patch. That is also the one I'm running
now.

Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
