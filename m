Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVENF70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVENF70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 01:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVENF70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 01:59:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:26021 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262554AbVENF7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 01:59:18 -0400
Date: Fri, 13 May 2005 22:59:16 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050514055916.GA19188@kroah.com>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <20050512214229.GA30233@kroah.com> <20050513231917.GA1770@tsiryulnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513231917.GA1770@tsiryulnik>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 01:21:33AM +0200, Per Svennerbrandt wrote:
> * On Fri, 13 May 2005, Greg KH (greg@kroah.com) wrote:
> > Ok, as you never posted your patch, I had to do it myself :)
> 
> Oh, crap! Seems like I'm forever doomed to be sitting on my patches for
> six months thinking they arn't good enough, only to then repeatedly 
> getting beaten by couple of hours when finally deciding on submitting
> them then... ;) ;)
> 
> I guess I'l just have to dedicate more time if I'm ever going to get any
> code into the kernel.

Or just send those patches earlier :)

> This is pretty much identical to my patch except mine also converts PCI
> into using add_hotplug_env_var().

That would be nice to do, but it would have been doing 2 things in one
patch, not good.  

> > +static ssize_t show_modalias(struct device *dev, char *buf)
> > +{
> > +	struct usb_interface *intf;
> > +	struct usb_device *udev;
> > +
> > +	intf = to_usb_interface(dev);
> > +	udev = interface_to_usbdev(intf);
> > +	if (udev->descriptor.bDeviceClass == 0) {
> > +		struct usb_host_interface *alt = intf->cur_altsetting;
> > +
> > +		return sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic%02Xisc%02Xip%02X\n",
> > +			       le16_to_cpu(udev->descriptor.idVendor),
> > +			       le16_to_cpu(udev->descriptor.idProduct),
> > +			       le16_to_cpu(udev->descriptor.bcdDevice),
> > +			       udev->descriptor.bDeviceClass,
> > +			       udev->descriptor.bDeviceSubClass,
> > +			       udev->descriptor.bDeviceProtocol,
> > +			       alt->desc.bInterfaceClass,
> > +			       alt->desc.bInterfaceSubClass,
> > +			       alt->desc.bInterfaceProtocol);
> 
> Are you sure this is correct?

Works for me :)

> I had problems with alt (intf->cur_altsetting) beeing null and actually 
> ended up ignoring the interface bits altogether. I'm bretty sure the 
> above will crash repeatedly on at least some of my machines.

Please let me know if it does.  Did you put the modalias on the
usb_device or the interface?  It belongs on the interface, as this patch
does.

cur_altsetting could be NULL pretty early in the initialization phase of
a USB device, but by the time these files are created, it should be fine
(otherwise this same check in the hotplug call would also fail, right?)

> So now that I'm not able to submit it toghether with a mixture of other,
> at least slightly, related things that I actually *do believe* have a
> small possibility of beeing accepted: How do I get my request_modalias
> patch in? ;) ;)

Send them on, let's see what you have, and we can take it from there.

thanks,

greg k-h
