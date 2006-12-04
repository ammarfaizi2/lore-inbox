Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967740AbWLDW7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967740AbWLDW7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967741AbWLDW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:59:22 -0500
Received: from ns2.suse.de ([195.135.220.15]:49836 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967740AbWLDW7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:59:22 -0500
Date: Mon, 4 Dec 2006 14:58:54 -0800
From: Greg KH <greg@kroah.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux PCI mailing list <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: /sys/bus/pci/drivers/<driver>/new_id
Message-ID: <20061204225854.GA9359@kroah.com>
References: <20061129211803.GB15186@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129211803.GB15186@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 09:18:04PM +0000, Russell King wrote:
> Unfortunately, the .../new_id feature does not work with the 8250_pci
> driver.
> 
> The reason for this comes down to the way .../new_id is implemented.
> When PCI tries to match a driver to a device, it checks the modules
> static device ID tables _before_ checking the dynamic new_id tables.
> 
> When a driver is capable of matching by ID, and falls back to matching
> by class (as 8250_pci does), this makes it absolutely impossible to
> specify a board by ID, and as such the correct driver_data value to
> use with it.
> 
> Let's say you have a serial board with vendor 0x1234 and device 0x5678.
> It's class is set to PCI_CLASS_COMMUNICATION_SERIAL.
> 
> On boot, this card is matched to the 8250_pci driver, which tries to
> probe it because it matched using the class entry.  The driver finds
> that it is unable to automatically detect the correct settings to use,
> so it returns -ENODEV.
> 
> You know that the information the driver needs is to match this card
> using a device_data value of '7'.  So you echo 1234 5678 0 0 0 0 7
> into new_id.
> 
> The kernel attempts to re-bind 8250_pci to this device.  However,
> because it scans the PCI driver tables, it _again_ matches the class
> entry which has the wrong device_data.  It fails.
> 
> End of story.  You can't support the card without rebuilding the
> kernel (or writing a specific PCI probe module to support it.)
> 
> So, can we make new_id override the driver-internal PCI ID tables?
> IOW, like this:

Yes, you are right, I'll add this to my queue.

thanks,

greg k-h
