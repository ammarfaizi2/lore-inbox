Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284469AbRLEQm0>; Wed, 5 Dec 2001 11:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284484AbRLEQmF>; Wed, 5 Dec 2001 11:42:05 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:42509 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S284472AbRLEQlu>; Wed, 5 Dec 2001 11:41:50 -0500
Date: Wed, 5 Dec 2001 11:41:44 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Cory Bell <cory.bell@usa.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <1007541620.2340.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112051127390.27471-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> video chipset (blech). Would you consider putting the patch on your
> website? I got the k7/sse patch, but the irq patch isn't actually
> linked, I just happened across it while doing my research.

Sure.. I'll put yours up thought because it's slightly less intrusive.  I
was hoping to find out a much cleaner way of doing this before I put it
up for anyone to use.... so i posted it here first... but as they say, the
silence was deafening...

> ACPI seems to work on my laptop (detects ACPI resources, thermal
> zone, etc), but if I "cat /proc/acpi/events" and press the suspend or
> power buttons, I don't get anything. On my old NEC Versa LX, I'd get a
> few junk chars for each press (been a while since I tried it, though). I
> don't see any interrupts on IRQ 9, either.

I'm not 100% sure how ACPI works, period. I've got it up and running, but
about the only thing it does seem to report correctly is battery life
(and, I assume, it uses ACPI idle..)..  everything else appears to be just
window dressing for now.. not sure if that's a limitation of hardware or
the linux ACPI implementation.

> About interrupt routing: Does the PIRQ table actually contain the IRQ a
> device is assigned to, or just a "link number" and a mask of acceptible
> IRQs. I see on your laptop, the audio is on irq 5, which matches the
> mask, but there seems to be no PIRQ link for 5, just like there's none
> for IRQ 9 on yours or mine, yet the audio device still gets 5. Perhaps
> the setup code is interpereting the "link" to mean a particular IRQ, but
> is failing to validate the IRQ against the mask? Any idea how the setup
> code gets from PIRQ 0x59 to IRQ 9, or PIRQ 0x48 to IRQ 11? Would you
> mind emailing me a dump_pirq from your desktop ALi?
>
> I imagine it doesn't help that the link numbers vary between machines of
> the same chipset (ie, you have 0x00, 0x48-0x49, and 0x59, and I have
> 0x00, 0x01-0x03, and 0x59 - interesting that the "troublemaker" link #
> is the same for both of us). Have you heard from anyone else with
> ALi-chipset laptops having similar problems? I think the compaq I was
> looking at had the same core chipset.

I'm afraid we may both be in over our heads here.  That link number
sppears to be some sort of code to help routing (see code for "see if
hard-coded, it checks for 0xf"), and the mask is just what
you think it is.  However, from my gatherings, pIRQ tables are often wrong
and thus ignored by Linux a lot of times.  I think the -real- problem here
is the bios is assigning IRQ's to PCI devices, and assign's 9 to the USB
on startup, writes that to it's config registers, and Linux is stuck with
it.  But that's just speculation.

> Does the standard kernel have DMI? I thought that was an -ac thing... I
> know I don't see any DMI messages on boot.

Yes, they just don't print out anymore (see
arch/i386/kenrel/dmiscan.c<?>).

Who maintains the PCI irq routing code?

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


