Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTIYS5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTIYS5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:57:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:23428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261828AbTIYS5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:57:37 -0400
Date: Thu, 25 Sep 2003 11:53:03 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@us.ibm.com>
Subject: Re: [BUG/MEMLEAK?] struct pci_bus, child busses & bridges
In-Reply-To: <3F73309B.4070908@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0309251146170.947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, I see that now.  I guess my only remaining question is why do child 
> busses not get their own struct device, but rather only a pointer to the 
> bridge's struct device?  There's no refcounting done on this, ie: no 
> pci_dev_get/put calls, but I guess that's kinda ok, since we're pretty 
> sure that the child bus won't exist for longer than the bridge that owns 
> it, right?  So using the bridge's struct dev allows the pci topology to 
> look cleaner?  As in, there's no actual bus exposed in sysfs/procfs/etc, 
> just devices that seem to be hanging off the bridge?

Buses are not devices. Bridges are devices and get a struct device. Buses 
are physical (or logical) collections of devices at the same topological 
level which reside on one side of a bridge. I.e. they are objects of some 
sort, but not devices, and hence are not represented in /sys/devices/. 

It would be nice to export them in /sys/bus/pci/ somehow, but it's one of 
those things that I haven't gotten around to in the last 6 months or so. 
:) 


	Pat


