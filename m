Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267801AbUG3T4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267801AbUG3T4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267813AbUG3T4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:56:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:40388 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267807AbUG3T4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:56:49 -0400
Date: Fri, 30 Jul 2004 12:55:39 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730195539.GA30466@kroah.com>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk> <200407301112.10361.jbarnes@engr.sgi.com> <200407301149.39256.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301149.39256.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 11:49:39AM -0700, Jesse Barnes wrote:
> +
> +	/* If the device has a ROM, map it */
> +	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
> +		pci_rom_attr.size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
> +		sysfs_create_bin_file(&pdev->dev.kobj, &pci_rom_attr);
> +	}

Doesn't this code cause _all_ rom sizes to be the same, as you only have
1 pci_rom_attr variable?  You should create a new one for every pci
device (making sure to clean it up when the device is removed.)

thanks,

greg k-h
