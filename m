Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275341AbSITXj5>; Fri, 20 Sep 2002 19:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275353AbSITXj5>; Fri, 20 Sep 2002 19:39:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13699 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S275341AbSITXj4>;
	Fri, 20 Sep 2002 19:39:56 -0400
Date: Fri, 20 Sep 2002 16:46:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Brad Hards <bhards@bigpond.net.au>
cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
In-Reply-To: <200209210922.41887.bhards@bigpond.net.au>
Message-ID: <Pine.LNX.4.44.0209201635290.6409-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Sep 2002, Brad Hards wrote:

> On Sat, 21 Sep 2002 06:42, David Brownell wrote:
> > >>I wasn't joking about putting back the /proc/bus/usb/drivers file. This
> > >> is really going to hurt us in 2.6.
> >
> > Considering that the main use of that file that I know about was
> > implicit (usbfs is available if its files are present, another
> > assumption broken in 2.5), I'm not sure I feel any pain... :-)
> OK. Everytime someone goes "I've got usbfs loaded, and here is
> /proc/bus/usb/devices, but can't send you /proc/bus/usb/drivers", I'll assume
> that you two will answer the question.
> 
> Helping people is hard. Please don't make it harder. :-(

We definitely don't want to make it harder, for users or developers. We're 
actually trying to make it easier for both, even though it may not be 
apparent right now. 

Converting code to the driver model means we get to consolidate a lot of 
similar yet disparate interfaces and code, which most people seem to 
favor. 

As far as userspace goes, there are tools being developed to extract 
data from driverfs, to give users easy access to device and driver 
attributes; the stuff that was encoded in various proc files. With these 
tools, $user should be able to extract $data for $developer WRT $object. 

And, they should work identically for any instance of an object type 
that's encoded in driverfs: all devices or all bus types or all class 
types, etc, will behave identicaly and give similar data. 

For example, to extract the data you mention above, it would be something 
like: 

	$ lsbus usb devices > usb.info
	$ lsbus usb drivers >> usb.info

No, they're not done, and so I'm all talk about at this point. But, this 
has been the plan all along..

	-pat

