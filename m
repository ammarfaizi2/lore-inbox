Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290880AbSARXxd>; Fri, 18 Jan 2002 18:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290882AbSARXxY>; Fri, 18 Jan 2002 18:53:24 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:24357 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290880AbSARXxP> convert rfc822-to-8bit; Fri, 18 Jan 2002 18:53:15 -0500
Date: Sat, 19 Jan 2002 00:52:02 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kent E Yoder <yoder1@us.ibm.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
In-Reply-To: <E16RiHs-0008CD-00@the-village.bc.nu>
Message-ID: <20020119004144.F2500-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jan 2002, Alan Cox wrote:

> >   BTW, I don't know what PCI posting effects are...
>
> Ok given
>
> 	writel(foo, dev->reg);
> 	udelay(5);
> 	writel(bar, dev->reg);
>
> The pci bridge is at liberty to delay the first write until the second or a
> read from that device comes along (and wants to do so to merge bursts). It
> tends to bite people
>
> 	-	When they do a write to clear the IRQ status and don't do
> 		a read so they keep handling lots of phantom level triggered
> 		interrupts.

Not only (when the write is intended to clear some interrupt condition).

As the actual clear of the interrupt condition is delayed, then it may
just also clear a sub-sequent condition and this condition may be missed
by the driver interrupt routine. Due to this a race, interrupt stall can
occur.

> 	-	When there is a delay (reset is common) that has to be observed
>
> 	-	At the end of a DMA transfer when people unmap stuff early
> 		and the "stop the DMA" command got delayed

  Gérard.

