Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSL0XrZ>; Fri, 27 Dec 2002 18:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSL0XrZ>; Fri, 27 Dec 2002 18:47:25 -0500
Received: from host194.steeleye.com ([66.206.164.34]:265 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265250AbSL0XrY>; Fri, 27 Dec 2002 18:47:24 -0500
Message-Id: <200212272355.gBRNtbl04274@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Manfred Spraul <manfred@colorfullife.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from Manfred Spraul <manfred@colorfullife.com> 
   of "Fri, 27 Dec 2002 23:57:02 +0100." <3E0CDABE.7000907@colorfullife.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Dec 2002 17:55:37 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manfred@colorfullife.com said:
> This is not entirely correct: The driver must use the normal memory
> barrier instructions even in  coherent memory. Could you copy the
> section about wmb() from DMA-mapping  into your new documentation? 

I made the name change from consistent to coherent (at David Mosberger's) 
request to address at least some of this.

I suppose I can add it as a note to dma_alloc_coherent too.

> Noone obeys that rule, and it's not trivial to fix it. 

Any driver that disobeys this rule today with the pci_ API is prone to cache 
related corruption on non-coherent architectures.

> Is it really impossible to work around that in the platform specific
> code? In the worst case, the arch code could memcopy to/from a
> cacheline aligned buffer. 

Well, it's not impossible, but I don't believe it can be done efficiently.  
And since it can't be done efficiently, I don't believe it's right to impact 
the drivers that are properly written to take caching effects into account.

Isn't the better solution to let the platform maintainers negotiate with the 
driver maintainers to get those drivers they care about fixed?

James


