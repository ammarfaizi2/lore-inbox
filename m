Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRCKSvh>; Sun, 11 Mar 2001 13:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRCKSvS>; Sun, 11 Mar 2001 13:51:18 -0500
Received: from f61.law3.hotmail.com ([209.185.241.61]:36113 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129051AbRCKSvJ>;
	Sun, 11 Mar 2001 13:51:09 -0500
X-Originating-IP: [65.25.188.54]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: HP Vectra XU 5/90 interrupt problems
Date: Sun, 11 Mar 2001 18:50:23 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F61uN6tdqVvPdLFYxc900008c66@hotmail.com>
X-OriginalArrivalTime: 11 Mar 2001 18:50:24.0028 (UTC) FILETIME=[2163DDC0:01C0AA5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>
> > So PCI interrupts must always be level triggered? If so, then the kernel
> > should never program the IO APIC to use an edge triggered interrupt on a 
>PCI
> > device. If that's true, then why not force the interrupt type to level
> > triggered for all PCI devices (to work around a potentially broken MP
> > table)?
>
>Its not that simple. Its common to edge trigger some of the built in 
>devices
>like IDE controllers.

Ok, I guess I'm a little confused again. My SCSI controller hangs when the 
interrupt it shares with the network card is configured as edge triggered. 
When I force the interrupt to be level triggered, everything works fine. 
Does this sound like a problem in one of the two drivers (unable to share an 
edge triggered interrupt) or is it a no-no to set up a shared PCI interrupt 
as edge triggered?

If shared, edge triggered interrupts are ok then I will talk to the driver 
maintainers about the problem. If this isn't ok, then maybe the sanity check 
in pci-irq.c would be to force level triggering only on shared PCI 
interrupts?

I'm going down this path because I can't see a good way to check for the 
presence of a valid ELCR, so I'm hoping a PCI IRQ sanity check would fix my 
problem (but someone please correct me if I'm wrong). Are SMP standard type 
#5 machines (ISA/PCI) or just the Vectra's so rare that I'm the only one 
having this problem? Or am I the only one to try putting a PCI card in one 
of it's two slots... :-)

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

