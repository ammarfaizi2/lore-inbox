Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262643AbSJGTnB>; Mon, 7 Oct 2002 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262644AbSJGTnB>; Mon, 7 Oct 2002 15:43:01 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:42995 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262643AbSJGTnA>; Mon, 7 Oct 2002 15:43:00 -0400
Subject: Re: New PCI Device Driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Jennings <jennings@red-river.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <NFBBJBMDCLFFHHFEAKNAMEEHCBAA.jennings@red-river.com>
References: <NFBBJBMDCLFFHHFEAKNAMEEHCBAA.jennings@red-river.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 20:58:26 +0100
Message-Id: <1034020706.26549.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 18:24, Patrick Jennings wrote:
> I have been tasked with writing a driver for my companies digital radio.
> The card has 16K of PCI space at BAR0.  I need to memory map this into user
> space, and provide DMA and isr handling.  First things first i want to get
> the mapping working.   When i run the code below after inserting the module
> i seg. fault.  I know this is what happens when engineers have to write
> code, but can someone point me in the right direction?

First things I'd pick on are the obvious ones - we have headers defining
KERN_ERR etc as <1> so use them 8)

Second you probably want to use the pci_module_init api then multiple
cards will basically just work, cardbus will just work and even hotplug
should come for free.

Beyond that you get the pci resources correctly, you enable the device
first as you should. You then ruin it all by poking around directly into
I/O space you have not mapped.

The kernel isn't running in physical space, and on other platforms it
gets even more exciting as to what goes on. Its all abstracted do

	addr = ioremap(io_base_start, len);
        databuf = read(addr + 0x590);


Finally note that we have a radio interface layer as part of
video4linux. Other than some basic tuning ioctls it probably has little
in common with digital radio (assuming you mean something like
Eureka-147 (aka DAB) rather than digital tuner/mixer for analogue
radio.It would nice to make use of that API and extend it logically if
you want to get a driver into the base kernel eventually.

Alan

