Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275322AbTHGNC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275323AbTHGNC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:02:29 -0400
Received: from choke.semantico.com ([212.74.15.98]:19440 "EHLO semantico.com")
	by vger.kernel.org with ESMTP id S275322AbTHGNCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:02:24 -0400
Message-ID: <3F324DDE.3040409@buttersideup.com>
Date: Thu, 07 Aug 2003 14:02:22 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, linux-pcmcia@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TI yenta-alikes
References: <200308062025.08861.daniel.ritz@gmx.ch>	 <20030806194430.D16116@flint.arm.linux.org.uk>	 <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>	 <20030806203217.F16116@flint.arm.linux.org.uk>	 <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com>	 <3F317FD7.6020209@buttersideup.com>	 <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>	 <20030807100211.A17690@flint.arm.linux.org.uk> <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2003-08-07 at 10:02, Russell King wrote:
>  
>
>>doing is *wrong*.  The only people who know whether the pin has been
>>wired for INTA or IRQ3 are the _designers_ of the hardware, not the
>>Linux kernel.
>>    
>>
>
>That assumes the yenta controller isnt hotplugged.
>  
>
Some (all?) PCI add-in cards leave this up to the OS/driver as well.  
The card I have has no firmware on board, and from a quick look at the 
PCI1031 datasheet, I can't see any easy way of adding one.  The default 
power-on state (at least for the PCI1031) is to disable all interrupts.

>>Currently, the Linux kernel assumes a "greater than designers" approach
>>to fiddling with the registers which control the function of these pins,
>>and so far I've seen:
>>
>>- changing the mode from serial PCI interrupts to parallel PCI interrupts
>>  causes the machine to lock hard (since some cardbus controllers use the
>>  same physical pins for both functions.)
>>    
>>
>
>Basically we got burned by changing the IRQMUX register rather than just
>using it as an information source.
>  
>
I think it should be possible to use the IRQMUX, and other registers to 
work out whether the bridge has been setup or not..  e.g.

"device control register bits2,1:  R/W, Interrupt mode.
Bits 2 1 select the interrupt mode used by the PCI1031. Bits 2 1 are 
encoded as: 00 = No interrupts enabled (default) 01 = ISA 10 = 
Serialized IRQ type interrupt scheme 11 = Reserved"

If these bits are non-zero, I suppose we should probably leave the IRQ 
routing registers alone, as it would seem to be a good indicator that 
the BIOS has programmed these for us.  This is just on the 1031, 
however, I haven't checked any of the other datasheets...


Tim.

