Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276302AbRJIDH4>; Mon, 8 Oct 2001 23:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276953AbRJIDHp>; Mon, 8 Oct 2001 23:07:45 -0400
Received: from f199.law7.hotmail.com ([216.33.237.199]:13579 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S276302AbRJIDH3>;
	Mon, 8 Oct 2001 23:07:29 -0400
X-Originating-IP: [64.157.61.151]
From: "Binx Bolling" <binxboll_usenet@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: parport problems in 2.4.[9,10]
Date: Tue, 09 Oct 2001 03:07:54 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F199PLkJUz4W28xS4yx000081dc@hotmail.com>
X-OriginalArrivalTime: 09 Oct 2001 03:07:54.0938 (UTC) FILETIME=[971481A0:01C1506F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to get my HP DeskJet 932C to work over the parallel port under 
kernels 2.4.9 and 2.4.10. Not sure about earlier kernels. When the lp 
modules loads by default, no interrupt is selected:

parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD DESKJET 930C
lp0: using parport0 (polling).
In this case, printing proceeds, but at a glacial pace, something like 
15min/page.
When I specify insmod parport_pc irq=7, printing goes quickly, but the 
printout gets garbled and leaves the printer in a funky state. When I do 
insmod parport_pc irq=7 dma=3, once again the printer works but at 
apainfully slow speed. Specifying the dma option also triggers lots of 
errors from dmesg:

DMA write timed out
parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio
spurious 8259A interrupt: IRQ7.

Seems like interrupt driven FIFO output is failing somehow, so it falls back 
to polling mode. I can find no interrupt conflict with other devices in the 
system.

I have checked in my BIOS to make sure that ECP mode is enabled with IRQ7 
and DMA3. I do have CONFIG_PARPORT_PC_FIFO enabled.

What do I try next? Any help would be greatly appreciated.

bb


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

