Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVBADSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVBADSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVBADSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:18:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:38058 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261515AbVBADSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:18:02 -0500
Subject: Re: pci: Arch hook to determine config space size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: brking@us.ibm.com
Cc: Arnd Bergmann <arnd@arndb.de>,
       Linux Arch list <linux-arch@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <41FEB492.2020002@us.ibm.com>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com>
	 <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk>
	 <41FEA4AA.1080407@us.ibm.com> <200501312256.44692.arnd@arndb.de>
	 <41FEB492.2020002@us.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 14:15:27 +1100
Message-Id: <1107227727.5963.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 16:43 -0600, Brian King wrote:

> diff -puN include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg include/asm-ppc64/prom.h
> --- linux-2.6.11-rc2-bk9/include/asm-ppc64/prom.h~ppc64_pcix_mode2_cfg	2005-01-31 14:32:01.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/include/asm-ppc64/prom.h	2005-01-31 14:32:01.000000000 -0600
> @@ -137,6 +137,7 @@ struct device_node {
>  	int	devfn;			/* for pci devices */
>  	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
>  	int	eeh_config_addr;
> +	int	pci_ext_config_space;	/* for phb's or bridges */
>  	struct  pci_controller *phb;	/* for pci devices */
>  	struct	iommu_table *iommu_table;	/* for phb's or bridges */

Grrr... more crap added to the device-node, I don't like that ...

This is a PHB only field, can't it be in struct pci_controller instead ?

Ben.


