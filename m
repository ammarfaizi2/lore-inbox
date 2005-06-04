Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVFDHCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVFDHCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 03:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFDHCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 03:02:08 -0400
Received: from colo.lackof.org ([198.49.126.79]:17630 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261273AbVFDHCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 03:02:03 -0400
Date: Sat, 4 Jun 2005 01:05:37 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <gregkh@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050604070537.GB8230@colo.lackof.org>
References: <20050603224551.GA10014@kroah.com> <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604064821.GC13238@suse.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 11:48:21PM -0700, Greg KH wrote:
> > One complication is some drivers will want to register a different
> > IRQ handler depending on if MSI is enabled or not.
> 
> That's fine, they can always check the device capabilities and do that.

Can you be more specific?
Maybe a short chunk of psuedo code?

> > If MSI is enabled (and usable), then some MMIO reads can be omitted.
> > I've posted a patch for tg3 driver:
> > 	ftp://ftp.parisc-linux.org/patches/diff-2.6.10-tg3_MSI-03
> > 
> > (Just an example! It was not accepted because of buggy HW
> >  though it worked great on the HW I have access to.)
> > 
> > drivers/infiniband/hw/mthca driver is another example.
> 
> But it doesn't do that yet either ;)

Sorry - only uses different IRQ handlers for MSI-X support.
But it could do something different for MSI IRQ handlers as well.

> > How can the driver know which IRQ handlers to register?
> 
> Same as always, use the dev->irq field like they do today.

I think you misunderstood my question.
The driver uses dev->irq as a "token" to register *some* IRQ handler.
If the driver wants to register "tg3_irq_nommioread()" for the
MSI case and "tg3_irq()" for Line Based IRQ case, how would the
driver know which IRQ handler it should register?

The arch IRQ support knows the difference and currently returns
that status in the pci_msi_enable() call.

thanks,
grant
