Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265264AbSISLJi>; Thu, 19 Sep 2002 07:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265869AbSISLJi>; Thu, 19 Sep 2002 07:09:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38372 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265264AbSISLJh>;
	Thu, 19 Sep 2002 07:09:37 -0400
Date: Thu, 19 Sep 2002 13:14:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Altaparmakov <aia21@cantab.net>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
Message-ID: <20020919111422.GD31033@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk> <20020919094520.GB31033@suse.de> <20020919100831.GC31033@suse.de> <1032433110.26669.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032433110.26669.30.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19 2002, Alan Cox wrote:
> On Thu, 2002-09-19 at 11:08, Jens Axboe wrote:
> > Seems to be ide probe calling the pci probe functions, and then they get
> > called by the pci layer later when they register. Dunno what the best
> > way to handle this is. Alan quotes ordering constraints as the reason.
> > Then maybe the easiest fix is to just do
> 
> Something is very wrong if they initialize twice. Hacking chipset_init
> is not a fix its an ugly hack.

True :-)

> They should end up on the ide queue to init, then transfer to the core
> PCI hotplug layer. The hotplug layer won't call the setups again because
> the device is already owned by the driver that grabbed it.
> 
> In 2.4 at least pci_register_driver checks that it doesnt do that
> 
>     pci_for_each_dev(dev) {
>                 if (!pci_dev_driver(dev))
>                         count += pci_announce_device(drv, dev);
>         }
> 
> 
> 2.5 should do the same

2.5 is reorged big time it seems, pci_register_driver() ->
drier_attach() -> do_driver_attach() -> found_match() calls ->probe()
unconditionally...

-- 
Jens Axboe

