Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265747AbRGJGiJ>; Tue, 10 Jul 2001 02:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265766AbRGJGiA>; Tue, 10 Jul 2001 02:38:00 -0400
Received: from zeus.kernel.org ([209.10.41.242]:42713 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265747AbRGJGh6>;
	Tue, 10 Jul 2001 02:37:58 -0400
Date: Mon, 9 Jul 2001 23:37:33 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
In-Reply-To: <3B4A7972.F0CFBACE@megsinet.net>
Message-ID: <Pine.LNX.4.10.10107092330030.7791-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There appears to be a max-pio sync error.
Specifically PIO is used to setup all transfers regardless of
DMA/Multi/PIO and if that is wrong the the rest is toast.

CMD has the strangest interlace of PIO ever.

PIO can only as hast as the slowest device.

I need to think about this some more, kick me to keep me on task.

Cheers,

On Mon, 9 Jul 2001, M.H.VanLeeuwen wrote:

> Andre,
> 
> I had a chance to play a little more today, here is what I've come up with:
> 
> a. w/ hdc disable in BIOS, changing the PIO mode to 0 or 1 seems to allow the
>    system to run error free.  PIO mode 3 still has silent FS corruption issues.
> 
> b. w/ hdc enabled in BIOS, the PIO mode doesn't seem to matter. (except for speed;)
> 
> c. CONFIG_IDEDMA_PCI_AUTO affects the number of interrupts needed to complete
>    each block xfer.  With it enabled the number of IRQ's per second ~600.
>    With it disabled ~2/block or 5000-6000 per second.  I thought from the dmesg
>    output that DMA was disabled and this option should have no affect.
> 
>    > CMD646: IDE controller on PCI bus 00 dev 10
>    > CMD646: chipset revision 1
>    > CMD646: not 100% native mode: will probe irqs later
>    > CMD646: chipset revision 0x01, MultiWord DMA Limited, IRQ workaround enabled
>    > CMD646: simplex device:  DMA disabled
>    > ide0: CMD646 Bus-Master DMA disabled (BIOS)
>    > CMD646: simplex device:  DMA disabled
>    > ide1: CMD646 Bus-Master DMA disabled (BIOS)
> 
> d. CONFIG_IDEDMA_PCI_AUTO does not seem to affect the outcome of "a" or "b" above.
> 
> Martin
> 
> andre@linux-ide.org wrote:
> > 
> > Martin, you have an old beast that there are problems in how the chipset
> > was deployed.
> > How are you confirming the corruption against the various layers in the
> > kernel?
> > If you would like patches & tests to verify I will send them to you.
> > 
> > Cheers
> > 
> > --
> > Andre Hedrick
> > Linux ATA Development
> > ASL Kernel Development
> > -----------------------------------------------------------------------------
> > ASL, Inc.                                     Toll free: 1-877-ASL-3535
> > 1757 Houret Court                             Fax: 1-408-941-2071
> > Milpitas, CA 95035                            Web: www.aslab.com
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

