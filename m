Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319487AbSH3AQY>; Thu, 29 Aug 2002 20:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319499AbSH3AQY>; Thu, 29 Aug 2002 20:16:24 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:2688 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S319487AbSH3AQX>; Thu, 29 Aug 2002 20:16:23 -0400
Date: Thu, 29 Aug 2002 16:50:11 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC] USB driver conversion to
 "struct device_driver" for 2.5.32
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D6EB333.7050509@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020822204457.GA7532@kroah.com> <20020829221339.GA5074@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So to be sure I've got this right ... those modified driver
entry points change things as follows:

> +	int (*probe) (struct usb_interface *intf,
> +		      const struct usb_device_id *id);

  (a) the device (for urbs etc) is now implicit:
        struct usb_device *dev = interface_to_usbdev (int):

  (b) the interface index should no longer matter

  (c) returns 0 (not void *) or -Errno (not null)

  (d) that void * handle is explicitly intf->dev.driver_data

> +	void (*disconnect) (struct usb_interface *intf);

   (a) and (d) above: same change

Makes me wonder about intf->private_data, which was the
original version of intf->dev.driver_data.  Shouldn't that
be removed too?  It's only used in the interface claiming
calls (shouldn't they fit in with the driver model?) and
usbfs just now.  Is that the usbfs work you mentioned?

- Dave



