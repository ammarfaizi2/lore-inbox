Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314686AbSEPVEt>; Thu, 16 May 2002 17:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314694AbSEPVEs>; Thu, 16 May 2002 17:04:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19840 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314686AbSEPVEr>; Thu, 16 May 2002 17:04:47 -0400
Date: Thu, 16 May 2002 17:05:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "'Roger Luethi'" <rl@hellgate.ch>
cc: Shing Chuang <ShingChuang@via.com.tw>,
        Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        AJ Jiang <AJJiang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
In-Reply-To: <20020516203159.GA10868@k3.hellgate.ch>
Message-ID: <Pine.LNX.3.95.1020516165412.1477A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, 'Roger Luethi' wrote:

> > > The driver "waits a little" in the interrupt handler? How long can that
> > > take, worst case?
> > 
> > Forever..........^;)
> 
> We should assume that this is indeed the case, but it often helps to know
> what the expected values and their distribution are.
> 
> It's a weird situation anyway: both the buffer descriptor and the interrupt
> status have been updated by the chip to reflect the abort, but by the time
> we handle the error it may still be busy coming to a halt.
> 
> What tickles my curiosity is that my previous patch didn't fix the stalling
> for Ivan G. on his VT86C100A. Maybe the chip just wasn't ready to be
> restarted.
> 
> > Even if the chip never breaks, you end up with reports like..
> > "Strange, I make frisbees when buring CDs while M$ machines do
> > backups over the network..."
> 
> Not if the chip is guaranteed to have its thing done after one or two
> iterations. We make some inb and outb calls in the ISR either way.
> 
> That was hypothetically speaking of course, I'm not suggesting we rely on
> such a "guarantee".
> 
> Roger

I think one has to <somehow> find that the chip has halted besides
the current way (noticing that it can't transmit anymore). I don't
know how to do this, of course, but; if you could know that the
chip is hung, the first thing to do is to turn off its interrupt
request(s) (the chip, not the interrupt controller). Some older
(National) devices needed to have the chip then set to loopback
mode because they couldn't be programmed properly if data kept
coming in on the wire. The internal buffer pointers kept changing
in response to incoming data while the chip was being programmed.
By the time you got the chip programmed, it was hung by pointer-wrap.

In the chip-halted work-around that everybody seems to use now,
reprogram it from scratch. The last program operation being to remove
loop-back. I don't even know if this chip can be set to loop-back,
though, so the whole idea may be moot.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

