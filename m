Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312519AbSCYTR1>; Mon, 25 Mar 2002 14:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312516AbSCYTRS>; Mon, 25 Mar 2002 14:17:18 -0500
Received: from air-2.osdl.org ([65.201.151.6]:4235 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S312513AbSCYTQ7>;
	Mon, 25 Mar 2002 14:16:59 -0500
Date: Mon, 25 Mar 2002 11:15:02 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devexit fixes in i82092.c 
In-Reply-To: <Pine.LNX.4.33.0203160010510.2448-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0203251105370.3237-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, Linus Torvalds wrote:

> 
> 
> On Sat, 16 Mar 2002, Keith Owens wrote:
> >
> > Does that mean that we also get rid of the initcall methods?  If
> > shutdown follows a device tree then startup should also use that tree.
> 
> You cannot _build_ the tree without the initcall methods - it's populating
> the tree that the initcalls mostly do, after all.

Actually, you could theoretically get rid of the device initcalls. 

The device tree is built by the bus drivers, before the driver initcalls. 
The driver initcalls simply check for existence of devices they support. 

Once the device tree is built, you could do one walk of the tree, take the 
device id of each device, and query the device drivers to see if they 
support it or not. 

This requires the device ID tables to be in a special section; or to use 
the probe() function and pass it a device id. Or, pass the device id to 
/sbin/hotplug so it can load the right module.

> We could make one of the methods be "startup", of course, and move the
> actual device initialization there (and leave just the "find driver" in
> the initcall logic), but that would not get rid of the initcalls, it would
> just split them into two parts.

Yes. jgarzik has been saying this for some time, and I fully agree. You 
really only want to check if you have a device you support and continue 
on. (By delaying initialization, you can also keep the device in a low 
power state until you're really ready to use it as well.)

	-pat

