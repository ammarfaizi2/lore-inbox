Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbUKMKp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUKMKp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 05:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKMKp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 05:45:26 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:30171
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261743AbUKMKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 05:45:19 -0500
Message-ID: <4195E5AC.7030904@ppp0.net>
Date: Sat, 13 Nov 2004 11:45:00 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
References: <1100301717571@kroah.com> <11003017181402@kroah.com> <20041113091208.A30939@flint.arm.linux.org.uk> <4195DBE3.9000606@ppp0.net> <20041113102205.A646@flint.arm.linux.org.uk>
In-Reply-To: <20041113102205.A646@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, Nov 13, 2004 at 11:03:15AM +0100, Jan Dittmer wrote:
> 
>>Russell King wrote:
>>
>>>Why is this needed?  pci_bus_add_devices() is designed to only add new
>>>devices to the device tree - new devices have an empty dev->global_list.
>>>
>>>Just calling pci_bus_add_devices() for the parent bus should suffice.
>>
>>The device got removed from bus->devices, so I can't call that.
> 
> 
> This sounds very wrong.  Why did it get removed from bus->devices ?
> 
> If it isn't on bus->devices, how does pci_bus_add_device() help?
> Sure you get it onto the global list and into the device tree,
> but it won't be attached to the parent bus properly.
> 
> I think what you want to be using is:
> 
> int __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
> 
> to discover the new device, which will do the right thing from the
> point of setting stuff up before calling pci_bus_add_device*().
> 

I don't see how pci_scan_slot helps me here. I already call
pci_scan_single_device which seems just about the same.

Thanks, Jan
