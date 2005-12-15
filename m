Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVLOWeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVLOWeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVLOWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:34:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:16537 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750946AbVLOWeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:34:11 -0500
Date: Thu, 15 Dec 2005 14:33:22 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       Joachim_Jaeger@digi.com
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Message-ID: <20051215223322.GA8578@kroah.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512141102.53599.david-b@pacbell.net> <43A1118E.9040608@ru.mvista.com> <200512151206.26515.david-b@pacbell.net> <43A1EB94.5040300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A1EB94.5040300@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 01:17:56AM +0300, Vitaly Wool wrote:
> David Brownell wrote:
> 
> >On Wednesday 14 December 2005 10:47 pm, Vitaly Wool wrote:
> >
> > 
> >
> >>One cannot allocate memory in interrupt context, so the way to go is 
> >>allocating it on stack, thus the buffer is not DMA-safe.
> >>   
> >>
> >
> >kmalloc(..., GFP_ATOMIC) is the way to allocate memory in irq context.
> >It's done that way throughout the kernel.
> > 
> >
> It's not applicable within the RT-related changes. kmalloc anyway takes 
> mutexes, so allocationg it in interrupt context is buggy.

What RT-related changes cause this?

> *Legacy* kernel code does that but why produce a new code with that?

In this terminoligy, you are calling 2.6.15-rc5 "legacy".  Which is not
true.

> >>Making it DMA-safe in thread that does the very message processing is a 
> >>good way of overcoming this.
> >>   
> >>
> >
> >The rest of Linux appears to work fine without needing such mechanisms...
> > 
> >
> The rest of Linux still has a lot of bugs. Noone I guess is ready to 
> argue that.

Huh?  Please point out these bugs in the mainline tree and we will be
glad to fix them.

> >I really fail to see why you think SPI needs that.  USB isn't the only
> >counterexample, but it's particularly relevant since both USB and SPI
> >use asynchronous message passing over serial links ... and USB has a
> >rather complete driver stack over it.   (None of the USB based WLAN
> >drivers need those static buffers you worry about, by the way...)
> > 
> >
> I haven't heard of USB device registers needing to be written in IRQ 
> context. I'm not that well familiar with USB, so if you give such an 
> example, that'd be fine.

The USB host controller drivers routienly allocate memory in irq context
as they are being asked to submit a new "packet" from a driver which was
called in irq context.  Lots of USB drivers also allocate buffers in irq
context too.

So, please, drop this line of argument, it will not go any further.

greg k-h
