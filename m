Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUDWUgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUDWUgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUDWUgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:36:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44041 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261369AbUDWUfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:35:55 -0400
Date: Fri, 23 Apr 2004 21:35:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423213546.C2896@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <200404230802.42293.dtor_core@ameritech.net> <1082730412.23959.118.camel@pegasus> <200404231156.03106.dtor_core@ameritech.net> <20040423171614.GA13835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040423171614.GA13835@kroah.com>; from greg@kroah.com on Fri, Apr 23, 2004 at 10:16:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 10:16:14AM -0700, Greg KH wrote:
> On Fri, Apr 23, 2004 at 11:55:59AM -0500, Dmitry Torokhov wrote:
> > --- 1.11/drivers/net/wireless/atmel_cs.c	Thu Feb  5 05:04:40 2004
> > +++ edited/drivers/net/wireless/atmel_cs.c	Fri Apr 23 11:43:42 2004
> > @@ -348,17 +348,13 @@
> >  	{ 0, 0, "11WAVE/11WP611AL-E", "atmel_at76c502e%s.bin", "11WAVE WaveBuddy" } 
> >  };
> >  
> > -/* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
> > -static struct device atmel_device = {
> > -        .bus_id    = "pcmcia",
> > -};
> > -
> 
> <snip>
> 
> Much nicer (well, in a wierd way at least.)  It seems that the pcmcia
> system is intregrated into the driver model.  Why not push it down into
> the individual pcmcia drivers so you don't have to do this GetSysDevice
> kind of hack still?

They're actually getting at is the PCI device, or statically allocated
platform device, rather than anything specific to the card.

Obviously this is going to create the silly scenario where people
can attach PCMCIA device attributes to the bridge device, which
provides the wrong API to userspace.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
