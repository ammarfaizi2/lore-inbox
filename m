Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSFYSlH>; Tue, 25 Jun 2002 14:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSFYSlG>; Tue, 25 Jun 2002 14:41:06 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8348 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315758AbSFYSlF>;
	Tue, 25 Jun 2002 14:41:05 -0400
Date: Tue, 25 Jun 2002 11:35:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: RE: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map
 )
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.33.0206251123480.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Surely a driver using IP-over-wire like iSCSI is no less 
> > deserving of appearing
> > in "driverfs" than one whose driver uses 
> > custom-protocol-over-a-"wire" like USB,
> > FireWire, FC, IR, SCSI, or Bluetooth?  I don't see why some 
> > disks (for example)
> > should deserve to be "more equal than others" -- and approved 
> > to be in driverfs.
> 
> It's a matter of where to draw the line. Obviously when we're talking
> physical devices, my tcpip connection to www.yahoo.com is not one. My PS/2
> port is. I actually think keeping in mind that driverfs is for power
> management can help delineate what should be in driverfs and what shouldn't.
> With technologies like USB, infiniband, NFS, iSCSI, and 1394, it's tough,
> but the main question should be:

When you're talking to www.yahoo.com, you're really only talking to the 
webserver. Sure, indirectly you're talking to their network card, their 
disk, their memory, and their cpu. But, let's not get carried away. 

With things like network block devices, you're communicating directly with 
a device. (Yes, it may be a virtual device that doesn't have a mapping to 
a real physical device. But it doesn't matter; you _think_ it's a device.)

driverfs is not power management. driverfs does not care about power 
management. The device model is not about power management. Power 
management is one benefit of having a unified device tree, but it is not 
it's main focus. It's purpose is to represent the physical layout of 
devices in the system as accurately as possible. 

> "If my computer suspends, should this device be turned off?" Which is
> another way of asking is the use of a device exclusive to a particular
> machine.
> 
> If a device can be accessed by multiple machines concurrently, it should not
> be in driverfs.

So, what about network cards? Disks with partitions exported via NFS? 
Serial ports with a null modem attached? 

Sound absurd? Of course it does, but in it lies the distinction between 
devices you care about and devices you don't: if it's local, you suspend 
it. If it's not, then you don't power it down. The drivers for these 
devices should be able to tell whether you're communicating with a local 
or remote device and choose the appropriate action. 

	-pat

