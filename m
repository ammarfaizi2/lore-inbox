Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWGCW1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWGCW1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWGCW1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:27:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:37029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750857AbWGCW1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:27:37 -0400
Date: Mon, 3 Jul 2006 15:26:45 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Message-ID: <20060703222645.GA22855@kroah.com>
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com> <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com> <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com> <44A95F12.8080208@gmail.com> <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com> <20060703214509.GA5629@kroah.com> <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 06:11:03PM -0400, Daniel Bonekeeper wrote:
> >> Reading Greg's comment, now I'm in doubt if this should really be in
> >> kernel mode or at userspace. Since there is no standard (AFAIK) for
> >> those readers, how should it be done ?
> >
> >It all depends on what you want the userspace interface to be.
> >
> 
> That's one problem: I don't want to create one more userspace
> interface for that. I suppose that all the hundreds of fingerprint
> readers that ships with a SDK have their own way of doing that.. that
> looks awfull to me, even though I believe that currently there isn't
> any uniform way of working with fingerprint readers... shouldn't we
> have a way to classify devices ? For example, if I want to list all
> the printers connected via USB (supposing that we have more than one),
> I should be able to request that information from somewhere
> (/dev/usb/printers/* ?) I suppose that different fingerprint readers
> works with different resolutions... we should be able to have an
> unified interface that could tell the userspace the capabilities of
> each fingerprint device (the area size of the scanner, resolution,
> etc)... I think that applies for a lot of devices, not just
> fingerprint readers. Probably there is already something like that.

Yes, we should have one way of identifying them.  I've talked with Dan
already about this in the past.  Please see his driver for support for a
few devices already.

> >> For example, I suppose that some (or all) USB devices may have DMA
> >> capabilities... how is this done ?
> >
> >Heh, no, USB can't do DMA at all.  Why would you think they could?  It's
> >a serial bus that just streams data across it at relativly slow speeds.
> >
> 
> Well.. even though I didn't know how and was a bit suspicious, I used
> to believe that USB devices could do DMA because I heard some time ago
> about "the danger of USB devices that could do DMA and have total
> access over the OS"... something on bugtraq or securityfocus...
> talking about USB and FireWire devices and how they could be used to
> "inject" stuff on the system's memory and take it over... but I guess
> it only applies to firewire (even though USB was clearly mentioned).
> Reviewing it, it definitely applies just for firewire stuff.
> 
> http://www.csoonline.com/read/050106/ipods.html

Yes, firewire and USB is very different.  You can't dma memory directly
out using USB, although I've heard rumors that through the USB debug
port you might be able to do that, but as that requires a custom cable,
which no one will give me, I can't confirm or deny that yet...

thanks,

greg k-h
