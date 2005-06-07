Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVFGQE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVFGQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVFGQEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:04:55 -0400
Received: from colo.lackof.org ([198.49.126.79]:7361 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261922AbVFGQEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:04:49 -0400
Date: Tue, 7 Jun 2005 10:08:26 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050607160826.GB29220@colo.lackof.org>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118129500.5497.16.camel@laptopd505.fenrus.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 09:31:39AM +0200, Arjan van de Ven wrote:
> 
> > > * What if the driver writer does not want MSI enabled for their
> > >   hardware (even though there is an MSI capabilities entry)?  Reasons
> > >   include: overhead involved in initiating the MSI; no support in some
> > >   versions of firmware (QLogic hardware).
> > 
> > Yes, a very good point.  I guess I should keep the pci_enable_msi() and
> > pci_disable_msi() functions exported for this reason.
> > 
> 
> well... only pci_disable_msi() is needed for this ;)

It depends on how the switch from MSI to MSI-X is supposed to work.
I'm thinking of the following sort of sequence:
	pci_disable_msi(dev);
	if (pci_enable_msix(dev,...)) {
		register MSIX stuff
	} else {
		/* MSIX won't work...fall back to MSI */
		pci_enable_msi(dev);
	}

and that makes a bad assumption MSI will work.

grant
