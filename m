Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbSLDWWL>; Wed, 4 Dec 2002 17:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbSLDWWL>; Wed, 4 Dec 2002 17:22:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40973 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267123AbSLDWWJ>;
	Wed, 4 Dec 2002 17:22:09 -0500
Date: Wed, 4 Dec 2002 14:29:39 -0800
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model
Message-ID: <20021204222938.GA29519@kroah.com>
References: <20021204181353.GA28062@kroah.com> <200212041935.gB4JZ0p03464@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212041935.gB4JZ0p03464@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 01:35:00PM -0600, James Bottomley wrote:
> greg@kroah.com said:
> > Why not have a call in the driver that notifies the bus specific core
> > of this?  Or just check the status of the return value of your "probe"
> > function that the bus provides.  See usb_device_probe() and
> > pci_device_probe() for examples of this. 
> 
> Well, I did do it this way for parisc.  However, I assumed from reading the 
> driver model docs that we were transitioning to using the generic driver probe 
> rather than doing probe interceptions like this.
> 
> Doing it like this just seems rather clumsy.  wouldn't it be better to 
> deprecate bus specific registrations in favour of the generic one?

I don't know.  Then for every bus specific driver, they would have to do
the "dereference the structure" logic before they can start to determine
if they should bind to this specific device.  That's all the PCI and USB
code really does, strip out the proper structures that are relevant to
the specific bus type, and then call the driver.

So in the end you would probably have a lot of duplicated code that
would be better off being in one place, like it is today :)

> There is another advantage to notifiers: they can be chained.  Certain bus 
> architectures need to do additional setup for things like pci devices.  They 
> would be able to do this by attaching a notifier.

That seems a bit overkill.  The bus specific code can add those
architecture setup hooks right now if it's needed, right?

thanks,

greg k-h
