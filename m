Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262077AbRETQ0O>; Sun, 20 May 2001 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbRETQ0E>; Sun, 20 May 2001 12:26:04 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:16064 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262077AbRETQZv>; Sun, 20 May 2001 12:25:51 -0400
Message-ID: <3B07EEFE.43DDBA5C@uow.edu.au>
Date: Mon, 21 May 2001 02:21:18 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random>,
		<20010520154958.E18119@athlon.random>; from andrea@suse.de on Sun, May 20, 2001 at 03:49:58PM +0200 <20010520181803.I18119@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, May 20, 2001 at 03:49:58PM +0200, Andrea Arcangeli wrote:
> > they returned zero. You either have to drop the skb or to try again later
> > if they returns zero.
> 
> BTW, pci_map_single is not a nice interface, it cannot return bus
> address 0, so once we start the fixage it is probably better to change
> the interface as well to get either the error or the bus address via a
> pointer passed to the function.
> 

Would it not be sufficient to define a machine-specific
macro which queries it for error?  On x86 it would be:

#define BUS_ADDR_IS_ERR(addr)	((addr) == 0)

I can't find *any* pci_map_single() in the 2.4.4-ac9 tree
which can fail, BTW.

-
