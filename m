Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUIEVYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUIEVYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUIEVYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:24:13 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:11675 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267235AbUIEVYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:24:06 -0400
Message-ID: <9e47339104090514244873fd05@mail.gmail.com>
Date: Sun, 5 Sep 2004 17:24:05 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <20040905184852.GA25431@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040905184852.GA25431@linux.ensimag.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd don't know enough about the LPC bridge chip to know what the
correct answer is for this. Right now I tend to think that the PCI
driver should own the bridge chip. If not the PCI driver then there
should be an explicit bridge driver. I don' think it is correct that a
joystick driver is attaching to a bridge chip given the simple fact
that all legacy IO - joystick, PS/2, parallel, serial, etc is located
off from that same bridge chip.

Matthieu's comments about using PNP for this seem to make sense. Are
we missing implementation of an ACPI feature for controlling these
ports?

On Sun, 5 Sep 2004 20:48:52 +0200, Matthieu Castet
<mat@ensilinx1.imag.fr> wrote:
> On Sul, 2004-09-05 at 03:43, Jon Smirl wrote:
> > The joystick PCI ID table in intel8x0.c is not correct. Joysticks and
> > MIDI ports are ISA devices and need be located by manual probing. This
> > ID table needs to be removed. Joystick and MIDI ports do not have PCI
> > IDs.
> 
> I agree, that was I explain in a previous post
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109420281830288&w=2)
> see the PS.
> 
> 
> > It isn't that simple. The LPC bridge also contains the controls for
> > the
> > joystick ports. You also need them for hotplug handling of the bridge
> > should someone stick one in a laptop docking station. The ID table
> > also
> > ensures the driver is loaded. It's probably true that it will need
> > splitting up a bit if another driver also needs ownership of the LPC
> > bridge but for now that hasn't happened.
> 
> Not for jostick and midi stuff you have to use pnp bus.
> On my computer it works well :
> I have removed the support of MIDI and GAMEPORT in alsa driver.
> The gameport is handle with ns558
> The midi device with a mpu401_pnp I post on the alsa mailling list
> (http://sourceforge.net/mailarchive/forum.php?thread_id=5468125&forum_id=1751)
> For that it work well you need a pnpbios patch
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109411306024720&w=2) or
> even try to use my pnpacpi patch
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109430451522335&w=2)
> And the isapnp hotplug script auto load the right module...
> 
> Regards,
> Matthieu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Jon Smirl
jonsmirl@gmail.com
