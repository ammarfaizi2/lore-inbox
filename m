Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbTCJGP3>; Mon, 10 Mar 2003 01:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbTCJGP3>; Mon, 10 Mar 2003 01:15:29 -0500
Received: from krynn.axis.se ([193.13.178.10]:45287 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S261258AbTCJGP2>;
	Mon, 10 Mar 2003 01:15:28 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE885@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Mikael Starvik'" <mikael.starvik@axis.com>
Cc: Johan Adolfsson <johan.adolfsson@axis.com>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
       "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Avoid PC(?) specific cascade dma reservation inkernel
	/dma.c
Date: Mon, 10 Mar 2003 07:25:55 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For CRIS the DMA channel numbers supplied refers to internal DMA
channels between the CPU and other units in the chip. The numbers
never refers to external units such as PCI devices or ISA devices.
If anybody would connect ISA or PCI the devices would all share
the same internal DMA. This may not be the intended usage of 
kernel/dma.c and we could provide our own code to do the same
thing.

If kernel/dma.c should be as generic as it looks then the 
reservation of DMA 4 as "cascade" should probably be done by
some other module (or by arch specific code).

/Mikael

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Sunday, March 09, 2003 9:33 PM
To: Mikael Starvik
Cc: Johan Adolfsson; 'Marcelo Tosatti'; 'Linus Torvalds'; 'Linux Kernel
Mailing List'
Subject: RE: [PATCH] Avoid PC(?) specific cascade dma reservation
inkernel/dma.c


On Sun, 2003-03-09 at 13:49, Mikael Starvik wrote:
> >I don't know of any PC cards that can support ISA DMA channel 4 so I
> >guess simply because of that it hasn't happened. Do you actually
> >know of any DMA 4 capable ISA devices or is it used for onboard
> >ISA devices ?
> 
> In this case it is used in a non ISA capable system where DMA channel
> numbers doesn't relate to ISA numbers in any way. 

So what happens if someone plugs a PCI/ISA bridge into an axis system.
Surely you should be reporting no ISA DMA and having a set of similar
axis specific DMA handlers - or does it really look so close to ISA think ?
