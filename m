Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135551AbRAMDTC>; Fri, 12 Jan 2001 22:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135950AbRAMDSw>; Fri, 12 Jan 2001 22:18:52 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:28380 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135896AbRAMDSj>; Fri, 12 Jan 2001 22:18:39 -0500
Message-ID: <3A5FCA86.4DB4682F@uow.edu.au>
Date: Sat, 13 Jan 2001 14:24:54 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Frank de Lange <frank@unternet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <3A5FB997.7F366C3@uow.edu.au> <Pine.LNX.4.10.10101121835130.815-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> I'm also nervous about the complete lack of locking in vortex_timer():
> disabling interrupts doesn't mean that transmits couldn't be
> pending. But maybe the hardware is ok with changing status concurrently.
> 

mm..  It's a little racy wrt vortex_ioctl(), but otherwise OK.
del_timer_sync() in vortex_ioctl() seems to be needed.

disable_irq() is very useful in functions such as this.  It
would be a shame to have to stop using it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
