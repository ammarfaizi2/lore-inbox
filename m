Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSEPS0C>; Thu, 16 May 2002 14:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314502AbSEPS0B>; Thu, 16 May 2002 14:26:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314500AbSEPS0A>; Thu, 16 May 2002 14:26:00 -0400
Date: Thu, 16 May 2002 14:25:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "'Roger Luethi'" <rl@hellgate.ch>
cc: Shing Chuang <ShingChuang@via.com.tw>,
        Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        AJ Jiang <AJJiang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
In-Reply-To: <20020516180354.GA9151@k3.hellgate.ch>
Message-ID: <Pine.LNX.3.95.1020516141423.993A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, 'Roger Luethi' wrote:

> On Thu, 16 May 2002 18:03:25 +0800, Shing Chuang wrote:
> >      As following three error conditions occurred,   the VT6102 & VT86C100A
> > chip are designed to shutdown TX for driver to examine the error frame.
> > 
> >      1. Tx fifo underrun.                   
> > 
> >      2. Tx Abort (Too many collisions occurred).
> > 
> >      3. TxDescriptors status write back  error. (Only on VT6102 chip)
> 
> Hey, thanks! That's exactly the piece of information I've been looking for.
> 
> >      All the three conditions caused the TXON bit of CR1 went off. the
> > driver must wait  a little while until the bit go off, reset the pointer of
> > [...]
> >           do {} while (BYTE_REG_BITS_IS_ON(CR0_TXON,&pMacRegs->byCR0));
> 
> The driver "waits a little" in the interrupt handler? How long can that
> take, worst case?

Forever..........^;)

> I don't know of many places where the kernel stops to
> wait for an external device to change some value.
> 

Yep... should never wait inside an ISR, to say nothing about
the potential wait-forever.

Even if the chip never breaks, you end up with reports like..
"Strange, I make frisbees when buring CDs while M$ machines do
backups over the network..."

Or, I can't play ".wav" files anymore unless I unplug from the
network...

Stuff has to play together. Sometimes this means you can't get
the maximum-theoretical-possible through-put from your connected
devices.

The worse-case driver is where the programmer decided to turn
interrupts back on in the ISR.... to let higher-priority interrupts
occur...  FYI, there are always higher-priority interrupts that
will take the CPU away... you lose big-time.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

