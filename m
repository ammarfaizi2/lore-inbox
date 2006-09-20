Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWITV6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWITV6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWITV6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:58:07 -0400
Received: from ns.suse.de ([195.135.220.2]:29091 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932228AbWITV6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:58:05 -0400
Date: Wed, 20 Sep 2006 14:57:53 -0700
From: Greg KH <greg@kroah.com>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Development List <linux-kernel@vger.kernel.org>,
       USB Development List <linux-usb-devel@lists.sourceforge.net>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: USB: u132-hcd: host controller driver for ELAN U132 adapter
Message-ID: <20060920215753.GA15138@kroah.com>
References: <1158143255.4328.14.camel@n04-207.elan.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158143255.4328.14.camel@n04-207.elan.private>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 11:27:35AM +0100, Tony Olech wrote:
> This "u132-hcd" module is one half of the "driver" for
> ELAN's U132 which is a USB to CardBus OHCI controller
> adapter. This module needs the "ftdi-elan" module in
> order to communicate to CardBus OHCI controller inserted
> into the U132 adapter.
> 
> When the "ftdi-elan" module detects a supported CardBus
> OHCI controller in the U132 adapter it loads this "u132-hcd"
> module.
> 
> Upon a successful device probe() the single workqueue
> is started up which does all the processing of commands
> from the USB core that implement the host controller.
> 
> The workqueue maintains the urb queues and issues commands
> via the functions exported by the "ftdi-elan" module. Each
> such command will result in a callback.
> 
> Note that the "ftdi-elan" module is a USB client driver.
> 
> Note that this "u132-hcd" module is a (cut-down OHCI)
> host controller.
> 
> Thus we have a topology with the parent of a host controller
> being a USB client! This really stresses the USB subsystem
> semaphore/mutex handling in the module removal.
> 
> Signed-off-by: Tony Olech <tony.olech@elandigitalsystems.com>

I've applied this, and fixed up the build issue (needed to add it also
to the drivers/usb/Makefile file) and the sparse errors, but I'm still
getting these warnings:

drivers/usb/host/ohci.h:605: warning: 'periodic_reinit' defined but not used
drivers/usb/host/ohci.h:629: warning: 'roothub_a' defined but not used
drivers/usb/host/ohci.h:635: warning: 'roothub_portstatus' defined but not used

Care to send me a follow-on patch that fixes this?

thanks,

greg k-h
