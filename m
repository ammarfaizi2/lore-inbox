Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWBNFRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWBNFRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWBNFRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:17:07 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8899 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030384AbWBNFRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:17:00 -0500
Date: Mon, 13 Feb 2006 21:17:00 -0800
From: Greg KH <gregkh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PCI probe leaves master abort disabled in PCI_BRIDGE_CONTROL
Message-ID: <20060214051700.GA28721@suse.de>
References: <20060213.171321.126221906.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213.171321.126221906.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 05:13:21PM -0800, David S. Miller wrote:
> 
> In drivers/pci/probe.c:pci_scan_bridge(), if this is not the first
> pass (pass != 0) we don't restore the PCI_BRIDGE_CONTROL_REGISTER and
> thus leave PCI_BRIDGE_CTL_MASTER_ABORT off:
> 
> int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
> {
>  ...
> 	/* Disable MasterAbortMode during probing to avoid reporting
> 	   of bus errors (in some architectures) */ 
> 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
> 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
>  ...
> 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
> 		unsigned int cmax, busnr;
> 		/*
> 		 * Bus already configured by firmware, process it in the first
> 		 * pass and just note the configuration.
> 		 */
> 		if (pass)
> 			return max;
>  ...
> 	}
> 
> 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>  ...
> 
> This doesn't seem intentional.

No it doesn't.  Ralf added that code, way back in 2.6.2-rc2, with a
patch description of "[PATCH] PCI: fix probing for some mips systems"

David, does this break some stuff on your boxes?

Ralf, any thoughts?  It was way back in January of 2004 that this change
went in.

thanks,

greg k-h
