Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262156AbSIZEK2>; Thu, 26 Sep 2002 00:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262163AbSIZEK2>; Thu, 26 Sep 2002 00:10:28 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:48905 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262156AbSIZEK0>;
	Thu, 26 Sep 2002 00:10:26 -0400
Date: Wed, 25 Sep 2002 21:14:22 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: devicefs requests
Message-ID: <20020926041422.GA1733@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D68C1E8C2@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1E8C2@AUSXMPC122.aus.amer.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 10:48:31PM -0500, Matt_Domsch@Dell.com wrote:
> > Um, what 64-bit unique id?  USB devices do not have such a thing.
> 
> The EDD spec (http://www.t13.org/docs2002/d1572r0.pdf - T13 committee
> project 1572D BIOS Enhanced Disk Drive Services - 3) says:
> USB identifier:  64-bit Serial Number as defined in the USB Mass Storage
> specifications

Ah, but that's a USB storage identifier, not a USB identifier.  The usb
device structure does not contain this field, nor will it ever, sorry.

It seems that this spec is oriented toward storage devices.  The USB
device structure if for all types of devices.

> I assume that they mean the USB Mass Storage spec v1.0
> (http://www.usb.org/developers/data/devclass/usbmassbulk_10.pdf) section
> 4.1.1 - Serial Number, which is 12-16 bytes long.  drivers/usb/storage/usb.c
> turns that into a 16-byte GUID in storage_probe().  I hadn't gotten so far
> as to see that these two specs don't agree for USB - I'd been looking at the
> IDE and SCSI descriptions so far.  It wouldn't be the first time the EDD
> spec needed editing, and given that few (if any) BIOSs yet implement it
> apart from SCSI, is reason for the confusion.

The majority of USB devices do not support serial numbers, as that field
was made optional in the spec.  Even if it was required, it's a string
field, not a 64 bit number :(

> I don't think Dell has a T13 committee representative right now, but I'll
> see if we have a process for getting this cleared up through official
> channels.  As I'm not a USB expert, would you care to comment on the right
> way to handle this (i.e. instead of a 64-bit serial number, use the 16-byte
> GUID)?

Um, what do you mean, "right way"?  All USB devices do not have any such
serial number.  Only a very small minority of devices contain a kind of
serial number, and that field is a string (and often times it is not
even unique, unfortunately.)

As for USB storage devices, I don't know if they all contain serial
numbers that are unique, you might want to go ask the author of the
usb-storage driver, Matt Dharm.

What are you trying to walk all of the USB devices for?  What would you
do if you found a USB mass storage device that matched something in the
EDD tables?

thanks,

greg k-h
