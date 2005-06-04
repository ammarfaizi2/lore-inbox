Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFDB1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFDB1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 21:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVFDB1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 21:27:44 -0400
Received: from colo.lackof.org ([198.49.126.79]:56792 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261207AbVFDB1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 21:27:42 -0400
Date: Fri, 3 Jun 2005 19:31:12 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <gregkh@suse.de>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050604013112.GB16999@colo.lackof.org>
References: <20050603224551.GA10014@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603224551.GA10014@kroah.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 03:45:51PM -0700, Greg KH wrote:
> In talking with a few people about the MSI kernel code, they asked why
> we can't just do the pci_enable_msi() call for every pci device in the
> system (at somewhere like pci_enable_device() time or so).  That would
> let all drivers and devices get the MSI functionality without changing
> their code, and probably make the api a whole lot simpler.

One complication is some drivers will want to register a different
IRQ handler depending on if MSI is enabled or not.
If MSI is enabled (and usable), then some MMIO reads can be omitted.
I've posted a patch for tg3 driver:
	ftp://ftp.parisc-linux.org/patches/diff-2.6.10-tg3_MSI-03

(Just an example! It was not accepted because of buggy HW
 though it worked great on the HW I have access to.)

drivers/infiniband/hw/mthca driver is another example.

> Now I know the e1000 driver would have to specifically disable MSI for
> some of their broken versions, and possibly some other drivers might
> need this, but the downside seems quite small.
> 
> Or am I missing something pretty obvious here?

How can the driver know which IRQ handlers to register?

grant
