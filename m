Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265175AbSKEUIP>; Tue, 5 Nov 2002 15:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265186AbSKEUIP>; Tue, 5 Nov 2002 15:08:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27145 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265175AbSKEUIO>;
	Tue, 5 Nov 2002 15:08:14 -0500
Date: Tue, 5 Nov 2002 21:14:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: root@chaos.analogic.com, Willy Tarreau <willy@w.ods.org>,
       Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105201438.GA26116@alpha.home.local>
References: <Pine.LNX.3.95.1021105141917.604A-100000@chaos.analogic.com> <1036526846.6750.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036526846.6750.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 08:07:26PM +0000, Alan Cox wrote:
> On Tue, 2002-11-05 at 19:29, Richard B. Johnson wrote:
> > The only hardware a modern PC needs to use "slow-down_io" on is
> > the RTC CMOS device. Since we need to support older boards, you
> > don't want to remove the _p options indiscriminately, but you do
> > not want them ever between two consecutive writes to the same device-
> > port.
> 
> I own at least one that needs the _p on the DMA controller and at one
> that needs _p on the PIT

Well, in fact, Intel's 82C54 datasheet says that this chip needs at least
165 ns between two consecutive operations, either read or write. So with a
8 Mhz bus, you may effectively need to insert fake accesses, although most
modern chipsets certainly have better specs.

But the spec clearly states that you can interleave accesses to other
counters between the first and second bytes without problem, so good
implementations should see no side effect.

Richard, if your PIT doesn't support accesses to port 80, could you try to
use other ports ?

Cheers,
Willy

