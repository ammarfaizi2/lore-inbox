Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292155AbSBBAZN>; Fri, 1 Feb 2002 19:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292156AbSBBAZD>; Fri, 1 Feb 2002 19:25:03 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:65291 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292155AbSBBAYx>;
	Fri, 1 Feb 2002 19:24:53 -0500
Date: Fri, 1 Feb 2002 16:23:09 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] driverfs support for USB - take 2
Message-ID: <20020202002309.GD10313@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201301018580.800-100000@segfault.osdlab.org> <0a1e01c1a9cc$15e164c0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1e01c1a9cc$15e164c0$6800000a@brownell.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 04 Jan 2002 21:46:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 12:24:13PM -0800, David Brownell wrote:
> "> " == "Patrick Mochel" <mochel@osdl.org>
> 
> > You have a PCI device that is the USB controller. You create a child of 
> > that represents the USB bus. Then, devices are added as children of that.
> > 
> > Logically, couldn't you skip that extra layer of indirection and make USB 
> > devices children of the USB controller? Or, do you see benefit in the 
> > explicit distinction?
> 
> Since I don't see a benefit from that extra indirection, I was going to ask
> almost that same question ... :)

But that device _is_ a USB device, it's a root hub.  It has bandwidth
allocation, strings, a configuration, and other stuff.  It operates a
bit differently from other hubs, but it's pretty close to the real
thing.

> But it's broader than that:  Why shouldn't that apply to _every_ kind
> of bridge, not just USB controllers ("PCI-to-USB bridges")?
> 
> For example, with PCI why should there ever be "pci0" directories,
> with children "00:??.?" and "pci1"?

It's information that is useful to the user.  If presented with a tree
that doesn't have the pci? and usb directories, it just looks like a
random tree of different numbers.  If we did that, we would really need
a lsdevice program just to determine what the different devices are
easily :)

I want to be able to easily see where the pci root buses, usb root
buses, ieee1394 root buses, etc. are in the system, by just looking at
the tree.

I'll play around more with the naming scheme next week and post the
results.

thanks,

greg k-h
