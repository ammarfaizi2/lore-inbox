Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRGJDW1>; Mon, 9 Jul 2001 23:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRGJDWQ>; Mon, 9 Jul 2001 23:22:16 -0400
Received: from mail4.mx.voyager.net ([216.93.66.203]:61712 "EHLO
	mail4.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S263960AbRGJDWK>; Mon, 9 Jul 2001 23:22:10 -0400
Message-ID: <3B4A7972.F0CFBACE@megsinet.net>
Date: Mon, 09 Jul 2001 22:41:38 -0500
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
In-Reply-To: <3B492324.E36B86AF@linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

I had a chance to play a little more today, here is what I've come up with:

a. w/ hdc disable in BIOS, changing the PIO mode to 0 or 1 seems to allow the
   system to run error free.  PIO mode 3 still has silent FS corruption issues.

b. w/ hdc enabled in BIOS, the PIO mode doesn't seem to matter. (except for speed;)

c. CONFIG_IDEDMA_PCI_AUTO affects the number of interrupts needed to complete
   each block xfer.  With it enabled the number of IRQ's per second ~600.
   With it disabled ~2/block or 5000-6000 per second.  I thought from the dmesg
   output that DMA was disabled and this option should have no affect.

   > CMD646: IDE controller on PCI bus 00 dev 10
   > CMD646: chipset revision 1
   > CMD646: not 100% native mode: will probe irqs later
   > CMD646: chipset revision 0x01, MultiWord DMA Limited, IRQ workaround enabled
   > CMD646: simplex device:  DMA disabled
   > ide0: CMD646 Bus-Master DMA disabled (BIOS)
   > CMD646: simplex device:  DMA disabled
   > ide1: CMD646 Bus-Master DMA disabled (BIOS)

d. CONFIG_IDEDMA_PCI_AUTO does not seem to affect the outcome of "a" or "b" above.

Martin

andre@linux-ide.org wrote:
> 
> Martin, you have an old beast that there are problems in how the chipset
> was deployed.
> How are you confirming the corruption against the various layers in the
> kernel?
> If you would like patches & tests to verify I will send them to you.
> 
> Cheers
> 
> --
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com
