Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSEQT4Z>; Fri, 17 May 2002 15:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSEQT4V>; Fri, 17 May 2002 15:56:21 -0400
Received: from mta3n.bluewin.ch ([195.186.1.212]:54923 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S316674AbSEQT4T>;
	Fri, 17 May 2002 15:56:19 -0400
Date: Fri, 17 May 2002 21:56:03 +0200
From: "'Roger Luethi'" <rl@hellgate.ch>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Shing Chuang <ShingChuang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Message-ID: <20020517195603.GA7681@k3.hellgate.ch>
In-Reply-To: <3CE55009.9050505@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.8-ac9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>do {} while (BYTE_REG_BITS_IS_ON(CR0_TXON,&pMacRegs->byCR0));
> >
> >The driver "waits a little" in the interrupt handler? How long can that
> >take, worst case? I don't know of many places where the kernel stops to
> >wait for an external device to change some value.
> 
> It's not that uncommon: Most network drivers busy-wait after stopping 
> the tx process during netif_close().

Yeah, but they don't depend on the chip to behave. They will break out at
some point. That's the issue several people pointed out.

> Shing, I don't like the empty body of the while loop. It's not a bug, 
> but doesn't that generate a large load on the pci bus?
> 
> I've always added an udelay(1), i.e. wait one microsecond, into such loops.

Sounds reasonable. I will add that later. Currently I have no delay,
either, because I want to collect some numbers about how long we expect to
wait.

Roger
