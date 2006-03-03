Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWCCRmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWCCRmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWCCRmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:42:08 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:34697 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1030253AbWCCRmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:42:06 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9D653F4D-A375-4D2C-8A5A-063A0BBD962B@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: proper way to assign fixed PCI resources to a "hotplug" device
Date: Fri, 3 Mar 2006 11:42:03 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering what the proper way to assign and setup a single PCI  
device that comes into existence after the system has booted.  I have  
an FPGA that we load from user space at which time it shows up on the  
PCI bus.

It has a single BAR and I need to assign it at a fixed address in PCI  
MMIO space.

All of the exported interfaces I see have to do with having the  
kernel assign the BAR automatically for me.

the following looks like what I want to do:

bus = pci_find_bus(0, 3);
dev = pci_scan_single_device(bus, devfn);
pci_bus_alloc_resource(...);
pci_update_resource(dev, dev->resource[0], 0);
pci_bus_add_devices(bus);

However, pci_update_resource() is not an exported symbol, so I could  
replace that code with the need updates to the actual BAR.

Is this the "right" way to go about this or is there a better  
mechanism to do this.

thanks

- kumar

