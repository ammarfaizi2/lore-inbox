Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291406AbSCDFCW>; Mon, 4 Mar 2002 00:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291477AbSCDFCM>; Mon, 4 Mar 2002 00:02:12 -0500
Received: from mnh-1-23.mv.com ([207.22.10.55]:39691 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S291406AbSCDFCB>;
	Mon, 4 Mar 2002 00:02:01 -0500
Message-Id: <200203040504.AAA05343@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 03:35:14 GMT."
             <E16hjFq-0006OQ-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 00:04:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> You never get a SIGBUS. Writes to tmpfs for new blocks will fail if
> that would place the system in a potential overcommit situation.

How will writes to tmpfs fail if we're not in an overcommit situation, but
tmpfs is full?  Unless tmpfs is changed, it looks to me like you get a SIGBUS.

> It isnt the alloc pages that is the problem.

We are somehow failing to communicate...

> You mmap - no pages are allocated. 

I understand this.

> You use them , pages get allocated.

This too.

> If you look at the actual maps you'll find a lot of people allocate an
> area of address space but don't use it all. 

Yes.

> Without the address
> overcommit management nothing guarantees that when you touch those
> pages you won't fault. 

Even with address overcommit management, I can fault if I touch pages when
tmpfs is full but the system is not near overcommit.

> Furthermore unless you are very careful you may
> fault again on the stack push for the SIGBUS and if that faults -
> SIGKILL->OOM time

We are talking about UML kernel stacks.  If they have been allocated the way
I'm proposing with the UML __alloc_pages touching each page on the way out,
they are allocated on the host, and therefore can't fault.

This seems to me to be sufficiently careful.

One of us is missing something, who is it?

				Jeff

