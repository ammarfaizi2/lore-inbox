Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272108AbSISRmK>; Thu, 19 Sep 2002 13:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272116AbSISRmK>; Thu, 19 Sep 2002 13:42:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43392 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S272108AbSISRmJ>;
	Thu, 19 Sep 2002 13:42:09 -0400
Date: Thu, 19 Sep 2002 10:48:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Altaparmakov <aia21@cantab.net>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
In-Reply-To: <20020919132724.GS31033@suse.de>
Message-ID: <Pine.LNX.4.44.0209191041090.968-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Sep 2002, Jens Axboe wrote:

> On Thu, Sep 19 2002, Alan Cox wrote:
> > On Thu, 2002-09-19 at 12:14, Jens Axboe wrote:
> > > 2.5 is reorged big time it seems, pci_register_driver() ->
> > > drier_attach() -> do_driver_attach() -> found_match() calls ->probe()
> > > unconditionally...
> > 
> > That would appear to be a bug in the 2.5 driver layer then. I'd suggest
> > fixing it there. Attempting to probe a device that already has a driver
> > attached to it doesn't seem to make sense.
> 
> Agree. Pat?

Yes, and that's the way it's set up: we check if the device has a driver 
before we bind to it. However, dev->driver doesn't get set before the 
device is registered with the core for PCI devices. That's fixed easily 
enough. 

But, I'm a bit confused on where this is happening. The PCI layer will 
probe for devices before any drivers are registered. The drivers are 
registered, then they're attached to devices that were already discovered. 
So, how are they getting init'ed twice? 


	-pat

