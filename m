Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136089AbRAMB22>; Fri, 12 Jan 2001 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136155AbRAMB2J>; Fri, 12 Jan 2001 20:28:09 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:8208 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136089AbRAMB2G>;
	Fri, 12 Jan 2001 20:28:06 -0500
Date: Sat, 13 Jan 2001 02:27:41 +0100
From: Frank de Lange <frank@unternet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Message-ID: <20010113022741.D29757@unternet.org>
In-Reply-To: <20010113014807.B29757@unternet.org> <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 04:56:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 04:56:24PM -0800, Linus Torvalds wrote:
> IDE is not my favourite example of a "known stable driver". Also, in many
> cases IDE is for historical reasons connected to an EDGE io-apic pin (ie
> it's still considered an ISA interrupt). Which probably wouldn't show this
> problem anyway.

They (ide interrupts) are indeed EDGE-triggered on my box. I have not enabled
the HPT366 (ATA66) controller on this board, so I can not tell if that
controller is EDGE-triggered as well.

> Also, IDE doesn't generate all that many interrupts. You can make a
> network driver do a _lot_ more interrupts than just about any disk driver
> by simply sending/receiving a lot of packets. With disks it is very hard
> to get the same kind of irq load - Linux will merge the requests and do at
> least 1kB worth of transfer per interrupt etc. On a ne2k 100Mbps PCI card,
> you can probably _easily_ generate a much higher stream of interrupts.

There's sound... The msnd.c (Turtle Beach MultiSound) driver (and its
derivatives, like msnd_pinnacle) uses disable_irq.  Running esd (esound
daemon), sound can easily generate > 1000 interrupts/second, since esd uses
small dma transfers. This can be seen quite clearly from /proc/interrupts on my
soundserver:

           CPU0       
  0:  276867328          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:    7631519          XT-PIC  eth1
  4:    2751419          XT-PIC  serial
  5: 1907346678          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:   45022986          XT-PIC  eth0
 13:          1          XT-PIC  fpu
 14:    4320643          XT-PIC  ide0
 15:    4409193          XT-PIC  ide1
NMI:          0

OK, this is an ageing P166, and it uses a different driver, etc. I have not
found any problems with hanging sound drivers in Google query for 'linux msnd
bp6' or 'linux multisound bp6'. Of course, this is no conclusive evidence, far
from it... It could be that people using those cards are not the ones who tend
to go for the (somewhat tricky) BP6 board...

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
