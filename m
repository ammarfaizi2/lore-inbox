Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132826AbRAKQ4h>; Thu, 11 Jan 2001 11:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132859AbRAKQ4U>; Thu, 11 Jan 2001 11:56:20 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:37644 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132826AbRAKQ4F>;
	Thu, 11 Jan 2001 11:56:05 -0500
Date: Thu, 11 Jan 2001 17:55:47 +0100
From: Frank de Lange <frank@unternet.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010111175547.A3269@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D9D87.8A868F6A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 11, 2001 at 10:48:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you get any transmit timeout messages in the logs?  If
> so, send them.

In addition to my previous message, here's what I get from the debug log
facility:

Jan 10 22:56:51 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:56:51 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=33. 
Jan 10 22:56:52 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:56:52 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=26. 
Jan 10 22:56:53 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:56:53 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=30. 
Jan 10 22:56:56 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:56:56 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=78. 
Jan 10 22:56:56 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:56:56 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=32. 
Jan 10 22:56:58 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:56:58 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=89. 
Jan 10 22:57:00 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:57:00 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=77. 
Jan 10 22:57:03 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 22:57:03 behemoth kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=171. 

So yeah, I get timeouts allright...

Currently running NOAPIC, pity to see CPU1 receiving no interrupts at all... In the same debug log I now just saw this:

Jan 11 17:37:05 behemoth kernel: spurious 8259A interrupt: IRQ7

That's weird, since there's nothing there...:

cat /proc/interrupts 
           CPU0       CPU1       
  0:     232967          0          XT-PIC  timer
  1:       6424          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  3:        138          0          XT-PIC  serial
  4:      46201          0          XT-PIC  serial
  9:         52          0          XT-PIC  sym53c8xx
 10:     744329          0          XT-PIC  eth0, eth1, usb-uhci
 11:          0          0          XT-PIC  bttv
 12:          0          0          XT-PIC  es1371, mga@PCI:1:0:0
 14:      19778          0          XT-PIC  ide0
 15:       4520          0          XT-PIC  ide1
NMI:          0          0 
LOC:     232916     232914 
ERR:          1

See? Nothing on 7... This is with NOAPIC (as you can see from the XT-PIC's in
the above dump). BP6 again?

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
