Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290551AbSA3U0R>; Wed, 30 Jan 2002 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290553AbSA3UZ5>; Wed, 30 Jan 2002 15:25:57 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:37085 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S290551AbSA3UZt>; Wed, 30 Jan 2002 15:25:49 -0500
Date: Wed, 30 Jan 2002 12:24:13 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [PATCH] driverfs support for USB - take 2
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <0a1e01c1a9cc$15e164c0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0201301018580.800-100000@segfault.osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"> " == "Patrick Mochel" <mochel@osdl.org>

> You have a PCI device that is the USB controller. You create a child of 
> that represents the USB bus. Then, devices are added as children of that.
> 
> Logically, couldn't you skip that extra layer of indirection and make USB 
> devices children of the USB controller? Or, do you see benefit in the 
> explicit distinction?

Since I don't see a benefit from that extra indirection, I was going to ask
almost that same question ... :)

But it's broader than that:  Why shouldn't that apply to _every_ kind
of bridge, not just USB controllers ("PCI-to-USB bridges")?

For example, with PCI why should there ever be "pci0" directories,
with children "00:??.?" and "pci1"?


>    ... A 'bus' is simply a device that has children. 
>
> This concept is something that I have argued both for and against since I 
> started on this. Initially, the goal was to separate the two because they 
> followed such different semantics. 
> 
> But, I've found it, IMO, it creates more problems than it solves. ...

If the model that driverfs exposes is that directories denote devices
(of any type including bridge) and (text) files expose device properties,
then my initial suspicion is that the additional level of indirection would
not be necessary.  Maybe some "type" property would be desirable
though, to better separate namespace structure from typing issues.
(It might need to be provided by the device/bridge driver.)

When I've seen corresponding problems in other areas, the extra
indirection has not been necessary.  The simpler naming policies
have been a lot easier to work with.

I suspect it'd be better to simplify the naming policy for bridges and
busses everywhere in driverfs, not just for USB, but I'd like to know
any arguments for keeping that extra level of indirection.

- Dave




