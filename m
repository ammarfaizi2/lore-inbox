Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRALVW3>; Fri, 12 Jan 2001 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135387AbRALVWT>; Fri, 12 Jan 2001 16:22:19 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:25102 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129792AbRALVWM>;
	Fri, 12 Jan 2001 16:22:12 -0500
Date: Fri, 12 Jan 2001 22:21:27 +0100
From: Frank de Lange <frank@unternet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112222127.A28576@unternet.org>
In-Reply-To: <20010112205245.A26555@unternet.org> <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 11:59:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Remind me: what polarity are your io-apic irq's? Level, edge, sideways?
> Anything else that might be relevant?

Well, sideways ofcourse! :-)

here's a cat /proc/interrupts from the (BP6) box:

           CPU0       CPU1       
  0:     104936     105433    IO-APIC-edge  timer
  1:       4444       4384    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:         79         59    IO-APIC-edge  serial
  4:      12743      12850    IO-APIC-edge  serial
 14:       7855       7885    IO-APIC-edge  ide0
 15:       1990       1703    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  es1371, mga@PCI:1:0:0
 17:         24         28   IO-APIC-level  sym53c8xx
 18:          0          0   IO-APIC-level  bttv
 19:     460435     460402   IO-APIC-level  eth0, eth1, usb-uhci
NMI:     210303     210303 
LOC:     210285     210284 
ERR:          0

The interrupt which caused problems was 19 (with both network cards and USB on
it). It shows a high number of interrupts because I've been load-testing the
network. The mere fact that it shows this hig number of interrupts shows the
fix works...

As this is a BP6, I'm now supposed to go on about the dead chickens, dedicated
air conditioners, nuclear powersupplies and other magic you're supposed to buy
to get these boards running. Well, nothing of that sort, it is running on a
simple (but high quality) 235W PSU with heatgreased coolers on the CPUs and the
BX xhipset. Nothing is overclocked. CPU and chipset tmeperatures are 24.C and
32.C, respectively.

In short, nothing remarkable. All PCI slots are used, as you can see from my
first posting in this thread (which contains more info on the hardware).

//Frank
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
