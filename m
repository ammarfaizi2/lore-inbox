Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263169AbSJGXAB>; Mon, 7 Oct 2002 19:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbSJGXAB>; Mon, 7 Oct 2002 19:00:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5288 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262659AbSJGW7T>;
	Mon, 7 Oct 2002 18:59:19 -0400
Date: Mon, 7 Oct 2002 16:06:51 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Alexander Viro <viro@math.psu.edu>
cc: torvalds@transmeta.com, <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
In-Reply-To: <Pine.GSO.4.21.0210071851370.29030-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210071601050.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It's the desctrutor for the device object. ->release() is the last thing 
> > called when the last reference to the device goes away. That's the only 
> > time it's called. 
> 
> ???
> 
> Details, please.  When can it happen and what normally holds that object
> pinned?

get_device()/put_device(). When struct device::refcount hits 0, it's 
cleaned up. c.f. drivers/base/core.c::put_device(). 

The bus type that the device belongs to always owns it, and could easily
be put in struct bus_type. Basically, it tells the bus that it's finally
ok to free the structure. That's not done by the driver core, since the 
struct device is (so far) always embedded in a bus-specific structure. 

Thoughts? Suggestions?

	-pat

