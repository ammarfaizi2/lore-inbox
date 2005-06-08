Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVFHRBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVFHRBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVFHRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:01:50 -0400
Received: from colo.lackof.org ([198.49.126.79]:41693 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261396AbVFHRAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:00:39 -0400
Date: Wed, 8 Jun 2005 11:04:16 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050608170416.GB5908@colo.lackof.org>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org> <20050607161029.GB15345@suse.de> <20050608133732.GV23831@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608133732.GV23831@wotan.suse.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 03:37:32PM +0200, Andi Kleen wrote:
> > The issue is, if pci_enable_msix() fails, we want to fall back to MSI,
> > so you need to call pci_enable_msi() for that (after calling
> > pci_disable_msi() before calling pci_enable_msix(), what a mess...)
> 
> It is messy in that case, but still preferable to having MSI code
> in every driver. I suppose most devices will not use MSI-X for some time...

I was going to argue the opposite:
	New devices are implementing MSI-X, not MSI.
	e.g. IB/10GigE implement MSI-X.

But wording in the PCI-[XE] specs forecast what Andi said:
| 2.1.9.    Message-Signaled Interrupts
| PCI-X devices are required to support message-signaled interrupts and
| must support a 64-bit message address, as specified in PCI 2.2.

PCI-E 1.0 has similar language:
| 6.1.4.         Message Signaled Interrupt (MSI) Support
| The Message Signaled Interrupt (MSI) capability is defined in the
| PCI 2.3 Specification. MSI interrupt support, which is optional for
| PCI 2.3 devices, is required for PCI Express devices.  MSI-capable
| devices deliver interrupts by performing memory write transactions.
| MSI is an edge-triggered interrupt; neither the PCI 2.3 Specification
| nor this specification support level-triggered MSI interrupts.

PCI 3.0 spec was the first to mention anything about MSI-X.

PCI-E 1.1 also mentions MSI-X:
| 6.1.4.           Message Signaled Interrupt (MSI/MSI-X) Support
| MSI/MSI-X interrupt support, which is optional for PCI 3.0 devices,
| is required for PCI Express devices. All PCI Express devices that
| are capable of generating interrupts must support MSI or MSI-X or both.
| The MSI and MSI-X mechanisms deliver interrupts by performing memory
|  write transactions. MSI and MSI-X are edge-triggered interrupt
| mechanisms; neither the PCI Local Bus Specification, Revision 3.0 nor
| this specification support level-triggered MSI/MSI-X interrupts.

My point is that MSI-X is optional (an alternative to MSI).

hth,
grant
