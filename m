Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292767AbSBUUsk>; Thu, 21 Feb 2002 15:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292772AbSBUUsa>; Thu, 21 Feb 2002 15:48:30 -0500
Received: from air-2.osdl.org ([65.201.151.6]:39057 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S292767AbSBUUsS>;
	Thu, 21 Feb 2002 15:48:18 -0500
Date: Thu, 21 Feb 2002 12:48:09 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: Adam <ambx1@netscape.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: driverfs question
In-Reply-To: <3C755A8A.90000@netscape.net>
Message-ID: <Pine.LNX.4.33.0202211242120.31464-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Feb 2002, Adam wrote:

> 
> How will the devices in the driverfs be arranged?
> It seems to me that it could only be one of the following three methods.
> 
> Method 1:
> All devices will be arranged according to type.  There will be a folder 
> for video, sound, joysticks, etc.
> Pros: - Easy to read and understand while browsing the driverfs.
> Cons: - Similar interface already implemented in device fs.
>        - arrangement shows no hierarchy and doesn't involve the buses.
> 
> Method 2:
> Folders are created for each bus then devices are placed within them.
> If a bus has another bus for a parent, like a pci USB controller,
> it doesn't matter.  The bus still gets a root level folder.
> Pros: - Useful and unique information to the user.
> Cons: - Still doesn't truly represent devices by their actual connection
>        - Makes root level device detection APIs more difficult to write
> 
> Method 3:
> Devices are arranged by their true connection.  If a usb controller is a 
> member of a pci bus, it's folder will be within the pci folder.  The 
> root level bus will either be PnP BIOS, APIC device tables, or, for 
> legacy computers, an emulation of some sort.
> Pros: - Devices are arranged by their actual connection.
>        - PnP and APIC will finally be truly integrated into the kernel.
> Cons: - Legacy emulation could be challenging.

This is the intended method of operation, and we have so far. The PCI bus 
is a child of the root; a USB bus is a child of the rest. 

Legacy is emulation is interesting, since many legacy devices just 
"appear" on the system bus. The method I have suggested for this to create 
a 'legacy bus' that parents all legacy devices found in the system.

> I tend to prefer method 3.  Not only does it provide a perfect interface 
> for user level daemons but also it shows the devices in their true 
> locations.  This is very important.  Perhaps all or some of these 
> methods should be compile time options.

The other methods can be wrapped into userspace utilities, if one so 
desires. Some of them already are. There are 'lspci' and 'lsusb' 
utilities.

A device typically knows what device class it belongs to, though this 
information is not represented in struct device currently. If it was, one 
could theoretically do 'lsvideo' (or 'lsdev -c video') to see what video 
devices they had in their system. :)

	-pat

