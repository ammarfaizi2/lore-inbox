Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275305AbTHGNMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275310AbTHGNMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:12:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14350 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275305AbTHGNMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:12:30 -0400
Date: Thu, 7 Aug 2003 14:12:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, Tim Small <tim@buttersideup.com>,
       linux-pcmcia@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TI yenta-alikes (was: ToPIC specific init for yenta_socket)
Message-ID: <20030807141227.B25908@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pavel Roskin <proski@gnu.org>, Tim Small <tim@buttersideup.com>,
	linux-pcmcia@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com> <20030806203217.F16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com> <3F317FD7.6020209@buttersideup.com> <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com> <20030807100211.A17690@flint.arm.linux.org.uk> <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 07, 2003 at 01:18:15PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 01:18:15PM +0100, Alan Cox wrote:
> On Iau, 2003-08-07 at 10:02, Russell King wrote:
> > doing is *wrong*.  The only people who know whether the pin has been
> > wired for INTA or IRQ3 are the _designers_ of the hardware, not the
> > Linux kernel.
> 
> That assumes the yenta controller isnt hotplugged.

Even if it is hot plugged, the _kernel_ doesn't have the hardware
design information to make the correct decision about the value to
program into that register.

However, luckily, some devices load the IRQMUX register from an
EEPROM, so it should be correctly setup.

> > Currently, the Linux kernel assumes a "greater than designers" approach
> > to fiddling with the registers which control the function of these pins,
> > and so far I've seen:
> > 
> > - changing the mode from serial PCI interrupts to parallel PCI interrupts
> >   causes the machine to lock hard (since some cardbus controllers use the
> >   same physical pins for both functions.)
> 
> Basically we got burned by changing the IRQMUX register rather than just
> using it as an information source.

Different register - that was the device control register...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

