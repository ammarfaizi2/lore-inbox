Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVIKIgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVIKIgG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 04:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVIKIgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 04:36:06 -0400
Received: from web30303.mail.mud.yahoo.com ([68.142.200.96]:15774 "HELO
	web30303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751027AbVIKIgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 04:36:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Bcxge2zAhL30SPU1K1E7/ToEUwWKdobrqVH0jDjNK5VxsJU5RU9MpI7EZUn91aKK5BSigbAeXykJWXUGWB3r8ZjujdObldu78TahzMfBT4BgYG8hrSSkYBfmnkPUBG2tDI0pkZASFzST75Z89sm+wEn0//smG3bwC/TjsTvODcw=  ;
Message-ID: <20050911083557.56515.qmail@web30303.mail.mud.yahoo.com>
Date: Sun, 11 Sep 2005 09:35:57 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: Vital <vitalhome@rbcmail.ru>
Cc: Vital <vitalhome@rbcmail.ru>, David Brownell <david-b@pacbell.net>,
       linux-kernel@vger.kernel.org, dpervushin@ru.mvista.com
In-Reply-To: <43234E0E.6000308@rbcmail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vital <vitalhome@rbcmail.ru> wrote:

> Mark Underwood wrote:
> 
> >>Same as for suspend.
> >>
> >>And the basic idea anyway looks wrong and not
> >>LDM'ish.
> >>What if your driver
> >>
> >>+static struct device_driver spi_adapter_driver =
> {
> >>+ .name = "spi_adapter",
> >>+ .bus = &spi_bus_type,
> >>+ .probe = spi_adapter_probe,
> >>+ .remove = spi_adapter_remove,
> >>+};
> >>
> >>presents also suspend/resume functions (what it
> >>should have done anyway).
> >>
> >>Won't it be in a clash with your suspend/resume
> >>technique?
> >>    
> >>
> >
> >Probably as I said above I don't know enough about
> >this area yet. Maybe you could help me to do this
> >correctly?
> >
> >  
> >
> I guess that it's basically wrong to use
> platform_device here. My POV is 
> that a specific spi_device structure should be
> introduced here, just 
> like pcidevice, for instance.

If you look at spi.h you will see the spi_device
structure :). My comment about suspend/resume was that
I based my suspend/resume functions on those in
platform.c.

> 
> >>Also:
> >>
> >>Can you please specify what is the difference
> >>between 'bus' and 'chip' 
> >>in your model?
> >>    
> >>
> >
> >My current terminology is:
> >
> >spi adapter: A device that sits on an bus
> (platform,
> >PCI, USB etc) and is a SPI master and/or slave (I
> >haven't done any work on the slave part yet).
> >
> >spi device: A SPI device (e.g. a SPI eeprom) which
> one
> >or more of are connected to a spi adapter.
> >
> >  
> >
> >>It's not clear to me how the following situation
> is
> >>handled. Suppose you 
> >>have two SPI 'busses' with same devices (for
> >>instance, 2 SD card 
> >>adapters) attached to different busses.
> >>    
> >>
> >
> >I don't understand your question here. You would
> have
> >two instances of a SD card adapter. In sysfs it
> would
> >look like:
> >
> >SD card 0
> >/sys/devices/platform/spi-0/0-0000
> >
> >SD card 1
> >/sys/devices/platform/spi-1/1-0002
> >
> >As far as the SD card driver is concernedit doesn't
> >need to know which one its driving or even how many
> of
> >them they are. The big advantage of using the LDM.
> >  
> >
> Not sure if I get you right.
> If we suspend bus 0, how does the SD driver get
> aware of that?

That is what my suspend/resume functions are doing
(maybe incorrectly). My current understanding is that
it is the job of the bus layer (e.g. PCI, USB and in
this case SPI) to handle the fact that a bus has been
suspended or resumed. This means that when an adapter
gets a suspend/resume call the core layer must then
ask all the devices on that adapter to suspend/resume.
In platform.c there are 3 calls made to the suspend
resume function which I assumed was the standard why
of doing this as some devices might have to be called
3 times inorder to be suspended/resumed correctly.
I can see that you could have a situation where a SPI
device has been suspended, and then the bus gets
suspended and then resumed, in which case I guess that
SPI device should probably still be suspended but at
the moment would get resumed.

Mark

> 
> Vitaly
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
