Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVFGWIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVFGWIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVFGWIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:08:46 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:15284 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262006AbVFGWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:08:43 -0400
Date: Tue, 7 Jun 2005 15:08:32 -0700
From: Greg KH <gregkh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050607220832.GA19173@suse.de>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org> <20050607161029.GB15345@suse.de> <1118176872.5497.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118176872.5497.38.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 10:41:12PM +0200, Arjan van de Ven wrote:
> On Tue, 2005-06-07 at 09:10 -0700, Greg KH wrote:
> > On Tue, Jun 07, 2005 at 09:31:39AM +0200, Arjan van de Ven wrote:
> > > 
> > > > > * What if the driver writer does not want MSI enabled for their
> > > > >   hardware (even though there is an MSI capabilities entry)?  Reasons
> > > > >   include: overhead involved in initiating the MSI; no support in some
> > > > >   versions of firmware (QLogic hardware).
> > > > 
> > > > Yes, a very good point.  I guess I should keep the pci_enable_msi() and
> > > > pci_disable_msi() functions exported for this reason.
> > > > 
> > > 
> > > well... only pci_disable_msi() is needed for this ;)
> > 
> > I thought so too, until I looked at the IB driver :(
> > 
> > The issue is, if pci_enable_msix() fails, we want to fall back to MSI,
> > so you need to call pci_enable_msi() for that (after calling
> > pci_disable_msi() before calling pci_enable_msix(), what a mess...)
> 
> if the core enables msi.. shouldn't the core also do msix ?

Damm, I knew someone was going to say that :)

Yeah, problem is, the driver provides the msix entries for the core to
fill in.  I could just move that to the pci structure itself if no one
minds, and just use the max number of entries as the default.

Hm, or does it really help for the driver to specify different numbers
of msi-x vectors?

Roland, any ideas here?  You seem to be the only one who has actually
used the msix code so far.

thanks,

greg k-h
