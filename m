Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRA2SRU>; Mon, 29 Jan 2001 13:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRA2SRK>; Mon, 29 Jan 2001 13:17:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39300 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129733AbRA2SQ5>; Mon, 29 Jan 2001 13:16:57 -0500
Date: Mon, 29 Jan 2001 13:16:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sergey Kubushin <ksi@cyberbills.com>
cc: "Craig I. Hagan" <hagan@cih.com>, Romain Kang <romain@kzsu.stanford.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100 - Linux vs. FreeBSD
In-Reply-To: <Pine.LNX.4.31ksi3.0101290957530.25829-100000@nomad.cyberbills.com>
Message-ID: <Pine.LNX.3.95.1010129130906.1100A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Sergey Kubushin wrote:

> On Mon, 29 Jan 2001, Richard B. Johnson wrote:
> 
> > Two of my Linux machines use the Intel Ethernet controller on the
> > motherboard. These are both SMP machines. I have never, ever, had
> > any problems with the eepro100 driver that handles these chips.
> >
> > I spite of the fact that the driver loops in the ISR, and does other
> > things that show poor design, it works so I have not done anything
> > to it. "If it ain't broke, don't fix it..."
> >
> > So, if you have problems with using on-board Intel chip, it's
> > unlikely that it's a driver problem. If you have cards on the PCI
> > bus, the driver doesn't "know" any difference (PCI is PCI even if
> > it's not in a connector). You may find that the problem is caused
> > by PCI (mis)configuration since recent kernels use internal PCI
> > code. You may find that some bus master device does not have its
> > latency set correctly so it's taking over the bus. This can cause
> > problems with any high-activity device on the bus, such as a
> > network device.
> 
> The older chips (e.g. 82557) work fine. The problem arises when you have the
> newer 82559's. They do work, however, if the power management for eepro100
> is enabled in kernel config. It definitely means that those chips are
> underinitialized (or overinitialized :)) when it's not.
> 
> ---

Ah HA! Thanks for helping to get the word out. So it's new new-fangled
EPA stuff that's mucking them up. I suppose if you save a microwatt
here and a microwatt there, eventually you are talking about keeping
California on-line ;).

grep CONFIG_EEPRO100  ./.config
CONFIG_EEPRO100=m
CONFIG_EEPRO100_PM=y

So those who are having problems should try turning on power managment
as above.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
