Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWGDD42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWGDD42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 23:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWGDD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 23:56:28 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:49669 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751292AbWGDD41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 23:56:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cLKmYRsgFd+a1FRwHBN2qT+lnWcq+ocHoRxpXX0bcwKxnR06LOlAzxBmyysA0qTZJDJeQ2qM748l5Etmu/uMrcDMc9R+BG/dP4/++eaoKGGDl9IbOOb9TOPphfx2clgyy6NbLwSr4+ZmuXlBTM0L9BRYiE2csDAQsGUzEC4Wwus=
Message-ID: <e1e1d5f40607032056x700c0333rf39fb43c8d73d117@mail.gmail.com>
Date: Mon, 3 Jul 2006 23:56:26 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: "Alon Bar-Lev" <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060703222645.GA22855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
	 <20060703222645.GA22855@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this is not a default on the market and is something that is
coming... but seems that some USB controllers are coming with DMA
capabilities:

http://www.usb.org/developers/presentations/pres0501/Augustin_DMA_Implem_Final.ppt
http://www.semiconductors.philips.com/pip/isp1183.html

Daniel

On 7/3/06, Greg KH <greg@kroah.com> wrote:
> On Mon, Jul 03, 2006 at 06:11:03PM -0400, Daniel Bonekeeper wrote:
> > >> Reading Greg's comment, now I'm in doubt if this should really be in
> > >> kernel mode or at userspace. Since there is no standard (AFAIK) for
> > >> those readers, how should it be done ?
> > >
> > >It all depends on what you want the userspace interface to be.
> > >
> >
> > That's one problem: I don't want to create one more userspace
> > interface for that. I suppose that all the hundreds of fingerprint
> > readers that ships with a SDK have their own way of doing that.. that
> > looks awfull to me, even though I believe that currently there isn't
> > any uniform way of working with fingerprint readers... shouldn't we
> > have a way to classify devices ? For example, if I want to list all
> > the printers connected via USB (supposing that we have more than one),
> > I should be able to request that information from somewhere
> > (/dev/usb/printers/* ?) I suppose that different fingerprint readers
> > works with different resolutions... we should be able to have an
> > unified interface that could tell the userspace the capabilities of
> > each fingerprint device (the area size of the scanner, resolution,
> > etc)... I think that applies for a lot of devices, not just
> > fingerprint readers. Probably there is already something like that.
>
> Yes, we should have one way of identifying them.  I've talked with Dan
> already about this in the past.  Please see his driver for support for a
> few devices already.
>
> > >> For example, I suppose that some (or all) USB devices may have DMA
> > >> capabilities... how is this done ?
> > >
> > >Heh, no, USB can't do DMA at all.  Why would you think they could?  It's
> > >a serial bus that just streams data across it at relativly slow speeds.
> > >
> >
> > Well.. even though I didn't know how and was a bit suspicious, I used
> > to believe that USB devices could do DMA because I heard some time ago
> > about "the danger of USB devices that could do DMA and have total
> > access over the OS"... something on bugtraq or securityfocus...
> > talking about USB and FireWire devices and how they could be used to
> > "inject" stuff on the system's memory and take it over... but I guess
> > it only applies to firewire (even though USB was clearly mentioned).
> > Reviewing it, it definitely applies just for firewire stuff.
> >
> > http://www.csoonline.com/read/050106/ipods.html
>
> Yes, firewire and USB is very different.  You can't dma memory directly
> out using USB, although I've heard rumors that through the USB debug
> port you might be able to do that, but as that requires a custom cable,
> which no one will give me, I can't confirm or deny that yet...
>
> thanks,
>
> greg k-h
>


-- 
What this world needs is a good five-dollar plasma weapon.
