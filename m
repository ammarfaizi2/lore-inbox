Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154840AbPICMFa>; Fri, 3 Sep 1999 08:05:30 -0400
Received: by vger.rutgers.edu id <S154530AbPICMFU>; Fri, 3 Sep 1999 08:05:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1083 "EHLO chaos.analogic.com") by vger.rutgers.edu with ESMTP id <S154769AbPICMDq> convert rfc822-to-8bit; Fri, 3 Sep 1999 08:03:46 -0400
Date: Fri, 3 Sep 1999 08:02:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gerard Roudier <groudier@club-internet.fr>
cc: David Schleef <ds@stm.lbl.gov>, Paul Ashton <lk@mailandnews.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu
Subject: Re: Shared interrupt (lack of) handling
In-Reply-To: <Pine.LNX.3.95.990902205502.393A-100000@localhost>
Message-ID: <Pine.LNX.3.95.990903074606.1016A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 2 Sep 1999, Gerard Roudier wrote:
[SNIPPED]

> 
> In PCI, INTERRUPT ARE NOT SYNCHRONISATION EVENTS!  Synchronisation
> events are PCI TRANSACTIONS in the context of ordering rules defined by
> the specs,....

This sounds like something written by a lawyer. In plan language, any
hardware interrupt is a hardware request for some software to do
something. The interrupt event, itself, does not convey any
knowledge about the reason why the interrupt occurred. Software has
to inspect the hardware to determine the reason for the interrupt.

With shared interrupts, it is mandatory that the software that handles
an interrupt event (the ISR), not complain if it finds that it got
control and, upon inspecting the hardware, finds there is nothing to
do.

How the PCI controller, raises the maskable interrupt pin on the
CPU make no difference at all. One doesn't care if it's a 'PCI
TRANSACTION' or a 'PYROSYNCHROGEM'. If it happened fast enough so
the event isn't stale, nobody cares --and if the software cares,
it's broken.

> 
> Gérard.
> 


Cheers,
Dick Johnson
                   **** FILE SYSTEM WAS MODIFIED ****
Penguin : Linux version 2.3.13 on an i686 machine (400.59 BogoMips).
Warning : It's hard to remain at the trailing edge of technology.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
