Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRALTWD>; Fri, 12 Jan 2001 14:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbRALTVx>; Fri, 12 Jan 2001 14:21:53 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:61703 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S131133AbRALTVe>;
	Fri, 12 Jan 2001 14:21:34 -0500
Date: Fri, 12 Jan 2001 20:21:04 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112202104.C25675@unternet.org>
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> <20010112183314.A24174@unternet.org> <3A5F4428.F3249D2@colorfullife.com> <20010112192500.A25057@unternet.org> <3A5F5538.57F3FDC5@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F5538.57F3FDC5@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 08:04:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 08:04:24PM +0100, Manfred Spraul wrote:
> I removed the disable_irq lines from 8390.c, and that fixed the problem:
> no hang within 2 minutes - the test is still running.
> 
> Frank, could you double check it?

I'm currently running my own patched version, which uses
spin_lock_irq/spin_unlock_irq instead of
spin_lock_irqsave/spin_unlock_irqrestore like you patch uses. Looking at
spinlock.h, spin_lock_irq does a local irq disable, which seems to be closer to
the original intent (disable_irq) than spin_lock_irqsave. Anyone want to
comment on this?

Anyway, still running under load, also got USB (which uses the same irq) to
produce some interrupts by scanning some stuff. No problems so far...

Cheers//Frank

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
