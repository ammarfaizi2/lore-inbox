Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSIZOlA>; Thu, 26 Sep 2002 10:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261309AbSIZOlA>; Thu, 26 Sep 2002 10:41:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261313AbSIZOk7>;
	Thu, 26 Sep 2002 10:40:59 -0400
Date: Thu, 26 Sep 2002 07:41:43 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Greg KH <greg@kroah.com>
cc: <Matt_Domsch@Dell.com>, <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: devicefs requests
In-Reply-To: <20020926041422.GA1733@kroah.com>
Message-ID: <Pine.LNX.4.33L2.0209260725410.32681-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Greg KH wrote:

| On Wed, Sep 25, 2002 at 10:48:31PM -0500, Matt_Domsch@Dell.com wrote:
| > > Um, what 64-bit unique id?  USB devices do not have such a thing.
| >
| > The EDD spec (http://www.t13.org/docs2002/d1572r0.pdf - T13 committee
| > project 1572D BIOS Enhanced Disk Drive Services - 3) says:
| > USB identifier:  64-bit Serial Number as defined in the USB Mass Storage
| > specifications
|
| Ah, but that's a USB storage identifier, not a USB identifier.  The usb
| device structure does not contain this field, nor will it ever, sorry.
|
| It seems that this spec is oriented toward storage devices.  The USB
| device structure if for all types of devices.

Yes, EDD would be oriented toward storage devices.

| > I assume that they mean the USB Mass Storage spec v1.0
| > (http://www.usb.org/developers/data/devclass/usbmassbulk_10.pdf) section
| > 4.1.1 - Serial Number, which is 12-16 bytes long.  drivers/usb/storage/usb.c
| > turns that into a 16-byte GUID in storage_probe().  I hadn't gotten so far
| > as to see that these two specs don't agree for USB - I'd been looking at the
| > IDE and SCSI descriptions so far.  It wouldn't be the first time the EDD
| > spec needed editing, and given that few (if any) BIOSs yet implement it
| > apart from SCSI, is reason for the confusion.
|
| The majority of USB devices do not support serial numbers, as that field
| was made optional in the spec.  Even if it was required, it's a string
| field, not a 64 bit number :(

It's optional in the USB CBI spec.  It's not even mentioned in the
USB UFI (floppy) spec, and USB floppy drives that I've seen do not
have it.  It's not listed as optional in the USB bulk interface
storage spec, and my Zip drive and USB hard drive do have serial
numbers.  At any rate, it cannot be depended on to be there.

| > I don't think Dell has a T13 committee representative right now, but I'll
| > see if we have a process for getting this cleared up through official
| > channels.  As I'm not a USB expert, would you care to comment on the right
| > way to handle this (i.e. instead of a 64-bit serial number, use the 16-byte
| > GUID)?
|
| Um, what do you mean, "right way"?  All USB devices do not have any such
| serial number.  Only a very small minority of devices contain a kind of
| serial number, and that field is a string (and often times it is not
| even unique, unfortunately.)
|
| As for USB storage devices, I don't know if they all contain serial
| numbers that are unique, you might want to go ask the author of the
| usb-storage driver, Matt Dharm.
|
| What are you trying to walk all of the USB devices for?  What would you
| do if you found a USB mass storage device that matched something in the
| EDD tables?

-- 
~Randy

