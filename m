Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUIFIdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUIFIdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUIFIdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:33:39 -0400
Received: from imag.imag.fr ([129.88.30.1]:50627 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S267638AbUIFIcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:32:33 -0400
Date: Mon, 6 Sep 2004 10:31:39 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Message-ID: <20040906083139.GA1188@linux.ensimag.fr>
Reply-To: 1094417386.1911.0.camel@localhost.localdomain
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 06 Sep 2004 10:32:28 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sul, 2004-09-05 at 22:24, Jon Smirl wrote:
> > I'd don't know enough about the LPC bridge chip to know what the
> > correct answer is for this. Right now I tend to think that the PCI
> > driver should own the bridge chip. If not the PCI driver then there
> > should be an explicit bridge driver. I don' think it is correct that a
> > joystick driver is attaching to a bridge chip given the simple fact
> 
> Nobody else currently needs to attach to it so why make life needlessly
> complicated.
> 
heu hw_random and i8xx_tco use also the lpc bridge, but hopefully they
don't attach it.
> > that all legacy IO - joystick, PS/2, parallel, serial, etc is located
> > off from that same bridge chip.
> > 
> > Matthieu's comments about using PNP for this seem to make sense. Are
> > we missing implementation of an ACPI feature for controlling these
> > ports?
> 
> See previous discussion. We have isapnp, biospnp but not great acpi pnp.
That why I start a patch implementing acpi PnP, but nobody seem
interested :(
> None of them help because you need to deal with hotplug.
Heu, I don't understant why you need to deal with hotplug ?
PnP modules works like pci modules. You make a list of know id, and then
you call {pci,pnp}_{port,irq,dma}_{start,len,...} to access resource of
the device.
Hotplug is need like for pci modules to autoload it.

Also using the LPC brigde the alsa driver don't know about the io port
and irq resource you had to pass them via modules option.
For the gameport, alsa driver use a hardcode value of 0x200 that is
wrong on my computer (it is 0x201).
For the midi port it don't use the irq...
With PnP, the bios/acpi give theses resourse.

For the bit you had to write in the LPC for enable io port, I made a
little test and even if you writte bit that disable the io gameport it
still work. Moreover, I think the bios autoset these bits.

Matthieu
