Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSJABcP>; Mon, 30 Sep 2002 21:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJABcP>; Mon, 30 Sep 2002 21:32:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:53391 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261430AbSJABcO>;
	Mon, 30 Sep 2002 21:32:14 -0400
Date: Mon, 30 Sep 2002 18:39:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Matt_Domsch@Dell.com
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: RE: devicefs requests
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1E8C0@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0209301833060.18550-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002 Matt_Domsch@Dell.com wrote:

> > But what do you do with the usb_bus_type?  Why would your code use
> > anything that is private to the driver core?
> 
> Fair enough.  I actually only need the 64-bit unique ID that the USB device
> provides, and its parent PCI device.  EDD provides this info as x86 BIOS
> sees it, so my code compares the two, and will make a symlink between the
> two.  This lets the OS know which device BIOS thinks it is (i.e. to know
> what disk you're booting from).
> 
> True, I don't (today) see a unique ID in struct usb_device.  Hopefully
> that's something that can be added in the future.  Functions which expose
> this info separate from exporting the bus type would be great.

UUIDs are something that many people have asked for in struct device. I've 
put it off because they're used in only a few places today, because it's 
impossible to standardize them across different device types, and it's 
difficult to extract one from devices that don't inherently support them. 

It's a valid request though. What we've talked about is:

- making it struct device::char * uuid;

- the bus that discovers the device is responsible for allocating and 
  freeing the field. 

- It must be a NULL-terminated ASCII string. 

- It will be exported in the device's drivefs directory in a file 'uuid'.

Anything else? 

	-pat

