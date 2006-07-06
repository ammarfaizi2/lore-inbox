Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWGFAuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWGFAuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWGFAuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:50:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:37847 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965101AbWGFAuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:50:21 -0400
Subject: Re: [patch 3/7] Check root chipset no_msi flag instead of all
	parent busses flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Goglin <brice@myri.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20060703004055.835863000@myri.com>
References: <20060703003959.942374000@myri.com>
	 <20060703004055.835863000@myri.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 10:50:06 +1000
Message-Id: <1152147006.24632.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 20:40 -0400, Brice Goglin wrote:
> plain text document attachment
> (03-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch)
> MSI only requires support in the root chipset, which may not even have
> a subordinate bus.
> pci_msi_supported() now checks the no_msi flag in the root_chipset pci_dev
> struct instead of the PCI_BUS_FLAGS_NO_MSI flag of all its parent busses.
> The MSI quirk now sets the no_msi flag accordingly.

I think we shall have msi_ops hanging off struct pci_bus.

That way, MSI support can be "installed" off a given bus and can be
handled differently when necessary. On many platforms, the MSI handling
will actually be different from one bus to the next (the Apple G5 comes
to mind with its PCIe off the northbridge on one side and it's HT<->PCIe
tunnels on the other, using different mecanisms for MSIs, but there are
or will be others).

Ben.


