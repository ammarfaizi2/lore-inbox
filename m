Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSFTQz5>; Thu, 20 Jun 2002 12:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSFTQz4>; Thu, 20 Jun 2002 12:55:56 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:64647 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S315278AbSFTQzx>;
	Thu, 20 Jun 2002 12:55:53 -0400
Date: Thu, 20 Jun 2002 18:55:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020620165553.GA16897@win.tue.nl>
References: <200206200711.RAA10165@thucydides.inspired.net.au> <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 08:13:22AM -0700, Linus Torvalds wrote:

> Try it out yourself. Just do
> 
> 	mount -t driverfs /devices /devices
> 
> and then look at the whole glory

OK. I just did.

# find . -name name -exec cat {} ";"
...
PCI device 8086:7113
figure out some name...
USB device 0000:0000
figure out some name...
USB device 0000:0000
figure out some name...
USB device 0000:0000
figure out some name...
USB device 0000:0000
figure out some name...
usb_name
PCI device 8086:7112
...

At present this does not look very useful, but it may have future.

But there is a pressing present problem. What name do my devices have?
I plug in a SmartMedia card reader. It will become some SCSI device.
But which one? The easiest way to find out is just to try
"blockdev --rereadpt /dev/sdX" for X=a,b,c,d,e to find: yes, today
this thing is /dev/sde.

Of course file system names are free, so instead of asking what sdX
this device is, I should ask what major:minor this device is.

In other words, there is the difficult naming problem,
but there is also the translation problem. The user does
not recognize the device as USB device 04e6:0005:...
She thinks of this thing as her DaneElec card reader.

So, there are many names and partial names for the same object,
and translation is required from one name to another.
>From sg names to sd names to usb names.

Kurt's patch does not solve all problems, but what it provides
is a small translation table between different names for the same thing.
That information is not easily obtainable without his patch.
I do not see that driverfs provides such information.

Andries


[And please, Linus, do not use words like "despise".
Lately I have seen an increase in the amount of insults
between Linux people. That is unnecessary.]
