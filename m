Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVCOXNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVCOXNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVCOXM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:12:57 -0500
Received: from colo.lackof.org ([198.49.126.79]:14724 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262162AbVCOXKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:10:37 -0500
Date: Tue, 15 Mar 2005 16:12:01 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, greg@kroah.com,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050315231201.GB4030@colo.lackof.org>
References: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com> <20050315225101.GJ498@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315225101.GJ498@austin.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 04:51:01PM -0600, Linas Vepstas wrote:
> Hi,
> 
> On Fri, Mar 11, 2005 at 04:12:18PM -0800, long was heard to remark:
> 
> > +void hw_aer_unregister(void)
> > +{
> > +	struct pci_dev *dev = (struct pci_dev*)host->dev;

I'm more nervous about "host" being defined as a global
instead of being passed in. I've not review the
other code and don't know if that's safe.

> > +	unsigned short id;
> > +
> > +	id = (dev->bus->number << 8) | dev->devfn;
> > +	
> > +	/* Unregister with AER Root driver */
> > +	pcie_aer_unregister(id);
> > +}
> 
> I don't understand how this can work on a system with 
> more than one domain.  On any midrange/high-end system, 
> you'll have a number of devices with identical values
> for (bus->number << 8) | devfn)

Yes - this is an error reported within a particular domain.
I'm expecting host-> to refer to a particular domain.
Maybe it doesn't?

[ example deleted ]

> Or am I being stupid/dense/all-of-the-above?

Probably not.

grant

> 
> --linas
