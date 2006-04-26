Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWDZGSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWDZGSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDZGSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:18:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:39116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750785AbWDZGSU (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:18:20 -0400
Date: Tue, 25 Apr 2006 23:13:28 -0700
From: Greg KH <greg@kroah.com>
To: biswa.nayak@wipro.com
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: PCI ERROR: Segmentation fault in pci_do_scan_bus
Message-ID: <20060426061328.GA2279@kroah.com>
References: <4F36B0A4CDAD6F46A61B2B32C33DC69C02502ABC@BLR-EC-MBX03.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F36B0A4CDAD6F46A61B2B32C33DC69C02502ABC@BLR-EC-MBX03.wipro.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 05:25:32PM +0530, biswa.nayak@wipro.com wrote:
> Hi 
> 
> I am getting segmentation fault, consistently on call to
> 'pci_do_scan_bus'. This is a small test code ( attached with this mail)
> to test the APIs exposed by the PCI subsystem.

The module code you attached isn't exactly "small" :)

What chunk of code is causing the problem?

Why are you scanning the PCI bus from a module?

>I just checked where it
> faults and found out that inside 'sysfs_create_bin_file' it is not able
> to find the kobject out of the dev pointer passed to it. Now extracting
> of the dev object out of the bus pointer is done by
> 'list_for_each_entry(dev, &bus->devices, bus_list)' in
> 'pci_bus_add_devices'. Now I am not able to understand why the kobject
> is missing. Is it something that I am missing or is it a kernel defect?
> Any help in this will be really appreciated. The bug message is pasted
> below.

I'm confused as to why you are trying to set up the pci bus for a pci
bus that is already set up.  That's why the function is dying...

thanks,

greg k-h
