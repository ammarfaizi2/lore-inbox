Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267933AbUGaKB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267933AbUGaKB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 06:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUGaKB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 06:01:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14471 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267933AbUGaKBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 06:01:54 -0400
Date: Sat, 31 Jul 2004 12:03:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040731100318.GA1799@ucw.cz>
References: <20040730212930.GA30979@kroah.com> <20040730215325.98365.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730215325.98365.qmail@web14922.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 02:53:25PM -0700, Jon Smirl wrote:
> Here's another grungy thing I needed to do to PCI. Multi-headed video
> cards don't really implement independent PCI devices even though they
> look like independent devices. I've heard that this behavior is needed
> for MS Windows compatibility.
> 
> I'm missing a PCI call to claim ownership for the secondary device
> without also causing a second instance of my driver to be loaded.
> Here's the code I'm using, what's the right way to do this?
> 
> struct pci_dev *secondary;
> /* check the next function on the same card */
> secondary = pci_find_slot(dev->pdev->bus->number, dev->pdev->devfn +
> 1);
> if (secondary) {
> 	/* check if class is secondary video */
> 	if (secondary->class == 0x038000) {
> 		DRM_DEBUG("registering secondary video head\n");
> 		/* This code is need to bind the driver to the secondary device */
> 		/* There is no direct pci call to do this, there should be one */
> 		secondary->dev.driver = dev->pdev->dev.driver;
> 		device_bind_driver(&secondary->dev);
> 		/* dev->pdev->driver is not filled until after probe completes */
> 		secondary->driver = to_pci_driver(dev->pdev->dev.driver);
> 		pci_dev_get(secondary);
> 	}
> }

You can do that, but where is the problem with your probe function being
called twice - once for each of the devices? You should be able to sort
out which one is which rather easily.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
