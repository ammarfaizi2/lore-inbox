Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVCOEce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVCOEce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVCOEce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:32:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55518 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262235AbVCOEcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:32:31 -0500
Subject: Re: User mode drivers: part 1, interrupt handling (patch for
	2.6.11)
From: Lee Revell <rlrevell@joe-job.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105031218035f323d68@mail.gmail.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <1110568448.15927.74.camel@localhost.localdomain>
	 <9e47339105031218035f323d68@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 23:32:30 -0500
Message-Id: <1110861150.15588.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-12 at 21:03 -0500, Jon Smirl wrote:
> On Fri, 11 Mar 2005 19:14:13 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I posted a proposal for this sometime ago because X has some uses for
> > it. The idea being you'd pass a struct that describes
> > 
> > 1.      What tells you an IRQ occurred on this device
> > 2.      How to clear it
> > 3.      How to enable/disable it.
> > 
> > Something like
> > 
> >         struct {
> >                 u8 type;                /* 8, 16, 32  I/O or MMIO */
> >                 u8 bar;                 /* PCI bar to use */
> >                 u32 offset;             /* Into bar */
> >                 u32 mask;               /* Bits to touch/compare */
> >                 u32 value;              /* Value to check against/set */
> >         }
> >
> 
> It might useful to add this to the main kernel API, and then over time
> modify all of the drivers to use it. If a driver does this it would be
> safe to transparently move it to user space like in UML or xen.  I've
> been told that PCI Express and MSI does not have this problem.
> 

This seems sufficient for the simplest devices, that just have an
IRQ_PENDING and an IRQ_ACK register.  But what about a device like the
emu10k1 where you have a half loop and loop interrupt for each of 64
channels, plus about 10 other interrupt sources?  The IPR just tells you
there's a channel loop interrupt pending, in order to properly ACK it
you need to set a bit in one of 4 registers depending on whether it's a
loop or half loop interrupt, and whether the channel is 0-31 or 32-64.

Lee

