Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSFYTxx>; Tue, 25 Jun 2002 15:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSFYTxw>; Tue, 25 Jun 2002 15:53:52 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:64915 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S315413AbSFYTxu>; Tue, 25 Jun 2002 15:53:50 -0400
Date: Tue, 25 Jun 2002 12:55:58 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: driverfs bus_id, name (was: [PATCH] /proc/scsi/map)
To: Patrick Mochel <mochel@osdl.org>
Cc: Nick Bellinger <nickb@attheoffice.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Message-id: <3D18CACE.608@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.LNX.4.33.0206251159040.8496-100000@geena.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>- It'd be more appropriate for PCI devices to copy pci_device.name into
>>   device.name and get the user-friendly names from the PCI device name
>>   database (when available), and only fallback to those nasty strings
>>   when the more user-friendly names aren't available.
> 
> 
> That is what happens with PCI devices. They're not appearing as meaningful 
> names probably because CONFIG_PCI_NAMES isn't set. Whether or not that 
> information belongs in the kernel is another debate. 

ERm ... it wasn't on the systems I looked at.  CONFIG_PCI_NAMES has
clearly been set, but the names were the user-unfriendly style.  And
yet I know the kernel has them accessible, since they're presented
by the USB layer and by /proc/pci.  But not in driverfs.

I now see some code (presumably yours) to set those two fields
to be identical, in pci_scan_device(), but the useful description
is instead set in pci_scan_slot().  Presumably this is a case of
various init paths in PCI not wholly agreeing with each other;
maybe pci_name_device() should set both name/description fields
instead of only the one.  (Though ... why have two copies? :)


>>- Likewise it'd be more appropriate for USB devices to take the
>>   descriptive strings from the devices, like "Philips USB Digital
>>   Speaker System", than "USB device 0471:0104".
> 
> 
> Those are in the devices themselves, right? There is nothing stopping the 
> USB people from doing that... ;)

Good, I was just sanity checking ... since the PCI names really
haven't worked to provide user-friendly names, and I couldn't tell
if that was intentional.  I can provide a patch for USB easily.


You didn't respond to the question about changing the identifier
from "name" to be the more appropriate "description" ... is that
because you're still thinking (it'd cost to change) or because
you like using the (IMO ambiguous) identifier "name" there?

- Dave


