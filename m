Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbSLDSGW>; Wed, 4 Dec 2002 13:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbSLDSGW>; Wed, 4 Dec 2002 13:06:22 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5389 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266991AbSLDSGV>;
	Wed, 4 Dec 2002 13:06:21 -0500
Date: Wed, 4 Dec 2002 10:13:53 -0800
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model
Message-ID: <20021204181353.GA28062@kroah.com>
References: <20021204175602.GC27780@kroah.com> <200212041804.gB4I4g803144@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212041804.gB4I4g803144@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 12:04:41PM -0600, James Bottomley wrote:
> greg@kroah.com said:
> > But doesn't the bus specific core know when drivers are attached, as
> > it was told to register or unregister a specific driver?  So I don't
> > see why this is really needed. 
> 
> The problem is that the bus specific core registration no-longer knows if the 
> probes succeeded or failed (and if they did, what devices were attached), 
> since probing is controlled by the base core.

Not quite.  Well, I guess you can modify all of your drivers to do this,
but see below for an easier way.

> What the bus needs to know is when a driver attaches to a specific device (and 
> what device it has attached to).

Why not have a call in the driver that notifies the bus specific core of
this?  Or just check the status of the return value of your "probe"
function that the bus provides.  See usb_device_probe() and
pci_device_probe() for examples of this.

thanks,

greg k-h
