Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVCOWxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVCOWxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVCOWxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:53:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:5504 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262074AbVCOWvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:51:05 -0500
Date: Tue, 15 Mar 2005 16:51:01 -0600
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com, tom.l.nguyen@intel.com
Subject: Re: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050315225101.GJ498@austin.ibm.com>
References: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 11, 2005 at 04:12:18PM -0800, long was heard to remark:

> +void hw_aer_unregister(void)
> +{
> +	struct pci_dev *dev = (struct pci_dev*)host->dev;
> +	unsigned short id;
> +
> +	id = (dev->bus->number << 8) | dev->devfn;
> +	
> +	/* Unregister with AER Root driver */
> +	pcie_aer_unregister(id);
> +}

I don't understand how this can work on a system with 
more than one domain.  On any midrange/high-end system, 
you'll have a number of devices with identical values
for (bus->number << 8) | devfn)

For example, on my system, lspci prints out:

mosquito:~ # lspci
0000:00:01.0 Co-processor: IBM: Unknown device 00e0 (rev 01)
0000:00:03.0 ISA bridge: Symphony Labs W83C553 (rev 10)
0001:00:02.0 PCI bridge: IBM: Unknown device 0188 (rev 02)
0001:00:02.2 PCI bridge: IBM: Unknown device 0188 (rev 02)
0001:00:02.3 PCI bridge: IBM: Unknown device 0188 (rev 02)
0001:00:02.4 PCI bridge: IBM: Unknown device 0188 (rev 02)
0001:00:02.6 PCI bridge: IBM: Unknown device 0188 (rev 02)
0001:01:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010
66MHz  Ultra3 SCSI Adapter (rev 01)
0001:01:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010
66MHz  Ultra3 SCSI Adapter (rev 01)
0001:21:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
100] (rev 0d)
0002:00:02.0 PCI bridge: IBM: Unknown device 0188 (rev 02)
0002:00:02.2 PCI bridge: IBM: Unknown device 0188 (rev 02)
0002:00:02.4 PCI bridge: IBM: Unknown device 0188 (rev 02)
0002:00:02.6 PCI bridge: IBM: Unknown device 0188 (rev 02)


Here, 'Unknown device' is actually an empty slot.

If I plugged the ethernet card in a few slots over, it would 
show up as

0002:01:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro

and so it would have the exact same (bus->number << 8) | devfn)
as the scsi device.

Or am I being stupid/dense/all-of-the-above?

--linas

