Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269786AbRHWSWm>; Thu, 23 Aug 2001 14:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269823AbRHWSWd>; Thu, 23 Aug 2001 14:22:33 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:17166 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269786AbRHWSWY>; Thu, 23 Aug 2001 14:22:24 -0400
Message-ID: <3B854A28.31C7ACB8@t-online.de>
Date: Thu, 23 Aug 2001 20:23:36 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
In-Reply-To: <200108231658.UAA07224@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > We will see what happens. Certainly if someone wants to provide pnpbios code
> > patches for -ac that grab and reserve the motherboard resources from the PCI
> > code go ahead.
> 
> Khm... this does not look simple. Seems, right way involves modification
> of each place, where the same ports are used by kernel.

The PNP0C01 ports are not used by the kernel !
No modifications necessary.

Of course you can teach each driver about their PNP devices, e.g.
my patch for parport_pc.c makes perfect io/irq/dma detection and
saves users from the error-prone procedure to supply module parameters.
Even serial now autodetects IRQ 10 when I give this in my BIOS setup !

> pcmcia-cs had completely private resource manager, so that it just
> did not worry about other subsystems and they still were able to allocate
> the same resources.
> 
> Look f.e. at extermal example, pnpbios announces as "system" resource
> all the memory. :-)

So we have another way besides several INTs to detect the avail mem :-)

> 
> Pallaitive soultions, sort of reserving of ports >= 0x1000 using
> this information do not look cool too.

Gerd's patch rules out your objections and should be included
unconditionally with pnpbios.o.

Probably PNP0C02 wants to be reserved, too.
