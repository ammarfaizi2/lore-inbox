Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUFBOjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUFBOjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUFBOjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:39:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52864 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261239AbUFBOjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:39:22 -0400
Date: Wed, 2 Jun 2004 10:39:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
In-Reply-To: <40BDE1BB.3030605@shadowconnect.com>
Message-ID: <Pine.LNX.4.53.0406021024400.3280@chaos>
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org>
 <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com>
 <40BD95EB.40506@shadowconnect.com> <40BDD4C9.5070602@pobox.com>
 <40BDDAD9.5070809@shadowconnect.com> <20040602134603.GA8589@havoc.gtf.org>
 <40BDE1BB.3030605@shadowconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004, Markus Lidel wrote:

> Hello,
>
> Jeff Garzik wrote:
> >>>>>My preferred approach would be:  consider that the hardware does not
> >>>>>need the entire 0x8000000-byte area mapped.  Plain and simple.
> >>>>>This is a "don't do that" situation, and that renders the other
> >>>>>questions moot :)  You should only be mapping what you need to map.
> >>>>Okay, i'll let try it out with only 64MB.
> >>>Why do you need 64MB, even?  :)
> >>I don't know how much space i need :-D But why does the device set the
> >>size to 128MB then?
> > Devices often export things you don't care about, such as direct access
> > to internal chip RAM.
> > Look through the driver that figure out the maximum value that the
> > driver actually _uses_.  There is no need to guess.
>
> Okay, i've looked at it, but i don't think i could simply use less
> space, because (if i understand the I2O spec right :-D) the controller
> returns me a address inside this window, where i could write the I2O
> message. So i ask the controller, where do you want my request, then he
> tells me a address...
>
> If i only ioremap 64MB, and the controller tells me write at 80MB, i'm
> in deep trouble :-D
>
> >> 	size = dev->resource[i].end-dev->resource[i].start+1;
> > You should be using pci_resource_start() and pci_resource_len()
> > to obtain this information.
>
> Yep, thanks, but a patch for this is already send :-)
>
> Best regards,
>

I2O, as seen from the PCI/Bus, is a bus! Right? You have a
PCI/Bus controller that provides for an interface into
I2O? Right? Can you do `cat /proc/pci` and show what device
you think it is?  I think you are attempting to access a bridge
or something. I2O is supposed to be intelligent and to grab
64 megabytes of host address space is the anthesis of this.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


