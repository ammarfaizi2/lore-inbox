Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287119AbSABOmF>; Wed, 2 Jan 2002 09:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287697AbSABOlz>; Wed, 2 Jan 2002 09:41:55 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:3597 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287119AbSABOlw>;
	Wed, 2 Jan 2002 09:41:52 -0500
Date: Wed, 2 Jan 2002 06:40:46 -0800
From: Greg KH <greg@kroah.com>
To: Roger Leblanc <r_leblanc@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
Message-ID: <20020102064046.I27118@kroah.com>
In-Reply-To: <3C322EB9.6080300@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C322EB9.6080300@videotron.ca>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 05 Dec 2001 11:36:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 04:48:41PM -0500, Roger Leblanc wrote:
> Hi,
> 
> I just compiled version 2.4.17 of the Linux kernel for my Pentium III. 
> It is compiled with modular USB support so I can run my USB scanner (an 
> Epson Perfection 1200U).
> 
> The scanner works fine but the system freeses when I shut it down. I 
> investigated a bit and found that in the file:
> <kernel_root>/drivers/usb/usb.c
> in function:
> usb_disconnect(struct usb_device **pdev)
> 
> there is a call to function:
> usbdevfs_remove_device(dev)
> at line 2423.
> 
> That is the exact point where it freeses. If I comment out that line, 
> everything goes fine. I know! This is not the proper way to fix it! But 
> at least, it fixes my problem. Since I'm not a kernel expert, I will 
> leave it to you to find the right way to fix it.

Does the system lock up when you unload the usbcore module by hand
without shutting the system down?

Are your init scripts unmounting the usbdevfs filesystem properly before
trying to unload the usbcore module?

thanks,

greg k-h
