Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSHPBB1>; Thu, 15 Aug 2002 21:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSHPBB1>; Thu, 15 Aug 2002 21:01:27 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:17927 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317809AbSHPBB0>;
	Thu, 15 Aug 2002 21:01:26 -0400
Date: Thu, 15 Aug 2002 18:00:58 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: driverfs: driver interface
Message-ID: <20020816010058.GA1907@kroah.com>
References: <3D5AD6BF.8060609@netscape.net> <20020815050419.GB30226@kroah.com> <3D5B885E.5000407@netscape.net> <20020815162308.GC32542@kroah.com> <3D5C14B4.1090706@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5C14B4.1090706@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 18 Jul 2002 23:53:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 08:53:08PM +0000, Adam Belay wrote:
> 
> Check this out.  Rather than explaining it, I've attached it to this 
> email.  It might solve this problem.  It's based on an idea I stated 
> earlier.  I haven't quite worked out the details yet and I'm not really 
> even sure if it's the best thing to do.  I created a sample interface 
> comprised of folders and links and then tarred and gzipped it.  I'm 
> looking forward to some reactions on it. (look in ./driver)

Hm, I think you're missing the whole point about classes.  You are
trying to do to the driver code, what will be done with the class
code.

Here's the interaction:
	- devices have a driver bound to them
	- devices live in the /root tree, showing how they are
	  interconnected.
	- drivers register with a bus (possibly more than one.)
	- drivers bind to a device present on a bus, and a class (some
	  drivers bind to many classes)
	- classes interact with userspace somehow, providing the
	  interface between the device and the user.

As an example:
	- A USB keyboard lives in the device tree.
	- The USB HID driver binds to the device, and the input class
	  (both the keyboard and generic subclasses of the input code.)
	- the user types keys, and that data gets sent from the USB
	  code, to the HID driver, to the input core, which then
	  translates them and sends the info out the /dev node.

Within your model, you are not accounting for the different classes
(input, serial, usb-serial, tty, disk, video, etc.).  Take a look at the
documentation for all of this for more information.

> Also I have two questions:
> 
> 1.)  Is it worth it to remove the bus interface?

No.

> 2.) Should driver management occur through driver model interfaces?

No.  Let's leave that the way things are today in this regards.

thanks,

greg k-h
