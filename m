Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbUKMKDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUKMKDw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 05:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbUKMKDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 05:03:52 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:27352
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261774AbUKMKDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 05:03:43 -0500
Message-ID: <4195DBE3.9000606@ppp0.net>
Date: Sat, 13 Nov 2004 11:03:15 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
References: <1100301717571@kroah.com> <11003017181402@kroah.com> <20041113091208.A30939@flint.arm.linux.org.uk>
In-Reply-To: <20041113091208.A30939@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Nov 12, 2004 at 03:21:58PM -0800, Greg KH wrote:
> 
>>ChangeSet 1.2091.1.2, 2004/11/11 16:32:25-08:00, jdittmer@ppp0.net
>>
>>[PATCH] fakephp: introduce pci_bus_add_device
>>
>>fakephp needs to add newly discovered devices to the global pci list.
>>Therefore seperate out the appropriate chunk from pci_bus_add_devices
>>to pci_bus_add_device to add a single device to sysfs, procfs
>>and the global device list.
> 
> 
> Why is this needed?  pci_bus_add_devices() is designed to only add new
> devices to the device tree - new devices have an empty dev->global_list.
> 
> Just calling pci_bus_add_devices() for the parent bus should suffice.

The device got removed from bus->devices, so I can't call that.
pci_do_scan_bus would probably the correct function to call.
But it isn't aware of already existing devices and doesn't allow
to add the hotplug slot after discovering new devices.
Well I could walk the device tree afterwards and find unbound
devices. Still pci_scan_slot would rescan and reenable all devices.
What do I overlook?

Thanks,

Jan
