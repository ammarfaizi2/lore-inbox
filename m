Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135910AbRAZQYM>; Fri, 26 Jan 2001 11:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135783AbRAZQYC>; Fri, 26 Jan 2001 11:24:02 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:22544 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S135910AbRAZQXu>; Fri, 26 Jan 2001 11:23:50 -0500
Date: Fri, 26 Jan 2001 17:22:56 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
Message-ID: <20010126172256.A7500@pcep-jamie.cern.ch>
In-Reply-To: <20010126163103.F7096@pcep-jamie.cern.ch> <Pine.LNX.3.95.1010126104710.1321A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010126104710.1321A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Jan 26, 2001 at 11:03:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Slowing down I/O is absolutely necessary any time you set an index
> register or a page register. For instance, to access the CMOS chip,
> you write an index value out port 0x70, then you read or write from
> port 0x71. Modern CPUs can execute instructions MUCH faster than
> the port index can be switched. If you don't force the CPU to wait
> until the hardware has actually switched the port offset, then
> you read/write to/from the wrong location.
> 
> The same thing occurs with DMA page registers, i.e., 64 k chunks
> of addresses. If takes time for hardware to switch in a new page --
> a LOT more time than it takes to read/write RAM. If you don't wait,
> you read/write to the wrong place.

Ah, I've always wondered when it's appropriate to use outb_p and when to
use outb.  The lack of comments in <asm-i386/io.h> kept this a mystery.
Modern bus hardware doesn't need this sort of thing -- it enforces the
required delays itself.

Is the list of ports for which outb_p is appropriate a small and well
defined one?

> The delay must be sufficient for the hardware to have accomplished
> the switch. That's why writing to a hardware port is ideal. If you
> have fast hardware, the delay is low. If you have slow hardware, the
> delay is longer.
> 
> I'm not going to debate this. If you understand hardware there
> is nothing to debate.

Agreed, however it's not that obvious.  Not all delays are to
synchronise at bus rates.  Sometimes the delay is because some _other_
component on a board, not directly connected to the bus, needs a short
delay.  E.g. a chip that can only be clocked at max. 1MHz.  The driver
author uses outb_p because he thinks that limits the rate to 0.5MHz, and
there is no other way to get that sort of data rate, but no it limits
the rate to 3MHz on your board.  Ah well.

If it was really as simple as matching the bus rate, there would be no
need for REALLY_SLOW_IO on some machines would there?  (Are
REALLY_SLOW_IO and SLOW_IO_BY_JUMPING ever used?)

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
