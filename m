Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318966AbSHSSKD>; Mon, 19 Aug 2002 14:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318969AbSHSSKD>; Mon, 19 Aug 2002 14:10:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16778 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318966AbSHSSKD>;
	Mon, 19 Aug 2002 14:10:03 -0400
Date: Mon, 19 Aug 2002 11:19:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Adam Belay <ambx1@netscape.net>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
In-Reply-To: <3D5D7E50.4030307@netscape.net>
Message-ID: <Pine.LNX.4.44.0208191111100.1048-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also if You're interested here's the write support for "driver".

This just doesn't make sense. When a device is inserted or a driver is
loaded, the bus tries to attach devices to a driver by comparing the
hardware ID of a device to the list of supported IDs of a driver. This is
handled at the bus level because the format of the ID and the semantics
for matching them are bus-specific.

Regardless, it happens automatically. It just doesn't make sense to let 
people try and bind a device to some random driver. 

Suppose we did support this. If you write the name of a driver to a file, 
we search the bus's list of drivers for a match. We then let the bus 
compare the hardware IDs and call probe if it matches. 

One big problem is that the IDs in the driver are marked __devinitdata, so
they're thrown away after init (if hotplugging is not enabled). So, we 
would have to change every driver. 

Besides, it just doesn't make sense. If $user wants to use a different 
or third party driver, let them rmmod and insmod. 

> PS:  Would you be interested in a patch that would port the pnpbios
> driver to the driver model?

Yes. 

	-pat


