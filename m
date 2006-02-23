Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWBWEzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWBWEzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWBWEzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:55:11 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:39010 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751146AbWBWEzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:55:09 -0500
In-Reply-To: <20060223043937.GA7204@kroah.com>
References: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org> <20060223043937.GA7204@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C29A9C12-5A2E-4609-8A74-8C3E63891C1F@kernel.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: what's a platform device?
Date: Wed, 22 Feb 2006 22:55:16 -0600
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


On Feb 22, 2006, at 10:39 PM, Greg KH wrote:

> On Wed, Feb 22, 2006 at 03:47:40PM -0600, Kumar Gala wrote:
>> Guys,
>>
>> I was hoping to get your opinion on a question I had.  The  
>> question comes
>> down to what we think a "platform device" is.
>>
>> The situation I have is an FPGA connected over PCI.  The FPGA  
>> implements
>> various device functionality (serial ports, I2C controller, IR,  
>> etc.) as a
>> single PCI device/function.  The FPGA breaks any notion of a true PCI
>> device, it uses PCI as a device interconnect more than anything else.
>>
>> In talking to Greg about this, he suggested I just create a new  
>> bus_type
>> for this similar to what is being done for usb-serial.  As I  
>> started to
>> think about what I wanted ended up being a platform_device plus a  
>> sysfs
>> entry for the MMIO region.
>>
>> So, it seems that a "platform device" is a pretty generic concept  
>> now.  Do
>> you guys thing its acceptable to use a platform device for my  
>> needs or
>> should I create some new bus_type?  Do we have a better definition  
>> of what
>> a platform device is or might be?
>
> Well, your FPGA is a pci device, right?  It's only the devices that  
> hang
> off of it that you are concerned about.  I really think you should  
> make
> your own bus type, as it's not much work, and it would not disturb the
> existing platform devices, which do not know about mmio regions like
> PCI.

Yes, the FPGA is a pci device.

Not sure I follow exactly what you mean by the fact that platform  
devices dont know about mmio regions.  They know about struct  
resource and iomem_resource & ioport_resource.

I think I might be missing something fundamental here.  In  
implementing my own bus_type, I'll end up introducing my own struct  
foobar_device which looked pretty much like struct platform_device.
Then I'll need a set of functions to assign resources, etc.

I got no issue implementing my own bus_type, but I clearly feel like  
I'm missing something here (just not sure what it is :)

- kumar


