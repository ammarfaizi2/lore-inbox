Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWGCXdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWGCXdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWGCXdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:33:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:43972 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932120AbWGCXdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:33:02 -0400
Date: Mon, 3 Jul 2006 16:29:27 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Message-ID: <20060703232927.GA19111@kroah.com>
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com> <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com> <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com> <44A95F12.8080208@gmail.com> <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com> <20060703214509.GA5629@kroah.com> <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com> <20060703222645.GA22855@kroah.com> <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 07:24:30PM -0400, Daniel Bonekeeper wrote:
> I think that I didn't make myself clear on that... let me try to
> explain on what I'm thinking to do. Let's take as example Dan's driver
> at http://prdownload.berlios.de/dpfp/dpfp-driver-0.1.2.tar.bz2.
> 
> On our usb_device_id, we specify the vendor of the device, etc. We
> could also (I don't know if this is the best place to do that) specify
> which kind of device is it (printer, storage, fingerprint reader, HID,
> etc).

No, why would we want to do that?

> Let's suppose that we have some #define's or a enum that specify
> the hundreds of different device types (is that possible ? :) Nothing
> that a USB_GENERIC can't solve lol).
> 
> enum usb_device_type {
> 	USB_DEVICE_SCANNER,
> 	USB_DEVICE_KEYBOARD,
> 	USB_DEVICE_MOUSE,
> 	USB_DEVICE_FINGERPRINT_READER,
> 	USB_DEVICE_GENERIC,
> 	...
> };

No, please see the USB layer for why we don't need this.

> So our usb_device_id array could also include the kind of device and a
> pointer to our structure describing the device capabilities, something
> like:
> 
> static struct usb_devcap_fingerprint_reader
> usb_devcap_fingerprint_reader_mskeyboard = {
> 	.width = 100,
> 	.height = 100,
> 	.colors = 2,
> 	.cap_encrypted_output = 0,
> 	.image_type = FINGEPRINT_IMAGE_BMP,
> }
> 
> static struct usb_device_id dpfp_table[] = {
> 	{
> 		/* Microsoft Keyboard with Fingerprint reader */
> 		USB_DEVICE(0x045e, 0x00bb),
> 		.driver_info = DPFP_TYPE_URU4000B,
> 		USB_DEVICE_FINGERPRINT_READER,
> 		(usb_devcap_fingerprint_reader *) 
> 		usb_devcap_fingerprint_reader_mskeyboard,
> 	},
> 	{}	/* terminating null entry */
> };

Yes, that's fine to do.

I'll await a real patch before critiquing anything else :)

thanks,

greg k-h
