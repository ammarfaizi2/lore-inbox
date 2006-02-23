Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWBWQNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWBWQNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWBWQNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:13:40 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:56725 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751587AbWBWQNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:13:39 -0500
In-Reply-To: <20060223093348.GB6248@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0602221517370.21264-100000@gate.crashing.org> <20060223093348.GB6248@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4128F00E-36F4-42AB-A845-ED761609D70D@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: what's a platform device?
Date: Thu, 23 Feb 2006 10:13:45 -0600
To: Russell King <rmk+lkml@arm.linux.org.uk>
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


On Feb 23, 2006, at 3:33 AM, Russell King wrote:

> On Wed, Feb 22, 2006 at 03:47:40PM -0600, Kumar Gala wrote:
>> The situation I have is an FPGA connected over PCI.  The FPGA  
>> implements
>> various device functionality (serial ports, I2C controller, IR,  
>> etc.) as a
>> single PCI device/function.  The FPGA breaks any notion of a true PCI
>> device, it uses PCI as a device interconnect more than anything else.
>
> We have at least one example where we have a single PCI function
> containing more than one type of functionality which are the parallel
> port and serial cards [*].  Normally, the different types of
> functionality are accessible via different BARs which at least gives
> some logical separation.
>
> It's not really a good model because you have to have a special PCI
> probe driver to register the various functionalities with the  
> subsystems
> rather than using the generic 8250_pci and parport_pci drivers  
> directly.
> Also it can have problems if you want to have (eg) serial built-in and
> i2c as a module.
>
> The alternative as Greg points out is to implement a pseudo  
> bus_type, but
> I start to worry about the overhead associated with doing so.
>
> Given the choice between a small PCI "probe" driver for a small number
> of functionalities and a complete driver model infrastructure, I'd
> prefer the former over the latter.

I might not have been clear before.  The number of functions that are  
implemented in the FPGA is not a small hand full.  I think Greg's  
idea of creating a bus is appropriate for the scale.

- kumar

