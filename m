Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136500AbRD3Rco>; Mon, 30 Apr 2001 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136504AbRD3Rce>; Mon, 30 Apr 2001 13:32:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56450 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S136502AbRD3Rcb>; Mon, 30 Apr 2001 13:32:31 -0400
Date: Mon, 30 Apr 2001 13:32:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Greg Hosler <hosler@lugs.org.sg>, linux-kernel@vger.kernel.org
Subject: Re: AC'97 (VT82C686A) & IRQ reassignment (I/O APIC)
In-Reply-To: <3AED950C.962360AF@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1010430131456.14407A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Jeff Garzik wrote:

> "Richard B. Johnson" wrote:
> > Observe that the PCI DWORD (long) register at DWORD offset 15 consists
> > of 4 byte-wide registers (from the PCI specification), Max_lat, Min_Gnt,
> > Interrupt pin, and interrupt line.  Nothing has to fit into 4 bits, you
> > have 8 bits. I haven't looked at the Linux code, but if it provides only 4
> > bits for the IRQ, it's broken.
> 
> Non-IO-APIC Via audio hardware only decodes the lower 4 bits of the IRQ.

Woof...  More GAWDAUFULL junk. You mean that if I write 0xff to the R/W
interrupt line register and read it back, it's only 0x0f?  This didn't
save any money. There are only 4 interrupt 'pins', i.e., interrupt lines
that go to the PCI bus (A thru D). What these lines connect to for
actual IRQs is known only to the motherboard manufacturer hence the
BIOS has to check the pin value and write the appropriate IRQ value
into the interrupt line register. This register is used only as a
scratch-pad so that a driver "knows" what IRQ goes to the board. The
board, itself, never accesses this register. The board only gets one
interrupt connected (A thru D), and to the board, all interrupts are
the same.

So, if the driver can find by some other means, the interrupt that is
connected to the board, it can use that interrupt rather than something
that was written to the scratch register by the BIOS.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


