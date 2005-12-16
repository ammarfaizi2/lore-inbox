Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVLPRo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVLPRo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVLPRo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:44:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:34277 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751315AbVLPRo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:44:26 -0500
Date: Fri, 16 Dec 2005 09:34:06 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Message-ID: <20051216173406.GC2122@kroah.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com> <200512141102.53599.david-b@pacbell.net> <43A1118E.9040608@ru.mvista.com> <20051215164444.GA14870@kroah.com> <43A1ECE4.6010600@ru.mvista.com> <20051215230217.GA11880@kroah.com> <43A27CDA.4020304@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A27CDA.4020304@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 11:37:46AM +0300, Vitaly Wool wrote:
> >What performance issues?  As an example, USB has this rule, and we can
> >saturate a 480Mbit line with a _userspace_ driver (loads of memcopy
> >calles involved there.)
> >
> What CPU is used there? I guess it's not 144 MHz ARM ;-)

I don't think so either, but don't remember the exact cpu (but it was an
embedded system...)

> >>And, can you please point me out the examples of devices behind USB bus 
> >>that need to write registers from an interrupt context?
> >>
> >
> >usb to serial drivers need to allocate buffers for their write functions
> >as they can be called in irq context from a tty line dicipline, which
> >causes a USB packet to be dynamically created and sent to the USB core.
> >I also think the USB network and ATM drivers have these requirements
> >too, just search for GFP_ATOMIC in the drivers/usb/ directory to find
> >these instances.
> >
> Oh BTW... I'm experiencing constant problems with root filesystem over 
> NFS over usbnet on my target
> I'm getting "server not responding, still trying" error whenever the 
> system (208-MHz ARM926 board) is under heavy load.
> I think it may well be related to the thing we discuss.

I really doubt it.  See David's other message to you about this.  And
if you have problems, please report them on the linux-usb-devel mailing
list.  We have never had bug reports due to issues involving the DMA
requirements (with the exception of people finding drivers that were
trying to send data off of the stack...)

thanks,

greg k-h
