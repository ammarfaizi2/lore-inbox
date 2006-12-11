Return-Path: <linux-kernel-owner+w=401wt.eu-S936553AbWLKOxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936553AbWLKOxd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936532AbWLKOx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:53:28 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:49902 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S936499AbWLKOxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:53:17 -0500
Date: Mon, 11 Dec 2006 09:53:15 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Peter Stuge <stuge-linuxbios@cdy.org>
cc: linuxbios@linuxbios.org, David Brownell <david-b@pacbell.net>,
       <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Andi Kleen <ak@suse.de>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [LinuxBIOS] [RFC][PATCH 0/2] x86_64 Early usb
 debug port support.
In-Reply-To: <20061207095116.27665.qmail@cdy.org>
Message-ID: <Pine.LNX.4.44L0.0612110939020.3115-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006, Peter Stuge wrote:

> On Wed, Dec 06, 2006 at 01:08:14PM -0800, Lu, Yinghai wrote:
> > -----Original Message-----
> > From: Andi Kleen [mailto:ak@suse.de] 
> > Sent: Wednesday, December 06, 2006 12:59 PM
> > 
> > >I haven't looked how the other usb_debug works -- if it's polled
> > >too then it wouldn't have much advantage.
> > 
> > Need to verify if the two sides of debug cable are identical. 

In fact they are not.  They are almost identical but not exactly the same.

> I got my device yesterday and after a small plugfest I can confirm
> that only one end of the device enumerates when connected to an ICH7
> EHCI driven by 2.6.19.

This is incorrect.  Both sides will enumerate.  In fact, both sides will
enumerate even at full speed (when plugged in to a UHCI controller instead
of EHCI).

The difference is that the device will accept power only from one side --
let's call it the A side (the side to the right when you have the PLX logo
facing you).

The device is bus-powered, so nothing will happen if the A side isn't 
plugged in.  But if it is then both the A and B sides will enumerate.  
Their descriptors are almost the same; only the serial numbers are 
different.  The A side's serial number string is "1", and the B side's 
serial number string is "0".  Oddly enough, both sides use the same string 
index number for the descriptor (3).

> Bus 001 Device 027: ID 0525:127a Netchip Technology, Inc. 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0        64
>   idVendor           0x0525 Netchip Technology, Inc.
>   idProduct          0x127a 
>   bcdDevice            1.01
>   iManufacturer           1 NetChip
>   iProduct                2 NetChip TurboCONNECT 2.0
>   iSerial                 3 1
...

> The device is in fact not self-powered.
> 
> My theory is that the same set of descriptors are used for both ends,
> but one end has been locked to address 127 in order to work with
> simpler debug port drivers that assume it will be there.

No, you are wrong.  The device will accept any address on either side.

> I guess that the self-powered error is also to simplify life for
> debug port drivers. IIRC most if not all USB power management
> concerns are noops for debug ports.

I don't see how it would make life any simpler, but the device certainly 
does lie about its power source.

Alan Stern

