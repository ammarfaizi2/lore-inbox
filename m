Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSFETAf>; Wed, 5 Jun 2002 15:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSFETAe>; Wed, 5 Jun 2002 15:00:34 -0400
Received: from air-2.osdl.org ([65.201.151.6]:58760 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315806AbSFETAd>;
	Wed, 5 Jun 2002 15:00:33 -0400
Date: Wed, 5 Jun 2002 11:56:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
cc: <linux-kernel@vger.kernel.org>, Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: device model documentation 3/3
In-Reply-To: <200206051224.g55COIZ208776@d06relay02.portsmouth.uk.ibm.com>
Message-ID: <Pine.LNX.4.33.0206051128150.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jun 2002, Arnd Bergmann wrote:

> On Tue Jun 04 2002 - 11:25:19 EST,
> Patrick Mochel <mochel@osdl.org> wrote:
> 
> > When a driver is removed, the list of devices that it supports is 
> > iterated over, and the driver's remove callback is called for each 
> > one. The device is removed from that list and the symlinks removed. 
> 
> Maybe I'm blind, but I can't see how this works without races for
> bridge device drivers. Imagine for example what happens when I rmmod
> a usb hcd driver. Its module use count should be zero as long as the 
> devices attached to it are not in use, right?
> When I e.g. open a file in directory of a device behind my hcd, the 
> devices use count is incremented but can still remove the driver.
> Reading the file after module unload then can do bad things if the
> show() callback was inside the hcd driver.
> Did I miss the obvious anywhere?

No, that's a race that would affect all modular drivers. Ideally, we would 
want to pin the module in memory on file open, then decrement the usage 
count on close. We could do this by adding a struct module field to struct 
driver_file_entry...

	-pat

