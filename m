Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVBWUsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVBWUsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVBWUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:47:45 -0500
Received: from alog0649.analogic.com ([208.224.223.186]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261567AbVBWUrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:47:20 -0500
Date: Wed, 23 Feb 2005 15:46:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Alan Kilian <kilian@bobodyne.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
In-Reply-To: <1109190273.9116.307.camel@desk>
Message-ID: <Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
References: <1109190273.9116.307.camel@desk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Alan Kilian wrote:

 	call	pci_enable_device(dev)
 	... before you use the IRQ in dev->irq.

 	The reported IRQ is bogus until you make that
 	call. It's a reported BUG, probably won't
 	ever get fixed because it's considered a
 	feature.

 	Also, make sure that your .config for the Dell looks
 	something like:

 	CONFIG_X86_IO_APIC=y
 	CONFIG_X86_LOCAL_APIC=y
 	CONFIG_PCI=y
 	# CONFIG_PCI_GOBIOS is not set
 	# CONFIG_PCI_GODIRECT is not set
 	CONFIG_PCI_GOANY=y
 	CONFIG_PCI_BIOS=y
 	CONFIG_PCI_DIRECT=y

>
>
>    Folks,
>
> 	This group was instrumental in helping me get my first-ever
> 	linux/PCI-bus device driver working last year, and I'm back for
> 	some more help if you are willing.
>
> 	I have a PCI card that generates an interrupt when it completes
> 	a DMA transfer to the PCs RAM.
>
> 	This works just fine on a Dell 4400 running 2.6.10-1.766_FC3
>
> 	When I try to run the driver on a Dell 2300 FC2/2.6.5-1.358smp
> 	or a Sun W2100Z running FC2/2.6.10-1.14_FC2smp I can see the
> 	DMA-done bit set in the device, but my interrupt service routine
> 	never gets called.
>
> 	On the Sun, I booted with "noapic" option, and it booted OK,
> 	but then when my device generated an interrupt, there was a
> 	kernel message about Disabling IRQ #5 and the system was hung
> 	solidly.
>
> 	I think this has something to do with the different interrupt
> 	hardware on the more advanced servers compared to my desktop
> 	Dell 4400, and I somehow need to "enable" the IOAPIC system
> 	so that my interrupt gets through to my service routine, but I
> 	don't know how.
>
> 	I tried grepping through the kernel/drivers source, and I didn't
> 	find anything that jumped out at me.
>
> 	The Rubini drivers book didn't help in this area either,
> 	although it's a wonderful book in other areas.
>
> 	I can post source somewhere if it will help.
>
> 	I can also post the essential bits from /var/log/messages about
> 	all the incredibly complicated IOAPIC configuration stuff.
>
> 	Thank you for your past help, and thank you in advance for any
> 	tips you can provide.
>
> 				-Alan
>
> -- 
> - Alan Kilian <kilian(at)bobodyne.com>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
