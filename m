Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265035AbTFRBYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 21:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTFRBYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 21:24:18 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:20891 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S265035AbTFRBYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 21:24:17 -0400
Message-ID: <3EEFC284.8080700@cox.net>
Date: Tue, 17 Jun 2003 18:38:12 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030603
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Patrick Mochel <mochel@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
References: <Pine.LNX.4.44L0.0306171329370.621-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0306171329370.621-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:

> For example, on my system the master device on the first PCI IDE channel
> is a hard disk, hda in fact.  This means that
> /sys/devices/pci0/0000:00:07.1/ide0/0.0/ and /sys/block/hda/ refer to the
> same physical device.  One is created by the IDE bus driver, the other by
> a block device driver.  Granted, there are links from one to the other,
> but it still indicates that the organization of sysfs reflects the
> software organization of the kernel as much as the physical organization
> of the computer system.
> 

PMJFI, and I'm not driver model expert, but I can think I can answer 
this one. Yes, you are correct, these two sysfs directories are 
associated with the same physical devices. However, they are definitely 
two different things.

The first is an IDE device. It has attributes common to IDE devices, 
like DMA/PIO mode, cable type, bus speed, etc.

The second is a block device. A _generic_ block device. It has 
attributes like length, dev (its device number), I/O scheduler settings, 
etc.

These are two wildly differing views, but yes, they are the same device. 
These differing attributes do _not_ belong in the same directory. An 
application looking at your IDE devices does not really care how the 
block subsystem perceives those devices (i.e. hdparm). Conversely, an 
application looking at your block devices should not care about what 
underlying physical devices (if any :-) they are associated with.

