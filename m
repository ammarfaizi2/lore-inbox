Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132801AbRD3SWS>; Mon, 30 Apr 2001 14:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135263AbRD3SWG>; Mon, 30 Apr 2001 14:22:06 -0400
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:4949 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S132801AbRD3ST6>; Mon, 30 Apr 2001 14:19:58 -0400
Message-ID: <3AEDACAE.5090105@humboldt.co.uk>
Date: Mon, 30 Apr 2001 19:19:26 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; rv:0.8.1+) Gecko/20010422
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Greg Hosler <hosler@lugs.org.sg>,
        linux-kernel@vger.kernel.org
Subject: Re: AC'97 (VT82C686A) & IRQ reassignment (I/O APIC)
In-Reply-To: <Pine.LNX.3.95.1010430131456.14407A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:


> Woof...  More GAWDAUFULL junk. You mean that if I write 0xff to the R/W
> interrupt line register and read it back, it's only 0x0f? 


Yes, and that disables generation of audio interrupts.

> This didn't
> save any money. There are only 4 interrupt 'pins', i.e., interrupt lines
> that go to the PCI bus (A thru D). What these lines connect to for
> actual IRQs is known only to the motherboard manufacturer hence the
> BIOS has to check the pin value and write the appropriate IRQ value
> into the interrupt line register.  This register is used only as a
> scratch-pad so that a driver "knows" what IRQ goes to the board. The
> board, itself, never accesses this register. The board only gets one
> interrupt connected (A thru D), and to the board, all interrupts are
> the same.


  I'm currently writing the BIOS for a PowerPC embedded system using the 
686B southbridge.  On the 686 the 8259 interrupt controller and the 
audio system are inside the same physical device. The value you write to 
offset 0x3c actually makes the internal connection between the audio 
interrupt and the PIC. There is a trick to route that interrupt to an 
external APIC involving config register 0x58 in function 0, but I've not 
used it.

Most southbridge functions work this way. The USB on the 686B is like 
this, and the the IDE controller always generates the legacy IRQ 14/15.

- Adrian Cox

