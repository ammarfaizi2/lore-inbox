Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWCCXNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWCCXNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWCCXNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:13:49 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:60033 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932238AbWCCXNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:13:49 -0500
In-Reply-To: <20060303220741.GA22298@kroah.com>
References: <9D653F4D-A375-4D2C-8A5A-063A0BBD962B@kernel.crashing.org> <20060303220741.GA22298@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9483AAD-670C-4D03-9996-6AE89F6FD4FB@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Date: Fri, 3 Mar 2006 17:13:55 -0600
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


On Mar 3, 2006, at 4:07 PM, Greg KH wrote:

> On Fri, Mar 03, 2006 at 11:42:03AM -0600, Kumar Gala wrote:
>> I was wondering what the proper way to assign and setup a single PCI
>> device that comes into existence after the system has booted.  I have
>> an FPGA that we load from user space at which time it shows up on the
>> PCI bus.
>
> Idealy your BIOS would set up this information :)
>
>> It has a single BAR and I need to assign it at a fixed address in PCI
>> MMIO space.
>>
>> All of the exported interfaces I see have to do with having the
>> kernel assign the BAR automatically for me.
>>
>> the following looks like what I want to do:
>>
>> bus = pci_find_bus(0, 3);
>> dev = pci_scan_single_device(bus, devfn);
>> pci_bus_alloc_resource(...);
>> pci_update_resource(dev, dev->resource[0], 0);
>> pci_bus_add_devices(bus);
>>
>> However, pci_update_resource() is not an exported symbol, so I could
>> replace that code with the need updates to the actual BAR.
>>
>> Is this the "right" way to go about this or is there a better
>> mechanism to do this.
>
> Take a look at how the compat pci hotplug driver does this, you  
> probably
> just need to do the same as it.

I found cpqhp_configure_device(), but I dont see anything about how  
to handle assigned a fixed address to the BAR.

I see I could use pci_find_slot()/pci_scan_slot().  Not sure I see  
how that is much better than pci_find_bus()/pci_scan_single_device().

- kumar
