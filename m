Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130812AbQKBI2u>; Thu, 2 Nov 2000 03:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130848AbQKBI2l>; Thu, 2 Nov 2000 03:28:41 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:9934 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130812AbQKBI2d>; Thu, 2 Nov 2000 03:28:33 -0500
Message-ID: <3A0125AE.467B640B@uow.edu.au>
Date: Thu, 02 Nov 2000 19:28:30 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Josefine Staff <staff@josefine.ben.tuwien.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.2.17] 3c59x and Transmit list error
In-Reply-To: <20001102013305.A17809@josefine.ben.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Fischer wrote:
> 
> Hello,
> 
>         For some time now we're observing a very bad [tm] network
> problem with our 3Com 3c905B Cyclone card. After booting the
> network works just fine, but after a few days ( ranging from five
> to 10) really hard network problems occur, rendering the network
> accessabilty to zero; only manually restarting the network solves
> this problem (from local, of course).

eth0: Transmit error, Tx status register 82.

This is an "out of window collision", otherwise known
as a "Transmit reclaim error".

It is almost certainly caused by another machine on
your network entering full-duplex mode.  It stomps 
on the 3c905's Tx packets and the collision is
detected too late for the 905 to be able to
retransmit - some of the packet contents have
been discarded from the on-chip FIFO.

Next time it happens, you need to run around the
building and find out who just did something such
as turning their computer on, or mucking around
with dangerous Linux netdriver module parameters.

If this description doesn't match your situation
please let me know and we'll work on it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
