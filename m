Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbUKPFkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUKPFkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUKPFke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:40:34 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:18087 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261896AbUKPFj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:39:57 -0500
Date: Tue, 16 Nov 2004 00:37:41 -0500
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, matthieu castet <castet.matthieu@free.fr>,
       bjorn.helgaas@hp.com, vojtech@suse.cz,
       "Brown, Len" <len.brown@intel.com>, greg@kroah.com
Subject: Re: [PATCH] PNP support for i8042 driver
Message-ID: <20041116053741.GD29574@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org,
	matthieu castet <castet.matthieu@free.fr>, bjorn.helgaas@hp.com,
	vojtech@suse.cz, "Brown, Len" <len.brown@intel.com>, greg@kroah.com
References: <41960AE9.8090409@free.fr> <200411140148.02811.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411140148.02811.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 01:48:00AM -0500, Dmitry Torokhov wrote:
> On Saturday 13 November 2004 08:23 am, matthieu castet wrote:
> > Hi,
> > this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
> > is try before the pnp driver so if you don't disable ACPI or apply 
> > others pnpacpi patches, it won't change anything.
> > 
> > Please review it and apply if possible
> > 
> > thanks,
> > 
> > Matthieu CASTET
> > 
> > Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>
> > 
> 
> Hi,
> 
> Do we really need to keep those drivers loaded - i8042 will not
> be hotplugged and ports are reserved anyway. We are only interested
> in presence of the keyboard and mouse ports. Can we unregister
> the drivers (both ACPI and PNP) right after registering and mark
> all that stuff as __init/__initdata as in the patch below?
> I also adjusted init logic so ACPI/PNP can be enabled/disabled
> independently of each other.
> 
> -- 
> Dmitry

As a general convention, I think we do.  This should apply to every bus and
driver.  Every hardware component should have a driver bound to it.
Otherwise, we can't take full advantage of sysfs.  We really need a driver to
link the physical device to logical "class" abstractions . Futhermore, as we
extend the functionality of the driver core (ex. manual binding and unbinding)
_init will cause many headaches.  Also, unloading the driver is not good for
power management.  This case may not apply to every device, but in most cases
we need to have a driver loaded before suspending a piece of hardware, as only
that driver can be sure of how to handle the device correctly.

It may not always be the most efficient solution for legacy hardware, but, at
least, if we require legacy drivers to behave like any other driver, then we
can ensure a minimum level of functionalily and flexability.  This set of
standards will help ensure that legacy hardware can coexist nicely with more
modern solutions.  That's really one of the main advantages of a layered
design like the driver model.

Thanks,
Adam
