Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314671AbSEPUcc>; Thu, 16 May 2002 16:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314674AbSEPUcb>; Thu, 16 May 2002 16:32:31 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:21281 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S314671AbSEPUca>;
	Thu, 16 May 2002 16:32:30 -0400
Date: Thu, 16 May 2002 22:31:59 +0200
From: "'Roger Luethi'" <rl@hellgate.ch>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Shing Chuang <ShingChuang@via.com.tw>,
        Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        AJ Jiang <AJJiang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Message-ID: <20020516203159.GA10868@k3.hellgate.ch>
In-Reply-To: <20020516180354.GA9151@k3.hellgate.ch> <Pine.LNX.3.95.1020516141423.993A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The driver "waits a little" in the interrupt handler? How long can that
> > take, worst case?
> 
> Forever..........^;)

We should assume that this is indeed the case, but it often helps to know
what the expected values and their distribution are.

It's a weird situation anyway: both the buffer descriptor and the interrupt
status have been updated by the chip to reflect the abort, but by the time
we handle the error it may still be busy coming to a halt.

What tickles my curiosity is that my previous patch didn't fix the stalling
for Ivan G. on his VT86C100A. Maybe the chip just wasn't ready to be
restarted.

> Even if the chip never breaks, you end up with reports like..
> "Strange, I make frisbees when buring CDs while M$ machines do
> backups over the network..."

Not if the chip is guaranteed to have its thing done after one or two
iterations. We make some inb and outb calls in the ISR either way.

That was hypothetically speaking of course, I'm not suggesting we rely on
such a "guarantee".

Roger
