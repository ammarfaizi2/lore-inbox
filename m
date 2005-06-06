Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVFFXUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVFFXUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVFFXT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:19:58 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:22103 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261757AbVFFXKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:10:05 -0400
Date: Mon, 6 Jun 2005 16:09:50 -0700
From: Greg KH <gregkh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050606230950.GA11498@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net> <20050606225548.GA11184@suse.de> <20050606.155954.59466251.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606.155954.59466251.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 03:59:54PM -0700, David S. Miller wrote:
> From: Greg KH <gregkh@suse.de>
> Date: Mon, 6 Jun 2005 15:55:49 -0700
> 
> > Why would it matter?  The driver shouldn't care if the interrupts come
> > in via the standard interrupt way, or through MSI, right?  And if it
> > does, it could always use a function like the one I proposed to set up a
> > different irq handler.
> 
> It matters because MSI totally changes the DMA vs. interrupt delivery
> guarentees.
> 
> With MSI, you can be assured that any DMA sent from the device, before
> the interrupt, has reached global visibility before the MSI arrives at
> the cpu.  There is no such guarentee with pre-MSI interrupt delivery.
> 
> Drivers optimize this, so they have to know if MSI is being used or
> not.

Ok, I buy that argument, but currently for all of the drivers in the
tree using MSI (all 7), only the tg3 driver does such an optimizaion
(well, the mthca does some other MSI-X stuff too.)  And I'm still saying
that if you want to provide such a functionality, you can.  The function
to see if MSI is being used or not will be present, which drivers can
call if they wish to to do such optimizations.

So, the tg3 driver would need a small tweak, but the other drivers would
get code removed from them...

thanks,

greg k-h
