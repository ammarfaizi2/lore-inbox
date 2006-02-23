Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWBWHEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWBWHEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 02:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWBWHEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 02:04:13 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:37479 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751635AbWBWHEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 02:04:12 -0500
In-Reply-To: <20060223051312.GA14534@kroah.com>
References: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org> <20060223043937.GA7204@kroah.com> <C29A9C12-5A2E-4609-8A74-8C3E63891C1F@kernel.crashing.org> <20060223051312.GA14534@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8B3A62DF-6991-4C46-A294-6DF314D24AF4@kernel.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: what's a platform device?
Date: Thu, 23 Feb 2006 01:04:22 -0600
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

>> Yes, the FPGA is a pci device.
>>
>> Not sure I follow exactly what you mean by the fact that platform
>> devices dont know about mmio regions.  They know about struct
>> resource and iomem_resource & ioport_resource.
>
> Yes, as they have no "bus" to attach too.  That's why they are there,
> they are for devices with no bus, but are merely "raw" memory mapped
> devices.

I'm not sure I follow this. How is PCI different?  How would "kumar"  
bus be different?

>> I think I might be missing something fundamental here.  In
>> implementing my own bus_type, I'll end up introducing my own struct
>> foobar_device which looked pretty much like struct platform_device.
>> Then I'll need a set of functions to assign resources, etc.
>>
>> I got no issue implementing my own bus_type, but I clearly feel like
>> I'm missing something here (just not sure what it is :)
>
> I guess I look at your FPGA as a PCI "bridge" chip, that bridges  
> between
> the PCI bus, and your "kumar" bus (for lack of a better name).  Your
> devices hang off of that bus, which is attached to the FPGA, which is
> attached to the pci bridge, and so on.  If you use the platform  
> bus, you
> break that link.
>
> Does that make sense?

This makes sense, but you seem to be talking about hierarchy more the  
functionality.  I agree in your description of hierarchy.

I was looking at it from a functional point of view, maybe more from  
the device view then from the bus.  I need a struct device type that  
contains resources, a name, an id.  I'll do matching based on name.   
 From a functional point of view platform does all this.

Based on your description would you say that a platform_device's  
parent device should always be platform_bus? [I'm getting at the fact  
that we allow pdev->dev.parent to be set by the caller of  
platform_device_add].

Hmm, as I think about this further, I think that its more coincidence  
that the functionality for the "kumar" bus is equivalent to that of  
the "platform" bus.

> Russell probably has other thoughts about this.

Hopefully he'll provide his thoughts :)

- kumar


